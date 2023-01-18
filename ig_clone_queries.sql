USE ig_clone;

-- Find the 5 oldest users. 
SELECT * FROM users ORDER BY created_at LIMIT 5;

-- What day of the week do most user register on?
SELECT DATE_FORMAT(created_at, '%W') AS most_register_weekday, COUNT(*)
FROM users 
GROUP BY most_register_weekday
ORDER BY COUNT(*) DESC LIMIT 2;

-- Find the users who have never posted a photo.
SELECT username
FROM users
LEFT JOIN photos ON users.id = photos.user_id
WHERE image_url IS NULL;
 
-- Who get the most like on a single photo?
SELECT username, photos.id, photos.image_url, COUNT(*) AS total
FROM users
JOIN photos ON photos.user_id = users.id
JOIN likes ON likes.photo_id = photos.id
GROUP BY photo_id
ORDER BY COUNT(*) DESC
LIMIT 1;

-- How many times doese the average user post?
SELECT ROUND(COUNT(DISTINCT image_url)/COUNT(DISTINCT username),2) AS avg_post
FROM users
LEFT JOIN photos ON photos.user_id = users.id;

-- What are the top 5 most commonly used hastags?
SELECT tag_name, COUNT(*) AS used_times
FROM photo_tags
JOIN tags ON tags.id = photo_tags.tag_id
GROUP BY tag_id
ORDER BY used_times DESC LIMIT 5;

-- Find users who have liked every single photo on the site.
SELECT username, COUNT(*) AS total_like
FROM likes
JOIN users ON users.id = likes.user_id
GROUP BY user_id
HAVING total_like = (SELECT COUNT(*) FROM photos) ;