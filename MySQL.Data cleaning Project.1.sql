-- Data Cleaning--

SELECT *
FROM layoffs ;

-- 1. REMOVE DUPLICATES
-- 2. STANDARDISZE THE DATA
-- 3. CHECK FOR NULL VALUES AND BLANK VALUES
-- 4. REMOVE COLUMNS WHEN NECESSARY

-- staging a new table TO AVOID LOSING DATA BY MISTAKE

CREATE TABLE layoffs_staging
LIKE layoffs;

SELECT *
FROM layoffs_staging ;

INSERT layoffs_staging
select *
FROM layoffs;

-- i will remove duplicates--
 
select *,
row_number() over (partition by company, industry,total_laid_off, percentage_laid_off,`date`) as row_num
FROM layoffs;

with duplicate_cte as
 (select *,
row_number() over (partition by company,location, industry,total_laid_off, percentage_laid_off,`date`,stage, country,funds_raised_millions) as row_num
FROM layoffs)

select *
from duplicate_cte
where row_num > 1;

-- double-checking by random duplicates --
SELECT *
FROM layoffs_staging
where company = 'Casper' ;

with duplicate_cte as
 (select *,
row_number() over (partition by company,location, industry,total_laid_off, percentage_laid_off,`date`,stage, country,funds_raised_millions) as row_num
FROM layoffs)

delete
from duplicate_cte
where row_num > 1;

CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SELECT *
FROM layoffs_staging2
where row_num >1;

insert into layoffs_staging2
select *,
row_number() over (partition by company,location, industry,total_laid_off, percentage_laid_off,`date`,stage, country,funds_raised_millions) as row_num
FROM layoffs;

delete
FROM layoffs_staging2
where row_num >1;

SELECT *
FROM layoffs_staging2;

-- to standardize my data --
-- example: trim text
select company, trim(company)
from layoffs_staging2;




