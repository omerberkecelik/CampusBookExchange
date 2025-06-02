USE campus_book_exchange_db;

CREATE TABLE IF NOT EXISTS `auth_user` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `password` VARCHAR(128) NOT NULL,
  `last_login` DATETIME NULL,
  `is_superuser` BOOLEAN NOT NULL,
  `username` VARCHAR(150) NOT NULL UNIQUE,
  `first_name` VARCHAR(150) NOT NULL,
  `last_name` VARCHAR(150) NOT NULL,
  `email` VARCHAR(254) NOT NULL,
  `is_staff` BOOLEAN NOT NULL,
  `is_active` BOOLEAN NOT NULL,
  `date_joined` DATETIME NOT NULL
);

CREATE TABLE IF NOT EXISTS `Courses` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `course_code` VARCHAR(20) NOT NULL UNIQUE,
  `course_name` VARCHAR(150) NOT NULL,
  `department` VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS `Books` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `isbn` VARCHAR(13) NOT NULL UNIQUE,
  `title` VARCHAR(255) NOT NULL,
  `author` VARCHAR(255) NOT NULL,
  `edition` VARCHAR(50),
  `publisher` VARCHAR(100),
  `publication_year` INT
);

CREATE TABLE IF NOT EXISTS `Listings` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `student_id` INT NOT NULL,
  `book_id` INT NOT NULL,
  `condition` ENUM('NEW','LN','GOOD','FAIR','ACC') NOT NULL,
  `price` DECIMAL(6,2),
  `status` ENUM('AVL','PEN','SOLD','TRD','REM') NOT NULL DEFAULT 'AVL',
  `date_listed` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `description` TEXT,
  FOREIGN KEY (`student_id`) REFERENCES `auth_user`(`id`) 
    ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (`book_id`) REFERENCES `Books`(`id`) 
    ON DELETE RESTRICT ON UPDATE CASCADE,
  CHECK (`price` IS NULL OR `price` >= 0)
);

CREATE TABLE IF NOT EXISTS `BookCourseAssignments` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `book_id` INT NOT NULL,
  `course_id` INT NOT NULL,
  `is_required` BOOLEAN NOT NULL DEFAULT TRUE,
  FOREIGN KEY (`book_id`) REFERENCES `Books`(`id`) 
    ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (`course_id`) REFERENCES `Courses`(`id`) 
    ON DELETE CASCADE ON UPDATE CASCADE,
  UNIQUE (`book_id`, `course_id`)
);

CREATE TABLE IF NOT EXISTS `Offer` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `listing_id` INT NOT NULL,
  `buyer_id` INT NOT NULL,
  `offer_price` DECIMAL(8,2) NOT NULL,
  `status` ENUM('PEN','ACC','REJ') NOT NULL DEFAULT 'PEN',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`listing_id`) REFERENCES `Listings`(`id`) 
    ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (`buyer_id`) REFERENCES `auth_user`(`id`) 
    ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS `BookSuggestion` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `title` VARCHAR(255) NOT NULL,
  `author` VARCHAR(255) NOT NULL,
  `isbn` VARCHAR(20),
  `suggested_by_id` INT,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`suggested_by_id`) REFERENCES `auth_user`(`id`) 
    ON DELETE SET NULL ON UPDATE CASCADE
);
