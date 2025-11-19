# 🗂️ SQLite SQL Tutorial

*A Comprehensive Guide for Learners and Developers*

---

## 📘 Overview

The **SQLite SQL Tutorial** provides a complete, learner-friendly reference to the SQL language as implemented in the **SQLite database engine**.
It explains every major concept—from creating tables and defining relationships to subqueries, triggers, and transactions—using clean SQL examples and detailed commentary.

This guide mirrors the structure of the *Microsoft Access SQL Tutorial* for consistency, allowing readers to compare relational behaviors across database engines.

---

## 🎯 Purpose

SQLite is the world’s most widely used embedded SQL database.
It powers countless applications, mobile devices, and analytical tools because it is:

* **Serverless** — no separate installation or service required
* **Self-contained** — data stored in a single `.db` file
* **Cross-platform** — available on Windows, macOS, Linux, iOS, and Android
* **Standards-compliant** — supports most of SQL-92 and several unique extensions

This tutorial equips learners and professionals to:

1. Understand SQLite’s architecture and data model.
2. Write, optimize, and debug SQL statements.
3. Master constraints, joins, transactions, and schema design.
4. Apply relational design principles in a lightweight environment.

---

## 📖 Contents

| Section                                               | Description                                                                   |
| ----------------------------------------------------- | ----------------------------------------------------------------------------- |
| **1. Introduction to SQLite**                         | Overview of the file-based database engine and its relational model.          |
| **2. Creating Tables & Schemas**                      | Defining tables, primary keys, constraints, and data types.                   |
| **3. Inserting and Modifying Data**                   | Using `INSERT`, `UPDATE`, and `DELETE` effectively.                           |
| **4. Querying Data with SELECT**                      | Core syntax, aliases, filtering, and sorting.                                 |
| **5. Understanding SQL Execution Order**              | Logical order of clause evaluation (`FROM` → `WHERE` → … → `LIMIT`).          |
| **6. Filtering and Aggregation**                      | `WHERE`, `GROUP BY`, and `HAVING` clauses with aggregates.                    |
| **7. Joining Tables**                                 | Combining related tables using `INNER` and `LEFT` joins.                      |
| **8. Subqueries and Common Table Expressions (CTEs)** | Nesting queries and simplifying logic with `WITH`.                            |
| **9. Managing Data and Schema**                       | Indexes, constraints, and foreign-key enforcement.                            |
| **10. Views, Triggers, and Transactions**             | Creating reusable queries, automating logic, ensuring consistency.            |
| **11. Built-in Functions**                            | String, math, date/time, and aggregate functions with examples.               |
| **12. PRAGMA and Database Metadata**                  | Inspecting schema, enabling features, and retrieving system info.             |
| **13. Backup, Export, and Import**                    | Working with CSV data in the SQLite command-line shell.                       |
| **14. Common Pitfalls & Best Practices**              | Avoiding type-affinity issues, enabling foreign keys, and using transactions. |
| **15. Quick Reference Tables**                        | Summaries of data types, functions, and date operations.                      |

---

## 🧠 Highlights

### Logical Execution Order

Understanding how SQLite processes SQL internally:

```
FROM → WHERE → GROUP BY → HAVING → SELECT → ORDER BY → LIMIT
```

Each clause builds upon the previous one:

* `FROM` defines the dataset.
* `WHERE` filters rows.
* `GROUP BY` and `HAVING` summarize and filter groups.
* `SELECT` defines final columns.
* `ORDER BY` and `LIMIT` refine output presentation.

---

### Example Query

```sql
SELECT Department, AVG(Salary) AS AvgSalary
FROM Employees
WHERE HireDate >= '2020-01-01'
GROUP BY Department
HAVING AVG(Salary) > 85000
ORDER BY AvgSalary DESC
LIMIT 5;
```

> Returns the top five departments where the average salary exceeds $85,000 for employees hired after 2020.

---

## ⚙️ Features Covered

* ✅ **Data Definition (DDL):** `CREATE TABLE`, `ALTER`, `DROP`
* ✅ **Data Manipulation (DML):** `INSERT`, `UPDATE`, `DELETE`
* ✅ **Data Querying (DQL):** `SELECT`, `JOIN`, `GROUP BY`, `HAVING`, `ORDER BY`
* ✅ **Transactions:** `BEGIN`, `COMMIT`, `ROLLBACK`
* ✅ **Triggers & Views:** Reusable automation and virtual tables
* ✅ **Common Table Expressions (CTEs):** `WITH` clauses for readable logic
* ✅ **Built-in Functions:** `STRFTIME()`, `GROUP_CONCAT()`, `ROUND()`, etc.
* ✅ **Indexes & Constraints:** `PRIMARY KEY`, `FOREIGN KEY`, `UNIQUE`, `CHECK`
* ✅ **Metadata Commands:** `PRAGMA`, `.schema`, `.tables`

---

## 🧩 Quick Reference

### Data Type Affinities

| Declared Type | Storage Class                    | Example             |
| ------------- | -------------------------------- | ------------------- |
| INTEGER       | Whole numbers, IDs               | `42`                |
| REAL          | Decimal values                   | `3.1415`            |
| TEXT          | Character data                   | `'Hello'`           |
| BLOB          | Binary objects                   | `<binary>`          |
| NUMERIC       | Flexible (dates, booleans, etc.) | `1`, `'2025-01-01'` |

### Date/Time Functions

| Function                   | Example | Result                |
| -------------------------- | ------- | --------------------- |
| `date('now')`              |         | `2025-11-19`          |
| `datetime('now','-1 day')` |         | Yesterday’s date/time |
| `strftime('%Y', 'now')`    |         | Extract year          |
| `julianday('now')`         |         | Julian day count      |

---

## ⚠️ Best Practices

| Tip                 | Recommendation                                                       |
| ------------------- | -------------------------------------------------------------------- |
| Enable foreign keys | Always run `PRAGMA foreign_keys = ON;` at the start of each session. |
| Use transactions    | Group multiple writes inside `BEGIN ... COMMIT;` for atomicity.      |
| Avoid `SELECT *`    | Explicitly list columns for clarity and efficiency.                  |
| Normalize data      | Use foreign keys to reduce duplication and enforce relationships.    |
| Handle NULLs        | Use `COALESCE()` or `IFNULL()` to manage missing values.             |
| Secure backups      | Copy `.db` files while no active connection exists.                  |

---

## 📚 Resources

* **Official Docs:** [https://www.sqlite.org/docs.html](https://www.sqlite.org/docs.html)
* **SQLite SQL Syntax:** [https://www.sqlite.org/lang.html](https://www.sqlite.org/lang.html)
* **Book:** *Using SQLite* by Jay A. Kreibich (O’Reilly, 2010)

---

## 🧩 Related Projects

| Repository                                        | Description                                                 |
| ------------------------------------------------- | ----------------------------------------------------------- |
| [Access SQL Tutorial](../Access_SQL_Tutorial)     | Companion guide for Microsoft Access (Jet/ACE SQL).         |
| [Halo Kitty Adventures](../Halo-Kitty-Adventures) | Federal Data Analytics Integration & Modernization toolkit. |

---

## 🧾 License

This project is released under the **MIT License**.
You are free to use, modify, and distribute it with attribution.

---

### ✉️ Contact

**Author:** Terry D. Eppler
📧 [terryeppler@gmail.com](mailto:terryeppler@gmail.com)

