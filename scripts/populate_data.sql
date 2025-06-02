-- =================================================================================
-- 0) DISABLE FOREIGN-KEY CHECKS (so that we can TRUNCATE in any order without errors)
-- =================================================================================
SET FOREIGN_KEY_CHECKS = 0;


-- =================================================================================
-- 1) TRUNCATE ALL DEPENDENT TABLES IN THE CORRECT ORDER
--    We start by truncating the most "child" tables, then move up to the parents.
-- =================================================================================

-- 1a) Remove all Offers
TRUNCATE TABLE `listings_offer`;

-- 1b) Remove all Listings
TRUNCATE TABLE `listings_listing`;

-- 1c) Remove all Book–Course assignments
TRUNCATE TABLE `listings_bookcourseassignment`;

-- 1d) Remove all BookSuggestions
TRUNCATE TABLE `listings_booksuggestion`;

-- 1e) Remove all Books
TRUNCATE TABLE `listings_book`;

-- 1f) Remove all Courses
TRUNCATE TABLE `listings_course`;


-- =================================================================================
-- 2) RE-ENABLE FOREIGN-KEY CHECKS
-- =================================================================================
SET FOREIGN_KEY_CHECKS = 1;


-- =================================================================================
-- 3) INSERT COURSES (IDs 1–10: COMPxxx & MATHxxx; ID 11: LIT101)
-- =================================================================================
INSERT IGNORE INTO `listings_course` (id, course_code, course_name, department) VALUES
  (1,  'COMP101', 'Introduction to Computer Science',    'Computer Science'),
  (2,  'COMP201', 'Data Structures and Algorithms',      'Computer Science'),
  (3,  'COMP301', 'Operating Systems',                    'Computer Science'),
  (4,  'COMP302', 'Database Systems',                     'Computer Science'),
  (5,  'COMP401', 'Software Engineering',                 'Computer Science'),
  (6,  'MATH101', 'Calculus I',                           'Mathematics'),
  (7,  'MATH201', 'Linear Algebra',                       'Mathematics'),
  (8,  'MATH202', 'Discrete Mathematics',                 'Mathematics'),
  (9,  'MATH301', 'Probability and Statistics',           'Mathematics'),
  (10, 'MATH302', 'Differential Equations',               'Mathematics'),
  (11, 'LIT101',  'Introduction to Literature',           'Literature');


-- =================================================================================
-- 4) INSERT THE ORIGINAL 20 BOOKS (CS + MATH TEXTBOOKS, IDs 1–20)
-- =================================================================================
INSERT IGNORE INTO `listings_book`
  (id, isbn, title, author, edition, publisher, publication_year)
VALUES
  (1,  '9780133760064', 'Computer Science: An Overview',                                                  'J. Glenn Brookshear',                     '12th', 'Pearson',                         2015),
  (2,  '9781590282755', 'Python Programming: An Introduction to Computer Science',                        'John M. Zelle',                           '3rd',  'Franklin, Beedle & Associates',       2017),
  (3,  '9780262033848', 'Introduction to Algorithms',                                                     'Thomas H. Cormen; Charles E. Leiserson; Ronald L. Rivest; Clifford Stein', '3rd', 'MIT Press', 2009),
  (4,  '9780321573513', 'Algorithms (4th Edition)',                                                      'Robert Sedgewick; Kevin Wayne',           '4th',  'Addison-Wesley',                     2011),
  (5,  '9781118063330', 'Operating System Concepts',                                                     'Abraham Silberschatz; Peter B. Galvin; Greg Gagne', '9th', 'Wiley',                   2012),
  (6,  '9780133805913', 'Modern Operating Systems',                                                      'Andrew S. Tanenbaum; Herbert Bos',        '4th',  'Pearson',                         2014),
  (7,  '9780073523323', 'Database System Concepts',                                                      'Abraham Silberschatz; Henry F. Korth; S. Sudarshan', '6th', 'McGraw-Hill',          2010),
  (8,  '9780131873254', 'Fundamentals of Database Systems',                                             'Ramez Elmasri; Shamkant B. Navathe',      '6th',  'Pearson',                         2010),
  (9,  '9780136042594', 'Software Engineering',                                                         'Ian Sommerville',                         '10th', 'Pearson',                         2015),
  (10, '9780132350884', 'Clean Code',                                                                   'Robert C. Martin',                        '1st',  'Prentice Hall',                   2008),
  (11, '9781118829368', 'Calculus: Early Transcendentals',                                              'James Stewart',                           '8th',  'Cengage',                         2015),
  (12, '9780134434203', 'Thomas'' Calculus',                                                            'George B. Thomas Jr.; Maurice D. Weir; Joel R. Hass', '13th', 'Pearson',            2014),
  (13, '9780321882714', 'Linear Algebra and Its Applications',                                          'David C. Lay',                            '4th',  'Pearson',                         2011),
  (14, '9783319110790', 'Linear Algebra Done Right',                                                    'Sheldon Axler',                           '3rd',  'Springer',                        2015),
  (15, '9780073383095', 'Discrete Mathematics and Its Applications',                                    'Kenneth H. Rosen',                        '7th',  'McGraw-Hill',                     2012),
  (16, '9781133594553', 'Discrete Mathematics with Applications',                                       'Susanna S. Epp',                          '4th',  'Cengage',                         2015),
  (17, '9780134118057', 'Probability & Statistics for Engineers & Scientists',                         'Ronald E. Walpole; Raymond H. Myers; Sharon L. Myers; Keying E. Ye', '9th', 'Prentice Hall', 2012),
  (18, '9780205036010', 'Probability and Statistics',                                                   'Morris H. DeGroot; Mark J. Schervish',     '4th',  'Pearson',                         2011),
  (19, '9781118533298', 'Elementary Differential Equations and Boundary Value Problems',                'William E. Boyce; Richard C. DiPrima',    '10th', 'Wiley',                         2012),
  (20, '9780134769316', 'Differential Equations with Boundary-Value Problems',                          'Dennis G. Zill',                          '9th',  'Cengage',                         2013);


-- =================================================================================
-- 5) INSERT 50 ADDITIONAL “LITERATURE” BOOKS (IDs 21–70)
--    (These rows were generated by a Python script; pasted here verbatim.)
-- =================================================================================
INSERT IGNORE INTO `listings_book`
  (id, isbn, title, author, edition, publisher, publication_year)
VALUES
  (21, '9780061120084', 'To Kill a Mockingbird',                      'Harper Lee',            NULL, 'J.B. Lippincott & Co.',           1960),
  (22, '9780451524935', '1984',                                       'George Orwell',         NULL, 'Secker & Warburg',                1949),
  (23, '9780743273565', 'The Great Gatsby',                           'F. Scott Fitzgerald',    NULL, 'Charles Scribner''s Sons',        1925),
  (24, '9780141439600', 'Pride and Prejudice',                        'Jane Austen',           NULL, 'T. Egerton',                      1813),
  (25, '9780140449136', 'Crime and Punishment',                       'Fyodor Dostoevsky',     NULL, 'The Russian Messenger',          1866),
  (26, '9780553212419', 'The Catcher in the Rye',                     'J.D. Salinger',         NULL, 'Little, Brown and Company',        1951),
  (27, '9780140449266', 'The Brothers Karamazov',                     'Fyodor Dostoevsky',     NULL, 'The Russian Messenger',          1880),
  (28, '9780142437230', 'Moby-Dick',                                   'Herman Melville',       NULL, 'Richard Bentley',                 1851),
  (29, '9780142437964', 'War and Peace',                               'Leo Tolstoy',           NULL, 'The Russian Messenger',          1869),
  (30, '9780486280615', 'Jane Eyre',                                   'Charlotte Brontë',      NULL, 'Smith, Elder & Co.',              1847),
  (31, '9780142437209', 'Wuthering Heights',                          'Emily Brontë',          NULL, 'Thomas Cautley Newby',             1847),
  (32, '9780140449181', 'Anna Karenina',                               'Leo Tolstoy',           NULL, 'The Russian Messenger',          1878),
  (33, '9780140449181', 'Les Misérables',                              'Victor Hugo',           NULL, 'A. Lacroix, Verboeckhoven & Cie.', 1862),
  (34, '9780140449198', 'Don Quixote',                                 'Miguel de Cervantes',   NULL, 'Francisco de Robles',              1605),
  (35, '9780140455316', 'Madame Bovary',                               'Gustave Flaubert',      NULL, 'Revue de Paris',                   1856),
  (36, '9780140449273', 'The Odyssey',                                  'Homer',                 NULL, 'Ancient Greece',                   -800),
  (37, '9780140449303', 'The Iliad',                                    'Homer',                 NULL, 'Ancient Greece',                   -750),
  (38, '9780140449402', 'Ulysses',                                     'James Joyce',           NULL, 'Sylvia Beach',                    1922),
  (39, '9780142437186', 'A Tale of Two Cities',                        'Charles Dickens',       NULL, 'Chapman & Hall',                   1859),
  (40, '9780140449280', 'Brave New World',                             'Aldous Huxley',         NULL, 'Chatto & Windus',                  1932),
  (41, '9780140449337', 'The Count of Monte Cristo',                  'Alexandre Dumas',       NULL, 'Journal des débats',               1844),
  (42, '9780142437100', 'Great Expectations',                          'Charles Dickens',       NULL, 'Chapman & Hall',                   1861),
  (43, '9780140449297', 'One Hundred Years of Solitude',               'Gabriel García Márquez',NULL, 'Harper & Row',                     1967),
  (44, '9780140449419', 'Invisible Man',                               'Ralph Ellison',         NULL, 'Random House',                     1952),
  (45, '9780140449211', 'Beloved',                                     'Toni Morrison',         NULL, 'Alfred A. Knopf',                   1987),
  (46, '9780140449320', 'Heart of Darkness',                           'Joseph Conrad',         NULL, 'Blackwood''s Magazine',             1899),
  (47, '9780140449351', 'Their Eyes Were Watching God',                'Zora Neale Hurston',    NULL, 'J. B. Lippincott & Co.',           1937),
  (48, '9780140449344', 'Mrs Dalloway',                                'Virginia Woolf',        NULL, 'Hogarth Press',                     1925),
  (49, '9780140449313', 'Frankenstein',                                'Mary Shelley',          NULL, 'Lackington, Hughes, Harding, Mavor & Jones', 1818),
  (50, '9780140449375', 'The Sound and the Fury',                      'William Faulkner',      NULL, 'Jonathan Cape and Harrison Smith', 1929),
  (51, '9780140449368', 'The Sun Also Rises',                          'Ernest Hemingway',      NULL, 'Scribner''s',                       1926),
  (52, '9780140449426', 'To the Lighthouse',                            'Virginia Woolf',        NULL, 'Hogarth Press',                     1927),
  (53, '9780140449382', 'Slaughterhouse-Five',                         'Kurt Vonnegut',         NULL, 'Delacorte',                         1969),
  (54, '9780140449433', 'Catch-22',                                     'Joseph Heller',         NULL, 'Simon & Schuster',                  1961),
  (55, '9780140449440', 'A Farewell to Arms',                          'Ernest Hemingway',      NULL, 'Scribner''s',                       1929),
  (56, '9780140449457', 'Lolita',                                      'Vladimir Nabokov',      NULL, 'Olympia Press',                     1955),
  (57, '9780140449464', 'On the Road',                                  'Jack Kerouac',          NULL, 'Viking Press',                      1957),
  (58, '9780140449471', 'Dune',                                        'Frank Herbert',         NULL, 'Chilton Books',                     1965),
  (59, '9780140449488', 'The Stranger',                                'Albert Camus',          NULL, 'Gallimard',                         1942),
  (60, '9780140449495', 'The Metamorphosis',                           'Franz Kafka',           NULL, 'Kurt Wolff Verlag',                 1915),
  (61, '9780140449501', 'One Flew Over the Cuckoo''s Nest',            'Ken Kesey',             NULL, 'Penguin Books',                     1962),
  (62, '9780140449518', 'The Scarlet Letter',                          'Nathaniel Hawthorne',   NULL, 'Ticknor, Reed & Fields',            1850),
  (63, '9780140449525', 'The Old Man and the Sea',                      'Ernest Hemingway',      NULL, 'Charles Scribner''s Sons',          1952),
  (64, '9780140449532', 'Their Eyes Were Watching God',                'Zora Neale Hurston',    NULL, 'J. B. Lippincott & Co.',           1937),
  (65, '9780140449549', 'A Room of One''s Own',                        'Virginia Woolf',        NULL, 'Hogarth Press',                     1929),
  (66, '9780140449556', 'Waiting for Godot',                           'Samuel Beckett',        NULL, 'Éditions de Minuit',                1953),
  (67, '9780140449563', 'Blood Meridian',                             'Cormac McCarthy',       NULL, 'Random House',                      1985),
  (68, '9780140449570', 'The Handmaid''s Tale',                       'Margaret Atwood',       NULL, 'McClelland & Stewart',              1985),
  (69, '9780140449587', 'The Road',                                    'Cormac McCarthy',       NULL, 'Alfred A. Knopf',                    2006),
  (70, '9780140449594', 'The Jungle',                                  'Upton Sinclair',        NULL, 'D. Appleton & Company',             1906);


-- =================================================================================
-- 6) ASSIGN EXISTING 20 BOOKS → THEIR ORIGINAL COMP & MATH COURSES
-- =================================================================================
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


-- =================================================================================
-- 7) ASSIGN THE NEW 50 BOOKS (IDs 21–70) → LIT101 (course_id = 11)
-- =================================================================================
INSERT IGNORE INTO `listings_bookcourseassignment` (book_id, course_id, is_required) VALUES
  (21, 11, TRUE),
  (22, 11, TRUE),
  (23, 11, TRUE),
  (24, 11, TRUE),
  (25, 11, TRUE),
  (26, 11, TRUE),
  (27, 11, TRUE),
  (28, 11, TRUE),
  (29, 11, TRUE),
  (30, 11, TRUE),
  (31, 11, TRUE),
  (32, 11, TRUE),
  (33, 11, TRUE),
  (34, 11, TRUE),
  (35, 11, TRUE),
  (36, 11, TRUE),
  (37, 11, TRUE),
  (38, 11, TRUE),
  (39, 11, TRUE),
  (40, 11, TRUE),
  (41, 11, TRUE),
  (42, 11, TRUE),
  (43, 11, TRUE),
  (44, 11, TRUE),
  (45, 11, TRUE),
  (46, 11, TRUE),
  (47, 11, TRUE),
  (48, 11, TRUE),
  (49, 11, TRUE),
  (50, 11, TRUE),
  (51, 11, TRUE),
  (52, 11, TRUE),
  (53, 11, TRUE),
  (54, 11, TRUE),
  (55, 11, TRUE),
  (56, 11, TRUE),
  (57, 11, TRUE),
  (58, 11, TRUE),
  (59, 11, TRUE),
  (60, 11, TRUE),
  (61, 11, TRUE),
  (62, 11, TRUE),
  (63, 11, TRUE),
  (64, 11, TRUE),
  (65, 11, TRUE),
  (66, 11, TRUE),
  (67, 11, TRUE),
  (68, 11, TRUE),
  (69, 11, TRUE),
  (70, 11, TRUE);


-- =================================================================================
-- 8) INSERT ALL LISTINGS (STUDENT⇢BOOK with CONDITION, PRICE, ETC.)
--    For demonstration, we include a few for both COMP/MATH and LIT courses.
-- =================================================================================
INSERT IGNORE INTO `listings_listing`
  (student_id, book_id, `condition`, price, status, date_listed, description)
VALUES
  -- (COMP & MATH textbooks)
  (2,  1,  'GOOD', 45.00, 'AVL', NOW(), 'Gently used – some highlighting'),
  (3,  2,  'LN',   50.00, 'AVL', NOW(), 'Like new, only used one semester'),
  (4,  3,  'FAIR', 35.00, 'AVL', NOW(), 'Cover worn but pages clean'),
  (5,  4,  'NEW',  80.00, 'AVL', NOW(), 'Brand new copy'),
  (2,  5,  'GOOD', 40.00, 'AVL', NOW(), 'No major issues'),
  (3,  6,  'GOOD', 42.00, 'AVL', NOW(), 'All chapters intact'),
  (4,  7,  'LN',   55.00, 'AVL', NOW(), 'Used one semester'),
  (5,  8,  'FAIR', 30.00, 'AVL', NOW(), 'Minor notes inside'),
  (2,  9,  'ACC',  25.00, 'AVL', NOW(), 'Has some page creases'),
  (3,  10, 'LN',   60.00, 'AVL', NOW(), 'Almost new, no marks'),

  (2,  11, 'GOOD', 50.00, 'AVL', NOW(), 'Lightly used, good shape'),
  (3,  12, 'LN',   55.00, 'AVL', NOW(), 'Like new, only flipped through'),
  (4,  13, 'GOOD', 48.00, 'AVL', NOW(), 'Several notes in margin'),
  (5,  14, 'FAIR', 35.00, 'AVL', NOW(), 'Slightly worn, but pages intact'),
  (2,  15, 'GOOD', 45.00, 'AVL', NOW(), 'Clean copy, no highlights'),
  (3,  16, 'LN',   50.00, 'AVL', NOW(), 'Like new, minor notes'),
  (4,  17, 'ACC',  30.00, 'AVL', NOW(), 'Some corner wear'),
  (5,  18, 'GOOD', 38.00, 'AVL', NOW(), 'All chapters intact'),
  (2,  19, 'FAIR', 35.00, 'AVL', NOW(), 'Used a semester'),
  (3,  20, 'LN',   52.00, 'AVL', NOW(), 'Like new, no marks'),

  -- (Two sample LIT101 listings)
  (4, 21, 'GOOD', 25.00, 'AVL', NOW(), 'Classic American Lit: To Kill a Mockingbird'),
  (5, 22, 'LN',   28.00, 'AVL', NOW(), '1984 – foreign edition'),
  
  -- Now add one listing for each of the remaining 48 literature titles:
  (2, 23, 'GOOD', 20.00, 'AVL', NOW(), 'The Great Gatsby – crisp copy'),
  (3, 24, 'FAIR', 18.00, 'AVL', NOW(), 'Pride and Prejudice – some notes'),
  (4, 25, 'GOOD', 22.00, 'AVL', NOW(), 'Crime and Punishment – intact'),
  (5, 26, 'NEW',  30.00, 'AVL', NOW(), 'The Catcher in the Rye – mint'),
  (2, 27, 'FAIR', 15.00, 'AVL', NOW(), 'The Brothers Karamazov – worn edges'),
  (3, 28, 'GOOD', 19.00, 'AVL', NOW(), 'Moby-Dick – few dog‐ears'),
  (4, 29, 'GOOD', 24.00, 'AVL', NOW(), 'War and Peace – hardcover'),
  (5, 30, 'LN',   18.00, 'AVL', NOW(), 'Jane Eyre – nearly new'),
  (2, 31, 'FAIR', 17.50, 'AVL', NOW(), 'Wuthering Heights – annotated'),
  (3, 32, 'GOOD', 23.00, 'AVL', NOW(), 'Anna Karenina – very clean'),
  (4, 33, 'LN',   21.00, 'AVL', NOW(), 'Les Misérables – like new'),
  (5, 34, 'GOOD', 20.00, 'AVL', NOW(), 'Don Quixote – good cond.'),
  (2, 35, 'FAIR', 16.00, 'AVL', NOW(), 'Madame Bovary – some wear'),
  (3, 36, 'GOOD', 25.00, 'AVL', NOW(), 'The Odyssey – hardcover'),
  (4, 37, 'GOOD', 25.00, 'AVL', NOW(), 'The Iliad – very good cond.'),
  (5, 38, 'LN',   22.00, 'AVL', NOW(), 'Ulysses – mint condition'),
  (2, 39, 'GOOD', 18.00, 'AVL', NOW(), 'A Tale of Two Cities – nice'),
  (3, 40, 'FAIR', 17.00, 'AVL', NOW(), 'Brave New World – some notes'),
  (4, 41, 'GOOD', 19.00, 'AVL', NOW(), 'The Count of Monte Cristo – clean'),
  (5, 42, 'GOOD', 20.00, 'AVL', NOW(), 'Great Expectations – good cond.'),
  (2, 43, 'LN',   23.00, 'AVL', NOW(), 'One Hundred Years of Solitude – like new'),
  (3, 44, 'GOOD', 20.00, 'AVL', NOW(), 'Invisible Man – hardcover'),
  (4, 45, 'FAIR', 18.00, 'AVL', NOW(), 'Beloved – well‐read'),
  (5, 46, 'GOOD', 19.00, 'AVL', NOW(), 'Heart of Darkness – clean'),
  (2, 47, 'FAIR', 17.00, 'AVL', NOW(), 'Their Eyes Were Watching God – scuffed'),
  (3, 48, 'GOOD', 21.00, 'AVL', NOW(), 'Mrs Dalloway – excellent cond.'),
  (4, 49, 'LN',   22.00, 'AVL', NOW(), 'Frankenstein – like new'),
  (5, 50, 'GOOD', 19.00, 'AVL', NOW(), 'The Sound and the Fury – clean'),
  (2, 51, 'GOOD', 18.50, 'AVL', NOW(), 'The Sun Also Rises – good cond.'),
  (3, 52, 'LN',   20.00, 'AVL', NOW(), 'To the Lighthouse – like new'),
  (4, 53, 'GOOD', 22.00, 'AVL', NOW(), 'Slaughterhouse-Five – clean'),
  (5, 54, 'FAIR', 17.00, 'AVL', NOW(), 'Catch-22 – some highlights'),
  (2, 55, 'GOOD', 18.00, 'AVL', NOW(), 'A Farewell to Arms – good cond.'),
  (3, 56, 'LN',   24.00, 'AVL', NOW(), 'Lolita – barely used'),
  (4, 57, 'GOOD', 21.00, 'AVL', NOW(), 'On the Road – clean'),
  (5, 58, 'FAIR', 20.00, 'AVL', NOW(), 'Dune – minor crease'),
  (2, 59, 'GOOD', 19.00, 'AVL', NOW(), 'The Stranger – hardcover'),
  (3, 60, 'GOOD', 20.00, 'AVL', NOW(), 'The Metamorphosis – good cond.'),
  (4, 61, 'LN',   22.00, 'AVL', NOW(), 'One Flew Over the Cuckoo''s Nest – like new'),
  (5, 62, 'GOOD', 18.00, 'AVL', NOW(), 'The Scarlet Letter – clean'),
  (2, 63, 'FAIR', 17.50, 'AVL', NOW(), 'The Old Man and the Sea – worn edges'),
  (3, 64, 'GOOD', 20.00, 'AVL', NOW(), 'Their Eyes Were Watching God – hardback'),
  (4, 65, 'LN',   21.00, 'AVL', NOW(), 'A Room of One''s Own – like new'),
  (5, 66, 'GOOD', 18.00, 'AVL', NOW(), 'Waiting for Godot – clean'),
  (2, 67, 'GOOD', 19.00, 'AVL', NOW(), 'Blood Meridian – hardcover'),
  (3, 68, 'FAIR', 18.00, 'AVL', NOW(), 'The Handmaid''s Tale – well‐used'),
  (4, 69, 'GOOD', 20.00, 'AVL', NOW(), 'The Road – very good cond.'),
  (5, 70, 'LN',   22.00, 'AVL', NOW(), 'The Jungle – like new');


-- =================================================================================
-- 9) INSERT SOME SAMPLE OFFERS
-- =================================================================================
INSERT IGNORE INTO `listings_offer`
  (listing_id, buyer_id, offer_price, status, created_at)
VALUES
  (1, 3, 40.00, 'PEN', NOW()),
  (1, 4, 38.00, 'PEN', NOW()),
  (2, 2, 45.00, 'PEN', NOW()),
  (3, 5, 30.00, 'PEN', NOW()),
  (4, 3, 75.00, 'PEN', NOW());


-- =================================================================================
-- 10) INSERT SOME SAMPLE BookSuggestions
--     Note: The Django model uses `timestamp` (not `created_at`) for BookSuggestion.
-- =================================================================================
INSERT IGNORE INTO `listings_booksuggestion`
  (title, author, isbn, suggested_by_id, timestamp)
VALUES
  ('Introduction to Machine Learning',                    'Alpaydin, Ethem',                   '9780262012430', 2, NOW()),
  ('Discrete Mathematical Structures',                     'Rosen, Kenneth H.',                 '9780546928119', 3, NOW()),
  ('Artificial Intelligence: A Modern Approach',           'Stuart Russell; Peter Norvig',      '9780136042594', 4, NOW()),
  ('Database Systems: The Complete Book',                  'Hector Garcia-Molina; Jeff Ullman; Jennifer Widom', '9780131873254', 5, NOW()),
  ('Clean Architecture',                                   'Robert C. Martin',                  '9780134494166', 2, NOW()),
  ('Deep Learning',                                        'Ian Goodfellow; Yoshua Bengio; Aaron Courville', '9780262035613', 3, NOW());
