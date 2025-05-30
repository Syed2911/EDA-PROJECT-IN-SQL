-- explorarity data analysis

select *
from layoffs_staging2;


select MAX(total_laid_off), MAX(percentage_laid_off)
from layoffs_staging2;


select *
from layoffs_staging2
where percentage_laid_off = 1
order by total_laid_off DESC ;

select company, sum(total_laid_off)
from layoffs_staging2
group by company
order by 2 desc;


select min(`date`), max(`date`)
from layoffs_staging2;

select country, sum(total_laid_off)
from layoffs_staging2
group by country
order by 2 desc;

select *
from layoffs_staging2;

select stage, sum(total_laid_off)
from layoffs_staging2
group by stage
order by 1 desc;

select company, avg(percentage_laid_off)
from layoffs_staging2
group by company
order by 2 desc;

select *
from layoffs_staging2;

select substring(`date`,1,10) as month, sum(total_laid_off)
from layoffs_staging2
where substring(`date`,1,10) is not null
group by `month`
order by 1 asc;

with rolling_total as
(
select substring(`date`,1,10) as month, sum(total_laid_off) as total_off
from layoffs_staging2
where substring(`date`,1,10) is not null
group by `month`
order by 1 asc
)
select `month`, total_off
,sum(total_off) over(order by `month`) as rolling_total

from rolling_total
order by 1 asc;


select company, avg(percentage_laid_off)
from layoffs_staging2
group by company
order by 2 desc;


select company, sum(total_laid_off)
from layoffs_staging2
group by company
order by 2 desc;

select company, substring(`date`,1,10), sum(total_laid_off)
from layoffs_staging2
group by company, substring(`date`,1,10)
order by company asc;

select company, substring(`date`,1,10), sum(total_laid_off)
from layoffs_staging2
group by company, substring(`date`,1,10)
order by 3 desc;

with company_year(company,years,total_laid_off) as
(
select company, substring(`date`,1,10), sum(total_laid_off)
from layoffs_staging2
group by company, substring(`date`,1,10)
), company_year_rank as(
select *, dense_rank() over(partition by years order by total_laid_off desc) as ranking
from company_year
where years is not null
)
select *
from company_year_rank
where ranking <= 5
;



