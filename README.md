# :phone: Telco Customer Churn - SQL project (part 1)

This project analyzes customer churn behavior in the telecom industry, data provided by Kaggle. The project is split into two parts, first part I used SQL on the Telco Customer Churn dataset, where the goal was to clean the dataset, explore patterns related to churn and customer behavior. The second part will involve building a Neural Network and make prediction on Churn, in progess.

- 📂 The dataset used in this project is available via Kaggle: \
 <a href="https://www.kaggle.com/datasets/blastchar/telco-customer-churn"> Telco Customer Churn - BlastChar </a>
- 🛠️ Tools used MySQL, DbGate and MySQL Workbench
- 📗 All code can be seen in the SQL folder \
  (hyperlink to the folder in GitHub )
- (emoji) 2nd part of the project is still in progress, will be published here (hyperlink to README for part 2, it will be blank with a header and saying brief project details and status in progress) \
<a href="Github link"> Name of project, pro something like Telco Customer Churn - ML Project (part 2) </a>

## 🧹 Data cleaning
The dataset contains 7,043 customer with 21 columns related to bla bla bla:

- Loaded raw data as VARCHAR
- Identified and removed blank spaces ➡️ from `TotalCharges` 11 rows was dropped
- Converted `TotalCharges` and `MonthlyCharges` to numeric values ➡️ `DECIMAL`
- Converted `SeniorCitizen` to binary numeric  ➡️ `TINYINT(1)`
  
*Please note, 11 rows with missing TotalCharges were dropped for the SQL EDA but in the ML phase, these rows will be re-evaluated.*
  
### 🔎 Column overview

*Make a table with a overview*

## :bar_chart: EDA 

### Overall churn rate 

Out of all the customers, 26.6% (1,869 out of 7,032) have churned, meaning nearly 1 in 4 customers have left the company. The majority, 73.4% (5,163 customers), are still active. But with more than 1 in 4 customers leaving, it’s worth taking a deeper dive into what might be driving churn.


**Revenue lost by churned contracts**
| Contract type | Revenue lost (USD)  | Total revenue (USD)|   Revenue lost %   | Churn rate %   |       
|    :---:      |        :---:        |     :---:          |      :---:         |     :---:      |
| Month to month|     1,927,182.25    |   5,305,861.50     |       36.32        |      43.0      |
| One year      |     260,753.45      |   4,467,053.50     |       15.11        |      11.0      |
| Two year      |     674,991.20      |   6,283,253.70     |        4.15        |       0.3      |

#### 💸 Revenue impact by contract type

- From the tables above, it can be seen that **Month to month contracts**, which have a high churn rate of 43%, and they represent a significant 36.3% loss related to the total revenue in that group, a revenue loss of $1.93M. This aligns with expectations, as shorter-term contracts typically have less customer commitment. This group is likely more flexible, easier to churn, and may require better retention strategies. 

- **One year contracts** are more stable, with a churn rate of 11%, yet still lose 15.11% of their revenue to churn. This suggests that while the risk is lower, there is still room for improvement such as maybe a loyalty program with loyalty offers. 

- **Two year contracts** have a very low churn rate of just 0.3%, are the most stable and are responsible for only a 4.15% revenue loss. These customers are likely more committed, and the company may consider leveraging this group to build long-term value or encourage upgrades.

### :chart_with_downwards_trend: Churn risk factors

This section explores how different features might have influence on the churn risk such as payment method, tech support, gender, tenure, and partnership status. 

- **Gender** ➡️ The churn rates are nearly identical between men and women (26–27%), suggesting gender is not a strong churn indicator in this dataset.
  
- **Partnership** ➡️ Customers with a partner have a 13–14% lower churn rate compared to those without, regardless of gender, which suggest that relationship status is associated with higher customer retention. 
  
- **Payment method** ➡️ Customers using electronic checks have a churn rate of 45%, significantly higher than those using automatic methods like credit card or bank transfer (15–17%). This suggests that customers who are manually involved in payments may be less committed or more sensitive to pricing, which may explain the churn pattern. It could be worth looking into ways to encourage more customers to switch to automatic payments. 
  
- **Tech support** ➡️ Customers with tech support churn 27% less than those without. This indicate that having customer service plays a role for customer retention. 
  


