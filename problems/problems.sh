#!/bin/bash

# ------------------ PARSE ARGUMENTS ------------------

url=""
token=""
timeframe=""

for ARG in "$@"; do
  case $ARG in
    url=*) url="${ARG#*=}" ;;
    token=*) token="${ARG#*=}" ;;
    timeframe=*) timeframe="${ARG#*=}" ;;
    *) echo "❌ Unknown parameter: $ARG"; exit 1 ;;
  esac
done

# ------------------- VALIDATION ----------------------

if [ -z "$url" ] || [ -z "$token" ] || [ -z "$timeframe" ]; then
  echo "❌ Usage: $0 url=\"<tenant_url>\" token=\"<api_token>\" timeframe=\"<-3h|-1d|-365d>\""
  exit 1
fi

# ---------------- CONFIGURATION ----------------------

api_endpoint="${url}/api/v2/problems"
initial_url="${api_endpoint}?pageSize=500&from=${timeframe}"
next_url="$initial_url"
output_file="all_problems.json"
output="[]"
fetched=0
total_count="?"

# ---------------- FETCH LOOP ------------------------

echo "🔍 Fetching problems from Dynatrace tenant: $url"
echo "🕒 Time range: $timeframe"
echo ""

while [ -n "$next_url" ]; do
  response=$(curl -s -X GET "$next_url" \
    -H "accept: application/json; charset=utf-8" \
    -H "Authorization: Api-Token $token")

  # Set total count only once from the first call
  if [ "$total_count" = "?" ]; then
    total_count=$(echo "$response" | jq -r '.totalCount')
    echo "📊 Total problems to fetch: $total_count"
  fi

  # Extract and count this page's problems
  problems=$(echo "$response" | jq '.problems')
  count=$(echo "$problems" | jq length)
  fetched=$((fetched + count))

  # Append to output
  output=$(echo "$output $problems" | jq -s 'add')

  # Display progress bar
  percent=$((fetched * 100 / total_count))
  bar=$(printf "%-${percent}s" "#" | tr ' ' '#')
  echo -ne "\r📦 Downloading: [${bar:0:50}] $percent% ($fetched/$total_count)"

  # Check for next page
  next_page_key=$(echo "$response" | jq -r '.nextPageKey // empty')
  if [ -n "$next_page_key" ]; then
    encoded_key=$(printf %s "$next_page_key" | jq -sRr @uri)
    next_url="${api_endpoint}?nextPageKey=${encoded_key}"
  else
    next_url=""
  fi
done

# ---------------- SAVE OUTPUT ------------------------

echo ""
echo "$output" > "$output_file"
total=$(jq length "$output_file")

echo "✅ Total problems fetched: $total"
echo "📁 Results saved to: $output_file"
