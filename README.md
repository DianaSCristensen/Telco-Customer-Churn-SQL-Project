# :phone: Telco Customer Churn - SQL Project (Part 1)

This project analyses customer churn behavior in the telecom industry, data provided by Kaggle. The project is split into two parts, first part I used SQL on the Telco Customer Churn dataset, where the goal was to clean the dataset, explore patterns related to churn and customer behavior. The second part will involve building a neural network and make prediction on churn.

- 📂 Dataset used in this project is available via Kaggle: \
 <a href="https://www.kaggle.com/datasets/blastchar/telco-customer-churn"> Telco Customer Churn - BlastChar </a>
- 🛠️ Tools used: MySQL Workbench and DbGate.
- 📗 Full SQL code can be found in the SQL folder: \
  [Complete analysis](SQL/complete_analysis.sql)
- :pushpin: Part 2 of the project is still in progress, but will be posted here:\
[Telco Customer Churn - ML Project (Part 2)](https://github.com/DianaSCristensen/Telco-Customer-Churn-ML-Project)
  
## 🧹 Data cleaning
The dataset contains 7,043 customers with 21 columns:

- Loaded raw data as VARCHAR.
- Identified and removed blank spaces ➡️ from `TotalCharges` 11 rows was dropped.
- Converted `TotalCharges` and `MonthlyCharges` to numeric values ➡️ DECIMAL.
- Converted `SeniorCitizen` to binary numeric  ➡️ TINYINT(1).
  
*Please note, 11 rows with missing TotalCharges were dropped for the SQL EDA but in the ML phase (part 2), these rows will be re-evaluated.*
  
### 🔎 Column overview

- **Customer ID**: Unique customer identifier, combined with numbers and letters. 
- **Gender**: Gender of the customer (*Female*/*Male*)
- **Senior citizens**: Binary indicator where *1* means the customer is a senior, and *0* means they are not.
- **Partner**: Showing if the customer has a partner (*Yes*/*No*)
- **Tenure**: Showing the number of months the customer has been with the company. 
- **Phone Service**: Showing if the customer has phone service (*Yes*/*No*).
- **Multiple lines**: If the customer has multiple phone lines (*Yes*, *No*, or *No phone service*)
- **Internet Service**: Type of internet service (*DSL*, *Fiber optic*, or *No*).
- **Online Security, Online Backup, Device Protection, Tech Support, Streaming TV, StreamingMovies**: \
  Showing if the customer has each respective service (*Yes*, *No*, or *No internet service*).
- **Contract**: Contract type (*Month-to-month*, *One year*, or *Two year*).
- **Paperless billing**: Showing if the customer receives paperless billing (*Yes*/*No*).
- **Payment method**: How the customer pays (*Electronic check*, *Mailed check*, *Bank transfer (automatic)*, or *Credit card (automatic)*).
- **Monthly charges**: The amount the customer is billed each month.
- **Total charges**: The total amount billed to the customer to date.
- **Churn**: Showing if the customer has left the company (*Yes*/*No*).

## :bar_chart: EDA 

### Overall churn rate 

Out of all the customers, 26.6% (1,869 out of 7,032) have churned, meaning nearly 1 in 4 customers have left the company. The majority, 73.4% (5,163 customers), are still active. But with more than 1 in 4 customers leaving, it’s worth taking a deeper dive into what might be driving churn.


**Revenue lost by churned contracts**
| Contract type | Revenue lost (USD)  | Total revenue (USD)|   Revenue lost %   | Churn rate  |       
|    :---:      |        :---:        |     :---:          |      :---:         |     :---:   |
| Month to month|     1,927,182.25    |   5,305,861.50     |       36.32        |      43.0%  |
| One year      |     260,753.45      |   4,467,053.50     |       15.11        |      11.0%  |
| Two year      |     674,991.20      |   6,283,253.70     |        4.15        |       0.3%  |

#### 💸 Revenue impact by contract type

- From the tables above ([see the SQL query](SQL/Revenue_lost.sql)), it can be seen that **Month to month contracts**, which have a high churn rate of 43%, and they represent a significant 36.3% loss related to the total revenue in that group, a revenue loss of $1.93M. This aligns with expectations, as shorter-term contracts typically have less customer commitment. This group is likely more flexible, easier to churn, and may require better retention strategies. 

- **One year contracts** are more stable, with a churn rate of 11%, yet still lose 15.11% of their revenue to churn. This suggests that while the risk is lower, there is still room for improvement such as maybe a loyalty program with loyalty offers. 

- **Two year contracts** are the most stable, with a churn rate of just 0.3%, and are responsible for only a 4.15% revenue loss. These customers are likely more committed, and the company might consider exploring ways to encourage upgrades within this group.
 
### :chart_with_downwards_trend: Churn risk factors

This section explores how different features might have influence on the churn risk such as gender, partnership, payment method, tech support and tenure. 

- **Gender** ➡️ The churn rates are nearly identical between men and women (26–27%), suggesting gender is not a strong churn indicator in this dataset.
  
- **Partnership** ➡️ Customers with a partner have a 13–14% lower churn rate compared to those without, regardless of gender, which suggest that relationship status is associated with higher customer retention. 
  
- **Payment method** ➡️ Customers using electronic checks have a churn rate of 45%, significantly higher than those using automatic methods like credit card or bank transfer (15–17%). The company might benefit by looking into ways to encourage more customers to switch to automatic payments. 
  
- **Tech support** ➡️ Customers with tech support churn 27% less than those without, indicating that access to support plays a role in retention. Especially, customers without internet service (and therefore no tech support) show an extremely low churn rate of just 0.7%.

:microscope: **Churn rate by tenure, tech support, and partnership status**

| Tenure group   | Tech support         | Partner | Churn rate |
| :---:          |        :---:         |  :---:  |    :---:   |
| Under 1 year   | No                   | No      | 62%        |
| Under 1 year   | Yes                  | Yes     | 46%        |
| 1-2 years      | No                   | No      | 42%        |
| 1-2 years      | Yes                  | No      | 30%        |
| 1-2 years      | Yes                  | Yes     | 25%        |
| 2+ years       | No                   | No      | 27%        |
| 2+ years       | Yes                  | Yes     | 8%         |
| 2+ years       |*No internet service* | No      | 2%         |

*Please note: This table only shows a selection of the most relevant combinations. The full results from the SQL query can be found [here](SQL/Churn_by_tenure_techsupport_partner.sql).* 

As gender was previously found not to have a significant influence on churn, it was excluded from this analysis to better highlight the impact of tenure, tech support, and partnership status:

- Based on the analysis it appears that tenure is one of the strongest indicators of churn; Shorter tenure customers showing significantly higher churn rates. Tech support (or no internet service) and partnership status also play important roles, often help reduce churn, especially for longer tenured customers.

- Customers with both tech support and a partner generally show lower churn rates. However, there is one exception; in the 'Under 1 year' group, even customers with both still churn at 46%, while customers in this group with tech support and no partner showed churn rate at 35%. This might indicate that newer customers may be at higher risk regardless of tech support or relationship status, which could be due to limited time for loyalty or satisfaction to build.

- For customers in the 2+ years tenure group, churn drops even further to just 0.1% for customers in this group who also have a partner, suggesting that even among low-risk segments, relationship status seems to still play a role.
  
This overall pattern suggests that reducing churn is not just about one factor alone, but rather a combination of customer tenure, customer support, and relationship. Customers tend to become more stable over time, and features like tech support and having a partner seem to strengthen that stability, especially after the first year.

While the main analysis highlights tenure, tech support, and partnership status, other features also appear to influence churn. For example, customers with **dependents** have a significantly lower churn rate (16%) than those without (31%), and **senior citizens** churn at a higher rate (42%) compared to non-senior customers (24%). Although these trends aren't explored in full detail here, they may be worth deeper investigation in Part 2 of this project, where the focus will be on predicting customer churn.

## ➡️ Next steps
The next step in this project is to build a neural network model to predict customer churn. Part 2 will focus on preparing the data, training the model, and evaluating how well it can identify customers risk of leaving. Part 2 is currently still in progress but can be found [here](https://github.com/DianaSCristensen/Telco-Customer-Churn-ML-Project).
