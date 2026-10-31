# 🏦 Loan Default Risk Analysis | SQL, Python & Power BI

An end-to-end **Loan Default Risk Analysis** project using MySQL, Python, and Microsoft Power BI to explore borrower data, identify high-risk loan segments, and understand factors associated with loan defaults.

This project demonstrates data cleaning, SQL analysis, exploratory data analysis, KPI development, and interactive dashboard creation.

---

## 📊 Dashboard Preview

![Loan Default Risk Dashboard](credit_risk_dashboard.png)

---

## 🎯 Project Objectives

- Analyze overall loan default and non-default rates.
- Identify high-risk loan grades.
- Understand default patterns across different loan purposes.
- Analyze the relationship between borrower income and loan defaults.
- Evaluate default rates across home ownership categories.
- Compare interest rates and default rates.
- Generate business recommendations from analytical findings.

---

## 🛠️ Tools & Technologies

| Technology | Purpose |
|---|---|
| MySQL | Data querying and analysis |
| Python | Data analysis and processing |
| Jupyter Notebook | Python analysis workflow |
| Pandas | Data manipulation |
| Microsoft Power BI | Interactive dashboard |
| DAX | KPI calculations |
| Power Query | Data transformation |

---

## 📁 Project Files

| File | Description |
|---|---|
| `credit_risk.ipynb` | Python analysis notebook |
| `credit_risk.sql` | SQL queries for loan risk analysis |
| `credit_risk_cleaned.csv` | Cleaned dataset |
| `credit_risk_dashboard.pbix` | Power BI dashboard file |
| `credit_risk_dashboard.png` | Dashboard preview image |
| `README.md` | Project documentation |

---

## 📌 Key Performance Indicators

The current Power BI dashboard displays the following KPIs:

| KPI | Dashboard Value |
|---|---:|
| Total Loans | 32,409 |
| Total Defaults | 7,088 |
| Default Rate | 21.87% |
| Non-Default Rate | 78.13% |
| Average Interest Rate | 11.01% |
| Average Loan Amount | $9,592 |

*Note: These are displayed dashboard values. They should be reconciled with the final cleaned dataset and SQL results before being treated as verified figures.*

---

## 📈 Dashboard Analysis

The Power BI dashboard explores six key areas:

### 1. Default Rate by Loan Grade
Compares default rates across loan grades A to G to identify higher-risk credit segments.

### 2. Default Rate by Loan Intent
Analyzes loan defaults across different purposes, including:
- Debt Consolidation
- Medical
- Home Improvement
- Personal
- Education
- Venture

### 3. Loan Status Distribution
Shows the distribution of default and non-default loans.

### 4. Default Rate by Income Bracket
Explores how borrower income levels relate to loan default patterns.

### 5. Default Rate vs Average Interest Rate
Compares default rates and average interest rates across loan grades.

### 6. Default Rate by Home Ownership
Examines default patterns across different home ownership categories.

---

## 🔍 Key Business Insights

The current dashboard indicates the following patterns:

### Credit Grade Analysis
- Grade G shows the highest displayed default rate, approximately 98.44%.
- Grade A shows the lowest displayed default rate, approximately 9.96%.
- Lower loan grades show substantially higher default rates.

### Income Analysis
- Borrowers earning below $30K show a displayed default rate of 47.20%.
- Borrowers earning $100K or more show a displayed default rate of 8.95%.

### Loan Intent Analysis
- Debt Consolidation shows a displayed default rate of 28.68%.
- Venture loans show a displayed default rate of 14.86%.

### Home Ownership Analysis
- RENT borrowers show a displayed default rate of 31.61%.
- OTHER borrowers show a displayed default rate of 31.13%.
- OWN borrowers show a displayed default rate of 7.49%.

*These observations are descriptive findings from the current dashboard and should be validated against the final data.*

---

## 🗄️ SQL Analysis

The SQL file includes analysis using:

- SELECT, WHERE and ORDER BY
- COUNT, SUM and AVG
- GROUP BY and HAVING
- CASE WHEN statements
- Subqueries
- Common Table Expressions (CTEs)
- Window Functions:
  - RANK()
  - DENSE_RANK()
  - ROW_NUMBER()
- Default rate calculations
- Loan risk segmentation

---

## 🐍 Python Analysis

The project includes a Jupyter Notebook (`credit_risk.ipynb`) for Python-based data analysis and processing.

The cleaned dataset is available as `credit_risk_cleaned.csv`.

---

## 🎛️ Interactive Dashboard Features

The Power BI dashboard provides interactive analysis through slicers for:

- Loan Grade
- Loan Intent
- Home Ownership
- Risk Category

These filters help explore loan default patterns across borrower segments.

---

## 💡 Business Recommendations

Based on the patterns observed in the dashboard:

1. Apply enhanced risk assessment to borrowers in higher-risk loan grades.
2. Carefully evaluate repayment capacity among lower-income applicants.
3. Strengthen underwriting checks for debt consolidation loans.
4. Consider loan grade, income, loan purpose, and interest rate together when evaluating lending risk.
5. Monitor default patterns regularly to support better lending decisions.

*These recommendations are based on descriptive analysis and do not represent a validated credit scoring or loan approval model.*

---

## 🚀 Project Outcome

This project demonstrates practical experience in:

- SQL-based data analysis
- Python and Pandas
- Data cleaning and processing
- Exploratory data analysis
- Power BI dashboard development
- DAX and KPI calculations
- Business insights and data storytelling
- Loan default risk analysis

---

## 👨‍💻 About Me

**Aman Raza**  
Aspiring Data Analyst | M.Sc. Mathematics

**Technical Skills:** SQL | Python | Pandas | Power BI | Excel

- **GitHub:** [amanraza9955](https://github.com/amanraza9955)
- **LinkedIn:** [Aman Raza](https://linkedin.com/in/aman-raza-ds)

---

⭐ If you find this project useful, feel free to explore the repository and share your feedback.
