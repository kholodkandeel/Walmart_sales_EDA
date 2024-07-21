# Walmart Sales Analysis

## About

This project involves the analysis of Walmart sales data from various branches. The aim is to extract meaningful insights to help understand sales patterns, customer behavior, and revenue/profit trends.

## Purposes Of The Project

-To analyze sales data to understand customer purchasing behavior.
-To identify trends and patterns in sales over different time periods.
-To calculate and optimize revenue and profit.
-To assess the impact of special events on sales.
-To evaluate the performance of different product lines.

## About Data

The dataset was obtained from the Kaggle Walmart Sales Forecasting Competition. This dataset contains sales transactions from a three different branches of Walmart, respectively located in Mandalay, Yangon and Naypyitaw. The data contains 17 columns and 1000 rows:

## Data Description

| Column                  | Description                               | Data Type       |
|-------------------------|-------------------------------------------|-----------------|
| invoice_id              | Invoice of the sales made                 | VARCHAR(30)     |
| branch                  | Branch at which sales were made           | VARCHAR(5)      |
| city                    | The location of the branch                | VARCHAR(30)     |
| customer_type           | The type of the customer                  | VARCHAR(30)     |
| gender                  | Gender of the customer making purchase    | VARCHAR(10)     |
| product_line            | Product line of the product sold          | VARCHAR(100)    |
| unit_price              | The price of each product                 | DECIMAL(10, 2)  |
| quantity                | The amount of the product sold            | INT             |
| VAT                     | The amount of tax on the purchase         | FLOAT(6, 4)     |
| total                   | The total cost of the purchase            | DECIMAL(10, 2)  |
| date                    | The date on which the purchase was made   | DATE            |
| time                    | The time at which the purchase was made   | TIMESTAMP       |
| payment_method          | The total amount paid                     | DECIMAL(10, 2)  |
| cogs                    | Cost Of Goods Sold                        | DECIMAL(10, 2)  |
| gross_margin_percentage | Gross margin percentage                   | FLOAT(11, 9)    |
| gross_income            | Gross Income                              | DECIMAL(10, 2)  |
| rating                  | Rating                                    | FLOAT(2, 1)     |


## Approach Used

1. **Data Cleaning and Preparation**
   - Ensured the data was free from errors and inconsistencies.
   - Added new columns for more detailed analysis (e.g., time of day, day name, month name, season, and week event).

2. **Feature Engineering**
   - Created new features from existing data to gain more insights.
   - Categorized time into morning, afternoon, and evening.
   - Extracted day names, month names, and seasons from the date column.
   - Identified and marked weeks with special events.

## Analysis approach used 

## Time-Based Analysis

Distribution of sales across different times of the day (morning, afternoon, evening).
Sales trends across different days of the week and months.
Seasonal sales analysis.
Customer-Based Analysis

## Sales distribution by customer type and gender.
Analysis of product line preferences among different customer types.
Revenue and Profit Analysis

## Calculation of total revenue and profit.
Analysis of gross margin percentage and gross income.
Event-Based Analysis

## Impact of special events (holidays, store events) on sales.
Sales patterns during specific weeks with special events.
Product Analysis

## Performance analysis of different product lines.
Analysis of unit prices and their impact on sales.
Product line sales distribution and preferences.


## Recommendations

Based on the analysis, the following recommendations are made to improve sales and customer satisfaction:

1. **Optimize Operating Hours**
   - Focus on peak sales times to ensure adequate staffing and inventory.

2. **Targeted Marketing**
   - Develop marketing strategies for top-performing days (Tuesday and Friday) to boost sales further.
   - Create promotional events around holidays and special weeks.

3. **Customer Segmentation**
   - Tailor marketing efforts to different customer segments based on their preferences and behavior.

4. **Product Line Optimization**
   - Stock popular product lines more heavily and consider expanding the variety in these categories.

5. **Continuous Monitoring**
   - Regularly monitor sales trends and adjust strategies accordingly to maintain and improve performance.

## Thanks for reading <3
