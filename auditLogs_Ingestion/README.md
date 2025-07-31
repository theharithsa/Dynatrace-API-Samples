## 📄 Dynatrace Audit Logs to Log Ingest Script Documentation

### 📌 Purpose

This script automates the following:

1. **Fetches Audit Logs** from Dynatrace API (with pagination support).
2. **Enhances each log** with:

   * `"log.source": "AuditLogs"`
   * `"dt.cost.costcenter": "LogIngest"`
   * `"content.length"`: number of characters in the raw log object.
3. **Sends** the enriched logs to the **Dynatrace Generic Log Ingest API**.

---

## ✅ Prerequisites

### 1. Dynatrace Tenant URL

You’ll need your full Dynatrace tenant URL in the format:

```bash
https://<your-environment-id>.live.dynatrace.com
```

**Or, if using a private managed tenant** (like HDFC Securities):

```bash
https://fsocarum.hdfcsec.com:443/e/<env-id>/api
```

🔧 Replace this in the script on:

```
Line 6 → TENANT_URL
```

---

### 2. API Tokens

Two tokens are needed:

| Token Purpose    | Required Permissions | Script Line |
| ---------------- | -------------------- | ----------- |
| Audit Log Reader | `Audit logs.read`    | Line 7      |
| Log Ingest       | `logs.ingest`        | Line 8      |

Create them from:
**Dynatrace → Settings → Integration → Dynatrace API → Generate token**

---

## 🔐 Required API Scopes

| API Token Name     | Scope Name        |
| ------------------ | ----------------- |
| `AUDITLOG_TOKEN`   | `Audit logs.read` |
| `LOG_INGEST_TOKEN` | `logs.ingest`     |

---

## ⚙️ Configuration Overview

```bash
# Configuration block (Lines 6–10)
TENANT_URL="<your Dynatrace environment URL>"
AUDITLOG_TOKEN="<API token with 'Audit logs.read'>"
LOG_INGEST_TOKEN="<API token with 'logs.ingest'>"
PAGE_SIZE=50
FROM_TIME="-6h"  # Change as needed (e.g., "-2h", "-24h")
```

---

## 🔁 Script Behavior & Logic

| Step | Description                                         |
| ---- | --------------------------------------------------- |
| 1    | Fetches audit logs via `/api/v2/auditlogs` endpoint |
| 2    | Checks response validity using `jq`                 |
| 3    | For each log, adds:                                 |

* `"log.source": "AuditLogs"`
* `"dt.cost.costcenter": "LogIngest"`
* `"content.length"`: size of original log |
  \| 4 | Sends batch to `/api/v2/logs/ingest` |
  \| 5 | Follows `nextPageKey` for pagination |
  \| 6 | Ends when no more pages remain |

---

## 🧠 Field Enrichment Summary

Each audit log entry will include:

| Field                | Value                | Purpose                               |
| -------------------- | -------------------- | ------------------------------------- |
| `log.source`         | `AuditLogs`          | Identifies log origin                 |
| `dt.cost.costcenter` | `LogIngest`          | Useful for tagging/chargeback         |
| `content.length`     | Integer (e.g., 1287) | Character length of original log JSON |

---

## 🚨 Error Handling Features

* Handles:

  * `null` or missing `auditLogs`
  * Unexpected API errors
  * Empty pages
* Logs failure reasons before exiting
* Skips ingestion if log count is 0

---

## 🧱 Dependencies

* `jq` must be installed:

```bash
sudo apt install jq      # Debian/Ubuntu
brew install jq          # macOS
```

---

## ▶️ Running the Script

1. **Make it executable**:

```bash
chmod +x full_auditlog_ingest.sh
```

2. **Run it**:

```bash
./full_auditlog_ingest.sh
```

---

## 🛡️ Security Note

* Keep API tokens secret
* Rotate tokens periodically
* Never commit this script with active tokens to version control

---

## 📁 Additional Resources (gen3 Folder)

The repository also includes additional Dynatrace automation resources in the `gen3/` folder:

### 📊 Notebooks (`gen3/Notebooks/`)

- **`Licensing Workflows DQL.json`** - A Dynatrace notebook containing DQL queries for:
  - **AppEngine Functions Usage Monitoring**: Tracks billing usage events for AppEngine functions by user and calling application
  - **DQL Query Usage Analysis**: Monitors automation workflow execution hours and details for licensing insights

### 🔄 Workflows (`gen3/Workflows/`)

- **`DDL_High_Query_Usage.json`** - An automated workflow for data usage governance:
  - **Purpose**: Monitors users who query more than 250 GB of data in 6 hours
  - **Trigger**: Runs every 6 hours on weekdays (Monday-Friday)
  - **Features**:
    - Executes DQL queries to identify high data usage
    - Groups results by user email
    - Sends personalized email notifications with:
      - Total data queried breakdown
      - List of executed queries
      - DQL optimization tips and best practices
      - Links to documentation
  - **Benefits**: Helps organizations manage DDU (Data Unit) consumption and reduce licensing costs

### 🎯 Use Cases

These resources are particularly useful for:
- **License Management**: Track and optimize Dynatrace feature usage
- **Cost Control**: Monitor and alert on high data consumption
- **User Education**: Provide automated guidance on query optimization
- **Compliance**: Maintain audit trails of data access patterns