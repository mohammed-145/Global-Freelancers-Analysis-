
### DATA CLEANING & STANDARDIZATION – GLOBAL FREELANCERS (MySQL)

-- Purpose:
-- Prepare raw freelancers data for analysis by:
-- 1. Checking duplicates
-- 2. Standardizing categorical values
-- 3. Cleaning numeric fields
-- 4. Handling missing & invalid values


-- 1. RAW DATA PREVIEW
SELECT *
FROM global_freelancers;

-- 2. DUPLICATE CHECK (Primary Key Validation)
SELECT
    freelancer_ID,
    COUNT(*) AS duplicates
FROM global_freelancers
GROUP BY freelancer_ID
HAVING COUNT(*) > 1;
-- Result expected: No duplicates (freelancer_ID should be unique)

-- 3. STANDARDIZE CATEGORICAL VARIABLES
-- 3.1 Gender Standardization
-- Step 1: Convert to lowercase
UPDATE global_freelancers
SET gender = LOWER(TRIM(gender));

-- Step 2: Map abbreviations to full labels
UPDATE global_freelancers
SET gender = CASE
    WHEN gender = 'f' THEN 'female'
    WHEN gender = 'm' THEN 'male'
    ELSE gender
END;

-- Validation
SELECT DISTINCT gender
FROM global_freelancers;


-- 3.2 Employment Status (is_active)
UPDATE global_freelancers
SET is_active = CASE
    WHEN LOWER(TRIM(is_active)) IN ('0','false','n','no') THEN 'No'
    WHEN LOWER(TRIM(is_active)) IN ('1','true','y','yes') THEN 'Yes'
    WHEN TRIM(is_active) = '' OR is_active IS NULL THEN NULL
    ELSE is_active
END;

-- Validation
SELECT DISTINCT is_active
FROM global_freelancers;


-- 4. STANDARDIZE NUMERIC VARIABLES
-- 4.1 Years of Experience
UPDATE global_freelancers
SET years_of_experience = CASE
    WHEN years_of_experience = '' THEN NULL
    ELSE years_of_experience
END;

-- Validation
SELECT years_of_experience
FROM global_freelancers
WHERE years_of_experience IS NULL;


-- 4.2 Hourly Rate (USD)
-- Step 1: Replace invalid values
UPDATE global_freelancers
SET `hourly_rate (USD)` = CASE
    WHEN `hourly_rate (USD)` IN ('no_data','') THEN NULL
    ELSE `hourly_rate (USD)`
END;

-- Step 2: Remove currency symbols & text
UPDATE global_freelancers
SET `hourly_rate (USD)` = TRIM(LEADING '$' FROM `hourly_rate (USD)`);

UPDATE global_freelancers
SET `hourly_rate (USD)` = TRIM(LEADING 'USD' FROM `hourly_rate (USD)`);

UPDATE global_freelancers
SET `hourly_rate (USD)` = TRIM(`hourly_rate (USD)`);

-- Validation
SELECT `hourly_rate (USD)`
FROM global_freelancers
WHERE `hourly_rate (USD)` IS NULL;


-- 4.3 Rating
UPDATE global_freelancers
SET rating = CASE
    WHEN rating IN ('no_data','') THEN NULL
    ELSE rating
END;

-- Validation
SELECT rating
FROM global_freelancers
WHERE rating IS NULL;


-- 4.4 Client Satisfaction
-- Step 1: Remove percentage symbol
UPDATE global_freelancers
SET client_satisfaction = TRIM(TRAILING '%' FROM client_satisfaction);

-- Step 2: Replace invalid values
UPDATE global_freelancers
SET client_satisfaction = CASE
    WHEN client_satisfaction IN ('','no_data') THEN NULL
    ELSE client_satisfaction
END;

-- Validation
SELECT client_satisfaction
FROM global_freelancers
WHERE client_satisfaction IS NULL;


-- 5. NULL HANDLING STRATEGY
-- Note:
-- No rows or columns are deleted.
-- NULL values are retained for transparency and handled during EDA.




