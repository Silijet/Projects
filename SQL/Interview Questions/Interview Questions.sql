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
ORDER BY cool DESC 

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
    ON reviews.cool = mc.cool

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
ORDER BY date

--This problem is not very specific. I was initially under the impression that conversation implied unique user1 to user2 data. Not just the msg_count. Also this does not sum up the msg_count data, so users have different numbers for sending and receiving.