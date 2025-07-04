DROP SCHEMA IF EXISTS baby_names_db;
CREATE database baby_names_db;
USE baby_names_db;

--
-- Table structure for table `names`
--
drop table names 
CREATE TABLE names (
  State CHAR(2),
  Gender CHAR(1),
  Year INT,
  Name VARCHAR(45),
  Births INT);

--



-- Table structure for table `regions`
--

CREATE TABLE regions (
  State CHAR(2),
  Region VARCHAR(45));

--
-- Insert data into table names
--

/* Launch mysql in your Terminal (Mac) / Command Prompt (PC)
Update root with your username and password (root is the default username without a password)
Update '/Users/alice/Desktop/names_data.csv' with the location of the names_data.csv on your computer

> mysql -u root

> USE baby_names_db;

> LOAD DATA LOCAL INFILE '/Users/alice/Desktop/names_data.csv'
INTO TABLE names
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n';

If you get the following error:
ERROR 3948 (42000): Loading local data is disabled; this must be enabled on both the client and server sides

Run the following and then run commands above again.

> SET GLOBAL local_infile=true;

> quit;

*/

--
-- Insert data into table regions
--

INSERT INTO regions VALUES ('AL', 'South'),
('AK', 'Pacific'),
('AZ', 'Mountain'),
('AR', 'South'),
('CA', 'Pacific'),
('CO', 'Mountain'),
('CT', 'New_England'),
('DC', 'Mid_Atlantic'),
('DE', 'South'),
('FL', 'South'),
('GA', 'South'),
('HI', 'Pacific'),
('ID', 'Mountain'),
('IL', 'Midwest'),
('IN', 'Midwest'),
('IA', 'Midwest'),
('KS', 'Midwest'),
('KY', 'South'),
('LA', 'South'),
('ME', 'New_England'),
('MD', 'South'),
('MA', 'New_England'),
('MN', 'Midwest'),
('MS', 'South'),
('MO', 'Midwest'),
('MT', 'Mountain'),
('NE', 'Midwest'),
('NV', 'Mountain'),
('NH', 'New England'),
('NJ', 'Mid_Atlantic'),
('NM', 'Mountain'),
('NY', 'Mid_Atlantic'),
('NC', 'South'),
('ND', 'Midwest'),
('OH', 'Midwest'),
('OK', 'South'),
('OR', 'Pacific'),
('PA', 'Mid_Atlantic'),
('RI', 'New_England'),
('SC', 'South'),
('SD', 'Midwest'),
('TN', 'South'),
('TX', 'South'),
('UT', 'Mountain'),
('VT', 'New_England'),
('VA', 'South'),
('WA', 'Pacific'),
('WV', 'South'),
('WI', 'Midwest'),
('WY', 'Mountain');





------------
---------
select * from names
 select * from regions


-------
------
--Find the overall most popular girl and boy names and show how they have changed in popularity rankings over the years

----most comman name in F 
	select top 1  
	name ,sum( Births) as nam_count from names
	where gender ='f'
	group by name  
	order by  nam_count desc -- output'Jessica'


	-------most comman name in M


select top 1  
	name ,sum( Births) as nam_count from names
	where gender ='m'
	group by name  
	order by  nam_count desc  --output 'michael'




	-----popularity rankings over the years

	-----popularity of the f  in all years 
	
 with ff as (select  year,name ,sum ( Births) as nam_birth
			from names  -- make sure the 'from' in the  cte 
			where gender ='f'
			group by name  ,year ),

ranked as (select  year,name,nam_birth,
		row_number()over(partition by year order by nam_birth desc  ) as popularity 
		from ff) 
		select * from ranked ---make sure the 'from' in window fun 
	
	


		-----popularity of the m  in all years 
	
 with ff as (select  year,name ,sum ( Births) as nam_birth
			from names  -- make sure the 'from' in the  cte 
			where gender ='m'
			group by name  ,year ),

ranked as (select  year,name,nam_birth,
		row_number()over(partition by year order by nam_birth desc  ) as popularity 
		from ff) 
		select * from ranked ---make sure the 'from' in window fun 



		------------------------------------
		-----------------
		-----
	
 ---- use 2 cte's the first one to group , the secound to rank 

 with ff as (select  year,name ,sum ( Births) as nam_birth
			from names  -- make sure the 'from' in the  cte 
			where gender ='f'
			group by name  ,year ),

ranked as (select  year,name,nam_birth,
		row_number()over(partition by year order by nam_birth desc  ) as popularity 
		from ff) 
		select * from ranked ---make sure the 'from' in window fun 
		where name ='Jessica'



		-----
		--another solve :
		
	WITH yearly_ranks AS (
    SELECT 
        year,
        name,
        SUM(births) AS total_births,
       row_number() OVER (PARTITION BY year ORDER BY SUM(births) DESC) AS rank_
    FROM names
	where gender='f'
    GROUP BY year, name
)

	select * from yearly_ranks
	where name ='Jessica'

		---outpot : 
		---1980 | Jessica | 33923 | 3 
  --Jessica was **the 3rd most popular** girl’s name in 1980, with **33,923** babies named Jessica 'THIS WHAT MEAN RANKING ' 

 -- **1985 to 1990**: Jessica was **the #1 name** for several years — extremely popular.
 --**1991 to 1997**: Slowly dropped to #2, then #8.
 --**1998–1999**: Jessica continued to fall in popularity.



	---Find the names with the biggest jumps in popularity from the first year of the data set to the last year
	select MIN (YEAR)as mi, --'1989'
			max (year) as ma --'2009'
			from  names

	--------------------------------------
	------------------------------

	-----use cte's to  get the  jumps in popularity from the first year of the data set to the last year


		with ff as (select  year,name ,sum ( Births) as nam_birth
				from names  -- make sure the 'from' in the  cte 
				group by name  ,year ),

			ranked as (select  year,name,nam_birth,
						row_number()over(partition by year order by nam_birth desc  ) as popularity 
						from ff) ,
			
			year_1998 as 
						(
							select  name ,
							nam_birth as bi_1998 ,
							popularity as prop_1998
							from ranked
							where year =1998
						), 
			year_2009 as 
						(
							select  name , 
							nam_birth as bi_2009 ,
							popularity as prop_2009
							from ranked
							where year =2009
						)

					select 
					year_1998.name,
					bi_1998,
					prop_1998,
					bi_2009,
					prop_2009 ,
					cast(prop_1998 as int )-cast (prop_2009 as int ) as diffrennt 
					from 
					year_1998 inner join
					year_2009 on year_1998.name =year_2009. name 
					order by diffrennt 

-----------------------------------------------------
--------------
select * from names
 select * from regions


 -----Your second objective is to find the top 3 girl names and top 3 boy names for each year, and also for each decade.

with rannk_name as(
	select 
		name , gender , year , sum(births ) as nam_birth ,
		ROW_NUMBER()over (partition by gender order by sum(births ) desc ) as rn ----Because SQL processes the SELECT  after the OVER( ... ) window function
		from names 
		group by name , year ,Gender )
		select 
			name , gender , year,nam_birth, rn 
			from rannk_name 
			where rn <=3 



--------------------------------
------------------------
--For each decade, return the 3 most popular girl names and 3 most popular boy names
with decade_cte as(
			select  name ,gender, 
			sum(births ) as nam_birth ,
			(year / 10)*10 as  decade
			from names
			group by name ,gender,(year / 10)*10 
			--	order by nam_birth desc --* 1985 → (1985 / 10) = 198 → 198 \* 10 = **1980**


			),

	 ranked as (
	 select * ,
	 row_number()over (partition by decade , gender order by nam_birth desc  ) as  rn 
	 from decade_cte 

	 
	 
	 )
	 
			select 
			name , gender ,   decade,nam_birth
			from ranked
			where rn <=3
		



			------ another solve fro decade
		
			with  ff as (select name , gender , year , sum(births ) as nam_birth,
			case 
			when year between 1980 and 1989 then '80'
			when year between 1990 and 1999 then '90'
			when year between 2000 and 2009 then '2000'
			else 'non' end as decade
			from names 
			group by name , gender , year)
			,

			rr as (select *,
			ROW_NUMBER()over (partition by decade ,gender order by nam_birth desc ) as rn from ff )

			select * from rr
			where rn <=3
			

			------------------------------------------------
			------------------------------


			
			select * from regions
			select * from names
			--------------------------3-----3---3--3-3-3-3-3
			--Your third objective is to find the number of babies born in each region,
			-- and also return the top 3 girl names and top 3 boy names within each region.

			-------Return the number of babies born in each of the six regions (NOTE: The state of MI should be in the Midwest region)
						select distinct *  from regions
						
-----Return the number of babies born in each of the six regions becase there is some error in our data 'New England' must be  'New_England'
			with clean_region as	(	select state ,
						case 
						when Region ='New England' then 'New_England' else region end as new_regoin
						  from regions )
						  select distinct new_regoin from clean_region

-----The state of MI should be in the Midwest region)
			with clean_region as	(	select state ,
						case 
						when Region ='New England' then 'New_England' else region end as new_regoin
						  from regions
						  UNION 
						select 'mi' state , 'Midwest'region
						)
					  select distinct n.state ,cg.new_regoin from clean_region as cg
						  right join 
						  names as n 
						  on n.state = cg.state	









						  -------
					with clean_region as	(	select state ,
						case 
						when Region ='New England' then 'New_England' else region end as new_regoin
						  from regions
						  UNION 
						select 'mi' state , 'Midwest'region
						)
				  select new_regoin ,sum (births) as num_birth 
					  from clean_region as cg
						  right join 
						  names as n 
						  on n.state = cg.state	
						  group by new_regoin


------

------------------Return the 3 most popular girl names and 3 most popular boy names within each region


                       with clean_region as	(	select state ,
						case 
						when Region ='New England' then 'New_England' else region end as new_regoin
						  from regions
						  UNION 
						select 'mi' as state , 'Midwest' as region
						),
				tot as (  select cg.new_regoin ,n.Gender , n.Name ,sum (n.births) as num_birth 
					  from clean_region as cg
						  right join 
						  names as n 
						  on n.state = cg.state	
						  group by cg.new_regoin ,n.Gender, n.Name),

						  pop as (select *,
						row_number()over (partition by new_regoin ,gender order by num_birth desc  ) as  rn 
						from tot)
					
					select *
						from pop
						where rn <=3

						-------

--------------------------4-4-4-4-4-4-4-
---------------------
---Find the 10 most popular androgynous names (names given to both females and males)




	with name_summary AS (
    SELECT 
        name,
        COUNT(DISTINCT gender) AS gender_count,
        SUM(Births) AS total_births
    FROM names
    GROUP BY name
	--order by gender_count desc === **can't use `ORDER BY` inside a CTE** 
 
	
)

select top 10 * from name_summary
where gender_count=2
order by gender_count desc


------------------------
------------
---Find the length of the shortest and longest names, and identify the most popular short names 
--(those with the fewest characters) and long names (those with the most characters)
with lenth as SELECT 
    MIN(LEN(name)) AS shortest_length,
    MAX(LEN(name)) AS longest_length
FROM names)



---Find the length of the shortest and longest names, and identify the most popular short names 

select name , sum(Births) as tot_births 
from names
where len (name)= (select min(len(name))from names  )
group by name 
order by tot_births desc



---------------
with first_q as(
			select name , 
			sum(births)as tot_birth,
			len(name) as n_len
			from names 
	group by name 

), 
 lenth as( SELECT  
    MIN(n_len) AS shortest_length,-- make sure 'shortest_length' return 1 value from 
    MAX(n_len) AS longest_length
FROM first_q),

splet as (
		select 
		fq.name ,
		fq.tot_birth,
		fq.n_len,
			case
			when fq.n_len = l.shortest_length then 'those with the fewest characters'
			when fq.n_len = l.longest_length then 'those with the most characters'
			  else null 
			  end as split_f
			  from first_q as fq  
			  cross join lenth as l )--- we use cross join Because we want to apply the same 2 values 
			  -- 'shortest_length' and 'longest_length' 
			  -- to every row from 'first_q'. 
			  --There's no matching column like a foreign key, so we can't use INNER JOIN or LEFT JOIN

			  select * from splet 
			  where split_f is not null
				order by n_len 


				------------------------
				-------------------
				--The founder of Maven Analytics is named Chris. Find the state with the highest percent of babies named "Chris"
			
			
			with cris as (
				select 
				state, sum(births) as c_num
				from names	
				where name = 'Chris' 
				group by state ),
				
			
		total as (
				select 
				state, sum(births) as baby_num
				from names	
				group by state)

				select c.state,c.c_num,t.baby_num,
				  CAST(c.c_num AS FLOAT) / NULLIF(t.baby_num, 0) * 100 AS c_percent
				  --If we divide an integer by another integer in SQL Server, 
				  --the result is **rounded down** (integer division).
				  --* So, we **cast** it to `FLOAT` to make sure the result will be a **decimal** (e.g. 0.0231 instead of 0).

				from	cris as c 
				inner join total as t 
				on c.state = t.state 
				order by c_percent asc


