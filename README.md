# 📊 U.S. Baby Names Analytics Project (SQL-Based Analysis)

As a **Data Analyst**, I led a comprehensive SQL-based project that analyzed baby name trends across time, region, and gender using U.S. birth record data. The project covered four core analytical objectives and included data ingestion from Excel using SQL Server.

---

## ✅ Objective 1: Track Changes in Name Popularity Over Time
- Identified the overall most popular boy and girl names.
- Tracked how these names ranked year-over-year to detect long-term popularity shifts.
- Applied window functions (`ROW_NUMBER`, `RANK`) to detect names with the biggest jumps in popularity from the earliest to latest years in the dataset.


### 🔄 Data set 
- [download heer](https://maven-datasets.s3.amazonaws.com/US+Baby+Names/US+Baby+Names+MySQL.zip)


### 🔄 Data Preparation: Excel to SQL Integration
- Performed bulk data import from Excel into SQL Server using `BULK INSERT`.
- Handled:
  - Field delimiters (commas, tabs)
  - Text qualifiers and encoding issues
  - Column type conversions and `NULL` handling
- Validated data load using row counts, checksum comparisons, and sample record checks.

---

## ✅ Objective 2: Compare Name Popularity by Year and Decade
- Built logic to return the top 3 boy and girl names for each year and each decade.
- Used `PARTITION BY` and window functions to generate ranked subsets for gender-based analysis.

---

## ✅ Objective 3: Analyze Regional Name Trends
- Mapped U.S. states to six regions, assigning MI to the Midwest.
- Calculated the total births per region.
- Identified the top 3 names by gender in each region using `ROW_NUMBER()` for ranking.

---

## ✅ Objective 4: Explore Unique Name Characteristics
- Discovered the 10 most popular androgynous names (used for both males and females).
- Used `LEN()` to determine the shortest and longest names and analyzed their popularity.
- Calculated the state with the highest % of babies named **"Chris"**, honoring Maven Analytics' founder.

---

## 🛠️ Skills & Tools Used
- **SQL Server (SSMS)**
- **T-SQL**: `CTEs`, `JOINs`, `Aggregations`, `Window Functions`, `CASE`, `LEN`, `CAST`
- **ETL**: `BULK INSERT`, `OPENROWSET`
- **Data Cleaning & Validation**
- **Temporal, Regional, and Gender-Based Pattern Analysis**

---

## 📌 Project Outcome
This project showcases my ability to:
- Design and execute multi-dimensional SQL analyses
- Handle real-world ETL processes from Excel to SQL
- Derive insights across demographic, geographic, and historical dimensions
- Communicate findings effectively through structured SQL queries
