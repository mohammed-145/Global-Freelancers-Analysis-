-- PROJECT: Global Freelancers EDA
-- TOOL: MySQL
-- DESCRIPTION:
-- End-to-end exploratory data analysis
-- global freelancers dataset, focusing on pricing,
-- experience, skills, geography, and performance.

-- 1. DATA PREVIEW
SELECT *
FROM Freelancers.global_freelancers;


-- 2. DESCRIPTIVE STATISTICS (NUMERIC FEATURES)
-- Age
SELECT 
    AVG(age) AS avg_age,
    MIN(age) AS min_age,
    MAX(age) AS max_age
FROM global_freelancers;

-- Years of experience
SELECT
    AVG(years_of_experience) AS avg_experience,
    MIN(years_of_experience) AS min_experience,
    MAX(years_of_experience) AS max_experience
FROM global_freelancers;

-- Hourly rate (USD)
SELECT 
    AVG(`hourly_rate (USD)`) AS avg_hourly_rate,
    MIN(`hourly_rate (USD)`) AS min_hourly_rate,
    MAX(`hourly_rate (USD)`) AS max_hourly_rate
FROM global_freelancers;

-- Rating
SELECT
    AVG(rating) AS avg_rating,
    MIN(rating) AS min_rating,
    MAX(rating) AS max_rating
FROM global_freelancers;

-- Client satisfaction
SELECT
    AVG(client_satisfaction) AS avg_satisfaction,
    MIN(client_satisfaction) AS min_satisfaction,
    MAX(client_satisfaction) AS max_satisfaction
FROM global_freelancers;


-- 3. MISSING VALUE ANALYSIS
-- Years of experience
SELECT
    COUNT(*) AS total_records,
    COUNT(years_of_experience) AS non_missing_records,
    COUNT(*) - COUNT(years_of_experience) AS missing_records,
    ROUND((COUNT(*) - COUNT(years_of_experience)) * 100.0 / COUNT(*), 2) AS missing_percentage
FROM global_freelancers;

-- Hourly rate
SELECT
    COUNT(*) AS total_records,
    COUNT(`hourly_rate (USD)`) AS non_missing_records,
    COUNT(*) - COUNT(`hourly_rate (USD)`) AS missing_records,
    ROUND((COUNT(*) - COUNT(`hourly_rate (USD)`)) * 100.0 / COUNT(*), 2) AS missing_percentage
FROM global_freelancers;

-- Rating
SELECT
    COUNT(*) AS total_records,
    COUNT(rating) AS non_missing_records,
    COUNT(*) - COUNT(rating) AS missing_records,
    ROUND((COUNT(*) - COUNT(rating)) * 100.0 / COUNT(*), 2) AS missing_percentage
FROM global_freelancers;

-- Client satisfaction
SELECT
    COUNT(*) AS total_records,
    COUNT(client_satisfaction) AS non_missing_records,
    COUNT(*) - COUNT(client_satisfaction) AS missing_records,
    ROUND((COUNT(*) - COUNT(client_satisfaction)) * 100.0 / COUNT(*), 2) AS missing_percentage
FROM global_freelancers;

-- Active status
SELECT
    COUNT(*) AS total_records,
    COUNT(is_active) AS non_missing_records,
    COUNT(*) - COUNT(is_active) AS missing_records,
    ROUND((COUNT(*) - COUNT(is_active)) * 100.0 / COUNT(*), 2) AS missing_percentage
FROM global_freelancers;


-- 4. CATEGORICAL DISTRIBUTIONS
-- Gender distribution
SELECT 
    gender, 
    COUNT(*) AS total
FROM global_freelancers
GROUP BY gender;

-- Top countries (ranked)
WITH country_counts AS (
    SELECT country, COUNT(*) AS total
    FROM global_freelancers
    GROUP BY country
), ranked AS (
    SELECT country, total,
           DENSE_RANK() OVER (ORDER BY total DESC) AS rnk
    FROM country_counts
)
SELECT *
FROM ranked
WHERE rnk <= 10
ORDER BY rnk;

-- Top 3 languages
SELECT 
    `language`, 
    COUNT(*) AS total_speakers
FROM global_freelancers
GROUP BY `language`
ORDER BY total_speakers DESC
LIMIT 3;

-- Primary skill usage ranking
WITH skill_counts AS (
    SELECT primary_skill, COUNT(*) AS total
    FROM global_freelancers
    GROUP BY primary_skill
), ranked AS (
    SELECT primary_skill, total,
           DENSE_RANK() OVER (ORDER BY total DESC) AS rnk
    FROM skill_counts
)
SELECT *
FROM ranked;

-- Active vs inactive freelancers
SELECT 
    is_active,
    COUNT(*) AS total
FROM global_freelancers
GROUP BY is_active;


-- 5. PAY SEGMENTATION
-- Count freelancers by pay category
SELECT 
    CASE 
        WHEN `hourly_rate (USD)` < 40 THEN 'Low pay'
        WHEN `hourly_rate (USD)` BETWEEN 40 AND 60 THEN 'Medium pay'
        WHEN `hourly_rate (USD)` > 60 THEN 'High pay'
        ELSE 'Unknown'
    END AS pay_category,
    COUNT(*) AS total
FROM global_freelancers
GROUP BY pay_category
ORDER BY total DESC;


-- 6. EXPERIENCE SEGMENTATION
SELECT 
    CASE 
        WHEN years_of_experience < 3 THEN 'Junior'
        WHEN years_of_experience BETWEEN 3 AND 7 THEN 'Mid-level'
        ELSE 'Senior'
    END AS experience_group,
    COUNT(*) AS total_freelancers,
    AVG(`hourly_rate (USD)`) AS avg_hourly_rate,
    AVG(rating) AS avg_rating
FROM global_freelancers
GROUP BY experience_group
ORDER BY avg_hourly_rate DESC;


-- 7. RELATIONSHIP ANALYSIS
-- Hourly rate vs experience
SELECT 
    years_of_experience,
    AVG(`hourly_rate (USD)`) AS avg_hourly_rate
FROM global_freelancers
GROUP BY years_of_experience
ORDER BY years_of_experience;

-- Hourly rate vs country (top 10)
SELECT 
    country,
    AVG(`hourly_rate (USD)`) AS avg_hourly_rate
FROM global_freelancers
GROUP BY country
ORDER BY avg_hourly_rate DESC
LIMIT 10;

-- Rating vs experience
SELECT 
    years_of_experience,
    AVG(rating) AS avg_rating
FROM global_freelancers
GROUP BY years_of_experience
ORDER BY years_of_experience;

-- Client satisfaction vs pay group
SELECT 
    CASE 
        WHEN `hourly_rate (USD)` < 40 THEN 'Low pay'
        WHEN `hourly_rate (USD)` BETWEEN 40 AND 60 THEN 'Medium pay'
		WHEN `hourly_rate (USD)` > 60 THEN 'High pay'
        ELSE 'Unknown'
    END AS pay_group,
    AVG(client_satisfaction) AS avg_satisfaction
FROM global_freelancers
GROUP BY pay_group
ORDER BY avg_satisfaction DESC;

-- Active vs inactive performance
SELECT 
    is_active,
    AVG(`hourly_rate (USD)`) AS avg_hourly_rate,
    AVG(rating) AS avg_rating
FROM global_freelancers
GROUP BY is_active;


-- 8. OUTLIER ANALYSIS
-- Top 10 hourly rates
SELECT name, country, `hourly_rate (USD)`
FROM global_freelancers
ORDER BY `hourly_rate (USD)` DESC
LIMIT 10;

-- Top 10 years of experience
SELECT name, country, years_of_experience
FROM global_freelancers
ORDER BY years_of_experience DESC
LIMIT 10;

-- Lowest ratings
SELECT name, country, rating
FROM global_freelancers
WHERE rating IS NOT NULL
ORDER BY rating ASC
LIMIT 10;

-- Lowest client satisfaction
SELECT name, country, client_satisfaction
FROM global_freelancers
WHERE client_satisfaction IS NOT NULL
ORDER BY client_satisfaction ASC
LIMIT 10;


-- 9. DATA VALIDATION CHECKS (POST-CLEANING)
-- Experience greater than age
SELECT COUNT(*) AS invalid_experience_age
FROM global_freelancers
WHERE years_of_experience > age;

-- Invalid rating values
SELECT COUNT(*) AS invalid_ratings
FROM global_freelancers
WHERE rating < 0 OR rating > 5;

-- Invalid satisfaction values
SELECT COUNT(*) AS invalid_satisfaction
FROM global_freelancers
WHERE client_satisfaction < 0 OR client_satisfaction > 100;

-- Invalid hourly rates
SELECT COUNT(*) AS invalid_hourly_rates
FROM global_freelancers
WHERE `hourly_rate (USD)` <= 0;


-- 10. KEY INSIGHTS (PORTFOLIO NOTES)
-- • Hourly rates increase with experience, indicating experience is a strong
--   driver of freelancer market value.
-- • Significant geographic differences exist in freelancer pricing.
-- • Higher-paid freelancers tend to maintain slightly higher satisfaction.
-- • Active freelancers outperform inactive ones in both pricing and ratings.
-- • Skill specialization strongly affects demand and valuation.


-- 11. LIMITATIONS & FUTURE WORK
-- • Hourly rate is used as a proxy for success due to lack of earnings data.
-- • Dataset relies on self-reported freelancer information.
-- • Country and skill imbalance may bias aggregate statistics.
-- • Future work: revenue data, time trends, dashboards, predictive modeling.





