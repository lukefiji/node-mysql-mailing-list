CREATE TABLE reviewers (
  id INT AUTO_INCREMENT PRIMARY KEY,
  first_name VARCHAR(100),
  last_name VARCHAR(100)
);

CREATE TABLE series(
  id INT AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(100),
  released_year YEAR(4),
  genre VARCHAR(100)
);

CREATE TABLE reviews(
  id INT AUTO_INCREMENT PRIMARY KEY,
  rating DECIMAL(2, 1),
  series_id INT,
  reviewer_id INT,
  FOREIGN KEY(series_id) REFERENCES series(id),
  FOREIGN KEY(reviewer_id) REFERENCES reviewers(id)
);

SELECT
  title,
  rating
FROM series
JOIN reviews
  ON series.id=reviews.series_id;

SELECT
  title,
  AVG(rating) as avg_rating
FROM series
JOIN reviews
  ON series.id = reviews.series_id
GROUP BY title
ORDER BY avg_rating;

SELECT
  first_name,
  last_name,
  rating
FROM reviews
INNER JOIN reviewers
  ON reviews.reviewer_id = reviewers.id
WHERE last_name IN ('Stoneman', 'Skaggs', 'Masters');

SELECT
  title AS unreviewed_series
FROM series
LEFT JOIN reviews
  ON reviews.series_id = series.id
WHERE rating IS NULL;

SELECT
  genre,
  ROUND(AVG(rating),2) AS avg_rating
FROM series
JOIN reviews
  ON reviews.series_id=series.id
GROUP BY genre;

SELECT
  first_name,
  last_name,
  COUNT(rating) AS COUNT,
  IFNULL(MIN(rating), 0.0) AS MIN,
  IFNULL(MAX(rating), 0.0) AS MAX,
  IFNULL(AVG(rating), 0.00000) AS AVG,
  IF(COUNT(rating) >= 1, 'ACTIVE', 'INACTIVE') AS STATUS
FROM reviewers
LEFT JOIN reviews
  ON reviews.reviewer_id = reviewers.id
GROUP BY first_name, last_name;

SELECT
  title,
  rating,
  CONCAT(first_name, ' ', last_name) AS reviewer
FROM reviewers
JOIN reviews
  ON reviewers.id = reviews.reviewer_id
JOIN series
  ON series.id = reviews.series_id
ORDER BY title;

