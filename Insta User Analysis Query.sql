create database ig_clone;
use ig_clone;
 
# MARKET ANALYSIS
-- 1. Loyal User Reward: Identify the five oldest users on Instagram from the provided database.

select * from users
order by created_at
limit 5;

-- 2. Inactive User Engagement: Identify users who have never posted a single photo on Instagram

SELECT id, username
FROM users
where id NOT IN (
    select user_id 
    from photos
);

-- 3. Contest Winner Declaration: Determine the winner of the contest and provide their details to the team
-- Winner is the user with the most likes on a single photo wins.

SELECT 
    photo_id, COUNT(*) AS like_count, photos.user_id as uploader_id
FROM 
    likes 
    INNER JOIN  photos ON  likes.photo_id = photos.id
    
GROUP BY photo_id
ORDER BY like_count DESC;

select *
from users 
where users.id = 52;


SELECT 
    username,
    photos.id as photoId,
    photos.image_url, 
    COUNT(*) AS total_likes
FROM photos
INNER JOIN likes
    ON likes.photo_id = photos.id
INNER JOIN users
    ON photos.user_id = users.id
GROUP BY photos.id
ORDER BY total_likes DESC
LIMIT 1;


-- 4. Hashtag Research: Identify and suggest the top five most commonly used hashtags on the platform.
SELECT 
    tag_id, COUNT(*) AS tag_count, tag_name
FROM
    photo_tags LEFT JOIN tags ON photo_tags.tag_id = tags.id
GROUP BY tag_id
ORDER BY tag_count DESC
LIMIT 5;

-- 5. Ad Campaign Launch:  Determine the day of the week when most users register on Instagram. Provide insights on when to schedule an ad campaign.

SELECT DAYNAME(created_at) AS day, COUNT(*) AS count
FROM users
GROUP BY day
ORDER BY count DESC
LIMIT 3;

# INVESTOR METRICS
-- User Engagement: Calculate the average number of posts per user on Instagram. 
-- 					Also, provide the total number of photos on Instagram divided by the total number of users.

select user_id, count(image_url) 
from photos 
group by user_id;

SELECT AVG(posts_per_user) AS average_posts_per_user
FROM (
  SELECT COUNT(*) AS posts_per_user
  FROM photos
  GROUP BY user_id
) AS subquery;

SELECT total_photos / total_users AS photos_per_user
FROM (
  SELECT COUNT(*) AS total_photos
  FROM photos
) AS subquery2, (
  SELECT COUNT(*) AS total_users
  FROM users
) AS subquery3;

-- 2. Bots & Fake Accounts: Identify users (potential bots) who have liked every single photo on the site, as this is not typically possible for a normal user.

select user_id , username
from likes inner join users on likes.user_id = users.id
group by user_id
having  count(photo_id) = (
	select count(id) from Photos
);






