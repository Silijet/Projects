--Histogram of Tweets
/*Assume you're given a table Twitter tweet data, write a query to obtain a histogram of tweets posted per user in 2022. Output the tweet count per user as the bucket and the number of Twitter users who fall into that bucket.

In other words, group the users by the number of tweets they posted in 2022 and count the number of users in each group.*/

SELECT 
  DISTINCT (tweets_num) AS tweet_bucket 
  ,COUNT(user_id) AS users_num 
FROM(
  SELECT 
    user_id 
    ,COUNT(tweet_id) AS tweets_num 
  FROM tweets 
  WHERE 
    tweet_date BETWEEN '2022-01-01' AND '2022-12-31' 
  GROUP BY
    user_id
  ) AS total_tweets
GROUP BY 
  tweets_num

/*Given a table of candidates and their skills, you're tasked with finding the candidates best suited for an open Data Science job. You want to find candidates who are proficient in Python, Tableau, and PostgreSQL.

Write a query to list the candidates who possess all of the required skills for the job. Sort the output by candidate ID in ascending order.*/

SELECT  candidate_id
FROM    candidates
WHERE   
  skill IN('Python','Tableau','PostgreSQL')
GROUP BY 
  candidate_id
HAVING 
  COUNT(*) > 2
ORDER BY
  candidate_id ASC

/*Assume you're given two tables containing data about Facebook Pages and their respective likes (as in "Like a Facebook Page").

Write a query to return the IDs of the Facebook pages that have zero likes. The output should be sorted in ascending order based on the page IDs.*/

SELECT p.pages_id
FROM pages p
  LEFT OUTER JOIN
    page_likes pl
    ON p.page_id = pl.page_id
WHERE pl.page_id IS NULL
ORDER BY p.pages_id asc
