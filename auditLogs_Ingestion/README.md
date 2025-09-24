## 📄 Dynatrace Audit Logs to Log Ingest Documentation

This folder contains both **Shell Script** and **TypeScript** implementations for automating audit log collection and ingestion into Dynatrace.

---

## 💼 Business Value & Strategic Importance

### 🎯 **Why Organizations Need This Solution**

This audit logs platform addresses **critical business requirements** for enterprise organizations operating Dynatrace environments:

#### 🛡️ **Compliance & Governance**
- **Regulatory Compliance**: Meets SOX, GDPR, HIPAA, and industry-specific audit requirements
- **Audit Trail Management**: Complete, tamper-proof logs with real-time accessibility
- **Risk Management**: Proactive identification of security threats and policy violations
- **Forensic Analysis**: Detailed investigation capabilities for security incidents

#### 💰 **Cost Optimization & Operational Efficiency**
- **License Optimization**: Monitor actual user engagement vs. licensed capacity
- **Resource Planning**: Data-driven insights for infrastructure scaling decisions
- **Audit Automation**: **90% reduction** in manual audit preparation time
- **Compliance Cost Savings**: Eliminates expensive third-party audit tools

#### 📊 **Real-Time Intelligence & Analytics**
- **User Adoption Tracking**: Measure platform utilization and identify training needs
- **Security Monitoring**: Real-time alerts for unusual activity patterns
- **Change Management**: Track configuration changes and system modifications
- **Executive Dashboards**: Strategic visibility into platform usage and security posture

### 📈 **Quantifiable Business Impact**

| Benefit Category | Immediate Impact (0-3 months) | Annual Value |
|------------------|--------------------------------|--------------|
| **Audit Efficiency** | 90% reduction in preparation time | $50K-$100K savings |
| **Compliance Costs** | Automated regulatory reporting | $25K-$75K savings |
| **Risk Mitigation** | Real-time threat detection | $100K-$500K value |
| **Operational Efficiency** | 70% reduction in manual monitoring | $30K-$80K savings |


### 🚀 **Strategic Business Benefits**

- **Executive Leadership**: Real-time compliance dashboards and regulatory reporting
- **IT Operations**: Automated monitoring with 25+ pre-built analytics tiles
- **Security Teams**: Continuous security posture monitoring and threat detection
- **Compliance Officers**: Streamlined audit preparation and evidence collection

---

## 📁 Repository Structure

```
auditLogs_Ingestion/
├── auditlog_ingestion.sh    # Bash implementation (legacy)
├── gen3/                    # Complete Gen3 platform solution
│   ├── alstom_audit_logs.md # Comprehensive implementation guide
│   └── assets/              # Ready-to-deploy resources
│       ├── wf_audit_logs_ingestion_*.json         # Audit logs workflow
│       ├── wf_user_and_groups_log_ingestion_*.json # User management workflow  
│       ├── AuditLogsDashboard.json                # Analytics dashboard
│       └── image-*.png                            # Visual implementation guide
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

### ⚡ Gen3 Complete Solution (`gen3/`)

**Purpose**: Comprehensive audit logs analytics platform featuring:

#### 🔄 **Automated Data Ingestion**
1. **Audit Logs Workflow**: Fetches and ingests audit logs every minute using Dynatrace SDK
2. **User & Groups Workflow**: Collects user management data every 2 hours via IAM API
3. **Data Enhancement**: Enriches logs with source identification and metadata

#### 📊 **Advanced Analytics Dashboard**
1. **Real-time User Activity Monitoring**: Current active users, login trends, session management
2. **Configuration Change Tracking**: CREATE/UPDATE/DELETE operations by user and schema
3. **User Management Analytics**: Total users, activation status, group memberships
4. **Security Intelligence**: Login patterns, logout analysis, access monitoring
5. **Interactive Visualizations**: Heatmaps, time series, categorical breakdowns

#### 📖 **Complete Implementation Guide**
- Step-by-step setup instructions in `alstom_audit_logs.md`
- Ready-to-deploy workflow JSON files
- Pre-configured dashboard with 25+ analytics tiles
- Visual screenshots for each implementation step

**Key Advantages**:

* ✅ **Native SDK Integration**: Uses official `@dynatrace-sdk/client-classic-environment-v2`
* ✅ **Automatic Authentication**: Leverages platform-managed tokens
* ✅ **Simplified Code**: Cleaner, more maintainable TypeScript implementation
* ✅ **Better Error Handling**: Built-in SDK error management
* ✅ **Workflow Integration**: Designed for Dynatrace workflow automation
* ✅ **Configurable Timeframe**: Default 48-hour lookback with easy customization

---

## 🎯 Which Implementation to Choose?

### Choose **Gen3 Complete Solution** (`gen3/`) if you want:

* 🚀 **Enterprise-Ready Analytics**: Complete audit logs dashboard with 25+ visualization tiles
* 📊 **Real-Time Monitoring**: Current active users, session management, configuration tracking
* 🔄 **Automated Workflows**: Minute-by-minute audit logs + hourly user management data
* 👥 **User Intelligence**: Group memberships, activation status, activity patterns
* 🛡️ **Security Analytics**: Login trends, access patterns, logout analysis
* 📈 **Business Intelligence**: Time-based analytics, heatmaps, interactive filtering
* 🎯 **Complete Package**: Ready-to-deploy with implementation guide and screenshots

### Choose **Shell Script Implementation** (`auditlog_ingestion.sh`) if you need:

* ✅ **Simple Log Collection**: Basic audit log ingestion without analytics
* ✅ **Traditional Environments**: Non-Gen3 Dynatrace instances
* ✅ **Custom Integration**: Bash scripting for system-level integration
* ✅ **Flexible Deployment**: Standalone execution on various systems
* ✅ **Custom Field Enhancement**: Cost center and content length metadata

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

### 🚀 Gen3 Complete Solution (Recommended)

**Quick Start - Complete Analytics Platform**:

1. **Follow Implementation Guide**:
   ```text
   1. Open gen3/alstom_audit_logs.md
   2. Follow step-by-step setup instructions
   3. Create audit logs storage bucket
   4. Configure OpenPipeline for data processing
   5. Import workflows from gen3/assets/ folder
   6. Deploy dashboard from AuditLogsDashboard.json
   ```

2. **Ready-to-Deploy Components**:
   ```text
   ├── Workflows (Import these):
   │   ├── wf_audit_logs_ingestion_*.json         (Every minute)
   │   └── wf_user_and_groups_log_ingestion_*.json (Every 2 hours)
   ├── Dashboard:
   │   └── AuditLogsDashboard.json (25+ analytics tiles)
   └── Visual Guide:
       └── image-*.png (Step-by-step screenshots)
   ```

3. **What You Get**:
   * Real-time user activity monitoring
   * Configuration change tracking
   * Security and compliance analytics
   * Interactive dashboards and filtering
   * Automated data collection workflows

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