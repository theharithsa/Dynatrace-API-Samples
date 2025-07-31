# 📊 Dynatrace Gen3 Platform Resources

Welcome to the Gen3 platform resources for advanced Dynatrace automation and licensing management.

## 📁 Repository Structure

```dql
gen3/
├── Notebooks/           # Dynatrace Notebooks for data analysis
├── Workflows/           # Automation workflows for governance
└── README.md           # This documentation
```

---

## 📊 Notebooks (`Notebooks/`)

### `Licensing Workflows DQL.json`

A comprehensive Dynatrace notebook containing DQL queries for licensing and usage analytics:

#### 🔍 **AppEngine Functions Usage Monitoring**

- Tracks billing usage events for AppEngine functions
- Monitors invocations by user and calling application
- Provides insights into function consumption patterns

#### 📈 **Workflow Usage Analysis**

- Monitors automation workflow execution hours
- Tracks workflow details for licensing insights
- Analyzes workflow ownership and creation patterns

#### 💡 **Key Features**

- Real-time usage tracking
- User-based consumption analysis
- Historical trend analysis
- Cost optimization insights

---

## 🔄 Workflows (`Workflows/`)

### `DDL_High_Query_Usage.json`

An intelligent automation workflow for data usage governance and cost control.

#### 🎯 **Purpose**
Monitors users who query more than 250 GB of data within 6 hours and provides automated guidance to optimize their usage.

#### ⏰ **Execution Schedule**
- **Trigger**: Automated cron schedule
- **Frequency**: Every 6 hours
- **Days**: Monday through Friday (business days)
- **Timezone**: Asia/Kolkata

#### 🔧 **Workflow Components**

1. **Data Collection Task (`find_expensive_queries`)**
   - Executes DQL queries to identify high data usage
   - Collects user information, query details, and data volumes
   - Filters for queries exceeding 250 GB threshold

2. **Processing Task (`create_output`)**
   - Groups results by user email
   - Calculates total data consumption per user
   - Prepares personalized notification content

3. **Notification Task (`sending_email`)**
   - Sends targeted email notifications to high-usage users
   - Includes optimization tips and best practices
   - Provides actionable guidance for cost reduction

#### 📧 **Email Notification Features**

Each notification includes:
- **📊 Usage Summary**: Total GB queried breakdown
- **👤 User Details**: Email and identification
- **🌐 Query Sources**: Where queries were executed
- **🔍 Query Analysis**: Complete list of executed queries
- **🛠️ Optimization Tips**: DQL best practices and performance guidance
- **📘 Documentation Links**: References to official best practices

#### 🛠️ **Optimization Guidance Provided**

- Early filtering techniques (`| filter` usage)
- Timeframe optimization strategies
- Grouping best practices for high-cardinality fields
- Dashboard refresh rate optimization
- Notebook auto-run configuration
- Sampling and scan limit recommendations

---

## 🎯 Use Cases & Benefits

### 🏢 **For Organizations**
- **Cost Control**: Proactive monitoring of DDU (Data Unit) consumption
- **License Management**: Track and optimize Dynatrace feature usage
- **Compliance**: Maintain audit trails of data access patterns
- **Budget Planning**: Predictive insights for licensing costs

### 👥 **For Users**
- **Education**: Automated learning about query optimization
- **Awareness**: Real-time feedback on data consumption
- **Guidance**: Practical tips for efficient DQL usage
- **Performance**: Improved query execution times

### 🔧 **For Administrators**
- **Governance**: Automated enforcement of usage policies
- **Monitoring**: Centralized view of platform usage
- **Optimization**: Identification of inefficient queries
- **Support**: Reduced manual intervention for user guidance

---

## 🚀 Getting Started

### Prerequisites
- Dynatrace Gen3 platform access
- Appropriate permissions for:
  - Workflow automation
  - Notebook execution
  - Email notifications
  - DQL query execution

### Deployment Steps

1. **Import Notebook**
   ```
   1. Navigate to Dynatrace → Notebooks
   2. Import `Licensing Workflows DQL.json`
   3. Configure timeframes as needed
   4. Execute queries to validate data
   ```

2. **Deploy Workflow**
   ```
   1. Navigate to Dynatrace → Workflows
   2. Import `DDL_High_Query_Usage.json`
   3. Configure email settings
   4. Activate the workflow schedule
   5. Test with sample data
   ```

### Configuration Tips
- **Threshold Adjustment**: Modify the 250 GB limit in the workflow as needed
- **Schedule Customization**: Adjust cron schedule for your organization's needs
- **Email Templates**: Customize notification content for your organization
- **Query Optimization**: Regular review and update of DQL queries for performance

---

## 📖 Documentation & Resources

- [Dynatrace DQL Best Practices](https://docs.dynatrace.com/docs/discover-dynatrace/references/dynatrace-query-language/dql-best-practices)
- [Workflow Automation Guide](https://docs.dynatrace.com/docs/platform-modules/automations)
- [Notebook User Guide](https://docs.dynatrace.com/docs/platform-modules/digital-experience/web-applications)
- [DDU Management Documentation](https://docs.dynatrace.com/docs/shortlink/ddu-management)

---

## 🛡️ Security & Best Practices

- **Token Security**: Use appropriate API tokens with minimal required permissions
- **Access Control**: Implement proper RBAC for workflow and notebook access
- **Data Privacy**: Ensure compliance with data protection regulations
- **Regular Updates**: Keep workflows and queries updated with platform changes
- **Monitoring**: Monitor workflow execution and email delivery success

---

## 🤝 Contributing

To contribute improvements or report issues:

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

---

## 📞 Support

For questions or support regarding these resources:
- Check the official Dynatrace documentation
- Review workflow execution logs
- Contact your Dynatrace administrator
- Submit issues through the repository issue tracker
