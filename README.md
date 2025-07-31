# 🚀 Dynatrace API Samples

A comprehensive collection of Dynatrace automation tools, scripts, and workflows for platform administration, monitoring, and governance.

## 📁 Repository Structure

```
Dynatrace-API-Samples/
├── 📋 auditLogs_Ingestion/     # Audit logs collection and ingestion
├── 🧠 gen3/                   # Advanced automation and licensing tools
├── 🚨 problems/               # Problem event fetching utilities
└── 📖 README.md               # This documentation
```

---

## 🛠️ Available Tools & Scripts

### 📋 Audit Logs Ingestion (`auditLogs_Ingestion/`)

**Purpose**: Automated collection and ingestion of Dynatrace audit logs for compliance and monitoring.

**Key Features**:

- ✅ Fetches audit logs from Dynatrace API with pagination support
- 🏷️ Enhances logs with custom metadata (source, cost center, content length)
- 📤 Sends enriched logs to Dynatrace Generic Log Ingest API
- ⚙️ Configurable timeframes and batch processing
- 🛡️ Built-in error handling and validation

**Use Cases**:

- Compliance and audit trail maintenance
- Security monitoring and analysis
- Cost tracking and chargeback
- Historical audit data preservation

**Quick Start**:

```bash
cd auditLogs_Ingestion/
chmod +x auditlog_ingestion.sh
./auditlog_ingestion.sh
```

📖 [Detailed Documentation](./auditLogs_Ingestion/README.md)

---

### 🧠 Gen3 Platform Resources (`gen3/`)

**Purpose**: Advanced Dynatrace Gen3 platform automation for licensing management and data governance.

**Components**:

#### 📊 **Notebooks**

- **Licensing Workflows DQL**: Comprehensive DQL queries for AppEngine usage and workflow analytics
- Real-time usage tracking and cost optimization insights
- Historical trend analysis and reporting

#### 🔄 **Automation Workflows**  

- **DDL High Query Usage Monitor**: Intelligent workflow for data consumption governance
- Automated user notifications for high data usage (>250GB in 6 hours)
- Personalized optimization guidance and best practices delivery
- Scheduled monitoring with email alerts

**Benefits**:

- 💰 **Cost Control**: Proactive DDU consumption monitoring
- 📚 **User Education**: Automated DQL optimization guidance  
- 🎯 **Governance**: Policy enforcement and compliance tracking
- 📈 **Analytics**: Deep insights into platform usage patterns

**Quick Start**:

```bash
# Import notebooks and workflows through Dynatrace UI
# See gen3/README.md for detailed deployment steps
```

📖 [Detailed Documentation](./gen3/README.md)

---

### 🚨 Problem Event Fetcher (`problems/`)

**Purpose**: Lightweight utility for fetching and analyzing Dynatrace problem events.

**Key Features**:

- ✅ Supports both Dynatrace SaaS and Managed environments
- 🧭 Configurable timeframe queries (`-1h`, `-1d`, `-365d`)
- 📑 Exports all problem entries to structured JSON
- 🔁 Automatic pagination handling
- 🧩 Simple command-line interface

**Use Cases**:

- Problem trend analysis and reporting
- Integration with external monitoring systems
- Historical problem data export
- Automated problem tracking workflows

**Quick Start**:

```bash
cd problems/
./problems.sh url="https://your-tenant.live.dynatrace.com" token="your-api-token" timeframe="-24h"
```

📖 [Detailed Documentation](./problems/README.md)

---

## 🎯 Target Audiences

### 🏢 **Platform Administrators**

- Comprehensive audit logging and compliance tools
- Cost management and license optimization utilities
- Automated governance and policy enforcement

### 👨‍💻 **DevOps Engineers**  

- Problem event automation and analysis
- Integration-ready scripts and workflows
- Monitoring and alerting enhancement tools

### 📊 **Data Analysts**

- Rich DQL query libraries for usage analytics
- Historical data export and analysis tools
- Cost optimization and trend analysis capabilities

### 🔧 **Dynatrace Users**

- Educational resources for query optimization
- Best practices and performance guidance
- Automated learning and improvement suggestions

---

## 🚀 Getting Started

### Prerequisites

Before using any tools in this repository, ensure you have:

1. **Dynatrace Environment Access**
   - SaaS: `https://<environment-id>.live.dynatrace.com`
   - Managed: `https://<your-domain>/e/<environment-id>`

2. **Required API Tokens**
   - Audit logs: `Audit logs.read` permission
   - Log ingestion: `logs.ingest` permission  
   - Problems: `DataExport` permission
   - Workflows: `Automation workflows` permission

3. **Technical Dependencies**
   - `bash` shell environment
   - `curl` for API requests
   - `jq` for JSON processing
   - Dynatrace Gen3 platform access (for gen3 tools)

### Installation & Setup

1. **Clone the Repository**

   ```bash
   git clone https://github.com/theharithsa/Dynatrace-API-Samples.git
   cd Dynatrace-API-Samples
   ```

2. **Choose Your Tool**

   ```bash
   # For audit logs ingestion
   cd auditLogs_Ingestion/
   
   # For gen3 platform resources  
   cd gen3/
   
   # For problem event fetching
   cd problems/
   ```

3. **Follow Tool-Specific Documentation**
   - Each directory contains detailed README with setup instructions
   - Configure API tokens and environment URLs as needed
   - Test with small datasets before production use

---

## 📖 Documentation & Resources

### 🔗 **Official Dynatrace Documentation**

- [Dynatrace API Reference](https://docs.dynatrace.com/docs/dynatrace-api)
- [DQL Best Practices](https://docs.dynatrace.com/docs/discover-dynatrace/references/dynatrace-query-language/dql-best-practices)
- [Workflow Automation Guide](https://docs.dynatrace.com/docs/platform-modules/automations)
- [DDU Management](https://docs.dynatrace.com/docs/shortlink/ddu-management)

### 📋 **Repository Resources**

- [Audit Logs Ingestion Guide](./auditLogs_Ingestion/README.md)
- [Gen3 Platform Resources](./gen3/README.md)  
- [Problem Fetcher Documentation](./problems/README.md)

---

## 🛡️ Security & Best Practices

### 🔐 **API Token Management**

- Use tokens with minimal required permissions
- Rotate tokens regularly (recommended: every 90 days)
- Never commit tokens to version control
- Store tokens securely using environment variables or secret management

### 🚨 **Usage Guidelines**

- Test scripts in non-production environments first
- Monitor API rate limits and quota consumption
- Implement proper error handling and logging
- Follow your organization's security policies

### 📊 **Data Governance**

- Ensure compliance with data protection regulations
- Implement appropriate access controls
- Maintain audit trails for all automated activities
- Regular review and validation of automated processes

---

## 🤝 Contributing

We welcome contributions to improve and expand this collection of Dynatrace tools!

### How to Contribute

1. **Fork the Repository**

   ```bash
   git fork https://github.com/theharithsa/Dynatrace-API-Samples.git
   ```

2. **Create a Feature Branch**

   ```bash
   git checkout -b feature/your-improvement
   ```

3. **Make Your Changes**
   - Add new tools or improve existing ones
   - Update documentation accordingly
   - Follow existing code style and conventions

4. **Test Thoroughly**
   - Validate your changes in test environments
   - Ensure backward compatibility
   - Update relevant documentation

5. **Submit a Pull Request**
   - Provide clear description of changes
   - Include testing instructions
   - Reference any related issues

### Contribution Guidelines

- **Code Quality**: Follow shell scripting best practices
- **Documentation**: Update READMEs for any new features
- **Security**: Never include API tokens or sensitive data
- **Testing**: Provide test cases or validation steps
- **Compatibility**: Ensure cross-platform compatibility where possible

---

## 📞 Support & Community

### 🆘 **Getting Help**

1. **Repository Issues**: [GitHub Issues](https://github.com/theharithsa/Dynatrace-API-Samples/issues)
2. **Dynatrace Community**: [Dynatrace Community Forum](https://community.dynatrace.com/)
3. **Official Support**: [Dynatrace Support Portal](https://support.dynatrace.com/)

### 📢 **Stay Updated**

- ⭐ Star this repository for updates
- 👀 Watch for new releases and features  
- 🔔 Subscribe to issue notifications
- 📱 Follow [@dynatrace](https://twitter.com/dynatrace) on social media

---

## 📜 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 🙏 Acknowledgments

- **Dynatrace Community** for inspiration and feedback
- **Contributors** who have helped improve these tools
- **Dynatrace Engineering** for providing excellent APIs and documentation

---

**Made with ❤️ for the Dynatrace community**

*Helping organizations maximize their Dynatrace investment through automation and best practices.*
