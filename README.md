###### Halo Kitty Adventures
![](https://github.com/is-leeroy-jenkins/Halo-Kitty-Adventures/blob/main/resources/images/Data.gif)
<div>
<div>
<h2> Data Analytics Integration & Modernization </h2>
</div>
  <p>
    An educational repository supporting the Federal Data Analytics Integration & Modernization initiatives. It consolidates four core learning domains — Excel, SQL, VBA, and Python — into a unified framework that builds technical fluency from tactical spreadsheet analytics to enterprise-scale data science
  </p>
  <p>
    •  <a href="https://colab.research.google.com/github/is-leeroy-jenkins/Halo-Kitty-Adventures/blob/main/excel/notebooks/formulas.ipynb"> Excel Formulas </a> •  <a href="https://colab.research.google.com/github/is-leeroy-jenkins/Halo-Kitty-Adventures/blob/main/sql/notebooks/access.ipynb"> Access SQL </a> •<a href="https://colab.research.google.com/github/is-leeroy-jenkins/Halo-Kitty-Adventures/blob/main/sql/notebooks/sqlite.ipynb"> SQLite </a> • <a href="https://colab.research.google.com/github/is-leeroy-jenkins/Halo-Kitty-Adventures/blob/main/vba/notebook/vba.ipynb"> VBA </a>  • <a href="https://colab.research.google.com/github/is-leeroy-jenkins/Halo-Kitty-Adventures/blob/main/python/notebooks/python.ipynb"> Python </a>
  </p>
</div>



## 📘 Overview

Each tutorial is written for analysts modernizing workflows under the **Army Data Plan (ADP)** and **DoD AI/ML modernization** strategy.
Lessons progress linearly, introducing tools and logic at each level of the Army’s analytic maturity model.

---

## 🧩 Repository Structure

```
Halo-Kitty-Adventures/
│
├── 📂 Excel/
│   ├── Excel_Formula_Cheat_Sheet.md
│   └── Advanced_Analytics_Formulas.md
│
├── 📂 SQL/
│   ├── Access_SQL_Tutorial.md
│   └── SQLite_Tutorial.md
│
├── 📂 VBA/
│   ├── Excel_VBA_Tutorial.md
│   └── Access_VBA_Tutorial.md
│
├── 📂 Python/
│   ├── Python_Programming_Tutorial.md
│   └── Python_VirtualEnv_Guide.md
│
└── README.md
```

---

## 🎯 Mission Objectives

|                       Domain | Goal                                                                              | Outcome                                                                      |
| ---------------------------: | --------------------------------------------------------------------------------- | ---------------------------------------------------------------------------- |
|        **🧮 Excel Formulas** | Build analytic foundations for non-coders using dynamic formulas and array logic. | Reduce manual processing and establish reproducible, auditable spreadsheets. |
| **🐘 SQL (Access / SQLite)** | Query, normalize, and aggregate structured data across systems.                   | Enable clean data pipelines for modern analytics environments.               |
|  **⚙️ VBA (Excel / Access)** | Automate repetitive Army business processes and integrate Office apps.            | Streamline workflows, reporting, and cross-application interoperability.     |
|                **🐍 Python** | Transition analysts into scripting, automation, and machine learning pipelines.   | Empower Army teams with scalable, AI-ready analytics capabilities.           |

---

## 🧮 Excel Formulas — *“The Foundation”*

<a href="https://colab.research.google.com/github/is-leeroy-jenkins/Halo-Kitty-Adventures/blob/main/excel/notebooks/formulas.ipynb" target="_parent">
<img src="https://colab.research.google.com/assets/colab-badge.svg" alt="Open In Colab"/></a>

> Every data workflow begins in Excel — transforming raw numbers into insight.


**Core Topics**

* Mathematical and logical operators
* Text manipulation (`LEFT`, `MID`, `FIND`, `TEXTJOIN`)
* Conditional logic (`IF`, `IFS`, `AND`, `OR`, `SWITCH`)
* Lookup functions (`VLOOKUP`, `XLOOKUP`, `INDEX`, `MATCH`)
* Dynamic arrays (`FILTER`, `SORT`, `UNIQUE`, `SEQUENCE`)
* Date and time analysis (`EOMONTH`, `NETWORKDAYS`, `YEARFRAC`)
* Financial/statistical formulas (`PMT`, `NPV`, `STDEV`, `FORECAST.LINEAR`)
* Named ranges, structured tables, and data validation

**Example:**

> Automate daily readiness metrics using dynamic array formulas that update automatically as new personnel data arrives.

---

## 🧾 SQL — *“The Language of Data”*
<a href="https://colab.research.google.com/github/is-leeroy-jenkins/Halo-Kitty-Adventures/blob/main/sql/notebooks/access.ipynb" target="_parent">
<img src="https://colab.research.google.com/assets/colab-badge.svg" alt="Open In Colab"/></a>


> Build and query relational datasets to power analytics across tactical and enterprise systems.

**Core Topics**

* SELECT query execution order
* INNER / OUTER / CROSS joins
* Subqueries and aggregation
* Normalization and indexing
* Access SQL macros and parameterized prompts
* Migrating Access queries to SQLite

**Army Example:**

> Create SQL joins between GFEBS obligation records and Power BI reporting datasets to reconcile funding execution in real time.

---

## ⚙️ VBA — *“Classic Automation”*
<a href="https://colab.research.google.com/github/is-leeroy-jenkins/Halo-Kitty-Adventures/blob/main/python/notebooks/vba.ipynb" target="_parent">
<img src="https://colab.research.google.com/assets/colab-badge.svg" alt="Open In Colab"/></a>


> Learn the Visual Basic for Applications (VBA) environment to automate tasks across Microsoft Office.

**Core Topics**

* Procedures, parameters, and return values
* Event handling and error trapping
* File System Object (FSO) for file I/O
* Collections, Dictionaries, and Arrays
* ADO/DAO database connections
* Excel ↔ Word ↔ Outlook integration
* UserForms and Ribbon customization

**Example:**

> Automatically generate Excel readiness dashboards from Access data, email them via Outlook, and archive backups with one button click.

---

## 🐍 Python — *“Advanced Analytics”*
<a href="https://colab.research.google.com/github/is-leeroy-jenkins/Halo-Kitty-Adventures/blob/main/python/notebooks/python.ipynb" target="_parent">
<img src="https://colab.research.google.com/assets/colab-badge.svg" alt="Open In Colab"/></a>


> Transition into enterprise-grade analytics and machine learning using modern open-source tooling.

**Core Topics**

* Virtual environments (`venv`, `pip`)
* File and database integration (`sqlite3`, `SQLAlchemy`)
* Data wrangling (`pandas`, `numpy`)
* Visualization (`matplotlib`, `seaborn`)
* Machine learning (`scikit-learn`, `PyTorch`)
* Natural Language Processing & RAG frameworks
* API and automation scripting

**Example:**

> Use Python ETL scripts to consolidate O&M execution data, generate predictive models, and deploy dashboards supporting OUSD(C) reporting.

---

## 🧠 Integrated Learning Framework

| Layer           | Excel                | SQL                | VBA               | Python                  |
| :-------------- | :------------------- | :----------------- | :---------------- | :---------------------- |
| **Data Access** | Tables & Ranges      | Relational Queries | DAO / ADO         | `sqlite3`, `pandas`     |
| **Automation**  | Dynamic Arrays       | N/A                | Macros            | Scripts / Cron Jobs     |
| **Analytics**   | PivotTables & Charts | Aggregations       | Chart Automation  | `seaborn`, `plotly`     |
| **Modeling**    | Forecast & Solver    | Query Modeling     | Regression Macros | `scikit-learn`, `torch` |
| **Deployment**  | Shared Workbooks     | Access Forms       | Add-Ins           | Flask / FastAPI APIs    |

---

## 🧬 Recommended Learning Sequence

```
START → Excel Formulas
        ↓
        SQL Queries
        ↓
        VBA Automation
        ↓
        Python Analytics
        ↓
        Cross-Domain Capstone: Integrating All Four Layers
```

---

## 🪖 Alignment with Army Data Modernization

| Initiative                    | Relevance                                                                         |
| ----------------------------- | --------------------------------------------------------------------------------- |
| **Army Data Plan (ADP)**      | Builds baseline data fluency and code literacy for field and enterprise analysts. |
| **Army Vantage / ADE**        | Supports self-service data integration for operational dashboards.                |
| **Access → Python Migration** | Bridges legacy Office automation to modern data science environments.             |
| **DoD AI/ML Modernization**   | Establishes standardized, model-ready data processes.                             |

---

## 🧾 Reference Materials

Learning modules draw from authoritative texts and field practice:

* *Excel 2019 Power Programming with VBA* — Michael Alexander & Dick Kusleika
* *Introduction to Machine Learning with Python* — Andreas Müller & Sarah Guido
* *Machine Learning with PyTorch and Scikit-Learn* — Sebastian Raschka et al.
* *Pro WPF 4.5 in C#* — Matthew MacDonald

---

## 🧰 Prerequisites

* **Microsoft 365** (Excel & Access)
* **Python 3.10+**
* **SQLite / DB Browser for SQLite**
* Optional: Visual Studio Code, GitHub Desktop, LM Studio (for RAG integration)


---

## 🪶 Author

**[Terry D. Eppler](https://gravatar.com/terryepplerphd)**
• Data Scientist • Developer • Data Modernization Architect
📧 *[terryeppler@gmail.com](mailto:terryeppler@gmail.com)*  |
GitHub: [@TerryEppler](https://github.com/TerryEppler)

> **Disclaimer**: This is for analytical exploration, research, and education purposes.  
> This is **not** an official government product; validate against authoritative sources before use.

---


## 📝 License

Halo Kitty Adventures is published under the [MIT General Public License v3](https://github.com/is-leeroy-jenkins/Sake/blob/master/LICENSE.txt).

