###### Halo Kitty Adventures
![](https://github.com/is-leeroy-jenkins/Halo-Kitty-Adventures/blob/main/resources/images/Project.png)
<div>
<div>
<h2> Data Analytics Integration & Modernization </h2>
</div>
  <p>
    An educational repository supporting the Federal Data Analytics Integration & Modernization initiatives. It consolidates four core learning domains — Excel, SQL, VBA, and Python — into a unified framework that builds technical fluency from tactical spreadsheet analytics to enterprise-scale data science
  </p>
  <p>
    •  <a href="https://colab.research.google.com/github/is-leeroy-jenkins/Halo-Kitty-Adventures/blob/main/excel/notebooks/dax.ipynb"> Excel (DAX) </a> •  <a href="https://colab.research.google.com/github/is-leeroy-jenkins/Halo-Kitty-Adventures/blob/main/sql/notebooks/sql-access.ipynb"> SQL (Access) </a> • <a href="https://colab.research.google.com/github/is-leeroy-jenkins/Halo-Kitty-Adventures/blob/main/excel/notebooks/formulas.ipynb"> Excel (Formulas) </a> •  <a href="https://colab.research.google.com/github/is-leeroy-jenkins/Halo-Kitty-Adventures/blob/main/sql/notebooks/sql-sqlite.ipynb"> SQL (SQLite) </a> • <a href="https://colab.research.google.com/github/is-leeroy-jenkins/Halo-Kitty-Adventures/blob/main/vba/notebook/vba-access.ipynb"> VBA (Access) </a>  • <a href="https://colab.research.google.com/github/is-leeroy-jenkins/Halo-Kitty-Adventures/blob/main/python/notebooks/python.ipynb"> Python </a> • <a href="https://colab.research.google.com/github/is-leeroy-jenkins/Halo-Kitty-Adventures/blob/main/html/html-tutorial.ipynb"> HTML5 </a>  •  <a href="https://colab.research.google.com/github/is-leeroy-jenkins/Halo-Kitty-Adventures/blob/main/vba/notebook/vba-tutorial.ipynb"> VBA (Excel) </a>  •  <a href="https://colab.research.google.com/github/is-leeroy-jenkins/Halo-Kitty-Adventures/blob/main/css/css-tutorial.ipynb"> CSS3 </a> • <a href="https://colab.research.google.com/github/is-leeroy-jenkins/Halo-Kitty-Adventures/blob/main/python/notebooks/pbi.ipynb"> Power BI </a>
  </p>
</div>



## 📘 Overview

- Each tutorial is written for analysts modernizing workflows.
- Lessons progress linearly, introducing tools and logic at each level of the Army’s analytic maturity model.



## 🧩 Repository Structure

```
Halo-Kitty-Adventures/
│
├── 📂 Excel/
│   ├── Excel_Formula.md
│   └── Advanced_Analytics_Formulas.md
│
├── 📂 SQL/
│   ├── sql-access.md
│   └── sql-sqlite.md
│
├── 📂 VBA/
│   ├── vba-tutorial.md
│   └── vba-access.md
│
├── 📂 Python/
│   ├── python.md
│
├── 📂 HTML5/
│   ├── html-tutorial.ipynb
│
├── 📂 CSS3_/
│   ├── css-tutorial.ipynb
│
├── 📂 Power BI_/
│   ├── pbi-tutorial.ipynb
│
└── README.md

```



## 🎯 Learning Objectives
|        Domain | Goal                                                                       | Outcome                                                   |
| ------------: | -------------------------------------------------------------------------- | --------------------------------------------------------- |
|  **🧮 Excel** | Teach analytical reasoning through structured formulas and dynamic arrays. | Accurate, repeatable spreadsheet analytics.               |
|    **🐘 SQL** | Develop mastery in querying and normalizing structured data.               | Clean, standardized datasets for enterprise use.          |
|    **⚙️ VBA** | Enable automation and interoperability across MS Office applications.      | Time savings and reduced data errors.                     |
| **🐍 Python** | Build modern analytics and AI pipelines.                                   | Automated RAG, ETL, and ML capabilities.                  |
|  **🌐 HTML5** | Introduce web structure for Army analytics dashboards.                     | Standardized, accessible web-based analytics interfaces.  |
|   **🎨 CSS3** | Teach styling and responsive design principles.                            | Visually coherent, device-agnostic Army web applications. |



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

# 🌐 HTML5 — *Web Foundations for Analytics*

<a href="https://colab.research.google.com/github/is-leeroy-jenkins/Halo-Kitty-Adventures/blob/main/html/html-tutorial.ipynb" target="_parent">
<img src="https://colab.research.google.com/assets/colab-badge.svg" alt="Open In Colab"/></a>


> Teach structure, semantics, and accessibility for data dashboards and Army web analytics systems.

## Core Topics

* HTML document structure and metadata
* Phrasing, flow, and grouping elements
* Forms, tables, and input controls
* Multimedia (audio/video) embedding
* Semantic layout (`header`, `nav`, `article`, `section`, `footer`)

## Notebook Examples

* `HTML5_Element_Guide.ipynb` — Organized by element group (metadata, form, text, media)
* `HTML5_Examples.ipynb` — Practical snippets and Army-themed dashboards

## Example

> Build a responsive command dashboard prototype with HTML5 elements to display live readiness metrics and operational KPIs.



# 🎨 CSS3 — *Designing with Purpose*

<a href="https://colab.research.google.com/github/is-leeroy-jenkins/Halo-Kitty-Adventures/blob/main/css/css-tutorial.ipynb" target="_parent">
<img src="https://colab.research.google.com/assets/colab-badge.svg" alt="Open In Colab"/></a>


> Master layout and design for analytics dashboards and knowledge portals.

## Core Topics

* Selectors and pseudo-classes
* The box model and positioning
* Flexbox and Grid layout systems
* Typography and color schemes
* Animations, transitions, media queries, and dark mode styling

## Notebook Examples

* `CSS3_Elements_and_Attributes.ipynb` — Attributes table, values, and examples
* `CSS3_Examples_and_Layouts.ipynb` — Real-world styling exercises


# 📊 Power BI — *Modern Visual Analytics*

<a href="https://colab.research.google.com/github/is-leeroy-jenkins/Halo-Kitty-Adventures/blob/main/python/notebooks/pbi.ipynb" target="_parent">
<img src="https://colab.research.google.com/assets/colab-badge.svg" alt="Open In Colab"/></a>

> Learn to build interactive dashboards, integrate multi‑source datasets, and publish secure analytics for commanders and staff.

## Core Topics

* Power BI Desktop interface and workflow
* Connecting to Excel, CSV, Access, SQL Server, and web APIs
* Data modeling with relationships and cardinality
* DAX fundamentals (`CALCULATE`, `FILTER`, `SUMX`, `VAR`, time‑intelligence functions)
* Building interactive visuals, drilldowns, and hierarchies
* Power Query (M language) for data cleaning and transformation
* Publishing to Power BI Service and securing workspaces

## Notebook Examples

* `PowerBI_Data_Modeling.ipynb` — Demonstrates shaping data for clean relationships
* `PowerBI_DAX_Workshop.ipynb` — DAX patterns and readiness‑focused formulas
* `PowerBI_Dashboard_Examples.ipynb` — Example Army execution, readiness, and personnel dashboards

## Example

> Create an end‑to‑end execution dashboard that connects Access/SQL/Python outputs, applies DAX time‑intelligence, and publishes to a secure Army workspace for operational leaders.

## 🧠 Integrated Learning Framework
| Layer             | Excel       | SQL               | VBA          | Python              | HTML5           | CSS3            |
| :---------------- | :---------- | :---------------- | :----------- | :------------------ | :-------------- | :-------------- |
| **Data Access**   | Sheets      | Queries           | DAO/ADO      | `pandas`, `sqlite3` | Forms & Inputs  | Styled Tables   |
| **Automation**    | Formulas    | Stored Procedures | Macros       | Scripts             | Web Scripts     | Animations      |
| **Analytics**     | PivotTables | Aggregates        | Reports      | AI Models           | Data Pages      | Visual Themes   |
| **Visualization** | Charts      | Views             | Excel Graphs | Plotly, Seaborn     | Canvas, SVG     | Layout & Colors |
| **Deployment**    | Workbooks   | Databases         | Add-ins      | Flask APIs          | HTML Dashboards | CSS UI Layer    |





# 📈 Combined Learning Progression Diagram

```
┌──────────────────────────┐
│        🧮 Excel          │
│  Foundations of Army     │
│  analytics: formulas,    │
│  tables, dynamic arrays  │
└──────────────┬───────────┘
               │
               ▼
┌──────────────────────────┐
│        🐘 SQL            │
│  Structured data access: │
│  joins, normalization,   │
│  Access & SQLite models  │
└──────────────┬───────────┘
               │
               ▼
┌──────────────────────────┐
│        ⚙️ VBA            │
│  Automation inside the   │
│  perimeter: macros, DAO  │
│  ADO, Office workflows   │
└──────────────┬───────────┘
               │
               ▼
┌──────────────────────────┐
│       🐍 Python          │
│  Modern analytics stack: │
│  pandas, ML, ETL, APIs   │
└──────────────┬───────────┘
               │
               ▼
┌──────────────────────────┐
│       🌐 HTML5           │
│  Web structure for Army  │
│  dashboards and portals  │
└──────────────┬───────────┘
               │
               ▼
┌──────────────────────────┐
│       🎨 CSS3            │
│  Responsive layouts, UI  │
│  theming, DoD-style GUI │
└──────────────┬───────────┘
               │
               ▼
┌──────────────────────────┐
│       📊 Power BI        │
│  Interactive dashboards, │
│  DAX, secure publishing  │
└──────────────────────────┘
```


## 🪖 Alignment with Army Data Modernization

| Initiative                    | Relevance                                                                         |
| ----------------------------- | --------------------------------------------------------------------------------- |
| **Army Data Plan (ADP)**      | Builds baseline data fluency and code literacy for field and enterprise analysts. |
| **Army Vantage / ADE**        | Supports self-service data integration for operational dashboards.                |
| **Access → Python Migration** | Bridges legacy Office automation to modern data science environments.             |
| **DoD AI/ML Modernization**   | Establishes standardized, model-ready data processes.                             |



## 🧾 Reference Materials

Learning modules draw from authoritative texts and field practice:

* *Excel 2019 Power Programming with VBA* — Michael Alexander & Dick Kusleika
* *Introduction to Machine Learning with Python* — Andreas Müller & Sarah Guido
* *Machine Learning with PyTorch and Scikit-Learn* — Sebastian Raschka et al.
* *Pro WPF 4.5 in C#* — Matthew MacDonald



## 🧰 Prerequisites

* **Microsoft 365** (Excel & Access)
* **Python 3.10+**
* **SQLite / DB Browser for SQLite**
* Optional: Visual Studio Code, GitHub Desktop, LM Studio (for RAG integration)




## 🪶 Author

**[Terry D. Eppler](https://gravatar.com/terryepplerphd)**
• Data Scientist • Developer • Data Modernization Architect
📧 *[terryeppler@gmail.com](mailto:terryeppler@gmail.com)*  |
GitHub: [@TerryEppler](https://github.com/TerryEppler)

> **Disclaimer**: This is for analytical exploration, research, and education purposes.  
> This is **not** an official government product; validate against authoritative sources before use.




## 📝 License

Halo-Kitty Adventures is published under the [MIT General Public License v3](https://github.com/is-leeroy-jenkins/Sake/blob/master/LICENSE.txt).

