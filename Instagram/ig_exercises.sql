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
SELECT photos.id,
  image_url,
  COUNT(likes.user_id) AS photo_likes
FROM photos
JOIN likes
  ON photos.id = likes.photo_id
GROUP BY photos.id
ORDER BY photo_likes DESC;

-- Exercise 5
-- --

-- Exercise 6
-- --

-- Exercise 7
-- --