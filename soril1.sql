CREATE DATABASE library_db;
USE library_db;

-- Members
CREATE TABLE members (
    member_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20) UNIQUE
);

-- Books
CREATE TABLE books (
    book_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(200) NOT NULL,
    author VARCHAR(100) NOT NULL,
    published_year INT
);

-- Librarians
CREATE TABLE librarians (
    librarian_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL
);

-- Borrow Records
CREATE TABLE borrow_records (
    record_id INT PRIMARY KEY AUTO_INCREMENT,
    member_id INT,
    book_id INT,
    librarian_id INT,
    borrow_date DATE NOT NULL,
    return_date DATE,

    FOREIGN KEY (member_id) REFERENCES members(member_id),
    FOREIGN KEY (book_id) REFERENCES books(book_id),
    FOREIGN KEY (librarian_id) REFERENCES librarians(librarian_id)
);




-- Members
INSERT INTO members (name, email, phone) VALUES
('Bat', 'bat@email.com', '99112233'),
('Sara', 'sara@email.com', '88112233');

-- Books
INSERT INTO books (title, author, published_year) VALUES
('Database Systems', 'Navathe', 2015),
('Clean Code', 'Robert Martin', 2008);

-- Librarians
INSERT INTO librarians (name, email) VALUES
('Admin1', 'admin1@lib.com'),
('Admin2', 'admin2@lib.com');

-- Borrow Records
INSERT INTO borrow_records (member_id, book_id, librarian_id, borrow_date, return_date) VALUES
(1, 1, 1, '2024-03-01', '2024-03-10'),
(2, 2, 2, '2024-03-05', NULL);

--------------------------------------------------

SELECT m.name AS member_name, b.title, br.borrow_date
FROM borrow_records br
JOIN members m ON br.member_id = m.member_id
JOIN books b ON br.book_id = b.book_id;

--------------------------------------------------

SELECT b.title, COUNT(*) AS borrow_count
FROM borrow_records br
JOIN books b ON br.book_id = b.book_id
GROUP BY b.title;

---------------------------------------------------

SELECT m.name, COUNT(*) AS total_borrow
FROM borrow_records br
JOIN members m ON br.member_id = m.member_id
GROUP BY m.name
ORDER BY total_borrow DESC
LIMIT 1;

--------------------------------------------------

SELECT m.name AS member_name,
       b.title AS book_title,
       l.name AS librarian_name,
       br.borrow_date
FROM borrow_records br
JOIN members m ON br.member_id = m.member_id
JOIN books b ON br.book_id = b.book_id
JOIN librarians l ON br.librarian_id = l.librarian_id;

--------------------------------------------------

SELECT b.title,
       COUNT(*) AS borrow_count
FROM borrow_records br
JOIN books b ON br.book_id = b.book_id
GROUP BY b.title;

--------------------------------------------------

SELECT b.title,
       COUNT(*) AS borrow_count
FROM borrow_records br
JOIN books b ON br.book_id = b.book_id
GROUP BY b.title
ORDER BY borrow_count DESC
LIMIT 1;

--------------------------------------------------

SELECT m.name,
       COUNT(*) AS total_borrow
FROM borrow_records br
JOIN members m ON br.member_id = m.member_id
GROUP BY m.name
HAVING COUNT(*) >= 2;

create user 'admin_user'@'localhost'
identified by '1234';

grant all privileges on library_db. * to 'admin_user'@'localhost';


show grants for 'admin_user'@'localhost';
show grants for 'report_user'@'localhost';