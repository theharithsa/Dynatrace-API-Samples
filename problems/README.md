Thanks! Here's the updated and enriched **Markdown documentation** including support for **Dynatrace Managed environments**, where the base URL pattern is `https://<domain>/e/<environment.id>`.

---

````markdown
# 🛠 Dynatrace Problem Fetch Script

This shell script fetches **problem events** from a Dynatrace SaaS or Managed environment using the Dynatrace API v2. It supports **pagination**, collects all problems from a specified time range, and stores the results in a single JSON file.

---

## 📄 Script Name

`problems.sh`

---

## 🚀 Features

- Works with both **Dynatrace SaaS** and **Dynatrace Managed** environments.
- Fully supports **API pagination** using `nextPageKey`.
- Stores all results in a consolidated JSON array.
- Accepts dynamic inputs via **named command-line parameters**.

---

## 🔧 Supports

| Platform           | URL Format Example                                 |
|--------------------|----------------------------------------------------|
| Dynatrace SaaS     | `https://abc123.live.dynatrace.com`                |
| Dynatrace Managed  | `https://your-domain.com/e/<environment-id>`       |

✅ Use either of the above formats for the `url` parameter.

---

## 🧾 Usage

```bash
./problems.sh url="<base_url>" token="<api_token>" timeframe="<relative_time>"
````

---

## ✅ Examples

### Dynatrace SaaS

```bash
./problems.sh \
  url="https://abc123.live.dynatrace.com" \
  token="dt0c01.XXXX.YYYYY" \
  timeframe="-6h"
```

### Dynatrace Managed

```bash
./problems.sh \
  url="https://monitoring.company.com/e/abc-environment" \
  token="dt0c01.XXXX.YYYYY" \
  timeframe="-1d"
```

---

## 📥 Parameters

| Parameter   | Description                                                                 |
| ----------- | --------------------------------------------------------------------------- |
| `url`       | Dynatrace base URL. SaaS or Managed format accepted.                        |
| `token`     | Dynatrace API token with **problems.read** scope.                           |
| `timeframe` | Relative timeframe (e.g. `-1h`, `-3d`, `-365d`) for filtering problem data. |

---

## 📤 Output

* The script writes the complete problem set to a file named:

  ```
  all_problems.json
  ```
* File contains a **single JSON array** with all problem entries from the specified time range.

---

## 🛠 Requirements

* `bash`
* `curl`
* `jq` (for processing JSON)

### Install `jq`:

```bash
# Debian/Ubuntu
sudo apt install jq

# Mac (Homebrew)
brew install jq
```

---

## 📦 Output File Example

```json
[
  {
    "problemId": "1234567890_1610000000000V2",
    "displayId": "P-123456789",
    "title": "Error rate increased",
    "severityLevel": "ERROR",
    "impactLevel": "SERVICE",
    "status": "CLOSED",
    "startTime": 1610000000000,
    "endTime": 1610003600000,
    "managementZones": [ ... ]
  },
  ...
]
```

---

## 💡 Notes

* **Pagination is automatic** – the script will continue fetching until all records are retrieved.
* Time range supports **Dynatrace-compatible relative times** (e.g., `-3h`, `-1d`, `-7d`, `-365d`).
* Make sure your API token includes `problems.read` permission.
* Managed users must include the `/e/<env-id>` part in their URL.

---

## 🧪 Sample Command in CI/CD or Automation

```bash
./problems.sh url="https://my.dynatrace.local/e/prod-env" token="$DT_API_TOKEN" timeframe="-24h"
```

---

## 👤 Author

Created by [Vishruth Harithsa](https://chat.openai.com), tailored for real-world Dynatrace operations with flexible environment support.

---

```

Let me know if you'd like this added as a `README.md` in a Git repo or need a variant that exports results in CSV!
```
