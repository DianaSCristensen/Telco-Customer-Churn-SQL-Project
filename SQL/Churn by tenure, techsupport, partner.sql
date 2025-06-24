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
