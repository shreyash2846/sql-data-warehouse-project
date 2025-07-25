# 📊 Data Warehouse and Analytics Project

Welcome to the **Data Warehouse and Analytics Project** repository! 🚀  
This project demonstrates a complete data warehousing and analytics solution — from building a modern data architecture to generating actionable insights.

> 🎓 **Perfect for portfolios** — showcasing best practices in **Data Engineering**, **ETL**, and **Analytics**.

---

## 🏗️ Data Architecture

This project follows the **Medallion Architecture** design pattern with three layers:

| Layer   | Description                                                                 |
|---------|-----------------------------------------------------------------------------|
| 🟤 **Bronze** | Raw data ingestion from CSV files into SQL Server (no transformation).       |
| ⚪ **Silver** | Cleaned, standardized, and transformed data for integration and quality.     |
| 🟡 **Gold**   | Business-ready data modeled in a **Star Schema** for analysis and reporting. |

---

## 📖 Project Overview

This project includes the following stages:

- 📐 **Data Architecture**: Design using Medallion architecture (Bronze → Silver → Gold)
- 🔄 **ETL Pipelines**: Extract, transform, and load data using SQL scripts
- 🧱 **Data Modeling**: Dimension and fact tables structured for reporting (Star Schema)
- 📊 **Analytics & Reporting**: SQL-based reports for key business insights

---

## 🎯 Ideal For

This repository is ideal for anyone pursuing or working in:

- 🧠 SQL Development  
- 🏗️ Data Architecture  
- ⚙️ Data Engineering  
- 🔌 ETL Pipeline Development  
- 🧮 Data Modeling  
- 📈 Data Analytics

---

## 🛠️ Tools & Resources (All Free!)

- 📂 **Datasets**: Provided CSV files (ERP + CRM)
- 🖥️ **SQL Server Express**: Lightweight database for hosting the warehouse
- 💻 **SSMS**: SQL Server Management Studio for database interactions
- 📄 **GitHub**: Version control and collaboration
- 🧩 **Draw.io**: Data architecture and model diagrams
- 🧠 **Notion**: Full project template and steps

---

## 🚧 Project Requirements

### 🎯 Goal:
Build a **modern SQL Server-based Data Warehouse** to consolidate and analyze sales data for business decision-making.

### ✅ Specifications:

- **Data Sources**: Import ERP and CRM data (CSV format)
- **Data Quality**: Clean, normalize, and validate datasets
- **Integration**: Merge into a unified, analysis-friendly model
- **Scope**: Latest data only (no historization)
- **Documentation**: Provide clear descriptions for analysts and stakeholders
- **BI/Analytics**: Generate SQL insights into:
  - 👥 Customer Behavior  
  - 📦 Product Performance  
  - 💵 Sales Trends  

📄 *For more details, refer to* [`docs/requirements.md`](./docs/requirements.md)

---

## 📂 Repository Structure

data-warehouse-project/
│
├── datasets/ # 📁 Raw ERP and CRM CSV files
│
├── docs/ # 📚 Documentation and architecture
│ ├── etl.drawio # ETL pipeline diagram
│ ├── data_architecture.drawio # Full Medallion architecture diagram
│ ├── data_catalog.md # Metadata and field descriptions
│ ├── data_flow.drawio # Data flow diagram
│ ├── data_models.drawio # Star schema ERD
│ ├── naming-conventions.md # Standards for naming tables/columns
│
├── scripts/ # 🛠️ SQL scripts for ETL and modeling
│ ├── bronze/ # Load raw data
│ ├── silver/ # Clean and transform
│ ├── gold/ # Create business-ready views
│
├── tests/ # ✅ Quality and validation scripts
├── README.md # 📘 Project overview (this file)
├── LICENSE # ⚖️ MIT License
├── .gitignore # 🚫 Files to exclude from versioning
└── requirements.txt # 📦 Required tools/libraries


# 🌟 About Me
Hi there! I'm Shreyash Gadling, and I'm thrilled to share my very first project after completing my SQL course. 📊
This marks the beginning of my journey into the world of data, and I’ve already learned so much — from writing complex queries to understanding how data powers real-world decisions. 💡
I'm deeply passionate about analytics, and my dream is to become a Data Analyst in the near future. 🚀
Let’s connect and grow together — I’d love to be part of a community that shares a love for learning and data!
