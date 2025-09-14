## 📄 Dynatrace Audit Logs to Log Ingest Documentation

This folder contains both **Shell Script** and **TypeScript** implementations for automating audit log collection and ingestion into Dynatrace.

## � Repository Structure

```
auditLogs_Ingestion/
├── auditlog_ingestion.sh    # Bash implementation (legacy)
├── gen3/                    # Gen3 platform implementation
│   └── audit_logs_ingest.ts # TypeScript implementation
└── README.md               # This documentation
```

---

## 🔄 Available Implementations

### 🛠️ Shell Script Implementation (`auditlog_ingestion.sh`)

**Purpose**: Traditional bash-based automation that:

1. **Fetches Audit Logs** from Dynatrace API (with pagination support).
2. **Enhances each log** with:
   * `"log.source": "AuditLogs"`
   * `"dt.cost.costcenter": "LogIngest"`
   * `"content.length"`: number of characters in the raw log object.
3. **Sends** the enriched logs to the **Dynatrace Generic Log Ingest API**.

### ⚡ TypeScript Implementation (`gen3/audit_logs_ingest.ts`)

**Purpose**: Modern Gen3 platform automation that:

1. **Fetches Audit Logs** using Dynatrace SDK client libraries with automatic pagination
2. **Enhances each log** with `"log.source": "auditLogs"` metadata
3. **Bulk ingests** all logs using the native Dynatrace logs client
4. **Returns** structured response with ingestion count and status

**Key Advantages**:

* ✅ **Native SDK Integration**: Uses official `@dynatrace-sdk/client-classic-environment-v2`
* ✅ **Automatic Authentication**: Leverages platform-managed tokens
* ✅ **Simplified Code**: Cleaner, more maintainable TypeScript implementation
* ✅ **Better Error Handling**: Built-in SDK error management
* ✅ **Workflow Integration**: Designed for Dynatrace workflow automation
* ✅ **Configurable Timeframe**: Default 48-hour lookback with easy customization

---

## 🎯 Which Implementation to Choose?

### Choose **TypeScript Implementation** (`gen3/audit_logs_ingest.ts`) if:

* ✅ You're using **Dynatrace Gen3 platform** with workflow automation
* ✅ You want **native SDK integration** with built-in authentication
* ✅ You prefer **modern, maintainable code** with TypeScript
* ✅ You need **seamless workflow integration** and scheduling
* ✅ You want **simplified deployment** without external dependencies

### Choose **Shell Script Implementation** (`auditlog_ingestion.sh`) if:

* ✅ You're using **traditional Dynatrace environments**
* ✅ You need **standalone script execution** outside workflows
* ✅ You prefer **bash scripting** for system integration
* ✅ You want **custom field enrichment** (cost center, content length)
* ✅ You need **flexible deployment** on various systems

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

## ▶️ Usage Instructions

### 🚀 TypeScript Implementation (Recommended)

1. **Deploy to Dynatrace Workflow**:

   ```text
   1. Navigate to Dynatrace → Workflows
   2. Create new workflow or import existing
   3. Add JavaScript task
   4. Copy content from gen3/audit_logs_ingest.ts
   5. Configure schedule (recommended: daily)
   6. Save and activate workflow
   ```

2. **Customize Timeframe** (optional):

   ```typescript
   // Change the timeframe as needed
   from: "now-24h",  // 24 hours
   from: "now-7d",   // 7 days
   from: "now-30d",  // 30 days
   ```

### 🛠️ Shell Script Implementation (Legacy)

1. **Make it executable**:

   ```bash
   chmod +x auditlog_ingestion.sh
   ```

2. **Run it**:

   ```bash
   ./auditlog_ingestion.sh
   ```

---

## 🛡️ Security Note

* Keep API tokens secret
* Rotate tokens periodically
* Never commit this script with active tokens to version control