/*This is a list of different interview questions and how to approach them. I'm trying to outline my exact thought process and each step in creating the output. If a schema is not provided in the question, then I will likely make some assumptions in what I think the database looks like. I will be basing a lot of these questions on popular questions from famous tech companies. The questions should be well known or public.*/

--1) Write a SQL query to count the number of unique users per day who logged in from both iPhone and web, where iPhone logs and web logs are in distinct relations.
--Schema is unknown. Will have to assume what it may look like. The tables MAY look like this:
--iPhone : ts | userid | iphone_sessionid
--Web: ts | userid | web_sessionid
--Join via userid and ts. Group by day.
--Count(distinct(userid))

SELECT CAST(i.ts AS Date) AS 'Date'
    ,COUNT(DISTINCT(i.userid)) AS number_of_users
FROM
    iphone i
    INNER JOIN web w
    ON i.userid = w.userid
    --Tuncating the timestamp down to date information only
    AND CAST(i.ts AS Date) = CAST(w.ts AS Date)
--Grouping by the date will make the output make more sense
GROUP BY 1

--Optimization? Cast could actually slow this down a bit. Might not be the most efficient way to get the date.