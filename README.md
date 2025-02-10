# Retail Sales Analysis using SQL

## Project Description
This project provides a comprehensive analysis of retail sales data using PostgreSQL. The dataset includes information about sales transactions, customer demographics, product categories, and sales values. The project covers various aspects such as data cleaning, exploratory data analysis (EDA), and answering key business questions.

---

## Dataset Description
The dataset used in this project contains the following columns:

- **transactions_id**: Unique identifier for each transaction
- **sale_date**: Date of the sale
- **sale_time**: Time of the sale
- **customer_id**: Unique identifier for each customer
- **gender**: Gender of the customer (Male/Female)
- **age**: Age of the customer
- **category**: Product category (Clothing, Electronics, Beauty, etc.)
- **quantity**: Quantity of items sold
- **price_per_unit**: Price per unit of the product
- **cogs**: Cost of goods sold
- **total_sale**: Total sales value for the transaction

---

## Project Objectives
1. Perform data cleaning to handle missing values.
2. Conduct exploratory data analysis (EDA) to understand trends and distributions.
3. Answer key business questions to derive actionable insights.
4. Present findings to inform business strategies.

---

## SQL Queries Overview
### Data Cleaning
- Checked for and removed records with null values (except for the `age` column).
- Filled missing `age` values with the mean age.

### Exploratory Data Analysis (EDA)
- Counted total transactions, unique customers, and gender-based distribution.
- Analyzed distribution of age, quantity, price per unit, cogs, and total sales.

### Business Questions Answered
1. **Which sales were made on a specific date (e.g., '2022-11-05')?**  
   Retrieved all transaction details for that date.
2. **What transactions involved the 'Clothing' category with quantities of 4 or more in November 2022?**  
   Filtered transactions based on category, quantity, and month.
3. **What are the total sales and number of transactions for each category?**  
   Aggregated total sales and counted transactions per category.
4. **What is the average age of customers purchasing from the 'Beauty' category?**  
   Computed the mean age of customers for beauty products.
5. **Which transactions had sales greater than 1000?**  
   Identified high-value transactions.
6. **What is the distribution of transactions by gender and category?**  
   Counted and grouped transactions by gender and category.
7. **What is the monthly sales trend, and which month had the highest average sales each year?**  
   Analyzed sales trends and highlighted best-performing months.
8. **Who are the top 5 customers based on total sales?**  
   Listed the top customers ranked by total sales value.
9. **How many unique customers made purchases in each category?**  
   Counted distinct customers per category.
10. **What is the sales distribution across different shifts (Morning, Afternoon, Evening)?**  
   Categorized and counted orders by time-based shifts.

---

## Key Insights
1. Orders were placed by **155 customers**, with a nearly equal distribution between male and female customers.
2. **Clothing** products had the highest number of orders, while **Electronics** contributed the highest sales.
3. Customers ranged in age from **18 to 64 years**, with most in their early forties.
4. **Maximum quantity ordered** was 4.
5. Average sales value per transaction was **457**.
6. Females purchased more Beauty products, while males favored Clothing and Electronics.
7. The highest average sales occurred in **July 2022** and **February 2023**.
8. The customer with ID 3 generated the highest sales.
9. Most orders were placed during the **Evening shift** (after 6 PM).

---

## Conclusion
This project provides valuable insights into customer purchasing behavior, product performance, and sales trends. It demonstrates the power of SQL for data cleaning, exploration, and answering critical business questions.


