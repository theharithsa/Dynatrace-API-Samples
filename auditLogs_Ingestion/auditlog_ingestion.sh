#!/bin/bash

# -------------------- CONFIGURATION --------------------
TENANT_URL="https://<your-tenant>.live.dynatrace.com"    # <-- Replace with your tenant URL
AUDITLOG_TOKEN="dt0c01.YOUR_AUDITLOG_TOKEN_HERE"          # <-- Must have 'Audit logs.read' permission
LOG_INGEST_TOKEN="dt0c01.YOUR_LOG_INGEST_TOKEN_HERE"      # <-- Must have 'logs.ingest' permission
PAGE_SIZE=50
FROM_TIME="-6h"  # Time window (e.g., -2h, -1d, etc.)

# -------------------- FETCH LOOP --------------------
NEXT_PAGE=""
while true; do
  if [ -z "$NEXT_PAGE" ]; then
    URL="$TENANT_URL/api/v2/auditlogs?pageSize=$PAGE_SIZE&from=$FROM_TIME&sort=-timestamp"
  else
    URL="$TENANT_URL/api/v2/auditlogs?nextPageKey=$NEXT_PAGE"
  fi

  echo "📥 Fetching: $URL"
  RESPONSE=$(curl -s -X GET "$URL" \
    -H "accept: application/json; charset=utf-8" \
    -H "Authorization: Api-Token $AUDITLOG_TOKEN")

  # ✅ Validate the auditLogs array exists and is an array
  IS_ARRAY=$(echo "$RESPONSE" | jq -r 'has("auditLogs") and (.auditLogs | type == "array")')
  if [ "$IS_ARRAY" != "true" ]; then
    echo "❌ Error: auditLogs array not found or not valid in response."
    echo "🔎 Response:"
    echo "$RESPONSE" | jq .
    break
  fi

  # ✅ Enrich each log with extra fields
  LOG_PAYLOAD=$(echo "$RESPONSE" | jq '[.auditLogs[] | 
    . as $log | 
    $log + {
      "log.source": "AuditLogs",
      "dt.cost.costcenter": "LogIngest",
      "content.length": ($log | tostring | length)
    }
  ]')

  COUNT=$(echo "$LOG_PAYLOAD" | jq 'length')
  echo "🚀 Ingesting $COUNT logs to Dynatrace..."

  if [ "$COUNT" -gt 0 ]; then
    curl -s -X POST "$TENANT_URL/api/v2/logs/ingest" \
      -H "accept: application/json; charset=utf-8" \
      -H "Authorization: Api-Token $LOG_INGEST_TOKEN" \
      -H "Content-Type: application/json" \
      -d "$LOG_PAYLOAD"
  else
    echo "⚠️  No logs to ingest on this page."
  fi

  # 🔁 Check for nextPageKey
  NEXT_PAGE=$(echo "$RESPONSE" | jq -r '.nextPageKey // empty')
  if [ -z "$NEXT_PAGE" ]; then
    echo "✅ Ingestion complete. No more pages."
    break
  fi

  sleep 1
done
