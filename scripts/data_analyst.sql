--1. How many rows are in the data_analyst_jobs table?

SELECT COUNT(*)
FROM data_analyst_jobs;
--Answer:1793

--2.Write a query to look at just the first 10 rows. What company is associated with the job posting on the 10th row? Company:"ExxonMobil"

SELECT *
FROM data_analyst_jobs
LIMIT 10;
--Answer="ExxonMobil"

--3.How many postings are in Tennessee?- How many are there in either Tennessee or Kentucky?-
SELECT COUNT(company)
FROM data_analyst_jobs
WHERE location='TN'
--Answer=21

SELECT COUNT(company)
FROM data_analyst_jobs
WHERE location='TN' OR location='KY'
--OR
SELECT COUNT (*)
FROM data_analyst_jobs
WHERE location IN ('TN','KY');
--Answer= 27

--4.How many postings in Tennessee have a star rating above 4?

SELECT *
FROM data_analyst_jobs
WHERE (location='TN') AND star_rating >4;
--Answer=3

OR 

SELECT COUNT (location)
FROM data_analyst_jobs
WHERE (location='TN') AND star_rating >4;
--Answer=3


--5.How many postings in the dataset have a review count between 500 and 1000?--151

SELECT COUNT (company)
FROM data_analyst_jobs
WHERE review_count
BETWEEN 500 and 1000;
--Answer=151

--6.Show the average star rating for companies in each state. The output should show the state as `state` and the average rating for the state as `avg_rating`. Which state shows the highest average rating?

SELECT location, AVG(star_rating) AS avg_rating
FROM data_analyst_jobs
GROUP BY location
ORDER BY avg_rating ASC;
--Answer=NE

--7.Select unique job titles from the data_analyst_jobs table. How many are there?
SELECT COUNT(DISTINCT title)
FROM data_analyst_jobs;
--Answer: 881

--8.How many unique job titles are there for California companies?
SELECT COUNT(DISTINCT title)
FROM data_analyst_jobs
WHERE location='CA';
--Answer: 230

--9.Find the name of each company and its average star rating for all companies that have more than 5000 reviews across all locations. How many companies are there with more that 5000 reviews across all locations?

SELECT company, AVG(star_rating) AS avg_star_rating
FROM data_analyst_jobs
WHERE company IS NOT NULL
GROUP BY company
HAVING MIN(review_count) >5000;

--Answer: 40

--10.Add the code to order the query in #9 from highest to lowest average star rating. Which company with more than 5000 reviews across all locations in the dataset has the highest star rating? What is that rating?
SELECT company,
	   AVG(star_rating) AS avg_star_rating
FROM data_analyst_jobs
WHERE company IS NOT NULL
GROUP BY company
HAVING MIN(review_count) > 5000
ORDER BY avg_star_rating DESC;
--Answer 6 way tie

--11.Find all the job titles that contain the word ‘Analyst’. How many different job titles are there? 
SELECT DISTINCT(title)
FROM data_analyst_jobs
WHERE title ILIKE '%Analyst%';
--Answer 774


--12.How many different job titles do not contain either the word ‘Analyst’ or the word ‘Analytics’? What word do these positions have in common? These positions still have the word analyst in common but the capitalization is different

SELECT (title)
FROM data_analyst_jobs
WHERE title NOT ILIKE '%analyst%'
AND title NOT ILIKE '%analytics%';
--Answer 4


--Bonus
--You want to understand which jobs requiring SQL are hard to fill. Find the number of jobs by industry (domain) that require SQL and have been posted longer than 3 weeks. 
 -- Disregard any postings where the domain is NULL. 
 -- Order your results so that the domain with the greatest number of `hard to fill` jobs is 	      at the top. 
  -- Which three industries are in the top 3 on this list? -"Consulting and Business Services", "Computers and Electronics", "Real Estate"
  --How many jobs have been listed for more than 3 weeks for each of the top 3?-

 SELECT COUNT (d.title), d.domain
 FROM data_analyst_jobs as d
 WHERE d.days_since_posting > 21
 		AND d.title IS NOT NULL
		 AND d.domain IS NOT NULL
		 AND skill ILIKE '%SQL%'
GROUP BY d.domain 
ORDER BY COUNT (d.title) DESC;