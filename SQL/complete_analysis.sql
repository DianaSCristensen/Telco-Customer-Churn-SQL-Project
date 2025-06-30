-- 1. CREATE & LOAD TABLE

CREATE TABLE telco_data (
  customerID VARCHAR(50),
  gender VARCHAR(10),
  SeniorCitizen VARCHAR(5),
  Partner VARCHAR(10),
  Dependents VARCHAR(10),
  tenure VARCHAR(10),
  PhoneService VARCHAR(10),
  MultipleLines VARCHAR(30),
  InternetService VARCHAR(30),
  OnlineSecurity VARCHAR(30),
  OnlineBackup VARCHAR(30),
  DeviceProtection VARCHAR(30),
  TechSupport VARCHAR(30),
  StreamingTV VARCHAR(30),
  StreamingMovies VARCHAR(30),
  Contract VARCHAR(30),
  PaperlessBilling VARCHAR(10),
  PaymentMethod VARCHAR(50),
  MonthlyCharges VARCHAR(20),
  TotalCharges VARCHAR(20),
  Churn VARCHAR(10)
);

-- Dataset from Kaggle (https://www.kaggle.com/datasets/blastchar/telco-customer-churn)
-- Data manually imported into MySQL Workbench and inserted into the telco_data table.


-- 2. Checked, dropped & updated the table


-- Ran NULL/blank checks on several columns; only TotalCharges had missing values:
SELECT * FROM telco_data
WHERE TRIM(TotalCharges) = '' OR TotalCharges IS NULL; -- 11 rows.

-- 11 rows with missing TotalCharges dropped for the SQL EDA
DELETE FROM telco_data
WHERE TRIM(TotalCharges) = '' OR TotalCharges IS NULL; 

-- Additional checks (examples shown below returned 0 rows): 

SELECT * FROM telco_data
WHERE TRIM(customerID) = '' OR customerID IS NULL; -- 0 rows

SELECT * FROM telco_data
WHERE TRIM(PaymentMethod) = '' OR PaymentMethod IS NULL; -- 0 rows

SELECT * FROM telco_data
WHERE TRIM(InternetService) = '' OR InternetService IS NULL; -- 0 rows

SELECT DISTINCT(gender) 
FROM telco_data; -- Stored as: Female/Male

SELECT DISTINCT(SeniorCitizen)
FROM telco_data; -- binary numerical: 0 = not a senior, 1 = senior

SELECT DISTINCT(Dependents) 
FROM telco_data; -- Stored as: Yes/No 

-- Updating the table:

ALTER TABLE telco_data
MODIFY COLUMN TotalCharges DECIMAL(10,2), -- TotalCharges changed from VARCHAR to numeric
MODIFY COLUMN MonthlyCharges DECIMAL(10,2), --  MonthlyCharges changed from VARCHAR to numeric
MODIFY COLUMN SeniorCitizen TINYINT(1); -- SeniorCitizen changed to binary numeric

DESCRIBE telco_data;

SELECT * FROM telco_data LIMIT 20;


-- 3. EDA


-- The following queries explore churn patterns based on different variables like 
-- gender, contract type, tech support, tenure, payment method, and more.

-- Overall churn rate:
SELECT 
  Churn,
  COUNT(*) AS number_customers,
  ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM telco_data), 2) AS percentage
FROM telco_data
GROUP BY Churn; 

-- Revenue lost by churned contracts
SELECT 
    Contract,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN TotalCharges ELSE 0 END), 2) AS revenue_lost,
    ROUND(SUM(TotalCharges), 2) AS total_revenue,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN TotalCharges ELSE 0 END) / SUM(TotalCharges) * 100, 2) AS pct_revenue_lost
FROM telco_data
GROUP BY Contract;

-- Churn rate by gender
SELECT 
  gender,
  COUNT(*) AS number_customers,
  SUM(IF(Churn = 'Yes', 1, 0)) AS churned, 
  ROUND(SUM(IF(Churn = 'Yes', 1, 0)) / COUNT(*), 2) AS churn_rate
FROM telco_data
GROUP BY gender; 

-- Churn rate by partner status and gender
SELECT 
  Partner,
  gender,
  COUNT(*) AS number_customers,
  ROUND(SUM(IF(Churn = 'Yes', 1, 0)) / COUNT(*), 2) AS churn_rate
FROM telco_data
GROUP BY Partner, gender; 

-- Churn rate by contract type 
SELECT 
    Contract, 
    COUNT(*) AS total_contracts,
    SUM(IF(Churn = 'Yes', 1, 0)) AS churned,
    ROUND(SUM(IF(Churn = 'Yes', 1, 0)) / COUNT(*), 2) AS churn_rate
FROM telco_data
GROUP BY Contract;

-- Average revenue by churn:
SELECT Churn, 
       ROUND(AVG(MonthlyCharges), 2) as avg_monthly,
       ROUND(AVG(TotalCharges), 2) as avg_total
FROM telco_data
GROUP BY Churn;

-- Churn rate by payment method
WITH payment_churn AS (
  SELECT 
    PaymentMethod,
    COUNT(*) AS total,
    SUM(IF(Churn = 'Yes', 1, 0)) AS churned,
    ROUND(SUM(IF(Churn = 'Yes', 1, 0)) / COUNT(*), 2) AS churn_percentage
  FROM telco_data
  GROUP BY PaymentMethod
)
SELECT * FROM payment_churn
ORDER BY churn_percentage DESC;

-- Churn rate by tech support
SELECT 
    TechSupport,
    SUM(IF(Churn = 'Yes', 1, 0)) AS churned_customers,
    ROUND(SUM(IF(Churn = 'Yes', 1, 0)) / COUNT(*), 2) AS churn_rate
FROM telco_data
GROUP BY TechSupport;

-- churn rate by dependents
SELECT 
    Dependents,
    SUM(IF(Churn = 'Yes', 1, 0)) AS churned_customers,
    ROUND(SUM(IF(Churn = 'Yes', 1, 0)) / COUNT(*), 2) AS churn_rate
FROM telco_data
GROUP BY Dependents;

-- churn rate by senior citizen
SELECT 
    SeniorCitizen,
    SUM(IF(Churn = 'Yes', 1, 0)) AS churned_customers,
    ROUND(SUM(IF(Churn = 'Yes', 1, 0)) / COUNT(*), 2) AS churn_rate
FROM telco_data
GROUP BY SeniorCitizen;
    
-- Creating tenure groups and analyze churn:
SELECT 
  CASE 
    WHEN tenure < 12 THEN 'Under 1 year'
    WHEN tenure < 24 THEN '1-2 years'
    ELSE '2+ years'
  END AS tenure_group,
  TechSupport,
  Partner,
  COUNT(*) AS total_customers,
  SUM(IF(Churn = 'Yes', 1, 0)) AS churned_customers,
  ROUND(SUM(IF(Churn = 'Yes', 1, 0)) / COUNT(*), 2) AS churn_rate
FROM telco_data
GROUP BY tenure_group, Partner, TechSupport
ORDER BY tenure_group, churn_rate DESC;
