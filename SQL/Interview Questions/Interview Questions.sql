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
GROUP BY 1;

--Optimization? Cast could actually slow this down a bit. Might not be the most efficient way to get the date.
--Ram suggested convert()

--2) Yelp. Find the business and the review_text that received the highest number of 'cool' votes. Output the business name along with the review text.
--yelp_reviews: business_name | review_id | user_id | stars | review_date | review_text | funny | useful | cool
--Assumptions: If two businesses have the same amount of cool votes, only pull the first one. 'cool' is already a count / aggregate, and no need to COUNT() it.
--Probably MAX(cool) or could even ORDER BY cool DESC
--SELECT TOP 1 or LIMIT 1
--Output: business_name | review_text 

SELECT TOP 1 business_name
    ,review_text
FROM yelp_reviews
ORDER BY cool DESC;

--Official Solution
SELECT
    business_name
    ,review_text
FROM 
    yelp_reviews yelp_reviews
    INNER JOIN 
    (
        SELECT MAX(cool) AS max_cool
        FROM yelp_reviews
    ) mc
    ON reviews.cool = mc.cool;

--3) Facebook. Find out the number of conversations (send or receive) by each user by date.
--fb_messages: id | date | user1 | user 2 | msg_count
--Assumptions: user1 is sending, user2 is receiving, there will be duplicates.
--Output: user | msg_count

--Official Solution
(SELECT
    date
    ,user1
    ,msg_count
FROM fb.messages)
UNION ALL
(SELECT
    date
    ,user2
    ,msg_count
FROM fb.messages)
ORDER BY date;

--This will sum up all the msg_count from the unioned table. Grouped by user and date, then ordered by date.
SELECT 
    tot.date
    ,tot.user1
    ,SUM(tot.msg_count)
FROM
    ((SELECT
        date
        ,user1
        ,msg_count
    FROM fb.messages)
    UNION ALL
    SELECT
        date
        ,user2
        ,msg_count
    FROM fb.messages)
    AS tot
GROUP BY tot.user1, tot.date
ORDER BY tot.date;
--This problem is not very specific. I was initially under the impression that conversation implied unique user1 to user2 data. Not just the msg_count. Also this does not sum up the msg_count data, so users have different numbers for sending and receiving.

-- Write a sql query to find out the overall friend acceptance rate for each day.
-- friend_requests: ds | sender | receiver | action (sent, accepted, rejected etc.)
-- Output: ds | acceptance_rate
-- acceptance_rate calculated by accepted / count(action)
DECLARE @Amount_Accepted FLOAT(1)
SET @Amount_Accepted = 
(
    SELECT COUNT(*)
    FROM friend_requests fr
    WHERE action = 'accepted'
)
SELECT
    fr.ds
    ,ROUND((@Amount_Accepted / COUNT(action)),3) *100 AS 'Acceptance_Rate'
FROM friend_requests fr
GROUP BY ds;

--Official Solution
SELECT ds,
    COUNT(CASE WHEN action = 'accepted' THEN 1
          ELSE NULL END) * 1.00 / COUNT(action) * 100 AS 'perc_acceptance'
FROM friend_requests
GROUP BY 1;


--Microsoft. Find the total number of downloads for paying and non-paying users by date. Include only records where non-paying customers have more downloads than paying customers. The output should be sorted by earliest date first and contain 3 columns date, non-paying downloads, paying downloads.
--Tables: ms_user_dimension, ms_acc_dimension, ms_download_facts
--ms_user_dimension: user_id | acc_id
--ms_acc_dimension: acc_id | paying_customer
--ms_download_facts: date | user_id | downloads
