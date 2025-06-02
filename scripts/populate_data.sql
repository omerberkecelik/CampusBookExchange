-- populate_data_django_tables.sql
-- =================================

-- 1) Courses verileri (Django tablosu: listings_course)
INSERT IGNORE INTO `listings_course` (id, course_code, course_name, department) VALUES
  (1,  'COMP101', 'Introduction to Computer Science', 'Computer Science'),
  (2,  'COMP201', 'Data Structures and Algorithms', 'Computer Science'),
  (3,  'COMP301', 'Operating Systems', 'Computer Science'),
  (4,  'COMP302', 'Database Systems', 'Computer Science'),
  (5,  'COMP401', 'Software Engineering', 'Computer Science'),
  (6,  'MATH101', 'Calculus I', 'Mathematics'),
  (7,  'MATH201', 'Linear Algebra', 'Mathematics'),
  (8,  'MATH202', 'Discrete Mathematics', 'Mathematics'),
  (9,  'MATH301', 'Probability and Statistics', 'Mathematics'),
  (10, 'MATH302', 'Differential Equations', 'Mathematics');

-- 2) Books verileri (Django tablosu: listings_book)
INSERT IGNORE INTO `listings_book` (id, isbn, title, author, edition, publisher, publication_year) VALUES
  (1,  '9780133760064', 'Computer Science: An Overview', 'J. Glenn Brookshear', '12th', 'Pearson', 2015),
  (2,  '9781590282755', 'Python Programming: An Introduction to Computer Science', 'John M. Zelle', '3rd', 'Franklin, Beedle & Associates', 2017),
  (3,  '9780262033848', 'Introduction to Algorithms', 'Thomas H. Cormen; Charles E. Leiserson; Ronald L. Rivest; Clifford Stein', '3rd', 'MIT Press', 2009),
  (4,  '9780321573513', 'Algorithms (4th Edition)', 'Robert Sedgewick; Kevin Wayne', '4th', 'Addison-Wesley', 2011),
  (5,  '9781118063330', 'Operating System Concepts', 'Abraham Silberschatz; Peter B. Galvin; Greg Gagne', '9th', 'Wiley', 2012),
  (6,  '9780133805913', 'Modern Operating Systems', 'Andrew S. Tanenbaum; Herbert Bos', '4th', 'Pearson', 2014),
  (7,  '9780073523323', 'Database System Concepts', 'Abraham Silberschatz; Henry F. Korth; S. Sudarshan', '6th', 'McGraw-Hill', 2010),
  (8,  '9780131873254', 'Fundamentals of Database Systems', 'Ramez Elmasri; Shamkant B. Navathe', '6th', 'Pearson', 2010),
  (9,  '9780136042594', 'Software Engineering', 'Ian Sommerville', '10th', 'Pearson', 2015),
  (10, '9780132350884', 'Clean Code', 'Robert C. Martin', '1st', 'Prentice Hall', 2008),
  (11, '9781118829368', 'Calculus: Early Transcendentals', 'James Stewart', '8th', 'Cengage', 2015),
  (12, '9780134434203', 'Thomas'' Calculus', 'George B. Thomas Jr.; Maurice D. Weir; Joel R. Hass', '13th', 'Pearson', 2014),
  (13, '9780321882714', 'Linear Algebra and Its Applications', 'David C. Lay', '4th', 'Pearson', 2011),
  (14, '9783319110790', 'Linear Algebra Done Right', 'Sheldon Axler', '3rd', 'Springer', 2015),
  (15, '9780073383095', 'Discrete Mathematics and Its Applications', 'Kenneth H. Rosen', '7th', 'McGraw-Hill', 2012),
  (16, '9781133594553', 'Discrete Mathematics with Applications', 'Susanna S. Epp', '4th', 'Cengage', 2015),
  (17, '9780134118057', 'Probability & Statistics for Engineers & Scientists', 'Ronald E. Walpole; Raymond H. Myers; Sharon L. Myers; Keying E. Ye', '9th', 'Prentice Hall', 2012),
  (18, '9780205036010', 'Probability and Statistics', 'Morris H. DeGroot; Mark J. Schervish', '4th', 'Pearson', 2011),
  (19, '9781118533298', 'Elementary Differential Equations and Boundary Value Problems', 'William E. Boyce; Richard C. DiPrima', '10th', 'Wiley', 2012),
  (20, '9780134769316', 'Differential Equations with Boundary-Value Problems', 'Dennis G. Zill', '9th', 'Cengage', 2013);

-- 3) BookCourseAssignments verileri (Django tablosu: listings_bookcourseassignment)
INSERT IGNORE INTO `listings_bookcourseassignment` (book_id, course_id, is_required) VALUES
  (1,  1, TRUE),
  (2,  1, TRUE),
  (3,  2, TRUE),
  (4,  2, TRUE),
  (5,  3, TRUE),
  (6,  3, TRUE),
  (7,  4, TRUE),
  (8,  4, TRUE),
  (9,  5, TRUE),
  (10, 5, TRUE),
  (11, 6, TRUE),
  (12, 6, TRUE),
  (13, 7, TRUE),
  (14, 7, TRUE),
  (15, 8, TRUE),
  (16, 8, TRUE),
  (17, 9, TRUE),
  (18, 9, TRUE),
  (19, 10, TRUE),
  (20, 10, TRUE);

-- 4) Listings verileri (Django tablosu: listings_listing)
--    Modelde: student→User, book→Book; condition, price, status, date_listed, description
INSERT IGNORE INTO `listings_listing` (`student_id`, `book_id`, `condition`, `price`, `status`, `date_listed`, `description`) VALUES
  (2,  1, 'GOOD', 45.00, 'AVL', NOW(), 'Gently used – some highlighting'),
  (3,  2, 'LN',   50.00, 'AVL', NOW(), 'Like new, only used one semester'),
  (4,  3, 'FAIR', 35.00, 'AVL', NOW(), 'Cover worn but pages clean'),
  (5,  4, 'NEW',  80.00, 'AVL', NOW(), 'Brand new copy'),
  (2,  5, 'GOOD', 40.00, 'AVL', NOW(), 'No major issues'),
  (3,  6, 'GOOD', 42.00, 'AVL', NOW(), 'All chapters intact'),
  (4,  7, 'LN',   55.00, 'AVL', NOW(), 'Used one semester'),
  (5,  8, 'FAIR', 30.00, 'AVL', NOW(), 'Minor notes inside'),
  (2,  9, 'ACC',  25.00, 'AVL', NOW(), 'Has some page creases'),
  (3, 10, 'LN',   60.00, 'AVL', NOW(), 'Almost new, no marks');

-- 5) Offer verileri (Django tablosu: listings_offer)
--    Modelde: listing→Listing, buyer→User, offer_price, status, created_at
INSERT IGNORE INTO `listings_offer` (`listing_id`, `buyer_id`, `offer_price`, `status`, `created_at`) VALUES
  (1,  3, 40.00, 'PEN', NOW()),
  (1,  4, 38.00, 'PEN', NOW()),
  (2,  2, 45.00, 'PEN', NOW()),
  (3,  5, 30.00, 'PEN', NOW()),
  (4,  3, 75.00, 'PEN', NOW());

-- 6) BookSuggestion verileri (Django tablosu: listings_booksuggestion)
--    Modelde: title, author, isbn, suggested_by (User), timestamp (ÖNEMLİ: created_at değil), is_approved (default=False)
INSERT IGNORE INTO `listings_booksuggestion` (`title`, `author`, `isbn`, `suggested_by_id`, `timestamp`, `is_approved`) VALUES
  ('Introduction to Machine Learning', 'Alpaydin, Ethem', '9780262012430', 2, NOW(), FALSE),
  ('Discrete Mathematical Structures',   'Rosen, Kenneth H.', '9780546928119', 3, NOW(), FALSE);
