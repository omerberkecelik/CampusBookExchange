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
-- 3) INSERT COURSES
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
-- 4) INSERT BOOKS WITH REALISTIC COURSE MAPPINGS
-- =================================================================================

-- COMP101 Books (Introduction to Computer Science)
INSERT IGNORE INTO `listings_book` (id, isbn, title, author, edition, publisher, publication_year) VALUES
  (1,  '9780133760064', 'Computer Science: An Overview',                       'J. Glenn Brookshear',                     '12th', 'Pearson',                         2015),
  (2,  '9781590282755', 'Python Programming: An Introduction to Computer Science', 'John M. Zelle',                           '3rd',  'Franklin, Beedle & Associates',   2017),
  (3,  '9780134444321', 'Introduction to Programming with Python',             'Y. Daniel Liang',                         '1st',  'Pearson',                         2018),
  (4,  '9780262033848', 'Starting Out with Programming Logic and Design',      'Tony Gaddis',                             '4th',  'Pearson',                         2016);

-- COMP201 Books (Data Structures and Algorithms)
INSERT IGNORE INTO `listings_book` (id, isbn, title, author, edition, publisher, publication_year) VALUES
  (5,  '9780262033841', 'Introduction to Algorithms',                          'Thomas H. Cormen; Charles E. Leiserson; Ronald L. Rivest; Clifford Stein', '3rd', 'MIT Press', 2009),
  (6,  '9780321573513', 'Algorithms (4th Edition)',                            'Robert Sedgewick; Kevin Wayne',           '4th',  'Addison-Wesley',                  2011),
  (7,  '9780073523408', 'Data Structures and Algorithm Analysis in Java',      'Mark Allen Weiss',                        '3rd',  'Pearson',                         2012),
  (8,  '9780134847665', 'Data Structures and Algorithms in Python',           'Michael T. Goodrich; Roberto Tamassia; Michael H. Goldwasser', '1st', 'Wiley', 2013);

-- COMP301 Books (Operating Systems)
INSERT IGNORE INTO `listings_book` (id, isbn, title, author, edition, publisher, publication_year) VALUES
  (9,  '9781118063330', 'Operating System Concepts',                           'Abraham Silberschatz; Peter B. Galvin; Greg Gagne', '9th', 'Wiley',                   2012),
  (10, '9780133805913', 'Modern Operating Systems',                            'Andrew S. Tanenbaum; Herbert Bos',        '4th',  'Pearson',                         2014),
  (11, '9780136006633', 'Operating Systems: Internals and Design Principles',  'William Stallings',                       '8th',  'Pearson',                         2015),
  (12, '9781449339531', 'The Linux Programming Interface',                     'Michael Kerrisk',                         '1st',  'No Starch Press',                 2010);

-- COMP302 Books (Database Systems)
INSERT IGNORE INTO `listings_book` (id, isbn, title, author, edition, publisher, publication_year) VALUES
  (13, '9780073523323', 'Database System Concepts',                            'Abraham Silberschatz; Henry F. Korth; S. Sudarshan', '6th', 'McGraw-Hill',          2010),
  (14, '9780131873254', 'Fundamentals of Database Systems',                    'Ramez Elmasri; Shamkant B. Navathe',      '6th',  'Pearson',                         2010),
  (15, '9780321884497', 'Database Management Systems',                         'Raghu Ramakrishnan; Johannes Gehrke',     '3rd',  'McGraw-Hill',                     2003),
  (16, '9780135093009', 'MySQL Crash Course',                                  'Ben Forta',                               '1st',  'Sams Publishing',                 2005);

-- COMP401 Books (Software Engineering)
INSERT IGNORE INTO `listings_book` (id, isbn, title, author, edition, publisher, publication_year) VALUES
  (17, '9780136042594', 'Software Engineering',                                'Ian Sommerville',                         '10th', 'Pearson',                         2015),
  (18, '9780132350884', 'Clean Code',                                          'Robert C. Martin',                        '1st',  'Prentice Hall',                   2008),
  (19, '9780132840286', 'The Mythical Man-Month',                              'Frederick P. Brooks Jr.',                 '2nd',  'Addison-Wesley',                  1995),
  (20, '9780321344751', 'Design Patterns: Elements of Reusable Object-Oriented Software', 'Erich Gamma; Richard Helm; Ralph Johnson; John Vlissides', '1st', 'Addison-Wesley', 1994);

-- MATH101 Books (Calculus I)
INSERT IGNORE INTO `listings_book` (id, isbn, title, author, edition, publisher, publication_year) VALUES
  (21, '9781118829368', 'Calculus: Early Transcendentals',                     'James Stewart',                           '8th',  'Cengage',                         2015),
  (22, '9780134434203', 'Thomas'' Calculus',                                   'George B. Thomas Jr.; Maurice D. Weir; Joel R. Hass', '13th', 'Pearson',            2014),
  (23, '9780321947345', 'Calculus for Scientists and Engineers',              'William L. Briggs; Lyle Cochran; Bernard Gillett', '1st', 'Pearson',                2013),
  (24, '9781464125188', 'Calculus: Single and Multivariable',                 'Deborah Hughes-Hallett; Andrew M. Gleason; William G. McCallum', '6th', 'Wiley', 2013);

-- MATH201 Books (Linear Algebra)
INSERT IGNORE INTO `listings_book` (id, isbn, title, author, edition, publisher, publication_year) VALUES
  (25, '9780321882714', 'Linear Algebra and Its Applications',                 'David C. Lay',                            '4th',  'Pearson',                         2011),
  (26, '9783319110790', 'Linear Algebra Done Right',                           'Sheldon Axler',                           '3rd',  'Springer',                        2015),
  (27, '9780470432051', 'Elementary Linear Algebra',                           'Howard Anton; Chris Rorres',              '10th', 'Wiley',                           2010),
  (28, '9780134860244', 'Linear Algebra: A Modern Introduction',               'David Poole',                             '4th',  'Cengage',                         2014);

-- MATH202 Books (Discrete Mathematics)
INSERT IGNORE INTO `listings_book` (id, isbn, title, author, edition, publisher, publication_year) VALUES
  (29, '9780073383095', 'Discrete Mathematics and Its Applications',           'Kenneth H. Rosen',                        '7th',  'McGraw-Hill',                     2012),
  (30, '9781133594553', 'Discrete Mathematics with Applications',              'Susanna S. Epp',                          '4th',  'Cengage',                         2015),
  (31, '9780321964687', 'A Discrete Transition to Advanced Mathematics',       'Bettina Richmond; Thomas Richmond',       '1st',  'Pearson',                         2004),
  (32, '9780534359454', 'Discrete and Combinatorial Mathematics',              'Ralph P. Grimaldi',                       '5th',  'Pearson',                         2003);

-- MATH301 Books (Probability and Statistics)
INSERT IGNORE INTO `listings_book` (id, isbn, title, author, edition, publisher, publication_year) VALUES
  (33, '9780134118057', 'Probability & Statistics for Engineers & Scientists', 'Ronald E. Walpole; Raymond H. Myers; Sharon L. Myers; Keying E. Ye', '9th', 'Prentice Hall', 2012),
  (34, '9780205036010', 'Probability and Statistics',                          'Morris H. DeGroot; Mark J. Schervish',     '4th',  'Pearson',                         2011),
  (35, '9781305251809', 'Introduction to Mathematical Statistics',             'Robert V. Hogg; Joseph McKean; Allen T. Craig', '7th', 'Cengage',                      2013),
  (36, '9780321795434', 'Mathematical Statistics with Applications',           'Dennis D. Wackerly; William Mendenhall III; Richard L. Scheaffer', '7th', 'Cengage', 2008);

-- MATH302 Books (Differential Equations)
INSERT IGNORE INTO `listings_book` (id, isbn, title, author, edition, publisher, publication_year) VALUES
  (37, '9781118533298', 'Elementary Differential Equations and Boundary Value Problems', 'William E. Boyce; Richard C. DiPrima',    '10th', 'Wiley',                         2012),
  (38, '9780134769316', 'Differential Equations with Boundary-Value Problems', 'Dennis G. Zill',                          '9th',  'Cengage',                         2013),
  (39, '9780321816245', 'A First Course in Differential Equations',            'J. David Logan',                          '3rd',  'Springer',                        2015),
  (40, '9780470458310', 'Differential Equations: An Introduction to Modern Methods', 'James R. Brannan; William E. Boyce',      '2nd',  'Wiley',                           2011);

-- LIT101 Books (Introduction to Literature)
INSERT IGNORE INTO `listings_book` (id, isbn, title, author, edition, publisher, publication_year) VALUES
  (41, '9780061120084', 'To Kill a Mockingbird',                               'Harper Lee',            NULL, 'J.B. Lippincott & Co.',           1960),
  (42, '9780451524935', '1984',                                                'George Orwell',         NULL, 'Secker & Warburg',                1949),
  (43, '9780743273565', 'The Great Gatsby',                                    'F. Scott Fitzgerald',   NULL, 'Charles Scribner''s Sons',        1925),
  (44, '9780141439600', 'Pride and Prejudice',                                 'Jane Austen',           NULL, 'T. Egerton',                      1813),
  (45, '9780140449136', 'Crime and Punishment',                                'Fyodor Dostoevsky',     NULL, 'The Russian Messenger',           1866),
  (46, '9780553212419', 'The Catcher in the Rye',                              'J.D. Salinger',         NULL, 'Little, Brown and Company',       1951),
  (47, '9780142437230', 'Moby-Dick',                                           'Herman Melville',       NULL, 'Richard Bentley',                 1851),
  (48, '9780142437964', 'War and Peace',                                       'Leo Tolstoy',           NULL, 'The Russian Messenger',           1869),
  (49, '9780486280615', 'Jane Eyre',                                           'Charlotte Brontë',      NULL, 'Smith, Elder & Co.',              1847),
  (50, '9780140449181', 'Anna Karenina',                                       'Leo Tolstoy',           NULL, 'The Russian Messenger',           1878),
  (51, '9780140449266', 'The Brothers Karamazov',                             'Fyodor Dostoevsky',     NULL, 'The Russian Messenger',          1880),
  (52, '9780140444308', 'Les Misérables',                                      'Victor Hugo',           NULL, 'A. Lacroix, Verboeckhoven & Cie.', 1862),
  (53, '9780140449198', 'Don Quixote',                                         'Miguel de Cervantes',   NULL, 'Francisco de Robles',              1605),
  (54, '9780140455316', 'Madame Bovary',                                       'Gustave Flaubert',      NULL, 'Revue de Paris',                   1856),
  (55, '9780140449273', 'The Odyssey',                                          'Homer',                 NULL, 'Ancient Greece',                   -800),
  (56, '9780140449303', 'The Iliad',                                            'Homer',                 NULL, 'Ancient Greece',                   -750),
  (57, '9780140449402', 'Ulysses',                                             'James Joyce',           NULL, 'Sylvia Beach',                    1922),
  (58, '9780142437186', 'A Tale of Two Cities',                                'Charles Dickens',       NULL, 'Chapman & Hall',                   1859),
  (59, '9780140449280', 'Brave New World',                                     'Aldous Huxley',         NULL, 'Chatto & Windus',                  1932),
  (60, '9780140449337', 'The Count of Monte Cristo',                          'Alexandre Dumas',       NULL, 'Journal des débats',               1844),
  (61, '9780142437100', 'Great Expectations',                                  'Charles Dickens',       NULL, 'Chapman & Hall',                   1861),
  (62, '9780140449297', 'One Hundred Years of Solitude',                       'Gabriel García Márquez',NULL, 'Harper & Row',                     1967),
  (63, '9780140449419', 'Invisible Man',                                       'Ralph Ellison',         NULL, 'Random House',                     1952),
  (64, '9780140449211', 'Beloved',                                             'Toni Morrison',         NULL, 'Alfred A. Knopf',                   1987),
  (65, '9780140449320', 'Heart of Darkness',                                   'Joseph Conrad',         NULL, 'Blackwood''s Magazine',             1899),
  (66, '9780140449351', 'Their Eyes Were Watching God',                        'Zora Neale Hurston',    NULL, 'J. B. Lippincott & Co.',           1937),
  (67, '9780140449344', 'Mrs Dalloway',                                        'Virginia Woolf',        NULL, 'Hogarth Press',                     1925),
  (68, '9780140449313', 'Frankenstein',                                        'Mary Shelley',          NULL, 'Lackington, Hughes, Harding, Mavor & Jones', 1818),
  (69, '9780140449375', 'The Sound and the Fury',                              'William Faulkner',      NULL, 'Jonathan Cape and Harrison Smith', 1929),
  (70, '9780140449368', 'The Sun Also Rises',                                  'Ernest Hemingway',      NULL, 'Scribner''s',                       1926),
  (71, '9780140449426', 'To the Lighthouse',                                    'Virginia Woolf',        NULL, 'Hogarth Press',                     1927),
  (72, '9780140449382', 'Slaughterhouse-Five',                                 'Kurt Vonnegut',         NULL, 'Delacorte',                         1969),
  (73, '9780140449433', 'Catch-22',                                             'Joseph Heller',         NULL, 'Simon & Schuster',                  1961),
  (74, '9780140449440', 'A Farewell to Arms',                                  'Ernest Hemingway',      NULL, 'Scribner''s',                       1929),
  (75, '9780140449457', 'Lolita',                                              'Vladimir Nabokov',      NULL, 'Olympia Press',                     1955),
  (76, '9780140449464', 'On the Road',                                          'Jack Kerouac',          NULL, 'Viking Press',                      1957),
  (77, '9780140449471', 'Dune',                                                'Frank Herbert',         NULL, 'Chilton Books',                     1965),
  (78, '9780140449488', 'The Stranger',                                        'Albert Camus',          NULL, 'Gallimard',                         1942),
  (79, '9780140449495', 'The Metamorphosis',                                   'Franz Kafka',           NULL, 'Kurt Wolff Verlag',                 1915),
  (80, '9780140449501', 'One Flew Over the Cuckoo''s Nest',                    'Ken Kesey',             NULL, 'Penguin Books',                     1962),
  (81, '9780140449518', 'The Scarlet Letter',                                  'Nathaniel Hawthorne',   NULL, 'Ticknor, Reed & Fields',            1850),
  (82, '9780140449525', 'The Old Man and the Sea',                              'Ernest Hemingway',      NULL, 'Charles Scribner''s Sons',          1952),
  (83, '9780140449549', 'A Room of One''s Own',                                'Virginia Woolf',        NULL, 'Hogarth Press',                     1929),
  (84, '9780140449556', 'Waiting for Godot',                                   'Samuel Beckett',        NULL, 'Éditions de Minuit',                1953),
  (85, '9780140449563', 'Blood Meridian',                                     'Cormac McCarthy',       NULL, 'Random House',                      1985),
  (86, '9780140449570', 'The Handmaid''s Tale',                               'Margaret Atwood',       NULL, 'McClelland & Stewart',              1985),
  (87, '9780140449587', 'The Road',                                            'Cormac McCarthy',       NULL, 'Alfred A. Knopf',                    2006),
  (88, '9780140449594', 'The Jungle',                                          'Upton Sinclair',        NULL, 'D. Appleton & Company',             1906),
  (89, '9780451526342', 'Of Mice and Men',                                     'John Steinbeck',        NULL, 'Covici Friede',                     1937),
  (90, '9780486411095', 'The Adventures of Huckleberry Finn',                  'Mark Twain',            NULL, 'Chatto & Windus',                   1884),
  (91, '9780486284712', 'The Canterbury Tales',                                'Geoffrey Chaucer',      NULL, 'William Caxton',                    1478),
  (92, '9780140449624', 'Hamlet',                                              'William Shakespeare',   NULL, 'Nicholas Ling and John Trundell',   1603),
  (93, '9780140449631', 'Romeo and Juliet',                                    'William Shakespeare',   NULL, 'John Danter',                       1597),
  (94, '9780140449648', 'Macbeth',                                             'William Shakespeare',   NULL, 'First Folio',                       1623),
  (95, '9780140449655', 'King Lear',                                           'William Shakespeare',   NULL, 'Nathaniel Butter',                  1608),
  (96, '9780140449662', 'Othello',                                             'William Shakespeare',   NULL, 'Thomas Walkley',                    1622),
  (97, '9780140449679', 'A Midsummer Night''s Dream',                          'William Shakespeare',   NULL, 'Thomas Fisher',                     1600),
  (98, '9780140449686', 'The Tempest',                                         'William Shakespeare',   NULL, 'First Folio',                       1623),
  (99, '9780486411101', 'Dracula',                                             'Bram Stoker',           NULL, 'Archibald Constable and Company',   1897),
  (100, '9780486415871', 'The Picture of Dorian Gray',                         'Oscar Wilde',           NULL, 'Ward, Lock and Company',            1890),
  (101, '9780486280288', 'The Strange Case of Dr. Jekyll and Mr. Hyde',        'Robert Louis Stevenson', NULL, 'Longmans, Green & Co.',            1886),
  (102, '9780486406510', 'The Time Machine',                                   'H.G. Wells',            NULL, 'William Heinemann',                 1895),
  (103, '9780486284460', 'The War of the Worlds',                              'H.G. Wells',            NULL, 'William Heinemann',                 1898),
  (104, '9780486401676', 'The Turn of the Screw',                              'Henry James',           NULL, 'Collier''s Weekly',                 1898),
  (105, '9780486415765', 'The Yellow Wallpaper',                               'Charlotte Perkins Gilman', NULL, 'The New England Magazine',        1892),
  (106, '9780486280479', 'The Awakening',                                      'Kate Chopin',           NULL, 'Herbert S. Stone & Company',        1899),
  (107, '9780486280486', 'Sister Carrie',                                      'Theodore Dreiser',      NULL, 'Doubleday, Page & Company',         1900),
  (108, '9780486411071', 'An American Tragedy',                                'Theodore Dreiser',      NULL, 'Boni & Liveright',                  1925),
  (109, '9780486280493', 'The Age of Innocence',                               'Edith Wharton',         NULL, 'D. Appleton and Company',           1920),
  (110, '9780486415758', 'Ethan Frome',                                        'Edith Wharton',         NULL, 'Charles Scribner''s Sons',          1911),
  (111, '9780486284477', 'The House of Mirth',                                 'Edith Wharton',         NULL, 'Charles Scribner''s Sons',          1905),
  (112, '9780486280509', 'Main Street',                                        'Sinclair Lewis',        NULL, 'Harcourt, Brace and Howe',          1920),
  (113, '9780486415741', 'Babbitt',                                            'Sinclair Lewis',        NULL, 'Harcourt, Brace and Company',       1922),
  (114, '9780486280516', 'Arrowsmith',                                         'Sinclair Lewis',        NULL, 'Harcourt, Brace and Company',       1925),
  (115, '9780486415734', 'Look Homeward, Angel',                               'Thomas Wolfe',          NULL, 'Charles Scribner''s Sons',          1929),
  (116, '9780486280523', 'You Can''t Go Home Again',                           'Thomas Wolfe',          NULL, 'Harper & Brothers',                 1940),
  (117, '9780486415727', 'U.S.A.',                                             'John Dos Passos',       NULL, 'Harcourt, Brace and Company',       1938),
  (118, '9780486280530', 'The Grapes of Wrath',                                'John Steinbeck',        NULL, 'The Viking Press',                  1939),
  (119, '9780486415710', 'East of Eden',                                       'John Steinbeck',        NULL, 'The Viking Press',                  1952),
  (120, '9780486280547', 'Cannery Row',                                        'John Steinbeck',        NULL, 'The Viking Press',                  1945),
  (121, '9780486415703', 'The Pearl',                                          'John Steinbeck',        NULL, 'The Viking Press',                  1947),
  (122, '9780486280554', 'For Whom the Bell Tolls',                            'Ernest Hemingway',      NULL, 'Charles Scribner''s Sons',          1940),
  (123, '9780486415697', 'The Snows of Kilimanjaro',                           'Ernest Hemingway',      NULL, 'Esquire Magazine',                  1936),
  (124, '9780486280561', 'A Streetcar Named Desire',                           'Tennessee Williams',    NULL, 'New Directions Publishing',         1947),
  (125, '9780486415680', 'The Glass Menagerie',                                'Tennessee Williams',    NULL, 'Random House',                      1945),
  (126, '9780486280578', 'Cat on a Hot Tin Roof',                              'Tennessee Williams',    NULL, 'New Directions Publishing',         1955),
  (127, '9780486415673', 'Death of a Salesman',                                'Arthur Miller',         NULL, 'Viking Press',                      1949),
  (128, '9780486280585', 'The Crucible',                                       'Arthur Miller',         NULL, 'Viking Press',                      1953),
  (129, '9780486415666', 'All My Sons',                                        'Arthur Miller',         NULL, 'Reynal & Hitchcock',                1947),
  (130, '9780486280592', 'Long Day''s Journey Into Night',                     'Eugene O''Neill',       NULL, 'Yale University Press',             1956),
  (131, '9780486415659', 'The Iceman Cometh',                                  'Eugene O''Neill',       NULL, 'Random House',                      1946),
  (132, '9780486280608', 'A Raisin in the Sun',                                'Lorraine Hansberry',    NULL, 'Random House',                      1959),
  (133, '9780486415642', 'Fences',                                             'August Wilson',         NULL, 'New American Library',              1986),
  (134, '9780486280616', 'The Piano Lesson',                                   'August Wilson',         NULL, 'Dutton',                            1990),
  (135, '9780486415635', 'Joe Turner''s Come and Gone',                        'August Wilson',         NULL, 'Samuel French',                     1988),
  (136, '9780486280622', 'Ma Rainey''s Black Bottom',                          'August Wilson',         NULL, 'Samuel French',                     1985),
  (137, '9780486415628', 'The Color Purple',                                   'Alice Walker',          NULL, 'Harcourt Brace Jovanovich',         1982),
  (138, '9780486280639', 'Meridian',                                           'Alice Walker',          NULL, 'Harcourt Brace Jovanovich',         1976),
  (139, '9780486415611', 'The Temple of My Familiar',                          'Alice Walker',          NULL, 'Harcourt Brace Jovanovich',         1989),
  (140, '9780486280646', 'Song of Solomon',                                    'Toni Morrison',         NULL, 'Alfred A. Knopf',                   1977),
  (141, '9780486415604', 'Sula',                                               'Toni Morrison',         NULL, 'Alfred A. Knopf',                   1973),
  (142, '9780486280653', 'The Bluest Eye',                                     'Toni Morrison',         NULL, 'Holt, Rinehart and Winston',        1970),
  (143, '9780486415598', 'Jazz',                                               'Toni Morrison',         NULL, 'Alfred A. Knopf',                   1992),
  (144, '9780486280660', 'Paradise',                                           'Toni Morrison',         NULL, 'Alfred A. Knopf',                   1997),
  (145, '9780486415581', 'Love',                                               'Toni Morrison',         NULL, 'Alfred A. Knopf',                   2003),
  (146, '9780486280677', 'A Mercy',                                            'Toni Morrison',         NULL, 'Alfred A. Knopf',                   2008),
  (147, '9780486415574', 'Home',                                               'Toni Morrison',         NULL, 'Alfred A. Knopf',                   2012),
  (148, '9780486280684', 'God Help the Child',                                 'Toni Morrison',         NULL, 'Alfred A. Knopf',                   2015),
  (149, '9780486415567', 'The House on Mango Street',                          'Sandra Cisneros',       NULL, 'Arte Público Press',                1984),
  (150, '9780486280691', 'Woman Hollering Creek',                              'Sandra Cisneros',       NULL, 'Random House',                      1991),
  (151, '9780486415550', 'Caramelo',                                           'Sandra Cisneros',       NULL, 'Alfred A. Knopf',                   2002),
  (152, '9780486280707', 'The Joy Luck Club',                                  'Amy Tan',               NULL, 'G. P. Putnam''s Sons',              1989),
  (153, '9780486415543', 'The Kitchen God''s Wife',                            'Amy Tan',               NULL, 'G. P. Putnam''s Sons',              1991),
  (154, '9780486280714', 'The Hundred Secret Senses',                          'Amy Tan',               NULL, 'G. P. Putnam''s Sons',              1995),
  (155, '9780486415536', 'The Bonesetter''s Daughter',                         'Amy Tan',               NULL, 'G. P. Putnam''s Sons',              2001),
  (156, '9780486280721', 'Saving Fish from Drowning',                          'Amy Tan',               NULL, 'G. P. Putnam''s Sons',              2005),
  (157, '9780486415529', 'The Valley of Amazement',                            'Amy Tan',               NULL, 'Ecco',                              2013),
  (158, '9780486280738', 'Interpreter of Maladies',                            'Jhumpa Lahiri',         NULL, 'Houghton Mifflin Harcourt',         1999),
  (159, '9780486415512', 'The Namesake',                                       'Jhumpa Lahiri',         NULL, 'Houghton Mifflin',                  2003),
  (160, '9780486280745', 'Unaccustomed Earth',                                 'Jhumpa Lahiri',         NULL, 'Alfred A. Knopf',                   2008),
  (161, '9780486415505', 'The Lowland',                                        'Jhumpa Lahiri',         NULL, 'Alfred A. Knopf',                   2013),
  (162, '9780486280752', 'Everything I Never Told You',                        'Celeste Ng',            NULL, 'Penguin Press',                     2014),
  (163, '9780486415499', 'Little Fires Everywhere',                            'Celeste Ng',            NULL, 'Penguin Press',                     2017),
  (164, '9780486280769', 'The Kite Runner',                                    'Khaled Hosseini',       NULL, 'Riverhead Books',                   2003),
  (165, '9780486415482', 'A Thousand Splendid Suns',                           'Khaled Hosseini',       NULL, 'Riverhead Books',                   2007),
  (166, '9780486280776', 'And the Mountains Echoed',                           'Khaled Hosseini',       NULL, 'Riverhead Books',                   2013),
  (167, '9780486415475', 'Life of Pi',                                         'Yann Martel',           NULL, 'Knopf Canada',                      2001),
  (168, '9780486280783', 'The Curious Incident of the Dog in the Night-Time', 'Mark Haddon',           NULL, 'Jonathan Cape',                     2003),
  (169, '9780486415468', 'Never Let Me Go',                                    'Kazuo Ishiguro',        NULL, 'Faber and Faber',                   2005),
  (170, '9780486280790', 'The Remains of the Day',                             'Kazuo Ishiguro',        NULL, 'Faber and Faber',                   1989),
  (171, '9780486415451', 'An Artist of the Floating World',                    'Kazuo Ishiguro',        NULL, 'Faber and Faber',                   1986),
  (172, '9780486280806', 'When We Were Orphans',                               'Kazuo Ishiguro',        NULL, 'Faber and Faber',                   2000),
  (173, '9780486415444', 'The Buried Giant',                                   'Kazuo Ishiguro',        NULL, 'Faber and Faber',                   2015),
  (174, '9780486280813', 'Klara and the Sun',                                  'Kazuo Ishiguro',        NULL, 'Faber and Faber',                   2021),
  (175, '9780486415437', 'Atonement',                                          'Ian McEwan',            NULL, 'Jonathan Cape',                     2001),
  (176, '9780486280820', 'Saturday',                                           'Ian McEwan',            NULL, 'Jonathan Cape',                     2005),
  (177, '9780486415420', 'On Chesil Beach',                                    'Ian McEwan',            NULL, 'Jonathan Cape',                     2007),
  (178, '9780486280837', 'Solar',                                              'Ian McEwan',            NULL, 'Jonathan Cape',                     2010),
  (179, '9780486415413', 'Sweet Tooth',                                        'Ian McEwan',            NULL, 'Jonathan Cape',                     2012),
  (180, '9780486280844', 'The Children Act',                                   'Ian McEwan',            NULL, 'Jonathan Cape',                     2014),
  (181, '9780486415406', 'Nutshell',                                           'Ian McEwan',            NULL, 'Jonathan Cape',                     2016),
  (182, '9780486280851', 'Machines Like Me',                                   'Ian McEwan',            NULL, 'Jonathan Cape',                     2019),
  (183, '9780486415390', 'The Sense of an Ending',                             'Julian Barnes',         NULL, 'Jonathan Cape',                     2011),
  (184, '9780486280868', 'Flaubert''s Parrot',                                 'Julian Barnes',         NULL, 'Jonathan Cape',                     1984),
  (185, '9780486415383', 'A History of the World in 10½ Chapters',            'Julian Barnes',         NULL, 'Jonathan Cape',                     1989),
  (186, '9780486280875', 'The Noise of Time',                                  'Julian Barnes',         NULL, 'Jonathan Cape',                     2016),
  (187, '9780486415376', 'The Only Story',                                     'Julian Barnes',         NULL, 'Jonathan Cape',                     2018),
  (188, '9780486280882', 'The Man in the Red Coat',                            'Julian Barnes',         NULL, 'Jonathan Cape',                     2019),
  (189, '9780486415369', 'Elizabeth Finch',                                    'Julian Barnes',         NULL, 'Jonathan Cape',                     2022),
  (190, '9780486280899', 'White Teeth',                                        'Zadie Smith',           NULL, 'Hamish Hamilton',                   2000),
  (191, '9780486415352', 'The Autograph Man',                                  'Zadie Smith',           NULL, 'Hamish Hamilton',                   2002),
  (192, '9780486280905', 'On Beauty',                                          'Zadie Smith',           NULL, 'Hamish Hamilton',                   2005),
  (193, '9780486415345', 'NW',                                                 'Zadie Smith',           NULL, 'Hamish Hamilton',                   2012),
  (194, '9780486280912', 'Swing Time',                                         'Zadie Smith',           NULL, 'Hamish Hamilton',                   2016),
  (195, '9780486415338', 'The Fraud',                                          'Zadie Smith',           NULL, 'Hamish Hamilton',                   2023),
  (196, '9780486280929', 'Middlesex',                                          'Jeffrey Eugenides',     NULL, 'Farrar, Straus and Giroux',         2002),
  (197, '9780486415321', 'The Virgin Suicides',                                'Jeffrey Eugenides',     NULL, 'Farrar, Straus and Giroux',         1993),
  (198, '9780486280936', 'The Marriage Plot',                                  'Jeffrey Eugenides',     NULL, 'Farrar, Straus and Giroux',         2011),
  (199, '9780486415314', 'Fresh Complaint',                                    'Jeffrey Eugenides',     NULL, 'Farrar, Straus and Giroux',         2017),
  (200, '9780486280943', 'The Corrections',                                    'Jonathan Franzen',      NULL, 'Farrar, Straus and Giroux',         2001),
  (201, '9780486415307', 'Freedom',                                            'Jonathan Franzen',      NULL, 'Farrar, Straus and Giroux',         2010),
  (202, '9780486280950', 'Purity',                                             'Jonathan Franzen',      NULL, 'Farrar, Straus and Giroux',         2015),
  (203, '9780486415291', 'Crossroads',                                         'Jonathan Franzen',      NULL, 'Farrar, Straus and Giroux',         2021),
  (204, '9780486280967', 'The Amazing Adventures of Kavalier & Clay',          'Michael Chabon',        NULL, 'Random House',                      2000),
  (205, '9780486415284', 'Wonder Boys',                                        'Michael Chabon',        NULL, 'Villard',                           1995),
  (206, '9780486280974', 'The Mysteries of Pittsburgh',                        'Michael Chabon',        NULL, 'William Morrow',                    1988),
  (207, '9780486415277', 'The Yiddish Policemen''s Union',                     'Michael Chabon',        NULL, 'HarperCollins',                     2007),
  (208, '9780486280981', 'Telegraph Avenue',                                   'Michael Chabon',        NULL, 'Harper',                            2012),
  (209, '9780486415260', 'Moonglow',                                           'Michael Chabon',        NULL, 'Harper',                            2016),
  (210, '9780486280998', 'The Brief Wondrous Life of Oscar Wao',               'Junot Díaz',            NULL, 'Riverhead Books',                   2007),
  (211, '9780486415253', 'Drown',                                              'Junot Díaz',            NULL, 'Riverhead Books',                   1996),
  (212, '9780486281004', 'This Is How You Lose Her',                           'Junot Díaz',            NULL, 'Riverhead Books',                   2012),
  (213, '9780486415246', 'The Sellout',                                        'Paul Beatty',           NULL, 'Farrar, Straus and Giroux',         2015),
  (214, '9780486281011', 'White Boy Shuffle',                                  'Paul Beatty',           NULL, 'Henry Holt',                        1996),
  (215, '9780486415239', 'Tuff',                                               'Paul Beatty',           NULL, 'Alfred A. Knopf',                   2000),
  (216, '9780486281028', 'Slumberland',                                        'Paul Beatty',           NULL, 'Bloomsbury',                        2008),
  (217, '9780486415222', 'The Underground Railroad',                           'Colson Whitehead',      NULL, 'Doubleday',                         2016),
  (218, '9780486281035', 'The Intuitionist',                                   'Colson Whitehead',      NULL, 'Anchor Books',                      1999),
  (219, '9780486415215', 'John Henry Days',                                    'Colson Whitehead',      NULL, 'Doubleday',                         2001),
  (220, '9780486281042', 'Zone One',                                           'Colson Whitehead',      NULL, 'Doubleday',                         2011);


-- =================================================================================
-- 5) ASSIGN BOOKS TO THEIR APPROPRIATE COURSES
-- =================================================================================

-- COMP101 assignments
INSERT IGNORE INTO `listings_bookcourseassignment` (book_id, course_id, is_required) VALUES
  (1, 1, TRUE),
  (2, 1, TRUE),
  (3, 1, FALSE),
  (4, 1, FALSE);

-- COMP201 assignments
INSERT IGNORE INTO `listings_bookcourseassignment` (book_id, course_id, is_required) VALUES
  (5, 2, TRUE),
  (6, 2, TRUE),
  (7, 2, FALSE),
  (8, 2, FALSE);

-- COMP301 assignments
INSERT IGNORE INTO `listings_bookcourseassignment` (book_id, course_id, is_required) VALUES
  (9, 3, TRUE),
  (10, 3, TRUE),
  (11, 3, FALSE),
  (12, 3, FALSE);

-- COMP302 assignments
INSERT IGNORE INTO `listings_bookcourseassignment` (book_id, course_id, is_required) VALUES
  (13, 4, TRUE),
  (14, 4, TRUE),
  (15, 4, FALSE),
  (16, 4, FALSE);

-- COMP401 assignments
INSERT IGNORE INTO `listings_bookcourseassignment` (book_id, course_id, is_required) VALUES
  (17, 5, TRUE),
  (18, 5, TRUE),
  (19, 5, FALSE),
  (20, 5, FALSE);

-- MATH101 assignments
INSERT IGNORE INTO `listings_bookcourseassignment` (book_id, course_id, is_required) VALUES
  (21, 6, TRUE),
  (22, 6, TRUE),
  (23, 6, FALSE),
  (24, 6, FALSE);

-- MATH201 assignments
INSERT IGNORE INTO `listings_bookcourseassignment` (book_id, course_id, is_required) VALUES
  (25, 7, TRUE),
  (26, 7, TRUE),
  (27, 7, FALSE),
  (28, 7, FALSE);

-- MATH202 assignments
INSERT IGNORE INTO `listings_bookcourseassignment` (book_id, course_id, is_required) VALUES
  (29, 8, TRUE),
  (30, 8, TRUE),
  (31, 8, FALSE),
  (32, 8, FALSE);

-- MATH301 assignments
INSERT IGNORE INTO `listings_bookcourseassignment` (book_id, course_id, is_required) VALUES
  (33, 9, TRUE),
  (34, 9, TRUE),
  (35, 9, FALSE),
  (36, 9, FALSE);

-- MATH302 assignments  
INSERT IGNORE INTO `listings_bookcourseassignment` (book_id, course_id, is_required) VALUES
  (37, 10, TRUE),
  (38, 10, TRUE),
  (39, 10, FALSE),
  (40, 10, FALSE);

-- LIT101 assignments
INSERT IGNORE INTO `listings_bookcourseassignment` (book_id, course_id, is_required) VALUES
  (41, 11, TRUE),
  (42, 11, TRUE),
  (43, 11, TRUE),
  (44, 11, TRUE),
  (45, 11, FALSE),
  (46, 11, FALSE),
  (47, 11, FALSE),
  (48, 11, FALSE),
  (49, 11, FALSE),
  (50, 11, FALSE),
  (51, 11, FALSE),
  (52, 11, FALSE),
  (53, 11, FALSE),
  (54, 11, FALSE),
  (55, 11, FALSE),
  (56, 11, FALSE),
  (57, 11, FALSE),
  (58, 11, FALSE),
  (59, 11, FALSE),
  (60, 11, FALSE),
  (61, 11, FALSE),
  (62, 11, FALSE),
  (63, 11, FALSE),
  (64, 11, FALSE),
  (65, 11, FALSE),
  (66, 11, FALSE),
  (67, 11, FALSE),
  (68, 11, FALSE),
  (69, 11, FALSE),
  (70, 11, FALSE),
  (71, 11, FALSE),
  (72, 11, FALSE),
  (73, 11, FALSE),
  (74, 11, FALSE),
  (75, 11, FALSE),
  (76, 11, FALSE),
  (77, 11, FALSE),
  (78, 11, FALSE),
  (79, 11, FALSE),
  (80, 11, FALSE),
  (81, 11, FALSE),
  (82, 11, FALSE),
  (83, 11, FALSE),
  (84, 11, FALSE),
  (85, 11, FALSE),
  (86, 11, FALSE),
  (87, 11, FALSE),
  (88, 11, FALSE),
  (89, 11, FALSE),
  (90, 11, FALSE),
  (91, 11, FALSE),
  (92, 11, FALSE),
  (93, 11, FALSE),
  (94, 11, FALSE),
  (95, 11, FALSE),
  (96, 11, FALSE),
  (97, 11, FALSE),
  (98, 11, FALSE),
  (99, 11, FALSE),
  (100, 11, FALSE),
  (101, 11, FALSE),
  (102, 11, FALSE),
  (103, 11, FALSE),
  (104, 11, FALSE),
  (105, 11, FALSE),
  (106, 11, FALSE),
  (107, 11, FALSE),
  (108, 11, FALSE),
  (109, 11, FALSE),
  (110, 11, FALSE),
  (111, 11, FALSE),
  (112, 11, FALSE),
  (113, 11, FALSE),
  (114, 11, FALSE),
  (115, 11, FALSE),
  (116, 11, FALSE),
  (117, 11, FALSE),
  (118, 11, FALSE),
  (119, 11, FALSE),
  (120, 11, FALSE),
  (121, 11, FALSE),
  (122, 11, FALSE),
  (123, 11, FALSE),
  (124, 11, FALSE),
  (125, 11, FALSE),
  (126, 11, FALSE),
  (127, 11, FALSE),
  (128, 11, FALSE),
  (129, 11, FALSE),
  (130, 11, FALSE),
  (131, 11, FALSE),
  (132, 11, FALSE),
  (133, 11, FALSE),
  (134, 11, FALSE),
  (135, 11, FALSE),
  (136, 11, FALSE),
  (137, 11, FALSE),
  (138, 11, FALSE),
  (139, 11, FALSE),
  (140, 11, FALSE),
  (141, 11, FALSE),
  (142, 11, FALSE),
  (143, 11, FALSE),
  (144, 11, FALSE),
  (145, 11, FALSE),
  (146, 11, FALSE),
  (147, 11, FALSE),
  (148, 11, FALSE),
  (149, 11, FALSE),
  (150, 11, FALSE),
  (151, 11, FALSE),
  (152, 11, FALSE),
  (153, 11, FALSE),
  (154, 11, FALSE),
  (155, 11, FALSE),
  (156, 11, FALSE),
  (157, 11, FALSE),
  (158, 11, FALSE),
  (159, 11, FALSE),
  (160, 11, FALSE),
  (161, 11, FALSE),
  (162, 11, FALSE),
  (163, 11, FALSE),
  (164, 11, FALSE),
  (165, 11, FALSE),
  (166, 11, FALSE),
  (167, 11, FALSE),
  (168, 11, FALSE),
  (169, 11, FALSE),
  (170, 11, FALSE),
  (171, 11, FALSE),
  (172, 11, FALSE),
  (173, 11, FALSE),
  (174, 11, FALSE),
  (175, 11, FALSE),
  (176, 11, FALSE),
  (177, 11, FALSE),
  (178, 11, FALSE),
  (179, 11, FALSE),
  (180, 11, FALSE),
  (181, 11, FALSE),
  (182, 11, FALSE),
  (183, 11, FALSE),
  (184, 11, FALSE),
  (185, 11, FALSE),
  (186, 11, FALSE),
  (187, 11, FALSE),
  (188, 11, FALSE),
  (189, 11, FALSE),
  (190, 11, FALSE),
  (191, 11, FALSE),
  (192, 11, FALSE),
  (193, 11, FALSE),
  (194, 11, FALSE),
  (195, 11, FALSE),
  (196, 11, FALSE),
  (197, 11, FALSE),
  (198, 11, FALSE),
  (199, 11, FALSE),
  (200, 11, FALSE),
  (201, 11, FALSE),
  (202, 11, FALSE),
  (203, 11, FALSE),
  (204, 11, FALSE),
  (205, 11, FALSE),
  (206, 11, FALSE),
  (207, 11, FALSE),
  (208, 11, FALSE),
  (209, 11, FALSE),
  (210, 11, FALSE),
  (211, 11, FALSE),
  (212, 11, FALSE),
  (213, 11, FALSE),
  (214, 11, FALSE),
  (215, 11, FALSE),
  (216, 11, FALSE),
  (217, 11, FALSE),
  (218, 11, FALSE),
  (219, 11, FALSE),
  (220, 11, FALSE);


-- =================================================================================
-- 6) INSERT SAMPLE LISTINGS
-- =================================================================================
INSERT IGNORE INTO `listings_listing`
  (student_id, book_id, `condition`, price, status, date_listed, description)
VALUES
  -- COMP101 listings
  (2, 1, 'GOOD', 45.00, 'AVL', NOW(), 'Computer Science Overview - good condition'),
  (3, 2, 'LN', 50.00, 'AVL', NOW(), 'Python Programming - like new'),
  (4, 3, 'FAIR', 35.00, 'AVL', NOW(), 'Programming with Python - some wear'),
  (5, 4, 'NEW', 40.00, 'AVL', NOW(), 'Programming Logic - brand new'),

  -- COMP201 listings
  (2, 5, 'GOOD', 60.00, 'AVL', NOW(), 'Introduction to Algorithms - classic textbook'),
  (3, 6, 'LN', 65.00, 'AVL', NOW(), 'Algorithms 4th Edition - excellent condition'),
  (4, 7, 'FAIR', 45.00, 'AVL', NOW(), 'Data Structures in Java - some highlighting'),
  (5, 8, 'GOOD', 55.00, 'AVL', NOW(), 'Python Data Structures - clean copy'),

  -- COMP301 listings
  (2, 9, 'GOOD', 70.00, 'AVL', NOW(), 'Operating System Concepts - comprehensive'),
  (3, 10, 'LN', 75.00, 'AVL', NOW(), 'Modern Operating Systems - like new'),
  (4, 11, 'FAIR', 50.00, 'AVL', NOW(), 'OS Internals - minor wear'),
  (5, 12, 'GOOD', 60.00, 'AVL', NOW(), 'Linux Programming Interface - good shape'),

  -- COMP302 listings
  (2, 13, 'GOOD', 80.00, 'AVL', NOW(), 'Database System Concepts - standard text'),
  (3, 14, 'LN', 85.00, 'AVL', NOW(), 'Fundamentals of Database Systems - pristine'),
  (4, 15, 'FAIR', 55.00, 'AVL', NOW(), 'Database Management Systems - well used'),
  (5, 16, 'GOOD', 30.00, 'AVL', NOW(), 'MySQL Crash Course - practical guide'),

  -- COMP401 listings
  (2, 17, 'GOOD', 90.00, 'AVL', NOW(), 'Software Engineering - Sommerville classic'),
  (3, 18, 'LN', 65.00, 'AVL', NOW(), 'Clean Code - essential reading'),
  (4, 19, 'FAIR', 40.00, 'AVL', NOW(), 'Mythical Man-Month - timeless wisdom'),
  (5, 20, 'GOOD', 70.00, 'AVL', NOW(), 'Design Patterns - Gang of Four'),

  -- MATH101 listings
  (2, 21, 'GOOD', 95.00, 'AVL', NOW(), 'Stewart Calculus - comprehensive text'),
  (3, 22, 'LN', 100.00, 'AVL', NOW(), 'Thomas Calculus - like new condition'),
  (4, 23, 'FAIR', 75.00, 'AVL', NOW(), 'Calculus for Scientists - some notes'),
  (5, 24, 'GOOD', 85.00, 'AVL', NOW(), 'Single and Multivariable - good shape'),

  -- MATH201 listings
  (2, 25, 'GOOD', 80.00, 'AVL', NOW(), 'Linear Algebra Applications - Lay'),
  (3, 26, 'LN', 75.00, 'AVL', NOW(), 'Linear Algebra Done Right - excellent'),
  (4, 27, 'FAIR', 60.00, 'AVL', NOW(), 'Elementary Linear Algebra - worn'),
  (5, 28, 'GOOD', 70.00, 'AVL', NOW(), 'Modern Introduction - clean copy'),

  -- MATH202 listings
  (2, 29, 'GOOD', 85.00, 'AVL', NOW(), 'Discrete Math Applications - Rosen'),
  (3, 30, 'LN', 80.00, 'AVL', NOW(), 'Discrete Math with Applications - mint'),
  (4, 31, 'FAIR', 55.00, 'AVL', NOW(), 'Advanced Mathematics - used'),
  (5, 32, 'GOOD', 65.00, 'AVL', NOW(), 'Combinatorial Mathematics - good'),

  -- MATH301 listings
  (2, 33, 'GOOD', 90.00, 'AVL', NOW(), 'Probability & Statistics - engineers'),
  (3, 34, 'LN', 85.00, 'AVL', NOW(), 'Probability and Statistics - pristine'),
  (4, 35, 'FAIR', 65.00, 'AVL', NOW(), 'Mathematical Statistics - some wear'),
  (5, 36, 'GOOD', 75.00, 'AVL', NOW(), 'Statistics with Applications - clean'),

  -- MATH302 listings
  (2, 37, 'GOOD', 85.00, 'AVL', NOW(), 'Elementary Differential Equations - Boyce'),
  (3, 38, 'LN', 80.00, 'AVL', NOW(), 'Differential Equations - Zill'),
  (4, 39, 'FAIR', 60.00, 'AVL', NOW(), 'First Course - some highlighting'),
  (5, 40, 'GOOD', 70.00, 'AVL', NOW(), 'Modern Methods - good condition'),

  -- LIT101 listings
  (2, 41, 'GOOD', 12.00, 'AVL', NOW(), 'To Kill a Mockingbird - classic'),
  (3, 42, 'LN', 15.00, 'AVL', NOW(), '1984 - thought-provoking'),
  (4, 43, 'FAIR', 10.00, 'AVL', NOW(), 'The Great Gatsby - American classic'),
  (5, 44, 'GOOD', 13.00, 'AVL', NOW(), 'Pride and Prejudice - Austen masterpiece'),
  (2, 45, 'GOOD', 16.00, 'AVL', NOW(), 'Crime and Punishment - Dostoevsky'),
  (3, 46, 'LN', 14.00, 'AVL', NOW(), 'Catcher in the Rye - coming of age'),
  (4, 47, 'FAIR', 18.00, 'AVL', NOW(), 'Moby-Dick - epic adventure'),
  (5, 48, 'GOOD', 20.00, 'AVL', NOW(), 'War and Peace - Russian epic'),
  (2, 49, 'GOOD', 11.00, 'AVL', NOW(), 'Jane Eyre - Gothic romance'),
  (3, 50, 'LN', 17.00, 'AVL', NOW(), 'Anna Karenina - Tolstoy classic'),
  (4, 51, 'GOOD', 19.00, 'AVL', NOW(), 'The Brothers Karamazov - philosophical'),
  (5, 52, 'FAIR', 22.00, 'AVL', NOW(), 'Les Misérables - Hugo masterpiece'),
  (2, 53, 'LN', 21.00, 'AVL', NOW(), 'Don Quixote - literary classic'),
  (3, 54, 'GOOD', 14.00, 'AVL', NOW(), 'Madame Bovary - Flaubert'),
  (4, 55, 'FAIR', 25.00, 'AVL', NOW(), 'The Odyssey - Homer epic'),
  (5, 56, 'GOOD', 24.00, 'AVL', NOW(), 'The Iliad - ancient classic'),
  (2, 57, 'LN', 23.00, 'AVL', NOW(), 'Ulysses - Joyce modernist'),
  (3, 58, 'GOOD', 16.00, 'AVL', NOW(), 'A Tale of Two Cities - Dickens'),
  (4, 59, 'FAIR', 15.00, 'AVL', NOW(), 'Brave New World - dystopian'),
  (5, 60, 'GOOD', 20.00, 'AVL', NOW(), 'The Count of Monte Cristo - adventure'),
  (2, 61, 'GOOD', 17.00, 'AVL', NOW(), 'Great Expectations - Dickens classic'),
  (3, 62, 'LN', 22.00, 'AVL', NOW(), 'One Hundred Years of Solitude - magical realism'),
  (4, 63, 'FAIR', 18.00, 'AVL', NOW(), 'Invisible Man - Ellison'),
  (5, 64, 'GOOD', 21.00, 'AVL', NOW(), 'Beloved - Morrison masterpiece'),
  (2, 65, 'GOOD', 14.00, 'AVL', NOW(), 'Heart of Darkness - Conrad'),
  (3, 66, 'LN', 16.00, 'AVL', NOW(), 'Their Eyes Were Watching God - Hurston'),
  (4, 67, 'FAIR', 19.00, 'AVL', NOW(), 'Mrs Dalloway - Woolf'),
  (5, 68, 'GOOD', 15.00, 'AVL', NOW(), 'Frankenstein - Shelley'),
  (2, 69, 'GOOD', 20.00, 'AVL', NOW(), 'The Sound and the Fury - Faulkner'),
  (3, 70, 'LN', 17.00, 'AVL', NOW(), 'The Sun Also Rises - Hemingway'),
  (4, 71, 'FAIR', 18.00, 'AVL', NOW(), 'To the Lighthouse - Woolf'),
  (5, 72, 'GOOD', 16.00, 'AVL', NOW(), 'Slaughterhouse-Five - Vonnegut'),
  (2, 73, 'GOOD', 19.00, 'AVL', NOW(), 'Catch-22 - Heller'),
  (3, 74, 'LN', 18.00, 'AVL', NOW(), 'A Farewell to Arms - Hemingway'),
  (4, 75, 'FAIR', 22.00, 'AVL', NOW(), 'Lolita - Nabokov'),
  (5, 76, 'GOOD', 17.00, 'AVL', NOW(), 'On the Road - Kerouac'),
  (2, 77, 'GOOD', 24.00, 'AVL', NOW(), 'Dune - Herbert sci-fi classic'),
  (3, 78, 'LN', 16.00, 'AVL', NOW(), 'The Stranger - Camus'),
  (4, 79, 'FAIR', 15.00, 'AVL', NOW(), 'The Metamorphosis - Kafka'),
  (5, 80, 'GOOD', 18.00, 'AVL', NOW(), 'One Flew Over the Cuckoo''s Nest - Kesey'),
  (2, 81, 'GOOD', 14.00, 'AVL', NOW(), 'The Scarlet Letter - Hawthorne'),
  (3, 82, 'LN', 13.00, 'AVL', NOW(), 'The Old Man and the Sea - Hemingway'),
  (4, 83, 'FAIR', 17.00, 'AVL', NOW(), 'A Room of One''s Own - Woolf'),
  (5, 84, 'GOOD', 16.00, 'AVL', NOW(), 'Waiting for Godot - Beckett'),
  (2, 85, 'GOOD', 20.00, 'AVL', NOW(), 'Blood Meridian - McCarthy'),
  (3, 86, 'LN', 19.00, 'AVL', NOW(), 'The Handmaid''s Tale - Atwood'),
  (4, 87, 'FAIR', 21.00, 'AVL', NOW(), 'The Road - McCarthy'),
  (5, 88, 'GOOD', 15.00, 'AVL', NOW(), 'The Jungle - Sinclair'),
  (2, 89, 'GOOD', 12.00, 'AVL', NOW(), 'Of Mice and Men - Steinbeck'),
  (3, 90, 'LN', 16.00, 'AVL', NOW(), 'Huckleberry Finn - Twain'),
  (4, 91, 'FAIR', 25.00, 'AVL', NOW(), 'The Canterbury Tales - Chaucer'),
  (5, 92, 'GOOD', 14.00, 'AVL', NOW(), 'Hamlet - Shakespeare'),
  (2, 93, 'GOOD', 13.00, 'AVL', NOW(), 'Romeo and Juliet - Shakespeare'),
  (3, 94, 'LN', 15.00, 'AVL', NOW(), 'Macbeth - Shakespeare'),
  (4, 95, 'FAIR', 14.00, 'AVL', NOW(), 'King Lear - Shakespeare'),
  (5, 96, 'GOOD', 13.00, 'AVL', NOW(), 'Othello - Shakespeare'),
  (2, 97, 'GOOD', 12.00, 'AVL', NOW(), 'A Midsummer Night''s Dream - Shakespeare'),
  (3, 98, 'LN', 14.00, 'AVL', NOW(), 'The Tempest - Shakespeare'),
  (4, 99, 'FAIR', 17.00, 'AVL', NOW(), 'Dracula - Stoker'),
  (5, 100, 'GOOD', 16.00, 'AVL', NOW(), 'The Picture of Dorian Gray - Wilde'),
  (2, 118, 'GOOD', 18.00, 'AVL', NOW(), 'The Grapes of Wrath - Steinbeck'),
  (3, 127, 'LN', 16.00, 'AVL', NOW(), 'Death of a Salesman - Miller'),
  (4, 137, 'FAIR', 20.00, 'AVL', NOW(), 'The Color Purple - Walker'),
  (5, 140, 'GOOD', 19.00, 'AVL', NOW(), 'Song of Solomon - Morrison'),
  (2, 152, 'GOOD', 17.00, 'AVL', NOW(), 'The Joy Luck Club - Tan'),
  (3, 164, 'LN', 21.00, 'AVL', NOW(), 'The Kite Runner - Hosseini'),
  (4, 169, 'FAIR', 18.00, 'AVL', NOW(), 'Never Let Me Go - Ishiguro'),
  (5, 175, 'GOOD', 20.00, 'AVL', NOW(), 'Atonement - McEwan'),
  (2, 190, 'GOOD', 22.00, 'AVL', NOW(), 'White Teeth - Smith'),
  (3, 196, 'LN', 24.00, 'AVL', NOW(), 'Middlesex - Eugenides'),
  (4, 200, 'FAIR', 21.00, 'AVL', NOW(), 'The Corrections - Franzen'),
  (5, 210, 'GOOD', 19.00, 'AVL', NOW(), 'The Brief Wondrous Life of Oscar Wao - Díaz'),
  (2, 217, 'GOOD', 23.00, 'AVL', NOW(), 'The Underground Railroad - Whitehead');


-- =================================================================================
-- 7) INSERT SAMPLE OFFERS
-- =================================================================================
INSERT IGNORE INTO `listings_offer`
  (listing_id, buyer_id, offer_price, status, created_at)
VALUES
  (1, 3, 40.00, 'PEN', NOW()),
  (2, 4, 45.00, 'PEN', NOW()),
  (3, 5, 30.00, 'PEN', NOW()),
  (11, 2, 65.00, 'PEN', NOW()),
  (21, 4, 90.00, 'PEN', NOW());


-- =================================================================================
-- 8) INSERT SAMPLE BOOK SUGGESTIONS
-- =================================================================================
INSERT IGNORE INTO `listings_booksuggestion`
  (title, author, isbn, suggested_by_id, timestamp)
VALUES
  ('Introduction to Machine Learning',           'Alpaydin, Ethem',                   '9780262012430', 2, NOW()),
  ('Computer Networks: A Top-Down Approach',    'James Kurose; Keith Ross',          '9780133594140', 3, NOW()),
  ('Artificial Intelligence: A Modern Approach', 'Stuart Russell; Peter Norvig',      '9780136042594', 4, NOW()),
  ('Advanced Linear Algebra',                   'Steven Roman',                      '9780387728285', 5, NOW()),
  ('Real Analysis',                             'Royden, H.L.',                      '9780131437470', 2, NOW()),
  ('The Elements of Style',                     'William Strunk Jr.; E.B. White',   '9780205309023', 3, NOW());