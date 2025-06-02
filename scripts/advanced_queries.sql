-- 1) Find the listing with the highest number of offers
SELECT l.id AS listing_id,
       b.title AS book_title,
       COUNT(o.id) AS total_offers
FROM Listings AS l
LEFT JOIN Offer AS o ON l.id = o.listing_id
LEFT JOIN Books AS b ON l.book_id = b.id
GROUP BY l.id, b.title
ORDER BY total_offers DESC
LIMIT 1;

-- 2) Count how many listings exist per course (only “Available” listings)
SELECT c.id AS course_id,
       c.course_code,
       c.course_name,
       COUNT(l.id) AS available_listings
FROM Courses AS c
LEFT JOIN BookCourseAssignments AS bca ON c.id = bca.course_id
LEFT JOIN Listings AS l ON l.book_id = bca.book_id AND l.status = 'AVL'
GROUP BY c.id, c.course_code, c.course_name
HAVING available_listings > 0
ORDER BY available_listings DESC;

-- 3) Find average price of listings per book author (only “Available”)
SELECT b.author,
       AVG(l.price) AS avg_price
FROM Listings AS l
JOIN Books AS b ON l.book_id = b.id
WHERE l.status = 'AVL' AND l.price IS NOT NULL
GROUP BY b.author
HAVING AVG(l.price) IS NOT NULL
ORDER BY avg_price DESC;

-- 4) Show users who have made offers on more than three distinct listings
SELECT u.id AS user_id,
       u.username,
       COUNT(DISTINCT o.listing_id) AS distinct_listings_offered
FROM Offer AS o
JOIN auth_user AS u ON o.buyer_id = u.id
GROUP BY u.id, u.username
HAVING COUNT(DISTINCT o.listing_id) > 3
ORDER BY distinct_listings_offered DESC;

-- 5) Retrieve all courses that have never had an “Available” listing
SELECT c.id AS course_id,
       c.course_code,
       c.course_name
FROM Courses AS c
LEFT JOIN BookCourseAssignments AS bca ON c.id = bca.course_id
LEFT JOIN Listings AS l ON l.book_id = bca.book_id AND l.status = 'AVL'
WHERE l.id IS NULL
ORDER BY c.course_code;
