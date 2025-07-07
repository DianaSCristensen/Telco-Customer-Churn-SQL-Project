SELECT
    Contract, 
    ROUND(SUM(IF(Churn = 'Yes', TotalCharges, 0)), 2) AS revenue_lost, 
    ROUND(SUM(TotalCharges), 2) AS total_revenue, 
    ROUND(SUM(IF(Churn = 'Yes', TotalCharges, 0)) / SUM(TotalCharges) * 100, 2) AS pct_revenue_lost 
FROM telco_data
GROUP BY Contract; 
