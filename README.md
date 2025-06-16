# :phone: Telco Customer Churn - SQL Project (part 1)

This project analyzes customer churn behavior in the telecom industry. The project is split into two parts, first part I used SQL on the Telco Customer Churn dataset, where the goal was to clean the dataset, explore patterns related to churn and customer behavior. The second part will involve building a Neural Network and make prediction on Churn, in progess.

- 📂 The dataset used in this project is available via Kaggle: \
 <a href="https://www.kaggle.com/datasets/blastchar/telco-customer-churn"> Telco Customer Churn - BlastChar </a>
- 🛠️ Tools used MySQL, DbGate and Workbench
- All code can be seen in the SQL folder \
  (hyperlink to the folder in GitHub )
- 2nd part of the project is still in progress, will be published here (hyperlink to README for part 2, it will be blank with a header and saying brief project details and status in progress) \
<a href="Github link"> Name of project, pro something like Telco Customer Churn - ML Project (part 2) </a>

## 🧹 Data Cleaning
The dataset contains 7,043 customer with 21 columns related to bla bla bla:

- Loaded raw data as VARCHAR
- Identified and removed blank `TotalCharges` rows (11 rows)
- Converted `TotalCharges` and `MonthlyCharges` to numeric values ➡️ `DECIMAL`
- Converted `SeniorCitizen` to binary numeric  ➡️ `TINYINT(1)`
  
*Please note, 11 rows with missing TotalCharges were dropped for the SQL EDA but in the ML phase, these rows will be re-evaluated.*
  
### Column overview

