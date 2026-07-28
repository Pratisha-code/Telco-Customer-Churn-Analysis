select * from telco_customer_churn;

#Top churn payment method
select PaymentMethod,count(Churn) as Customers
from telco_customer_churn
group by PaymentMethod
order by Customers desc;


#Average monthly charge
select avg(MonthlyCharges) as avg_monthlycharge
from telco_customer_churn;

#Contract wise Churn
select Contract, count(*) as Churn_wise from telco_customer_churn
where Churn='Yes'
group by Contract;

#senior citizen Churn
select SeniorCitizen,count(*) as Churn_wise 
from telco_customer_churn
where Churn='Yes'
group by SeniorCitizen;

#Top 10 highest Charges
select MonthlyCharges from telco_customer_churn
order by MonthlyCharges desc limit 10;

#Customer segmentation use
select CustomerID,MonthlyCharges,
case
when MonthlyCharges < 35 then 'Low'
when MonthlyCharges between 35 and 70 then 'Medium'
else 'High'
end as Customer_category from telco_customer_churn;

#Running Total Revenue
select CustomerID,TotalCharges,sum(TotalCharges) over (order by TotalCharges) as running_revenue 
from telco_customer_churn
order by running_revenue  desc;

#Percentage contribution of revenue
select CustomerID,TotalCharges,
concat(Round(TotalCharges*100.0/sum(TotalCharges)over(),2),'%') as Revenue_Percentage
from telco_customer_churn;

#Top 5 highest spending customer per contract
select * from 
( 
select CustomerID,Contract,TotalCharges, row_number() over(partition by Contract order by TotalCharges desc) as high_spending 
from telco_customer_churn) t
where high_spending<=5;

#Rank customer with monthly charges
select CustomerID,MonthlyCharges,rank() over(order by MonthlyCharges desc) as charge_rank
from telco_customer_churn;

#churn percentage by gender
select Gender,concat(Round(sum(case when Churn='Yes' then 1 else 0 end)*100.0/count(*),2),'%') as Churn_rate
from telco_customer_churn
group by Gender;

