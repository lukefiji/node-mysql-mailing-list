-- Exercise 1
-- -- Find the 5 oldest users
SELECT *
FROM users
ORDER BY created_at
LIMIT 5;

-- Exercise 2
-- -- What day of the week do most users register on?
SELECT DAYNAME(created_at) AS day_name,
  COUNT(DAYNAME(created_at)) AS total
FROM users
GROUP BY day_name
ORDER BY total DESC;

-- Exercise 3
-- -- Find users that have never posted a photo
SELECT username
FROM users
LEFT JOIN photos
  ON users.id = photos.user_id
WHERE photos.id IS NULL;

-- Exercise 4
-- -- Who got the most likes on a single photo?
SELECT username, 
  photos.id AS photo_id,
  image_url,
  COUNT(likes.user_id) AS total_likes
FROM photos
JOIN likes
  ON photos.id = likes.photo_id
JOIN users
  ON users.id = photos.user_id
GROUP BY photos.id
ORDER BY total_likes DESC;

-- Exercise 5
-- -- How many times does the average user post?
SELECT 
  (SELECT COUNT(*) FROM photos) / (SELECT COUNT(*) FROM users) AS average_posts;

-- Exercise 6
-- -- What are the top 5 most commonly used hashtags?
SELECT tag_name, COUNT(photo_id) AS total
FROM photo_tags
JOIN tags
  ON tags.id = photo_tags.tag_id
GROUP BY tag_id
ORDER BY total DESC
LIMIT 5;

-- Exercise 7
-- -- Find users who have liked every single photo on the site
SELECT user_id, username, COUNT(*) as num_likes
FROM users
JOIN likes
  ON users.id = likes.user_id
GROUP BY user_id
HAVING num_likes = (SELECT COUNT(*) FROM photos);
