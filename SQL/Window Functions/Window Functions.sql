/*Within this folder will be an overview window functions. Window functions are considered advanced and this is just a method to remember what I've learned and should I need to review. Going to include interview questions and how to address them with window functions. Mostly useful for data science.

Starting with 4 window functions:
Aggregate Functions - Normal aggregations but grouping by different categories (like month, countries, etc.)
Ranking - Rank by row. RANK(), RANK_DENSE(), ROW_NUMBER()
NTILEs
LAG/LEAD*/

/*Aggregate Function Example
Distance Per Dollar
You’re given a dataset of uber rides with the traveling distance (‘distance_to_travel’) and cost (‘monetary_cost’) for each ride. For each date, find the difference between the distance-per-dollar for that date and the average distance-per-dollar for that year-month. Distance-per-dollar is defined as the distance traveled divided by the cost of the ride.

The output should include the year-month (YYYY-MM) and the average difference in distance-per-dollar for said year-month as an absolute value rounded to the 2nd decimal. You should also count both success and failed request_status as the distance and cost values are populated for all ride requests. Also, assume that all dates are unique in the dataset. Order your results by earliest request date first.

uber_request_logs: request_id | request_date | request_status | distance_to_travel | monetary_cost | driver_to_client_distance */

--Take distance values and divide by the monetary amount to create distance-per-dollar (dpd)
--Need to extract month/year and create an average-distance-per-dollar-per-month (adpdpm)
--Then take the difference between each dpd and adpdpm
--Output: date | distance/cost - avg(distance/cost for month)

SELECT b.request_date
    ,round(abs(b.dist_to_cost-b.avg_dist_to_cost)::DECIMAL, 2) AS mean_deviation
FROM
    --Sub query. Window function. (3) is average of the distance-per-dollar grouped by month (request_mnth). 
    (SELECT a.request_date
        ,a.dist_to_cost
        ,AVG(a.dist_to_cost) OVER(PARTITION BY a.request_mnth) AS avg_dist_to_cost
    FROM
    --Subsub query. Selecting all columns. Extracting month/year from request_date AS request_mnth. dist_to_cost is the distance-per-dollar.
            (SELECT *
                ,to_char(request_date::date,'YYYY-MM') AS request_mnth
                ,(distance_to_travel/monetary_cost) AS dist_to_cost
            FROM uber_request_logs) a
    ORDER BY request_date) b
GROUP BY b.request_date
    ,b.dist_to_cost
    ,b.avg_dist_to_cost
ORDER BY b.request_date

/*Ranking Example
3 Different Ranking functions: RANK(), RANK_DENSE(), ROW_NUMBER(). May differe depending on implementation.
Twitter Unique Salaries
Find the top three unique salaries for each department. Output the department name and the top 3 unique salaries b y each department. Order your results alphabetically by department and then be highest salary to lowest.

twitter_employee: id | first_name | last_name | age | sex | employee_title | department | salary | target | bonus | email*/

--Need window function here because cannot just output top 3 salaries (specifically need top 3 salaries from each department).
--Group by department. Then take top 3 of each department.
SELECT  department
        ,salary
    SELECT department
        ,salary
        ,RANK() OVER (PARTITION BY a.department
                        ORDER BY a.salary DESC) AS rank_id
    FROM
        (SELECT department
            ,salary
        FROM twitter_employee
        GROUP BY department, salary
        ORDER BY department, salary) a
