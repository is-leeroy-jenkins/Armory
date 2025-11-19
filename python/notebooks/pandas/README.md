# 🐼 **Pandas Tutorial — A Practical Guide for Data Analysis**

Pandas is the foundational Python library for data analysis. It provides fast, flexible, and expressive data structures—`Series` and `DataFrame`—to help you clean, explore, transform, and analyze structured datasets. This tutorial offers a clear, example-driven walkthrough of the most essential concepts you'll use every day as a data scientist, analyst, or engineer.

---

## 📦 **1. Importing Pandas & Understanding Core Data Structures**

Pandas offers two primary objects:
**Series**, a 1-dimensional labeled array, and
**DataFrame**, a 2-dimensional labeled table similar to Excel or SQL tables.

* 🧩 Series = 1D labeled array (index + data).
* 📑 DataFrame = 2D table (rows + columns).
* 🧱 Column types can differ (int, float, string, objects).
* 🔍 Index labels enable alignment and intuitive selection.
* ⚙️ Pandas builds on NumPy.

### **Code Example**

```python
import pandas as pd

# Series
s = pd.Series([10, 20, 30], index=['A', 'B', 'C'])
print(s)

# DataFrame
df = pd.DataFrame({
    'Name': ['Alice', 'Bob', 'Chris'],
    'Age': [25, 30, 22],
    'Score': [88.5, 92.0, 79.5]
})
print(df)
```

---

## 📥 **2. Reading Data from Files**

Pandas supports numerous file types: CSV, Excel, JSON, SQL, Parquet, and more.

* 📄 Read CSV: `pd.read_csv()`.
* 📊 Read Excel: `pd.read_excel()`.
* 🗂️ Read SQL queries via connections.
* ✍️ Auto-type detection with ability to override.
* ⚠️ Use options (encoding, delim, header) for messy files.

### **Code Example**

```python
import pandas as pd

# CSV
df = pd.read_csv('employees.csv')

# Excel
df2 = pd.read_excel('budget.xlsx')

# JSON
df3 = pd.read_json('data.json')

print(df.head())
```

---

## 🧭 **3. Selecting, Filtering & Indexing**

Selection in Pandas uses **labels**, **integer positions**, and **logical filters**.

* 🎯 `.loc[]` = label-based selection.
* 🔢 `.iloc[]` = position-based selection.
* 🔎 Boolean filters let you query rows.
* 🪓 Column selection via attribute or key.
* 🎣 Chaining operations is powerful but must be used carefully.

### **Code Example**

```python
# Column
df['Age']

# Multiple columns
df[['Name', 'Score']]

# Row by label
df.loc[0]

# Row by position
df.iloc[2]

# Filtering
adults = df[df['Age'] >= 25]
print(adults)
```

---

## 🧹 **4. Cleaning & Preparing Data**

Real-world datasets are noisy. Pandas has extensive utilities for cleaning.

* 🔄 Handle missing values with `.fillna()` or `.dropna()`.
* 🧽 Transform text: `.str.lower()`, `.str.replace()`.
* 🔢 Convert types with `.astype()`.
* 🧮 Handle duplicates with `.duplicated()` and `.drop_duplicates()`.
* 🧱 Normalize values with `.apply()` or vectorized operations.

### **Code Example**

```python
# Missing values
df['Score'] = df['Score'].fillna(df['Score'].mean())

# Drop rows with any NaN values
clean_df = df.dropna()

# Convert type
df['Age'] = df['Age'].astype(int)

# Remove duplicates
df = df.drop_duplicates()

# String cleaning
df['Name'] = df['Name'].str.strip().str.title()
```

---

## 🔧 **5. Adding, Updating & Removing Columns**

Pandas makes column manipulation intuitive and consistent.

* ➕ Add new derived columns.
* 🔄 Update columns with vectorized operations.
* ➖ Drop columns using `axis=1`.
* 🧮 Computed columns support arithmetic and conditions.
* 🎛️ Use `.assign()` for method-chaining pipelines.

### **Code Example**

```python
# Add new column
df['Score_Adj'] = df['Score'] * 1.05

# Conditional column
df['Status'] = df['Score'].apply(lambda x: 'Pass' if x >= 80 else 'Fail')

# Drop column
df = df.drop('Age', axis=1)

# Assign method
df = df.assign(Rank=lambda d: d['Score'].rank(ascending=False))
```

---

## 🔢 **6. Sorting & Ranking**

Sorting and ranking help with ordering and priority scoring.

* ⬇️ `.sort_values()` sorts by column(s).
* 🔢 `.sort_index()` sorts by row index.
* 🥇 `.rank()` provides ranking metrics.
* ⬆️ Multi-column sorts support ascending/descending mix.
* 🏷️ Stable sorting ensures predictable ordering.

### **Code Example**

```python
# Sort by score ascending
df_sorted = df.sort_values('Score')

# Sort by two columns
df_sorted2 = df.sort_values(['Status', 'Score'], ascending=[True, False])

# Ranking
df['Rank'] = df['Score'].rank(ascending=False)
```

---

## 🧮 **7. Grouping, Aggregations & Summaries**

Grouping enables SQL-style analysis over categories.

* 📚 `.groupby()` creates grouped objects.
* 🧾 Aggregate with `sum`, `mean`, `count`, etc.
* 🛠️ Use `.agg()` for multiple operations.
* 🧱 Multi-index results preserve grouping layers.
* 📈 Ideal for pivot-style summaries.

### **Code Example**

```python
# Group by status
grouped = df.groupby('Status').agg({
    'Score': ['mean', 'max', 'min', 'count']
})

print(grouped)
```

---

## 🔄 **8. Merging, Joining & Concatenating**

Combine datasets easily using SQL-style joins & operations.

* 🔗 `merge()` behaves like SQL JOIN (inner, outer, left, right).
* 🧱 `concat()` stacks DataFrames vertically or horizontally.
* 🧬 Join on columns or indices.
* 🔄 Mismatched keys produce NaN for missing values.
* 🗂️ Ideal for multi-file ingestion.

### **Code Example**

```python
# Merge on key
merged = pd.merge(df, df2, on='Name', how='inner')

# Vertical stack
stacked = pd.concat([df, df], axis=0)

# Horizontal combine
wide = pd.concat([df, df2], axis=1)
```

---

## 📊 **9. Pivot Tables & Reshaping**

Pivot tables mirror Excel's summarization capabilities.

* 🔁 `pivot()` reshapes columns into a matrix.
* 📘 `pivot_table()` supports aggregation.
* 🔽 `melt()` unpivots wide → long.
* 🪢 `stack()` and `unstack()` manage multi-indexes.
* 🧬 Useful for time series, categorical summaries, reporting.

### **Code Example**

```python
# Pivot table (Excel-style)
pivot = df.pivot_table(
    values='Score',
    index='Status',
    aggfunc='mean'
)

# Melt example
long = pd.melt(df, id_vars='Name', var_name='Metric', value_name='Value')

print(long)
```

---

## 📈 **10. Time Series Handling**

Pandas provides industry-standard tools for time series.

* 🕒 Convert strings to datetime via `pd.to_datetime()`.
* 🗓️ Set datetime index for powerful slicing.
* ➕ Resample up/down with `.resample()`.
* 🧮 Rolling windows: `.rolling()`.
* 📉 Shift data with `.shift()`.

### **Code Example**

```python
# Parse date
df['Date'] = pd.to_datetime(df['Date'])

# Set index
df = df.set_index('Date')

# Resample monthly
monthly_avg = df['Score'].resample('M').mean()

# Rolling mean
df['Rolling_7'] = df['Score'].rolling(7).mean()
```

---

## 📤 **11. Exporting Data**

Save cleaned and transformed data to various formats.

* 💾 Save CSV: `df.to_csv()`.
* 📘 Save Excel: `df.to_excel()`.
* 🪢 Save JSON or Parquet for pipelines.
* 🌐 Store to databases with `.to_sql()`.
* ⚙️ Include index control and encoding options.

### **Code Example**

```python
# Export to CSV
df.to_csv('cleaned.csv', index=False)

# Export to Excel
df.to_excel('report.xlsx', index=False)

# JSON
df.to_json('out.json', orient='records')
```

---

If you'd like, I can also produce:

✅ A **Jupyter-ready .ipynb JSON notebook**
✅ A **GitHub-ready README.md**
✅ Versions with expanded sections or more examples
✅ A "Pandas Cookbook" with 50+ advanced recipes

Just tell me what you want next, Bro.
