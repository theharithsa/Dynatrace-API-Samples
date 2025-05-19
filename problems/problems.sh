#!/bin/bash

# ------------------ PARSE ARGUMENTS ------------------

# Default values (optional)
url=""
token=""
timeframe=""

# Loop through all passed arguments
for ARG in "$@"; do
  case $ARG in
    url=*)
      url="${ARG#*=}"
      ;;
    token=*)
      token="${ARG#*=}"
      ;;
    timeframe=*)
      timeframe="${ARG#*=}"
      ;;
    *)
      echo "❌ Unknown parameter: $ARG"
      exit 1
      ;;
  esac
done

# ------------------- VALIDATION ----------------------

if [ -z "$url" ] || [ -z "$token" ] || [ -z "$timeframe" ]; then
  echo "❌ Usage: $0 url=\"<tenant_url>\" token=\"<api_token>\" timeframe=\"<-3h|-1d|-365d>\""
  echo "Example: $0 url=\"https://abc123.live.dynatrace.com\" token=\"dt0c01.XXX\" timeframe=\"-3h\""
  exit 1
fi

# ---------------- CONFIGURATION ----------------------

api_endpoint="${url}/api/v2/problems"
initial_url="${api_endpoint}?pageSize=500&from=${timeframe}"
next_url="$initial_url"
output_file="all_problems.json"
output="[]"

# ---------------- FETCH LOOP ------------------------

echo "🔍 Fetching problems from Dynatrace tenant: $url"
echo "🕒 Time range: $timeframe"

while [ -n "$next_url" ]; do
  response=$(curl -s -X GET "$next_url" \
    -H "accept: application/json; charset=utf-8" \
    -H "Authorization: Api-Token $token")

  problems=$(echo "$response" | jq '.problems')
  output=$(echo "$output $problems" | jq -s 'add')

  next_page_key=$(echo "$response" | jq -r '.nextPageKey // empty')

  if [ -n "$next_page_key" ]; then
    encoded_key=$(printf %s "$next_page_key" | jq -sRr @uri)
    next_url="${api_endpoint}?nextPageKey=${encoded_key}"
  else
    next_url=""
  fi
done

# ---------------- SAVE OUTPUT ------------------------

echo "$output" > "$output_file"
total=$(jq length "$output_file")

echo "✅ Total problems fetched: $total"
echo "📁 Results saved to: $output_file"
