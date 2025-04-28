create database pmjdy;

use pmjdy;

-- creating table
create table data (
state_name text,
benefi_at_rural_bank int,
benefi_at_urban_bank int,
total_benefi int,
balance_in_acc decimal(12,2),
no_rupay_cards int);

-- loading data into table
load data infile "D:/Power BI/Project - PMJDY/clean_pmjdy.csv"
into table data
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows;

-- reterive data from table
select * from data;

-- finding total no. of beneficiaries
select round(sum(total_benefi) / 1000000,1) as Total_Beneficiaries_millions
from data ;

-- total balance in beneficiaries account
select round(sum(balance_in_acc)) as Total_Balance_in_Beneficiaries_Acc_in_Crore
from data;

-- total RuPay cards issued
select round(sum(no_rupay_cards)/1000000,1) as Total_Rupay_cards_issued_in_millions
from data;

-- Percentage of Beneficiaries with RuPay Cards
select round((sum(no_rupay_cards) / sum(total_benefi) * 100),2) as Percentage_of_beneficiaries_with_RuPay_cards 
from data;

-- Rural vs Urban Beneficiaries
select round(sum(benefi_at_rural_bank)/1000000) as At_Rural_in_Millions,
round(sum(benefi_at_urban_bank)/1000000) as At_Urban_in_Millions,
round((sum(benefi_at_rural_bank)/sum(total_benefi) * 100),2) as Percentage_at_rural,
round((sum(benefi_at_urban_bank)/sum(total_benefi) * 100),2) as Percentage_at_urban
from data;

-- Top 4 states by Beneficiaries
select state_name,round(total_benefi/1000000) as Total_Beneficiaries_in_Millions,
round(benefi_at_rural_bank/1000000) as At_Rural_in_Millions,
round(benefi_at_urban_bank/1000000) as At_Urban_in_Millions
from data
order by total_benefi desc
limit 4;


