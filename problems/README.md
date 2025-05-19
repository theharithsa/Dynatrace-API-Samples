
# 🔍 Dynatrace Problem Fetcher (Shell Script)

A lightweight shell script that fetches **problem events** from your **Dynatrace SaaS** or **Dynatrace Managed** environment using the [Dynatrace Problems API v2](https://www.dynatrace.com/support/help/dynatrace-api/environment-api/problems-v2/get-problems).

The script supports full pagination via `nextPageKey`, and stores the results in a single, well-structured JSON file for further analysis or automation.

---

## 🚀 Features

- ✅ Supports **Dynatrace SaaS** and **Dynatrace Managed**
- 🧭 Configurable timeframe (`-1h`, `-1d`, `-365d`, etc.)
- 📑 Saves all problem entries into one JSON array
- 🔁 Handles pagination automatically
- 🧩 Simple CLI usage with named parameters

---

## 🧾 Usage

```bash
./problems.sh url="<base_url>" token="<api_token>" timeframe="<relative_time>"
```

---

## ✅ Examples

### SaaS Example

```bash
./problems.sh \
  url="https://abc123.live.dynatrace.com" \
  token="dt0c01.XXXX.YYYYY" \
  timeframe="-6h"
```

### Managed Example

```bash
./problems.sh \
  url="https://monitoring.company.com/e/abc-env-id" \
  token="dt0c01.XXXX.YYYYY" \
  timeframe="-1d"
```

> ✅ Note: For Dynatrace Managed, the base URL **must include** `/e/<environment-id>`

---

## 📥 Parameters

| Parameter   | Description                                                                 |
|-------------|-----------------------------------------------------------------------------|
| `url`       | Dynatrace base URL (SaaS or Managed). Example: `https://abc.live.dynatrace.com` or `https://your.domain/e/env-id` |
| `token`     | Dynatrace API token with `problems.read` permission                         |
| `timeframe` | Relative time (e.g., `-1h`, `-3d`, `-365d`) for filtering problem data       |

---

## 📤 Output

- The script generates a file: `all_problems.json`
- It contains a single JSON array with all retrieved problem entries.
- You can process it further using tools like `jq`, `Python`, or export to CSV.

---

## 🛠 Requirements

- `bash`
- `curl`
- `jq`

### Install `jq`

```bash
# Ubuntu/Debian
sudo apt install jq

# macOS (Homebrew)
brew install jq
```

---

## 📦 Output Sample (JSON)

```json
[
  {
    "problemId": "3829904921303361697_1747656720000V2",
    "displayId": "P-2505153985",
    "title": "Backoff event",
    "severityLevel": "ERROR",
    "impactLevel": "APPLICATION",
    "status": "CLOSED",
    "startTime": 1747656720000,
    "endTime": 1747657860000,
    "managementZones": [...],
    "affectedEntities": [...]
  }
]
```

---

## 💡 Notes

- This script uses the `/problems` API endpoint with `pageSize=500`.
- Pagination is handled automatically using `nextPageKey`.
- Make sure your API token has the `problems.read` scope.
- Output is overwritten on every run (`all_problems.json`).

---

## 📄 License

This script is provided as-is for internal or commercial use. No warranties implied. Use responsibly.

---

## 👤 Author

Made with ❤️ by [Vishruth Harithsa](https://chat.openai.com)  
Optimized for automation, observability, and reporting use cases.

---
