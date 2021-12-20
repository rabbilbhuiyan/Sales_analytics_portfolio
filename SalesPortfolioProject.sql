-- SQL query for pipelining the database into PowerBI

-- Read all the tables
Select * 
From SalesPortfolioProject..['2018$']

Select * 
From SalesPortfolioProject..['2019$']

Select * 
From SalesPortfolioProject..['2020$']

-- Develop sql queris to get all data into one unified table to bring in into PowerBI for vizualization

-- One unified table using Union
Select * 
From SalesPortfolioProject..['2018$']
Union
Select * 
From SalesPortfolioProject..['2019$']
Union
Select * 
From SalesPortfolioProject..['2020$']


-- Create a temporary table by encapsulating all the select statements into parenthesis and using the select query 
with hotels as
(
Select * 
From SalesPortfolioProject..['2018$']
Union
Select * 
From SalesPortfolioProject..['2019$']
Union
Select * 
From SalesPortfolioProject..['2020$']
)
--Select *
--From hotels


-- Looking at the hotel reveniew by year : create a new metrics/column

Select arrival_date_year, hotel,
round(SUM((stays_in_week_nights + stays_in_weekend_nights)*adr),2) as revenue -- create revenue metrics, round the value to 2 decimal and use group by
From hotels
Group by arrival_date_year, hotel


-- select subset of data
with hotels as
(
Select * 
From SalesPortfolioProject..['2018$']
Union
Select * 
From SalesPortfolioProject..['2019$']
Union
Select * 
From SalesPortfolioProject..['2020$']
)
Select country, hotel, arrival_date_year, required_car_parking_spaces
From hotels
Where country like '%ESP%'
order by 1,2


-- Looking at the highest Average daily rate (adr)
with hotels as
(
Select * 
From SalesPortfolioProject..['2018$']
Union
Select * 
From SalesPortfolioProject..['2019$']
Union
Select * 
From SalesPortfolioProject..['2020$']
)
Select country, hotel, MAX(adr) as HighestAdr
From hotels
--Where country like '%ESP%'
Group by country, hotel
order by HighestAdr desc


-- Join two tables 

-- Frist call the two tables and look for the common fields
Select *
From SalesPortfolioProject..market_segment$

Select *
From SalesPortfolioProject..meal_cost$

with hotels as
(
Select * 
From SalesPortfolioProject..['2018$']
Union
Select * 
From SalesPortfolioProject..['2019$']
Union
Select * 
From SalesPortfolioProject..['2020$']
)
Select *
From hotels
left join SalesPortfolioProject..market_segment$ -- joing market_segment table on market segement field with hotels table
on hotels.market_segment = market_segment$.market_segment
left join SalesPortfolioProject..meal_cost$ -- joing meal_cost table on meal with hotels table
on hotels.meal = meal_cost$.meal

-- So far we have developed our sql query for powerBI
-- Go to powerBI and pipeline the sql in the new database