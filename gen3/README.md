# 📊 Dynatrace Gen3 Platform Resources

Welcome to the Gen3 platform resources for advanced Dynatrace automation and licensing management.

## 📁 Repository Structure

```
gen3/
├── Notebooks/           # Dynatrace Notebooks for data analysis
├── Workflows/           # Automation workflows for governance
│   ├── Scripts/         # TypeScript utilities for workflow processing
│   ├── DDL_High_Query_Usage_v0.1.json
│   ├── Dynatrace_Release_Notes_v0.1.json
│   └── Email_Alerts_Davis_AI_Recommendations.json
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

### `DDL_High_Query_Usage_v0.1.json`

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

### `Dynatrace_Release_Notes_v0.1.json`

An automated workflow for generating and distributing Dynatrace platform release notes and updates.

#### 🎯 **Purpose**
Automates the collection and distribution of Dynatrace platform updates, feature releases, and important announcements to stakeholders.

#### ⚙️ **Workflow Components**

1. **JavaScript Processing Task (`run_javascript_1`)**
   - Processes release note data and formats content
   - Generates structured output for email distribution
   - Handles data transformation and formatting

2. **Email Distribution Task (`send_email_1`)**
   - Sends formatted release notes to configured recipients  
   - Supports CC and BCC distribution lists
   - Customizable email templates and subjects

#### 📧 **Distribution Features**
- Automated email delivery to stakeholder lists
- Customizable email content and formatting
- Support for HTML and plain text formats
- Configurable distribution schedules

---

### `Email_Alerts_Davis_AI_Recommendations.json`

An intelligent workflow that combines Dynatrace problem detection with Davis AI-powered recommendations for enhanced incident response.

#### 🎯 **Purpose**
Automatically processes Dynatrace problems and generates AI-enhanced email alerts with contextual information and intelligent recommendations for faster resolution.

#### ⚙️ **Workflow Components**

1. **DQL Query Execution (`execute_dql_query_1`)**
   - Executes data queries to gather problem context and historical information
   - Collects relevant metrics and entity data
   - Provides input data for AI analysis

2. **JavaScript Processing (`run_javascript_1`)**
   - **Entity Resolution**: Resolves affected entity IDs to human-readable display names
   - **Timestamp Conversion**: Converts UTC timestamps to IST (Asia/Kolkata timezone)
   - **Markdown Formatting**: Creates structured problem descriptions with:
     - Problem details (name, kind, category, status, ID)
     - Maintenance mode status
     - Affected entities and root cause analysis
     - Host and infrastructure information
     - Entity tags and metadata
   - **Davis AI Integration**: Leverages Dynatrace Copilot API to generate intelligent explanations
   - **Contextual Analysis**: Analyzes similar problems in the last 7 days for pattern recognition

3. **Email Notification (`send_email_1`)**
   - Sends rich-formatted emails with problem details and AI insights
   - Includes direct links to Dynatrace problem investigation
   - Customizable recipient lists and subject formatting

#### 🤖 **AI-Powered Features**

- **Intelligent Explanations**: Davis AI generates clear, non-technical explanations for stakeholders
- **Historical Context**: References similar problems from the past 7 days
- **Pattern Recognition**: Identifies recurring issues and trends
- **Root Cause Insights**: AI-enhanced analysis of problem causes and impact

#### 📧 **Email Content Structure**

Each alert includes:
- **📋 Problem Summary**: Technical details and metadata
- **🤖 AI Analysis**: Human-friendly explanation and recommendations  
- **🔗 Direct Links**: Quick access to Dynatrace problem investigation
- **📊 Historical Context**: References to similar recent problems
- **🎯 Impact Assessment**: Entity and infrastructure impact details

#### 🏷️ **Trigger Configuration**

- **Event Types**: Error, custom, resource, slowdown, availability, monitoring unavailable
- **Entity Tags**: Supports multiple tag-based filtering (EV, ME, FTPC, ROCKWELL)
- **Problem Lifecycle**: Triggers on problem open and close events
- **Tag Matching**: Configurable "any" tag matching logic

#### 💡 **Benefits**

- **Faster Response**: AI-generated insights accelerate problem understanding
- **Better Communication**: Non-technical explanations for business stakeholders
- **Context Awareness**: Historical problem patterns and trends
- **Reduced MTTR**: Direct links and contextual information speed resolution
- **Automated Triage**: Intelligent categorization and impact assessment

---

### Scripts (`Workflows/Scripts/`)

#### `jsontomdTable.ts`

A TypeScript utility for converting JSON data structures into formatted Markdown tables within Dynatrace workflows.

**Key Features**:
- **Flexible Input Processing**: Handles various JSON structures (arrays, objects, nested data)
- **Automatic Column Detection**: Infers table columns from data keys across all records  
- **Data Type Handling**: Converts arrays, objects, and primitives to readable table cells
- **Markdown Safety**: Escapes special characters to maintain table formatting
- **Workflow Integration**: Designed for seamless use within Dynatrace automation workflows

**Input Support**:
- Direct arrays of objects
- Nested structures (`.records`, `.payload`, `.data`)
- JSON strings (with automatic parsing)
- Single objects (converted to single-row tables)

**Use Cases**:
- Converting DQL query results to readable tables
- Formatting API responses for email reports
- Creating structured data views in notifications
- Generating documentation tables from data

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
   ```text
   1. Navigate to Dynatrace → Notebooks
   2. Import `Licensing Workflows DQL.json`
   3. Configure timeframes as needed
   4. Execute queries to validate data
   ```

2. **Deploy Workflows**
   ```text
   1. Navigate to Dynatrace → Workflows
   2. Import desired workflow files:
      - `DDL_High_Query_Usage_v0.1.json` for data governance
      - `Dynatrace_Release_Notes_v0.1.json` for release notifications
      - `Email_Alerts_Davis_AI_Recommendations.json` for AI-enhanced problem alerts
   3. Configure email settings and recipients
   4. Set up Davis AI/Copilot API access for AI recommendations (if using)
   5. Upload TypeScript scripts from Scripts/ folder as needed
   6. Configure problem trigger filters and entity tags
   7. Activate workflow schedules and problem triggers
   8. Test with sample data and problem events
   ```

### Configuration Tips

- **Threshold Adjustment**: Modify the 250 GB limit in the DDL High Query Usage workflow as needed
- **Schedule Customization**: Adjust cron schedules for your organization's needs
- **Email Templates**: Customize notification content and recipient lists for all workflows
- **Query Optimization**: Regular review and update of DQL queries for performance
- **Script Customization**: Modify TypeScript scripts in the Scripts/ folder for specific data formatting needs
- **Release Notes**: Configure the Release Notes workflow with appropriate stakeholder distribution lists
- **AI Configuration**: Set up Davis AI/Copilot API tokens and endpoints for intelligent recommendations
- **Problem Filtering**: Configure entity tags and problem type filters for targeted alerting
- **Timezone Settings**: Adjust timestamp conversion for your regional requirements (default: IST)

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
