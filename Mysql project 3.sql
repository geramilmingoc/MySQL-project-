create database titanic_project;
use titanic_project;

-- show the first ten rows or last ten rows of the dataset --
select *
 FROM titanic limit 10;
select *
 FROM titanic
  order by PassengerId desc limit 10 ;

-- find number of passengers who survived -- w/ aliasing
select count(*) as Passengers_survived
 FROM titanic
  where	Survived = 1;

-- find the averae age of passengers --
select avg(Age)
FROM titanic;

-- find number of passengers in each class --
select Pclass,count(*) as "no. of passengers"
 FROM titanic
  group by Pclass
    order by Pclass;

-- find the first ten rows of the dataset sorted by passenger class in descending order --

select  *
 FROM titanic
  order by Pclass desc limit 10;
 
 -- find the number of passengers in each class sorted by class in ascending order --
 select Pclass, count(*)
  FROM titanic
   group by Pclass
    order by Pclass asc;
  
  -- find the average fare paid by passengers in each class -- 
select Pclass , avg(Fare) as average_fare
 FROM titanic
  group  by Pclass
   order by Pclass asc;

 -- find the name of passenger/s with the highest fare -- 
  select name, Fare
   from titanic
    where Fare = (select max(fare) from titanic);
  -- select max(fare) from titanic; --SUBQUERY ONLY	
  
 -- find the name of the passenger who had the  highest age among the survivors --
select name, age as 'oldest survivor'
 FROM titanic 
  where age = (select max(age) from titanic where Survived = 1);
   -- select max(age) from titanic where survived = 1; subquery only --

-- find the number of passengers who paid more than the average fare --
  
 select count(*) " number of passenger"
  from titanic
     where Fare > (select avg(fare) from titanic);
 
 -- select Pclass, avg(fare) from titanic;SUBQUERY only
 
 -- find the name of the passenger who had the most parents or childre on board --
 select name, Parch
  from titanic
    where Parch = 6;
 -- select max(parch) from titanic; Subquery only
 
 -- find the number of male and female passengers who survive,order results by sex in ascending order --
 select sex, count(*) as survivors
   from titanic 
	where Survived = 1
     group by sex
      order by sex asc;
      
      -- find the name,age  and fare of the oldest passenger who survived --
      select name , age , fare
        from titanic
			where age = ( select max(age) from titanic where Survived = 1);
-- select max(age) from titanic where Survived = 1;-- subquery only
   
-- find the name , age  of the youngest female passenger who survived from third class --

select Name, age, Sex
 from titanic
	where Pclass = 3 and age = (select min(age) from titanic  where Survived = 1 and Pclass = 3
                                                    and sex = 'female') 
						and Survived = 1 
                           and sex = "female";
      
   -- select min(age) from titanic where Survived = 1 and Pclass = 3 and sex = "female";
   
   -- find the number of male and female passengers -- 
   select sex , count(*)
   from titanic
   group by sex;
   -- by using CASE
  select
   sum(case when sex = "male" then 1 else 0 end) as num_male,
   sum(case when sex  = "female" then 1 else 0 end) as num_female
   from titanic;
   
   -- select all passengers who travelled in a cabin and not shared ny other passenger-- 
          -- using NOT IN and IN
   
   select *
	from titanic
     where cabin not in  (select cabin from titanic 
                           group by cabin 
                               having count(*) >1);
select *
 from titanic
	where cabin in  (select cabin from titanic 
                           group by cabin 
                               having count(*) = 1);
                                                         
-- select cabin from titanic group by cabin having count(*) > 1 
 --   select cabin from titanic group by cabin having count(*) = 1 
 
 
 
 
 
 
 
 
 