SELECT 
    Contract,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN TotalCharges ELSE 0 END), 2) AS revenue_lost,
    ROUND(SUM(TotalCharges), 2) AS total_revenue,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN TotalCharges ELSE 0 END) / SUM(TotalCharges) * 100, 2) AS pct_revenue_lost
FROM telco_data
GROUP BY Contract;
