# Global Freelancers Data Analysis (MySQL)

# Overview

This project explores a global freelancers dataset using MySQL, focusing on data cleaning, exploratory data analysis (EDA), relationship analysis, and creating a dashboard  using Power BI to demonstarte the insights.
The objective is to demonstrate strong SQL skills, Power BI skills, and an end-to-end analytical workflow suitable for a data analyst portfolio.

The project simulates a real-world scenario where raw data must be cleaned, standardized, and analyzed before meaningful insights can be extracted.

---

# Project Objectives

* Clean and standardize messy real-world data.
* Handle missing and inconsistent values safely.
* Perform structured exploratory data analysis (EDA).
* Analyze relationships between experience, pay, ratings, and activity status.
* Generate insights relevant to freelancing platforms and marketplaces.
* Generate an interactive dashboard using Power BI to understand insights and trends.
---

# Dataset Description

The dataset contains information about freelancers worldwide, including:

* Demographics (age, gender, country)
* Professional background (years of experience, primary skill, languages)
* Performance indicators (rating, client satisfaction)
* Economic variables (hourly rate in USD)
* Activity status (active vs inactive freelancers)

Note: The dataset was cleaned and analyzed entirely using MySQL.

---

# Data Cleaning Steps

Data cleaning was performed in a dedicated SQL script and included:

1. **Duplicate Validation**

   * Checked for duplicate `freelancer_ID` values

2. **Categorical Standardization**

   * Normalized gender values (e.g., `m/f` → `male/female`)
   * Standardized `is_active` values (Yes/No)

3. **Numeric Field Cleaning**

   * Cleaned `hourly_rate (USD)` by removing currency symbols
   * Converted invalid placeholders (e.g., `no_data`, empty strings) to NULL

4. **Missing Value Handling**

   * Replaced invalid values with NULLs
   * No rows or columns were deleted to preserve data integrity

---

# Exploratory Data Analysis (EDA)

The EDA process followed a structured approach:

### 1. Descriptive Statistics

* Average, minimum, and maximum values for:

  * Age
  * Years of experience
  * Hourly rate
  * Rating
  * Client satisfaction

### 2. Distribution Analysis

* Gender distribution
* Top countries by freelancer count
* Most common languages
* Primary skill frequency ranking
* Pay category distribution (Low / Medium / High)

### 3. Missing Value Analysis

* Calculated missing counts and percentages for key variables

### 4. Relationship Analysis

* Hourly rate vs years of experience
* Hourly rate by country (top countries)
* Rating vs years of experience
* Client satisfaction by pay category
* Active vs inactive freelancers comparison
  
---

# Power BI Dashboard

As a continuation of this project, an interactive Power BI dashboard was developed to visualize and communicate the insights derived from the SQL analysis.

### Dashboard Features:
- KPI cards (total freelancers, average hourly rate, rating, experience)
- Average hourly rate across countries
- Demand by primary skill
- Hourly rate distribution
- Relationships between experience, ratings, and pay
- Interactive filters (country, skill, gender, status)

# Key Insights

* Freelancers with more experience tend to command higher hourly rates.
* High-paying freelancers generally show higher client satisfaction.
* Certain countries dominate the freelancer population.
* Active freelancers earn higher average rates compared to inactive ones.

---

# Tools & Techniques

* **Database:** MySQL
* **Language:** SQL
* **Visualization** Power BI

* **Techniques:**
  * Data cleaning
  * Data standardization
  * Aggregation & grouping
  * Window functions
  * Exploratory data analysis

---

## 📁 Repository Structure

Global-Freelancers-Analysis/
│
├── Data/
│   └── global_freelancers_raw.csv      # Raw dataset
│
├── Mysql/
│   ├── Cleaning.sql                    # Data cleaning & standardization
│   └── EDA.sql                         # Exploratory data analysis queries
│
├── Dashboard/                            └─ PowerBI_Dashboard.pbix 
│   └─ PowerBI_Dashboard.pdf
└── README.md                           # Project documentation


---

# How to Run

1. Import the dataset into MySQL
2. Run `data_cleaning.sql` to prepare the data
3. Run `eda.sql` to perform exploratory analysis
4. Review query outputs for insights

---

# Author

**Mohammed Ba-tuq**
E-commerce Student | Aspiring Data Analyst,
data analysis, and business insights

---

# Why This Project Matters

This project demonstrates:

* End-to-end SQL analytics workflow
* Real-world data cleaning techniques
* Structured EDA methodology
* Portfolio-ready analytical thinking

Feel free to explore, fork, or provide feedback!

