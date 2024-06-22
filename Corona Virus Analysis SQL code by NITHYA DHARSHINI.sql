create database NithyaDharshini_CoronaAnalysis;

use NithyaDharshini_CoronaAnalysis;

select * from dataset
limit 800000;

-- A1
select 'Province' as Field, COUNT(*) as Null_Count 
from dataset 
where Province IS NULL
UNION ALL
select 'Country' as Field, COUNT(*) as Null_Count 
from dataset 
where Country IS NULL
UNION ALL
select 'Latitude' as Field, COUNT(*) as Null_Count 
from dataset 
where Latitude IS NULL
UNION ALL
select 'Longitude' as Field, COUNT(*) as Null_Count 
from dataset 
where Longitude IS NULL
UNION ALL
select 'Date' as Field, COUNT(*) as Null_Count 
from dataset 
where Date IS NULL
UNION ALL
select 'Confirmed' as Field, COUNT(*) as Null_Count
from dataset 
where Confirmed IS NULL
UNION ALL
select 'Deaths' as Field, COUNT(*) as Null_Count
from dataset 
where Deaths IS NULL
UNION ALL
select 'Recovered' as Field, COUNT(*) as Null_Count 
from dataset 
where Recovered IS NULL;


-- A2
-- No null values

-- A3
select count(*) as total_num_of_rows 
from dataset;

-- A4
select min(date) as Start_Date, max(date) as End_Date 
from dataset;

-- A5
select count(distinct month(date)) as num_of_months 
from dataset;

-- A6
select month(date) as Corona_months, avg(Confirmed),avg(Deaths), avg(Recovered) 
from dataset 
group by Corona_months;

-- A7
-- confirmed
with ConfirmedCounts as (
    select month(Date) AS Month, Confirmed, COUNT(*) AS Frequency
    from dataset
    group by month(Date), Confirmed
),
MaxConfirmedCounts as (
    select Month, MAX(Frequency) as MaxFrequency
    from ConfirmedCounts
    group by Month
)
select cc.Month, cc.Confirmed, cc.Frequency
from ConfirmedCounts cc
join MaxConfirmedCounts mcc on cc.Month = mcc.Month and cc.Frequency = mcc.MaxFrequency
order by cc.Frequency desc;

-- deaths
with DeathsCounts as (
    select month(Date) as Month, Deaths, COUNT(*) AS Frequency
    from dataset
    group by month(Date), Deaths
),
MaxDeathsCounts as (
    SELECT Month, MAX(Frequency) as MaxFrequency
    FROM DeathsCounts
    GROUP BY Month
)
select dc.Month, dc.Deaths, dc.Frequency
from DeathsCounts dc
join MaxDeathsCounts mdc on dc.Month = mdc.Month and dc.Frequency = mdc.MaxFrequency
order by dc.Frequency desc;

-- recovered
with RecoveredCounts as (
    select month(Date) AS Month, Recovered, COUNT(*) AS Frequency
    from dataset
    group by month(Date), Recovered
),
MaxRecoveredCounts as (
    select Month, MAX(Frequency) as MaxFrequency
    from RecoveredCounts
    group by Month
)
select rc.Month, rc.Recovered, rc.Frequency
from RecoveredCounts rc
join MaxRecoveredCounts mrc on rc.Month = mrc.Month and rc.Frequency = mrc.MaxFrequency
order by rc.Frequency desc;

-- A8
select year(date) as Corona_Year,min(confirmed),min(deaths), min(recovered)
from dataset
group by Corona_Year;

-- A9
select year(date) as Corona_Year,max(confirmed),max(deaths), max(recovered)
from dataset
group by Corona_Year;

-- A10
select month(date) as Corona_Month,sum(confirmed),sum(deaths),sum(recovered)
from dataset
group by Corona_Month;

-- A11
select sum(confirmed),avg(confirmed),variance(confirmed),stddev(confirmed)
from dataset;

-- A12
select month(date) as month,sum(deaths),avg(deaths),variance(deaths),stddev(deaths)
from dataset
group by month;

-- A13
select sum(recovered),avg(recovered),variance(recovered),stddev(recovered)
from dataset;

-- A14
select country,sum(confirmed) as Confirmed_Count
from dataset
group by country
order by Confirmed_Count desc
limit 1;

-- A15
select country,sum(deaths) as Death_Count
from dataset
group by country
order by Death_Count 
limit 4;

-- A16
select country,sum(recovered) as Recovered_Count
from dataset
group by country
order by Recovered_Count desc
limit 5;