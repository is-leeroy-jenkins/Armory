# 🧠 Power BI + Python Integration Tutorial

A complete, self-contained tutorial demonstrating how to use **Python** within **Microsoft Power BI** for data transformation, analytics, machine learning, and custom visualizations.
It also includes examples of Power BI Desktop automation and environment configuration.

---

## 📘 Overview

This repository contains:

* A ready-to-run **Jupyter Notebook (`PowerBI_Python_Full_Tutorial.ipynb`)**
* Example Python scripts for:

  * Power Query data cleaning
  * Statistical and ML modeling
  * Visualization with `matplotlib` and `seaborn`
  * Automating Power BI Desktop via Python

The notebook is designed to mirror how Python operates inside Power BI:

* **Power Query Layer** → Python for ETL (returns a `pandas.DataFrame`)
* **Report Canvas** → Python Visuals using the `dataset` variable
* **Automation Layer** → Python for scheduling, REST API, and desktop control

---

## ⚙️ Environment Setup

### Requirements

* **Power BI Desktop** (latest release)
* **Python 3.10+**
* Recommended libraries:

  ```
  pip install pandas numpy matplotlib seaborn scikit-learn statsmodels wordcloud psutil
  ```

### Configure Power BI to Use Python

1. Open **File → Options and Settings → Options → Python scripting**.
2. Set your Python home directory (for example):
   `C:\Users\<User>\AppData\Local\Programs\Python\Python310`

---

## 📊 Tutorial Highlights

### 1. Data Transformation with Python (Power Query)

```python
import pandas as pd
df = pd.read_csv("C:/Data/appropriations.csv")
df["Date"] = pd.to_datetime(df["Date"])
df.fillna(0, inplace=True)
grouped = df.groupby("Title")["Obligations"].sum().reset_index()
```

### 2. Python Visuals in Power BI

```python
import matplotlib.pyplot as plt
import seaborn as sns

sns.barplot(x="Agency", y="BudgetAuthority", data=dataset)
plt.title("Budget Authority by Agency (FY2024)")
plt.xticks(rotation=45)
plt.tight_layout()
plt.show()
```

### 3. Machine Learning Forecast

```python
from sklearn.linear_model import LinearRegression
from sklearn.model_selection import train_test_split
from sklearn.metrics import r2_score

X = dataset[["FiscalYear"]]
y = dataset["Outlays"]
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2)
model = LinearRegression().fit(X_train, y_train)
pred = model.predict(X_test)
r2 = r2_score(y_test, pred)
```

### 4. Statistical Smoothing

```python
from statsmodels.tsa.holtwinters import ExponentialSmoothing
model = ExponentialSmoothing(dataset["Outlays"], trend="add").fit()
model.fittedvalues.plot(title="Holt-Winters Trend Forecast")
```

### 5. Word Cloud from Text Fields

```python
from wordcloud import WordCloud
text = " ".join(dataset["Justification"])
WordCloud(width=900, height=400).generate(text).to_image()
```

### 6. Automate Power BI Desktop (Windows)

```python
import subprocess, psutil, time
from pathlib import Path

def open_powerbi_report_auto(report, exe, duration=300):
    rp = Path(report)
    proc = subprocess.Popen([exe, str(rp)])
    time.sleep(duration)
    for p in psutil.process_iter(["name"]):
        if "PBIDesktop" in p.info.get("name",""):
            p.terminate()
```

---

## 📂 Repository Structure

```
├── PowerBI_Python_Full_Tutorial.ipynb   # Main Jupyter notebook
├── PowerBI_Python_Tutorial.py           # Optional script form
├── README.md                            # This file
└── data/                                # (Optional) sample or synthetic data
```

---

## 🧩 Key Topics Covered

| Area                         | Examples                                   |
| ---------------------------- | ------------------------------------------ |
| **ETL / Data Prep**          | `pandas`, `numpy`                          |
| **Modeling**                 | `scikit-learn`, `statsmodels`              |
| **Visualization**            | `matplotlib`, `seaborn`, `plotly`          |
| **Text Analytics**           | `wordcloud`, `nltk`, `spacy`               |
| **Automation / Integration** | `subprocess`, `psutil`, `requests`, `msal` |

---

## 🧠 Best Practices

* Keep the Power BI Gateway Python environment identical to your Desktop environment.
* Avoid external API calls in Service-executed Python scripts.
* Use small, vectorized DataFrames (prefer under 500 MB).
* Cache transformations in Power Query where possible.
* Document script parameters and expected DataFrame columns.

---

## 🧾 License

MIT License © 2025 Terry D. Eppler

```
Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the “Software”), to deal
in the Software without restriction...
```

---

## ✉️ Contact

**Author:** Terry D. Eppler
**Email:** [terryeppler@gmail.com](mailto:terryeppler@gmail.com)
