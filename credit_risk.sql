-- ================================================================
-- LOAN DEFAULT RISK ANALYSIS
-- Author: Aman Raza
-- Database: credit_risk_analysis
-- Table: credit_risk
-- Tool: MySQL 8.0+
--
-- Before running:
-- 1. Create/import the source table as `credit_risk` in this database.
-- 2. Confirm that `loan_status` is coded as 1 = Default, 0 = Non-default.
-- 3. Run the verification queries first and confirm the row count.
-- ================================================================

CREATE DATABASE IF NOT EXISTS credit_risk_analysis;
USE credit_risk_analysis;

-- ================================================================
-- 1. DATA VERIFICATION
-- ================================================================

-- Q1. Total records
SELECT COUNT(*) AS Total_Records
FROM credit_risk;

-- Q2. Preview records
SELECT *
FROM credit_risk
LIMIT 10;

-- Q3. Inspect table columns and data types
DESCRIBE credit_risk;


-- ================================================================
-- 2. OVERALL BUSINESS KPIs
-- ================================================================

-- Q4. Overall loan portfolio and default KPIs
SELECT
    COUNT(*) AS Total_Loans,
    SUM(CASE WHEN loan_status = 1 THEN 1 ELSE 0 END) AS Total_Defaults,
    SUM(CASE WHEN loan_status = 0 THEN 1 ELSE 0 END) AS Total_NonDefaults,
    ROUND(100.0 * SUM(CASE WHEN loan_status = 1 THEN 1 ELSE 0 END)
          / NULLIF(COUNT(*), 0), 2) AS Default_Rate_Pct,
    ROUND(AVG(loan_amnt), 2) AS Avg_Loan_Amount,
    ROUND(AVG(loan_int_rate), 2) AS Avg_Interest_Rate,
    ROUND(AVG(person_income), 2) AS Avg_Income
FROM credit_risk;

-- Q5. Total loan amount and amount associated with defaults
SELECT
    ROUND(SUM(loan_amnt), 2) AS Total_Loan_Amount,
    ROUND(SUM(CASE WHEN loan_status = 1 THEN loan_amnt ELSE 0 END), 2)
        AS Defaulted_Loan_Amount,
    ROUND(
        100.0 * SUM(CASE WHEN loan_status = 1 THEN loan_amnt ELSE 0 END)
        / NULLIF(SUM(loan_amnt), 0), 2
    ) AS Defaulted_Amount_Pct
FROM credit_risk;


-- ================================================================
-- 3. DEFAULT ANALYSIS BY LOAN GRADE
-- ================================================================

-- Q6. Default rate, average interest rate and average loan amount by grade
SELECT
    loan_grade,
    COUNT(*) AS Total_Loans,
    SUM(CASE WHEN loan_status = 1 THEN 1 ELSE 0 END) AS Defaults,
    ROUND(100.0 * AVG(loan_status), 2) AS Default_Rate_Pct,
    ROUND(AVG(loan_int_rate), 2) AS Avg_Interest_Rate,
    ROUND(AVG(loan_amnt), 2) AS Avg_Loan_Amount
FROM credit_risk
GROUP BY loan_grade
ORDER BY loan_grade;

-- Q7. Assign a risk category to each loan grade
SELECT
    loan_grade,
    COUNT(*) AS Total_Loans,
    ROUND(100.0 * AVG(loan_status), 2) AS Default_Rate_Pct,
    CASE
        WHEN AVG(loan_status) * 100 < 10 THEN 'Low Risk'
        WHEN AVG(loan_status) * 100 < 30 THEN 'Medium Risk'
        WHEN AVG(loan_status) * 100 < 50 THEN 'High Risk'
        ELSE 'Very High Risk'
    END AS Risk_Category
FROM credit_risk
GROUP BY loan_grade
ORDER BY loan_grade;


-- ================================================================
-- 4. DEFAULT ANALYSIS BY LOAN INTENT
-- ================================================================

-- Q8. Default rate by loan purpose
SELECT
    loan_intent,
    COUNT(*) AS Total_Loans,
    SUM(CASE WHEN loan_status = 1 THEN 1 ELSE 0 END) AS Defaults,
    ROUND(100.0 * AVG(loan_status), 2) AS Default_Rate_Pct,
    ROUND(AVG(loan_amnt), 2) AS Avg_Loan_Amount
FROM credit_risk
GROUP BY loan_intent
ORDER BY Default_Rate_Pct DESC;


-- ================================================================
-- 5. DEFAULT ANALYSIS BY INCOME
-- ================================================================

-- Q9. Default rate by income bracket
SELECT
    CASE
        WHEN person_income < 30000 THEN 'Low (<30K)'
        WHEN person_income < 60000 THEN 'Mid (30K-60K)'
        WHEN person_income < 100000 THEN 'High (60K-100K)'
        ELSE 'Very High (100K+)'
    END AS Income_Bracket,
    COUNT(*) AS Total_Loans,
    SUM(CASE WHEN loan_status = 1 THEN 1 ELSE 0 END) AS Defaults,
    ROUND(100.0 * AVG(loan_status), 2) AS Default_Rate_Pct,
    ROUND(AVG(loan_amnt), 2) AS Avg_Loan_Amount
FROM credit_risk
GROUP BY Income_Bracket
ORDER BY
    CASE Income_Bracket
        WHEN 'Low (<30K)' THEN 1
        WHEN 'Mid (30K-60K)' THEN 2
        WHEN 'High (60K-100K)' THEN 3
        ELSE 4
    END;


-- ================================================================
-- 6. INTEREST RATE ANALYSIS
-- ================================================================

-- Q10. Compare defaults for high-interest and lower-interest loans
SELECT
    CASE
        WHEN loan_int_rate > 15 THEN 'High Interest (>15%)'
        ELSE 'Low Interest (<=15%)'
    END AS Interest_Category,
    COUNT(*) AS Total_Loans,
    SUM(CASE WHEN loan_status = 1 THEN 1 ELSE 0 END) AS Defaults,
    ROUND(100.0 * AVG(loan_status), 2) AS Default_Rate_Pct,
    ROUND(AVG(loan_int_rate), 2) AS Avg_Interest_Rate
FROM credit_risk
GROUP BY Interest_Category
ORDER BY Default_Rate_Pct DESC;

-- Q11. Default rate by interest-rate bracket
SELECT
    CASE
        WHEN loan_int_rate < 8 THEN 'Very Low (<8%)'
        WHEN loan_int_rate < 12 THEN 'Low (8-12%)'
        WHEN loan_int_rate < 16 THEN 'Medium (12-16%)'
        WHEN loan_int_rate < 20 THEN 'High (16-20%)'
        ELSE 'Very High (20%+)'
    END AS Rate_Bracket,
    COUNT(*) AS Total_Loans,
    ROUND(100.0 * AVG(loan_status), 2) AS Default_Rate_Pct
FROM credit_risk
GROUP BY Rate_Bracket
ORDER BY
    CASE Rate_Bracket
        WHEN 'Very Low (<8%)' THEN 1
        WHEN 'Low (8-12%)' THEN 2
        WHEN 'Medium (12-16%)' THEN 3
        WHEN 'High (16-20%)' THEN 4
        ELSE 5
    END;


-- ================================================================
-- 7. AGE GROUP ANALYSIS
-- ================================================================

-- Q12. Default rate by borrower age group
SELECT
    CASE
        WHEN person_age BETWEEN 18 AND 25 THEN '18-25'
        WHEN person_age BETWEEN 26 AND 35 THEN '26-35'
        WHEN person_age BETWEEN 36 AND 45 THEN '36-45'
        WHEN person_age BETWEEN 46 AND 60 THEN '46-60'
        ELSE '60+'
    END AS Age_Group,
    COUNT(*) AS Total_Loans,
    SUM(CASE WHEN loan_status = 1 THEN 1 ELSE 0 END) AS Defaults,
    ROUND(100.0 * AVG(loan_status), 2) AS Default_Rate_Pct,
    ROUND(AVG(loan_amnt), 2) AS Avg_Loan_Amount
FROM credit_risk
GROUP BY Age_Group
ORDER BY
    CASE Age_Group
        WHEN '18-25' THEN 1
        WHEN '26-35' THEN 2
        WHEN '36-45' THEN 3
        WHEN '46-60' THEN 4
        ELSE 5
    END;


-- ================================================================
-- 8. SUBQUERIES
-- ================================================================

-- Q13. Top 20 loans above the overall average loan amount
SELECT
    loan_grade,
    loan_intent,
    loan_amnt,
    loan_int_rate,
    loan_status
FROM credit_risk
WHERE loan_amnt > (SELECT AVG(loan_amnt) FROM credit_risk)
ORDER BY loan_amnt DESC
LIMIT 20;

-- Q14. Count borrowers who defaulted and have above-average interest rates
SELECT
    COUNT(*) AS High_Interest_Defaulters
FROM credit_risk
WHERE loan_int_rate > (SELECT AVG(loan_int_rate) FROM credit_risk)
  AND loan_status = 1;


-- ================================================================
-- 9. COMMON TABLE EXPRESSIONS (CTEs)
-- ================================================================

-- Q15. Grade-wise default summary with risk labels
WITH GradeSummary AS (
    SELECT
        loan_grade,
        COUNT(*) AS Total_Loans,
        SUM(CASE WHEN loan_status = 1 THEN 1 ELSE 0 END) AS Total_Defaults,
        AVG(loan_status) * 100 AS Default_Rate
    FROM credit_risk
    GROUP BY loan_grade
)
SELECT
    loan_grade,
    Total_Loans,
    Total_Defaults,
    ROUND(Default_Rate, 2) AS Default_Rate_Pct,
    CASE
        WHEN Default_Rate < 10 THEN 'Low Risk'
        WHEN Default_Rate < 30 THEN 'Medium Risk'
        ELSE 'High Risk'
    END AS Risk_Label
FROM GradeSummary
ORDER BY Default_Rate DESC;

-- Q16. Segment loans by low income and high interest rate
WITH HighRiskLoans AS (
    SELECT
        *,
        CASE
            WHEN person_income < 30000 AND loan_int_rate > 15
                THEN 'Low Income + High Interest'
            ELSE 'Other Borrowers'
        END AS Risk_Flag
    FROM credit_risk
)
SELECT
    Risk_Flag,
    COUNT(*) AS Total_Loans,
    SUM(CASE WHEN loan_status = 1 THEN 1 ELSE 0 END) AS Defaults,
    ROUND(100.0 * AVG(loan_status), 2) AS Default_Rate_Pct
FROM HighRiskLoans
GROUP BY Risk_Flag;


-- ================================================================
-- 10. WINDOW FUNCTIONS
-- ================================================================

-- Q17. Rank the 20 largest loans
SELECT
    loan_grade,
    loan_intent,
    person_income,
    loan_amnt,
    loan_int_rate,
    loan_status,
    RANK() OVER (ORDER BY loan_amnt DESC) AS Loan_Rank
FROM credit_risk
ORDER BY loan_amnt DESC
LIMIT 20;

-- Q18. Number loans within each grade, largest loan first
SELECT
    loan_grade,
    loan_amnt,
    loan_status,
    ROW_NUMBER() OVER (
        PARTITION BY loan_grade
        ORDER BY loan_amnt DESC
    ) AS Row_Num
FROM credit_risk
ORDER BY loan_grade, Row_Num
LIMIT 30;

-- Q19. Rank loan grades by default rate
SELECT
    loan_grade,
    ROUND(100.0 * AVG(loan_status), 2) AS Default_Rate_Pct,
    DENSE_RANK() OVER (
        ORDER BY AVG(loan_status) DESC
    ) AS Risk_Rank
FROM credit_risk
GROUP BY loan_grade
ORDER BY Risk_Rank;

-- Q20. Running total of defaults by loan grade
SELECT
    loan_grade,
    SUM(CASE WHEN loan_status = 1 THEN 1 ELSE 0 END) AS Defaults,
    SUM(SUM(CASE WHEN loan_status = 1 THEN 1 ELSE 0 END)) OVER (
        ORDER BY loan_grade
    ) AS Running_Total_Defaults
FROM credit_risk
GROUP BY loan_grade
ORDER BY loan_grade;


-- ================================================================
-- 11. HAVING CLAUSE
-- ================================================================

-- Q21. Loan intents with a default rate above 20%
SELECT
    loan_intent,
    COUNT(*) AS Total_Loans,
    ROUND(100.0 * AVG(loan_status), 2) AS Default_Rate_Pct
FROM credit_risk
GROUP BY loan_intent
HAVING AVG(loan_status) > 0.20
ORDER BY Default_Rate_Pct DESC;

-- Q22. Loan grades with more than 500 defaults
SELECT
    loan_grade,
    SUM(CASE WHEN loan_status = 1 THEN 1 ELSE 0 END) AS Total_Defaults,
    ROUND(100.0 * AVG(loan_status), 2) AS Default_Rate_Pct
FROM credit_risk
GROUP BY loan_grade
HAVING SUM(CASE WHEN loan_status = 1 THEN 1 ELSE 0 END) > 500
ORDER BY Total_Defaults DESC;


-- ================================================================
-- 12. FINAL BUSINESS INSIGHT QUERY
-- ================================================================

-- Q23. Default-rate profile by grade, income segment and interest segment
SELECT
    loan_grade,
    CASE
        WHEN person_income < 30000 THEN 'Low Income'
        WHEN person_income < 60000 THEN 'Mid Income'
        ELSE 'High Income'
    END AS Income_Segment,
    CASE
        WHEN loan_int_rate > 15 THEN 'High Interest'
        ELSE 'Normal Interest'
    END AS Rate_Segment,
    COUNT(*) AS Total_Loans,
    ROUND(100.0 * AVG(loan_status), 2) AS Default_Rate_Pct
FROM credit_risk
GROUP BY loan_grade, Income_Segment, Rate_Segment
HAVING COUNT(*) > 50
ORDER BY Default_Rate_Pct DESC
LIMIT 15;

-- END OF ANALYSIS
