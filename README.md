# Swiggy Restaurants Data Analysis

An end-to-end analysis of **8,680 Swiggy restaurants across 9 Indian cities** using **Excel (Pivot Tables and charts), SQL (MySQL) and Power BI**.

<img width="1320" height="737" alt="dashboard png" src="https://github.com/user-attachments/assets/6a3af7eb-5a4b-453a-8e0e-e7bed7fd9341" />

## Dashboard Analysis
The dashboard summarises the Swiggy restaurants data in one view. Here is what each part shows.

**KPI Cards**
- Avg. Rating: **3.66**, so restaurants are rated moderately on average.
- Avg. Price: **Rs. 348.44** per order/meal.
- Restaurants: **8,680** across 9 cities.
- Avg. Delivery Time: **53.97 minutes**.

**City and Area filters**
Two slicers let you filter the whole dashboard by city or by area to see how the numbers change.

**Top 5 Most Served Food Types (donut chart)**
Indian is the most served food type (389 restaurants, 28.2% of the top 5), followed by Chinese (277, 20.1%), North Indian (246, 17.8%), Fast Food (240, 17.4%) and South Indian (228, 16.5%). Indian and Chinese together make up almost half of the top 5.

**Top 10 Areas with Most Restaurants (column chart)**
Rohini has the most restaurants (257), followed by Chembur (208) and Kothrud (149). The top two areas are far ahead of the rest, which stay between 118 and 149.

**Avg. Price-Wise Most Expensive Areas (bar chart)**
Vile Parle is the most expensive area (about Rs. 1,500), followed by Pacific Mall Subhash Nagar and Someshwarpura (about Rs. 1,200 each). Many of these areas have only 1-2 restaurants, so these averages should be read carefully.

**Top 10 Cities with Most Restaurants (map)**
Kolkata (1,346), Mumbai (1,277) and Chennai (1,106) have the most restaurants. The map shows how the restaurants are spread across the 9 cities.

### Key Takeaways
- Indian and Chinese cuisines dominate the food market on Swiggy.
- Restaurants are concentrated in a few areas (Rohini, Chembur, Kothrud).
- Kolkata has the most restaurants, but also the slowest delivery (about 68 min on average).
- Prices vary a lot between areas, from Rs. 270 average in Surat to Rs. 394 in Mumbai at city level.


## Project Overview
This project explores restaurant data from Swiggy to answer questions such as:
- Which food types are served the most?
- Which areas and cities have the most restaurants?
- Which areas are the most expensive?
- How do rating, price and delivery time differ across cities?
- How are restaurants spread across rating categories?

## Tools Used
| Tool | Purpose |
|---|---|
| Excel | Data cleaning, Pivot Tables, 6 analysis reports with charts |
| MySQL | Querying the data with SQL |
| Power BI | Interactive dashboard |

## Repository Files
| File | Description |
|---|---|
| `swiggy.csv` | Swiggy restaurants dataset (8,680 rows) |
| `Swiggy_Analysis.xlsx` | Excel workbook with 6 analysis reports and charts |
| `swiggy_analysis_queries.sql` | MySQL queries for all reports |
| `dashboard.png` | Dashboard preview image |
| `README.md` | Project description |

## Dataset
`swiggy.csv` has 8,680 rows and 10 columns.

| Column | Description |
|---|---|
| ID | Unique restaurant ID |
| Area | Area of the restaurant |
| City | City (9 cities) |
| Restaurant | Restaurant name |
| Price | Average price for two (Rs.) |
| Avg ratings | Average customer rating |
| Total ratings | Number of ratings |
| Food Type | Cuisine(s) served |
| Address | Address of the restaurant |
| Delivery time | Delivery time in minutes |

## Key KPIs
| Avg. Rating | Avg. Price | Restaurants | Avg. Delivery Time |
|---|---|---|---|
| 3.66 | Rs. 348.44 | 8,680 | 53.97 min |

## The 6 Reports (Excel)
1. **Top 5 Most Served Food Types**: Indian (389), Chinese (277), North Indian (246), Fast Food (240), South Indian (228)
2. **Top 10 Areas with Most Restaurants**: Rohini (257), Chembur (208), Kothrud (149)
3. **Most Expensive Areas by Avg. Price**: Vile Parle (Rs. 1,500), Pacific Mall Subhash Nagar and Someshwarpura (Rs. 1,200)
4. **Cities with Most Restaurants**: Kolkata (1,346), Mumbai (1,277), Chennai (1,106)
5. **City-wise Performance**: rating, price and delivery time by city
6. **Restaurants by Rating Category**: Poor, Average, Good, Very Good, Excellent

## Key Insights
- **Kolkata** has the most restaurants (1,346) but also the **slowest delivery** (about 68 min).
- **Chennai** has the highest average rating (3.78); **Mumbai** has the highest average price (Rs. 393.79).
- **Ahmedabad** has the fastest average delivery (about 45 min); **Surat** has the lowest average price (Rs. 270.17).
- **Indian** is the most served food type, followed by Chinese.

## Data Notes
- **Rating 2.9:** 3,279 restaurants have a rating of exactly 2.9. This looks like a default value for new or unrated restaurants, so the "Poor" rating category looks very large.
- **Expensive areas:** many of the most expensive areas contain only 1-2 restaurants, so their averages are not very reliable. The SQL file includes a version that keeps only areas with at least 20 restaurants.

## Rating Categories
| Category | Rating |
|---|---|
| Poor | below 3.0 |
| Average | 3.0 - 3.4 |
| Good | 3.5 - 3.9 |
| Very Good | 4.0 - 4.4 |
| Excellent | 4.5 - 5.0 |

## How to Run the SQL
1. Create the table using the setup section of `swiggy_analysis_queries.sql`.
2. Import `swiggy.csv` with the MySQL Workbench Table Data Import Wizard.
3. Run the queries one by one. Expected result of `SELECT COUNT(*) FROM swiggy;` is **8680**.

 ## Contact

**Deepak Kumar**  
[LinkedIn](https://www.linkedin.com/in/analystdeepak/)
