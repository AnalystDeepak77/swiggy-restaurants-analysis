-- =====================================================================
-- SWIGGY RESTAURANTS DATA ANALYSIS - SQL QUERIES  (MySQL 8.0)
-- =====================================================================
-- Dataset  : swiggy.csv  (8,680 restaurants, 9 cities, 829 areas)

-- Table columns:
--   ID, Area, City, Restaurant, Price, Avg_ratings, Total_ratings,
--   Food_Type, Address, Delivery_time

-- Tool     : MySQL Workbench

-- =====================================================================
-- 1. KPI SUMMARY
-- =====================================================================
SELECT
    ROUND(AVG(Avg_ratings), 2)    AS avg_rating,          
    ROUND(AVG(Price), 2)          AS avg_price,           
    COUNT(*)                      AS total_restaurants,   
    ROUND(AVG(Delivery_time), 2)  AS avg_delivery_time,   
    COUNT(DISTINCT City)          AS total_cities,       
    COUNT(DISTINCT Area)          AS total_areas          
FROM swiggy;


-- =====================================================================
-- 2. REPORT 1 - TOP 5 MOST SERVED FOOD TYPES
-- =====================================================================
-- Expected: Indian 389, Chinese 277, North Indian 246,
--           Fast Food 240, South Indian 228
SELECT
    Food_Type,
    COUNT(*) AS restaurants
FROM swiggy
GROUP BY Food_Type
ORDER BY restaurants DESC
LIMIT 5;


-- =====================================================================
-- 3. REPORT 2 - TOP 10 AREAS WITH MOST RESTAURANTS
-- =====================================================================
-- Expected: Rohini 257, Chembur 208, Kothrud 149 ...
SELECT
    Area,
    COUNT(*) AS restaurants
FROM swiggy
GROUP BY Area
ORDER BY restaurants DESC
LIMIT 10;


-- =====================================================================
-- 4. REPORT 3 - MOST EXPENSIVE AREAS (AVERAGE PRICE)
-- =====================================================================
-- Same as the dashboard (no minimum restaurant filter).
-- Many of these areas have only 1-2 restaurants, so averages are not reliable.
SELECT
    Area,
    ROUND(AVG(Price), 2) AS avg_price,
    COUNT(*)             AS restaurants_in_area
FROM swiggy
GROUP BY Area
ORDER BY avg_price DESC
LIMIT 10;

-- More reliable version: only areas with at least 20 restaurants
SELECT
    Area,
    City,
    ROUND(AVG(Price), 2) AS avg_price,
    COUNT(*)             AS restaurants_in_area
FROM swiggy
GROUP BY Area, City
HAVING COUNT(*) >= 20
ORDER BY avg_price DESC
LIMIT 10;


-- =====================================================================
-- 5. REPORT 4 - CITIES WITH MOST RESTAURANTS
-- =====================================================================
-- Expected: Kolkata 1346, Mumbai 1277, Chennai 1106, Pune 1090 ...
SELECT
    City,
    COUNT(*) AS restaurants,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 1) AS pct_of_total
FROM swiggy
GROUP BY City
ORDER BY restaurants DESC;


-- =====================================================================
-- 6. REPORT 5 - CITY-WISE PERFORMANCE
-- =====================================================================
SELECT
    City,
    ROUND(AVG(Avg_ratings), 2)   AS avg_rating,
    ROUND(AVG(Price), 2)         AS avg_price,
    ROUND(AVG(Delivery_time), 2) AS avg_delivery_time
FROM swiggy
GROUP BY City
ORDER BY avg_rating DESC;


-- =====================================================================
-- 7. REPORT 6 - RESTAURANTS BY RATING CATEGORY
-- =====================================================================
-- Poor      : rating below 3.0
-- Average   : 3.0 - 3.4
-- Good      : 3.5 - 3.9
-- Very Good : 4.0 - 4.4
-- Excellent : 4.5 - 5.0
-- Expected: Poor 3314, Average 207, Good 1154, Very Good 3343, Excellent 662
--
-- NOTE: 3279 restaurants have a rating of exactly 2.9. This looks like a
-- default value for new/unrated restaurants, so "Poor" looks very large.
SELECT
    CASE
        WHEN Avg_ratings >= 4.5 THEN 'Excellent'
        WHEN Avg_ratings >= 4.0 THEN 'Very Good'
        WHEN Avg_ratings >= 3.5 THEN 'Good'
        WHEN Avg_ratings >= 3.0 THEN 'Average'
        ELSE 'Poor'
    END AS rating_category,
    COUNT(*) AS restaurants
FROM swiggy
GROUP BY rating_category
ORDER BY MIN(Avg_ratings);


-- =====================================================================
-- 8. BONUS QUERIES
-- =====================================================================

-- B1. Top 10 highest-rated restaurants (with at least 500 ratings)
SELECT Restaurant, Area, City, Avg_ratings, Total_ratings
FROM swiggy
WHERE Total_ratings >= 500
ORDER BY Avg_ratings DESC, Total_ratings DESC
LIMIT 10;

-- B2. Most popular food type in each city
SELECT City, Food_Type, restaurants
FROM (
    SELECT City, Food_Type, COUNT(*) AS restaurants,
           ROW_NUMBER() OVER (PARTITION BY City ORDER BY COUNT(*) DESC) AS rn
    FROM swiggy
    GROUP BY City, Food_Type
) t
WHERE rn = 1;

-- B3. Fastest delivery areas (areas with at least 20 restaurants)
SELECT Area, City, ROUND(AVG(Delivery_time), 2) AS avg_delivery_time, COUNT(*) AS restaurants
FROM swiggy
GROUP BY Area, City
HAVING COUNT(*) >= 20
ORDER BY avg_delivery_time ASC
LIMIT 10;

-- B4. Restaurants with delivery time above 45 minutes
SELECT Restaurant, Area, City, Delivery_time
FROM swiggy
WHERE Delivery_time > 45
ORDER BY Delivery_time DESC
LIMIT 20;

-- B5. Price segments
SELECT
    CASE
        WHEN Price < 200 THEN 'Budget (below 200)'
        WHEN Price < 400 THEN 'Mid (200-399)'
        WHEN Price < 600 THEN 'Premium (400-599)'
        ELSE 'Luxury (600+)'
    END AS price_segment,
    COUNT(*)                     AS restaurants,
    ROUND(AVG(Avg_ratings), 2)   AS avg_rating,
    ROUND(AVG(Delivery_time), 2) AS avg_delivery_time
FROM swiggy
GROUP BY price_segment
ORDER BY MIN(Price);

-- B6. Restaurant chains (same name, multiple outlets)
SELECT Restaurant, COUNT(*) AS outlets
FROM swiggy
GROUP BY Restaurant
HAVING COUNT(*) > 1
ORDER BY outlets DESC
LIMIT 10;
