# 🏛️ **T-SQL Tutorial for Microsoft SQL Server**

Transact-SQL (T-SQL) is Microsoft SQL Server’s procedural extension to the SQL language. It supports querying, data modification, joins, subqueries, transactions, error handling, procedural logic, and advanced analytical operations.
This tutorial provides a comprehensive, example-rich guide suitable for beginners through advanced analysts.

---

# 📌 **Table of Contents**

1. 🧱 SELECT Fundamentals
2. 🔗 JOIN Types
3. 🧩 Subqueries
4. 🗂️ Table Expressions
5. 🔄 Set Operators
6. 🧮 Aggregation & Grouping
7. 🔍 Filtering & Predicates
8. 🕒 Date & Time Functions
9. 📦 Data Modification (INSERT/UPDATE/DELETE/MERGE)
10. 🔒 Transactions
11. 🧰 Variables, Functions & Stored Procedures
12. 🛠️ Error Handling (TRY/CATCH)
13. 📊 Window Functions
14. 📂 Metadata Queries
15. 🗝️ T-SQL Keywords *(Part 2)*
16. 🧩 T-SQL Built-in Functions *(Part 2)*

---

# 🧱 **1. SELECT Fundamentals**

### Summary

The `SELECT` statement retrieves data from tables, views, or expressions. SQL Server evaluates queries using a logical order different from the written order (FROM → WHERE → GROUP BY → HAVING → SELECT → ORDER BY). Mastering `SELECT` is foundational to all T-SQL work.

### Key Points

* Projects (chooses) columns from a data source
* Supports expressions, aliases, and calculated values
* Filters rows with `WHERE`
* Sorts output using `ORDER BY`
* Works with joins, grouping, and CTEs

### Example

```
SELECT 
    EmployeeID,
    FirstName + ' ' + LastName AS FullName,
    Salary * 1.10 AS AdjustedSalary
FROM dbo.Employees
WHERE Salary > 60000
ORDER BY AdjustedSalary DESC;
```

---

# 🔗 **2. JOIN Types**

### Summary

Joins combine rows across tables based on relationships defined by matching keys. SQL Server supports several join types that determine which rows are included.

### Key Points

* `INNER JOIN` returns matching rows
* `LEFT JOIN` keeps all left-side rows
* `RIGHT JOIN` keeps all right-side rows
* `FULL JOIN` includes all rows from both sides
* `CROSS JOIN` produces a Cartesian product

### Examples

**INNER JOIN**
SELECT
e.EmployeeID,
e.FirstName,
d.DepartmentName
FROM dbo.Employees AS e
INNER JOIN dbo.Departments AS d
ON e.DepartmentID = d.DepartmentID;

**LEFT JOIN**
SELECT
e.EmployeeID,
e.FirstName,
d.DepartmentName
FROM dbo.Employees AS e
LEFT JOIN dbo.Departments AS d
ON e.DepartmentID = d.DepartmentID;

---

# 🧩 **3. Subqueries**

### Summary

Subqueries allow embedding a query inside another query to perform comparisons, filtering, or derived calculations.

### Key Points

* Used in SELECT, WHERE, FROM clauses
* Can be correlated (references outer query)
* Useful for filtering based on aggregated values
* Often replaced by joins for performance

### Example

```
SELECT EmployeeID, FirstName, Salary
FROM dbo.Employees
WHERE Salary > (SELECT AVG(Salary) FROM dbo.Employees);
```

---

# 🗂️ **4. Table Expressions (CTEs, Derived Tables, Views)**

### Summary

Table expressions improve readability and modularity by creating temporary or permanent named result sets.

### Key Points

* CTEs defined using `WITH`
* Can chain multiple CTEs
* Views store reusable SELECT results
* Improves maintainability and legibility

### Example: CTE

```
WITH MonthlySales AS (
    SELECT 
        SalesPersonID,
        SUM(TotalDue) AS MonthlyTotal
    FROM Sales.SalesOrderHeader
    WHERE OrderDate >= '2025-01-01'
    GROUP BY SalesPersonID
)
SELECT *
FROM MonthlySales
ORDER BY MonthlyTotal DESC;
```

---

# 🔄 **5. Set Operators**

### Summary

Set operators combine result sets from multiple queries.

### Key Points

* `UNION` removes duplicates
* `UNION ALL` keeps duplicates (faster)
* `INTERSECT` returns common rows
* `EXCEPT` returns rows in A not in B

### Example

```
SELECT EmployeeID FROM dbo.Employees
UNION ALL
SELECT EmployeeID FROM dbo.ArchivedEmployees;
```

---

# 🧮 **6. Aggregation & Grouping**

### Summary

Aggregations compute summaries across sets of rows. `GROUP BY` groups rows prior to aggregation, and `HAVING` filters aggregated results.

### Key Points

* Aggregates: SUM, AVG, MIN, MAX, COUNT
* Non-aggregated columns must appear in GROUP BY
* HAVING filters groups

### Example

```
SELECT 
    SalesPersonID,
    SUM(TotalDue) AS TotalSales
FROM Sales.SalesOrderHeader
GROUP BY SalesPersonID
HAVING SUM(TotalDue) > 500000;
```

---

# 🔍 **7. Filtering & Predicates**

### Summary

The `WHERE` clause filters rows based on logical conditions evaluated before grouping.

### Key Points

* Boolean operators: AND, OR, NOT
* Pattern searches: LIKE
* Range checks: BETWEEN
* Set membership: IN
* NULL handling: IS NULL / IS NOT NULL

### Example

```
SELECT *
FROM dbo.Users
WHERE Email LIKE '%@gmail.com';
```

---

# 🕒 **8. Working with Dates & Times**

### Summary

SQL Server includes powerful built-in date/time handling functions.

### Key Points

* CURRENT_TIMESTAMP vs GETDATE vs SYSDATETIME
* DATEADD, DATEDIFF for arithmetic
* DATENAME, DATEPART for components
* EOMONTH() for month-end

### Example

```
SELECT 
    OrderID,
    OrderDate,
    EOMONTH(OrderDate) AS MonthEnd
FROM Sales.SalesOrderHeader;
```

---

# 📦 **9. Data Modification (INSERT, UPDATE, DELETE, MERGE)**

### Summary

DML statements modify data in SQL Server.

### Key Points

* INSERT adds rows
* UPDATE changes rows
* DELETE removes rows
* MERGE handles conditional changes

### Examples

**INSERT**
INSERT INTO dbo.Departments (DepartmentName)
VALUES ('Data Analytics');

**UPDATE**
UPDATE dbo.Employees
SET Salary = Salary * 1.10
WHERE DepartmentID = 4;

---

# 🔒 **10. Transactions**

### Summary

Transactions ensure data integrity across multiple DML operations.

### Key Points

* Use BEGIN TRAN, COMMIT, ROLLBACK
* Prevents partial updates
* Combine with TRY/CATCH for safety

### Example

```
BEGIN TRAN;
    UPDATE Accounts SET Balance = Balance - 500 WHERE AccountID = 1;
    UPDATE Accounts SET Balance = Balance + 500 WHERE AccountID = 2;

    IF @@ERROR <> 0
        ROLLBACK TRAN;
    ELSE
        COMMIT TRAN;
```

---

# 🧰 **11. Variables, Functions & Stored Procedures**

### Summary

T-SQL supports procedural programming elements including variables, user-defined functions, and stored procedures.

### Key Points

* Variables declared using DECLARE
* Functions return scalar or table values
* Procedures encapsulate business logic

### Example

```
DECLARE @Rate DECIMAL(5,2) = 1.05;

SELECT 
    EmployeeID,
    Salary * @Rate AS AdjustedSalary
FROM dbo.Employees;
```

---

# 🛠️ **12. Error Handling (TRY/CATCH)**

### Summary

TRY/CATCH provides structured exception handling for T-SQL.

### Key Points

* TRY block runs primary code
* CATCH block handles errors
* System functions include ERROR_MESSAGE(), ERROR_LINE()

### Example

```
BEGIN TRY
    BEGIN TRAN;
    DELETE FROM dbo.Payroll WHERE PayrollID = -999;
    COMMIT TRAN;
END TRY
BEGIN CATCH
    ROLLBACK TRAN;

    SELECT 
        ERROR_NUMBER() AS ErrNum,
        ERROR_MESSAGE() AS ErrMsg;
END CATCH;
```

---

# 📊 **13. Window Functions**

### Summary

Window functions perform analytic operations across row sets without collapsing them into groups.

### Key Points

* Defined using OVER()
* Ranking: ROW_NUMBER(), RANK(), DENSE_RANK()
* Analytics: LAG(), LEAD(), FIRST_VALUE()

### Example

```
SELECT
    SalesPersonID,
    TotalDue,
    ROW_NUMBER() OVER (ORDER BY TotalDue DESC) AS RankOrder
FROM Sales.SalesOrderHeader;
```

---

# 📂 **14. Metadata Queries**

### Summary

SQL Server exposes schema and system metadata via catalog views.

### Key Points

* sys.tables, sys.columns for structure
* sys.databases for environment
* INFORMATION_SCHEMA for ANSI-compliant access

### Example

```
SELECT 
    name AS TableName,
    create_date
FROM sys.tables
ORDER BY name;
```


---

# 🗝️ **15. T-SQL Keywords (Grouped Reference)**

Below are the complete T-SQL keyword tables grouped logically and formatted for ease of lookup.

---

# 🔧 **DML Keywords (Data Manipulation Language)**

| Keyword  | Description                        | Example                                                      |
| -------- | ---------------------------------- | ------------------------------------------------------------ |
| SELECT   | Retrieves data.                    | SELECT * FROM Employees;                                     |
| INSERT   | Adds rows.                         | INSERT INTO T VALUES (1,'A');                                |
| UPDATE   | Modifies rows.                     | UPDATE T SET Name='X' WHERE ID=1;                            |
| DELETE   | Removes rows.                      | DELETE FROM T WHERE ID=1;                                    |
| MERGE    | Conditional insert/update/delete.  | MERGE A USING B ON A.ID=B.ID WHEN MATCHED THEN UPDATE SET... |
| TRUNCATE | Removes all rows, resets identity. | TRUNCATE TABLE Logs;                                         |
| VALUES   | Specifies row literals.            | INSERT INTO T VALUES (1,'A');                                |
| OUTPUT   | Returns affected rows.             | INSERT INTO T OUTPUT inserted.ID VALUES (1);                 |

---

# 🏗️ **DDL Keywords (Data Definition Language)**

| Keyword     | Description               | Example                                            |
| ----------- | ------------------------- | -------------------------------------------------- |
| CREATE      | Creates objects.          | CREATE TABLE T(ID int);                            |
| ALTER       | Modifies objects.         | ALTER TABLE T ADD Name varchar(20);                |
| DROP        | Removes objects.          | DROP TABLE T;                                      |
| CONSTRAINT  | Adds a constraint.        | ALTER TABLE T ADD CONSTRAINT PK_T PRIMARY KEY(ID); |
| PRIMARY KEY | Declares a primary key.   | PRIMARY KEY (ID)                                   |
| FOREIGN KEY | References another table. | FOREIGN KEY (DeptID) REFERENCES Dept(DeptID)       |
| CHECK       | Enforces a condition.     | CHECK (Salary > 0)                                 |
| DEFAULT     | Defines default value.    | Salary money DEFAULT 0                             |
| UNIQUE      | Enforces unique values.   | UNIQUE (Email)                                     |
| INDEX       | Creates an index.         | CREATE INDEX IX_T_Name ON T(Name);                 |
| VIEW        | Creates a view.           | CREATE VIEW v AS SELECT * FROM T;                  |

---

# 🔗 **JOIN & SET Keywords**

| Keyword   | Description            | Example                                    |
| --------- | ---------------------- | ------------------------------------------ |
| INNER     | Returns matching rows. | SELECT * FROM A INNER JOIN B ON A.ID=B.ID; |
| LEFT      | Left outer join.       | SELECT * FROM A LEFT JOIN B ON A.ID=B.ID;  |
| RIGHT     | Right outer join.      | SELECT * FROM A RIGHT JOIN B ON A.ID=B.ID; |
| FULL      | Full outer join.       | SELECT * FROM A FULL JOIN B ON A.ID=B.ID;  |
| CROSS     | Cartesian join.        | SELECT * FROM A CROSS JOIN B;              |
| UNION     | Set union (distinct).  | SELECT A UNION SELECT B;                   |
| UNION ALL | Set union (all rows).  | SELECT A UNION ALL SELECT B;               |
| INTERSECT | Intersection.          | SELECT A INTERSECT SELECT B;               |
| EXCEPT    | A minus B.             | SELECT A EXCEPT SELECT B;                  |

---

# 🎯 **Predicate & Filtering Keywords**

| Keyword | Description       | Example                                                 |
| ------- | ----------------- | ------------------------------------------------------- |
| WHERE   | Filters rows.     | SELECT * FROM T WHERE Flag=1;                           |
| HAVING  | Filters groups.   | HAVING SUM(Sales) > 1000                                |
| LIKE    | Pattern matching. | WHERE Name LIKE 'S%'                                    |
| IN      | Set membership.   | WHERE DeptID IN (1,2,3)                                 |
| BETWEEN | Inclusive range.  | WHERE Date BETWEEN '2024' AND '2025'                    |
| IS NULL | NULL filtering.   | WHERE ManagerID IS NULL                                 |
| EXISTS  | Subquery test.    | WHERE EXISTS (SELECT 1 FROM Dept D WHERE D.ID=T.DeptID) |

---

# 🧮 **Function & Expression Keywords**

| Keyword  | Description            | Example                                    |
| -------- | ---------------------- | ------------------------------------------ |
| CAST     | Converts data types.   | SELECT CAST('123' AS int);                 |
| CONVERT  | Converts w/format.     | SELECT CONVERT(varchar(10),GETDATE(),120); |
| COALESCE | First non-null.        | SELECT COALESCE(MiddleName,'');            |
| NULLIF   | Returns NULL if equal. | SELECT NULLIF(A,B);                        |

---

# 🔒 **Transaction & Concurrency Keywords**

| Keyword    | Description          | Example                          |
| ---------- | -------------------- | -------------------------------- |
| BEGIN TRAN | Starts transaction.  | BEGIN TRAN;                      |
| COMMIT     | Commits transaction. | COMMIT;                          |
| ROLLBACK   | Reverts transaction. | ROLLBACK;                        |
| SAVE TRAN  | Creates savepoint.   | SAVE TRAN P1;                    |
| WAITFOR    | Delay/wait event.    | WAITFOR DELAY '00:00:02';        |
| HOLDLOCK   | Strong lock hint.    | SELECT * FROM T WITH (HOLDLOCK); |

---

# 🛠️ **Control-of-Flow Keywords**

| Keyword  | Description                 | Example                              |
| -------- | --------------------------- | ------------------------------------ |
| IF       | Conditional logic.          | IF @x>5 PRINT 'High';                |
| ELSE     | Default branch.             | ELSE PRINT 'Low';                    |
| WHILE    | Loop.                       | WHILE @i<10 SET @i+=1;               |
| BREAK    | Exit loop.                  | IF @i=5 BREAK;                       |
| CONTINUE | Skip iteration.             | IF @i=3 CONTINUE;                    |
| RETURN   | Exit procedure.             | RETURN 0;                            |
| CASE     | Expression-level branching. | SELECT CASE WHEN x>0 THEN 'Pos' END; |
| GOTO     | Branch to label.            | GOTO MyLabel;                        |

---

# 🔐 **Security Keywords**

| Keyword      | Description    | Example                               |
| ------------ | -------------- | ------------------------------------- |
| GRANT        | Assign rights. | GRANT SELECT ON T TO UserA;           |
| REVOKE       | Remove rights. | REVOKE SELECT ON T FROM UserA;        |
| DENY         | Block rights.  | DENY UPDATE ON T TO UserA;            |
| LOGIN / USER | Principals.    | CREATE LOGIN Terry WITH PASSWORD='x'; |

---

# 🧩 **Server & Database Keywords**

| Keyword  | Description     | Example                                     |
| -------- | --------------- | ------------------------------------------- |
| USE      | Switch DB.      | USE FinanceDB;                              |
| DBCC     | Maintenance.    | DBCC CHECKDB (FinanceDB);                   |
| BACKUP   | Create backup.  | BACKUP DATABASE MyDB TO DISK='file.bak';    |
| RESTORE  | Restore backup. | RESTORE DATABASE MyDB FROM DISK='file.bak'; |
| SHUTDOWN | Stop server.    | SHUTDOWN WITH NOWAIT;                       |

---

# 🧬 **XML / JSON / External Access Keywords**

| Keyword        | Description                | Example                                                      |
| -------------- | -------------------------- | ------------------------------------------------------------ |
| OPENXML        | Parse XML.                 | EXEC sp_xml_preparedocument ...                              |
| OPENJSON       | Parse JSON.                | SELECT * FROM OPENJSON(@json);                               |
| OPENDATASOURCE | Remote source.             | SELECT * FROM OPENDATASOURCE(...).Db.dbo.T;                  |
| OPENROWSET     | Bulk load or remote query. | SELECT * FROM OPENROWSET(BULK 'file.csv', SINGLE_CLOB) AS J; |

---

# 🧩 **16. T-SQL Built-in Functions (Grouped Reference)**

---

# 🔤 **String Functions**

| Function   | Description            | Example                             |
| ---------- | ---------------------- | ----------------------------------- |
| LEN        | String length.         | SELECT LEN('Terry');                |
| DATALENGTH | Byte length.           | SELECT DATALENGTH('A');             |
| LEFT       | Left substring.        | SELECT LEFT('SQLServer',3);         |
| RIGHT      | Right substring.       | SELECT RIGHT('Server',3);           |
| SUBSTRING  | Middle substring.      | SELECT SUBSTRING('Database',2,4);   |
| CHARINDEX  | Position of substring. | SELECT CHARINDEX('a','T-SQL');      |
| PATINDEX   | Pattern search.        | SELECT PATINDEX('%er%','Server');   |
| REPLACE    | Replace text.          | SELECT REPLACE('2025-11','-','/');  |
| STUFF      | Insert text.           | SELECT STUFF('ABCDE',2,2,'xx');     |
| REPLICATE  | Repeat text.           | SELECT REPLICATE('*',5);            |
| RTRIM      | Trim end.              | SELECT RTRIM('Hi   ');              |
| LTRIM      | Trim start.            | SELECT LTRIM('   Hi');              |
| UPPER      | Uppercase.             | SELECT UPPER('sql');                |
| LOWER      | Lowercase.             | SELECT LOWER('SQL');                |
| FORMAT     | Format value.          | SELECT FORMAT(GETDATE(),'yyyy-MM'); |
| CONCAT     | Safe concatenation.    | SELECT CONCAT(First,' ',Last);      |

---

# 🔢 **Numeric Functions**

| Function | Description           | Example                  |
| -------- | --------------------- | ------------------------ |
| ABS      | Absolute value.       | SELECT ABS(-10);         |
| CEILING  | Round up.             | SELECT CEILING(5.3);     |
| FLOOR    | Round down.           | SELECT FLOOR(5.9);       |
| ROUND    | Round with precision. | SELECT ROUND(123.567,2); |
| SIGN     | Sign of number.       | SELECT SIGN(-42);        |
| SQRT     | Square root.          | SELECT SQRT(81);         |
| POWER    | Exponent.             | SELECT POWER(3,3);       |
| RAND     | Random number.        | SELECT RAND();           |

---

# 🕒 **Date & Time Functions**

| Function    | Description               | Example                                       |
| ----------- | ------------------------- | --------------------------------------------- |
| GETDATE     | Current timestamp.        | SELECT GETDATE();                             |
| SYSDATETIME | High precision timestamp. | SELECT SYSDATETIME();                         |
| DATEADD     | Add interval.             | SELECT DATEADD(day,7,GETDATE());              |
| DATEDIFF    | Difference between dates. | SELECT DATEDIFF(hour,'2025-01-01',GETDATE()); |
| DATENAME    | Name of date part.        | SELECT DATENAME(month,GETDATE());             |
| DATEPART    | Numeric date part.        | SELECT DATEPART(weekday,GETDATE());           |
| EOMONTH     | End of month.             | SELECT EOMONTH(GETDATE());                    |
| ISDATE      | Validate date.            | SELECT ISDATE('2025-02-30');                  |

---

# 🔄 **Conversion Functions**

| Function    | Description            | Example                                           |
| ----------- | ---------------------- | ------------------------------------------------- |
| CAST        | Change data type.      | SELECT CAST('123' AS int);                        |
| CONVERT     | Convert with style.    | SELECT CONVERT(varchar(10),GETDATE(),120);        |
| TRY_CAST    | Safe cast.             | SELECT TRY_CAST('abc' AS int);                    |
| TRY_CONVERT | Safe convert.          | SELECT TRY_CONVERT(int,'abc');                    |
| PARSE       | Culture-aware convert. | SELECT PARSE('11/21/2025' AS date USING 'en-US'); |

---

# 🧠 **Logical & Utility Functions**

| Function | Description         | Example                                |
| -------- | ------------------- | -------------------------------------- |
| IIF      | Inline conditional. | SELECT IIF(Salary>50000,'High','Low'); |
| CHOOSE   | Choose by index.    | SELECT CHOOSE(2,'A','B','C');          |
| NULLIF   | Null on match.      | SELECT NULLIF(A,B);                    |
| COALESCE | First non-null.     | SELECT COALESCE(MiddleName,'');        |

---

# 📊 **Aggregate Functions**

| Function  | Description     | Example                          |
| --------- | --------------- | -------------------------------- |
| COUNT     | Number of rows. | SELECT COUNT(*) FROM T;          |
| COUNT_BIG | Bigint count.   | SELECT COUNT_BIG(*) FROM Table1; |
| SUM       | Sum.            | SELECT SUM(Amount) FROM Orders;  |
| AVG       | Average.        | SELECT AVG(Salary) FROM Emp;     |
| MIN       | Minimum.        | SELECT MIN(HireDate) FROM Emp;   |
| MAX       | Maximum.        | SELECT MAX(Salary) FROM Emp;     |

---

# 📈 **Window / Analytic Functions**

| Function    | Description        | Example                               |
| ----------- | ------------------ | ------------------------------------- |
| ROW_NUMBER  | Sequential number. | ROW_NUMBER() OVER(ORDER BY ID)        |
| RANK        | Rank with gaps.    | RANK() OVER(ORDER BY Sales DESC)      |
| DENSE_RANK  | Rank without gaps. | DENSE_RANK() OVER(ORDER BY Sales)     |
| NTILE       | Buckets.           | NTILE(4) OVER(ORDER BY Score)         |
| LAG         | Previous row.      | LAG(Sales) OVER(ORDER BY Month)       |
| LEAD        | Next row.          | LEAD(Sales) OVER(ORDER BY Month)      |
| FIRST_VALUE | First value.       | FIRST_VALUE(Amount) OVER(ORDER BY Dt) |
| LAST_VALUE  | Last value.        | LAST_VALUE(Amount) OVER(ORDER BY Dt)  |

---

# 🧬 **System Information Functions**

| Function       | Description         | Example                           |
| -------------- | ------------------- | --------------------------------- |
| @@ROWCOUNT     | Rows affected.      | SELECT @@ROWCOUNT;                |
| @@ERROR        | Last error code.    | SELECT @@ERROR;                   |
| @@TRANCOUNT    | Transaction depth.  | SELECT @@TRANCOUNT;               |
| SCOPE_IDENTITY | Identity in scope.  | SELECT SCOPE_IDENTITY();          |
| IDENT_CURRENT  | Identity for table. | SELECT IDENT_CURRENT('T');        |
| SERVERPROPERTY | Server metadata.    | SELECT SERVERPROPERTY('Edition'); |

---

# 🗂️ **Metadata Functions**

| Function       | Description       | Example                                                      |
| -------------- | ----------------- | ------------------------------------------------------------ |
| OBJECT_ID      | Object ID.        | SELECT OBJECT_ID('dbo.Emp');                                 |
| OBJECT_NAME    | Name from ID.     | SELECT OBJECT_NAME(123);                                     |
| TYPE_ID        | Data type ID.     | SELECT TYPE_ID('int');                                       |
| TYPE_NAME      | Type name.        | SELECT TYPE_NAME(56);                                        |
| COL_LENGTH     | Column length.    | SELECT COL_LENGTH('dbo.Emp','Name');                         |
| COLUMNPROPERTY | Column attribute. | SELECT COLUMNPROPERTY(OBJECT_ID('Emp'),'Name','AllowsNull'); |

---

# 🔍 **Full-Text Functions**

| Function      | Description            | Example                                              |
| ------------- | ---------------------- | ---------------------------------------------------- |
| CONTAINS      | Full-text search.      | SELECT * FROM Docs WHERE CONTAINS(Text,'analytics'); |
| FREETEXT      | Meaning-based search.  | SELECT * FROM Docs WHERE FREETEXT(Text,'plan');      |
| CONTAINSTABLE | Ranked match.          | SELECT * FROM CONTAINSTABLE(Docs,Text,'data');       |
| FREETEXTTABLE | Ranked semantic match. | SELECT * FROM FREETEXTTABLE(Docs,Text,'policy');     |

---

# 🔐 **Cryptographic Functions**

| Function            | Description       | Example                                     |
| ------------------- | ----------------- | ------------------------------------------- |
| HASHBYTES           | Hash computation. | SELECT HASHBYTES('SHA2_256','Hello');       |
| ENCRYPTBYPASSPHRASE | Encryption.       | SELECT ENCRYPTBYPASSPHRASE('pw','data');    |
| DECRYPTBYPASSPHRASE | Decryption.       | SELECT DECRYPTBYPASSPHRASE('pw',Encrypted); |

---

# 🧮 **JSON Functions**

| Function   | Description           | Example                             |
| ---------- | --------------------- | ----------------------------------- |
| JSON_VALUE | Extract scalar value. | SELECT JSON_VALUE(@json,'$.name');  |
| JSON_QUERY | Extract object/array. | SELECT JSON_QUERY(@json,'$.items'); |
| OPENJSON   | Parse JSON into rows. | SELECT * FROM OPENJSON(@json);      |


