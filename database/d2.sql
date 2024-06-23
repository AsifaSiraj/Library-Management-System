create database DbmsProject;
use DbmsProject;

CREATE TABLE admin
(
  admin_id INT NOT NULL,
  ad_name VARCHAR(25)  NOT NULL,
  admin_phone VARCHAR(15) NOT NULL,
  library_id INT NOT NULL,
  PRIMARY KEY (admin_id)
);
INSERT INTO admin (admin_id, ad_name, admin_phone,library_id) VALUES
(1, 'Admin1', '123-456-7890',1),
(2, 'Admin2', '123-456-7891',1),
(3, 'Admin3', '123-456-7892',1),
(4, 'Admin4', '123-456-7893',1),
(5, 'Admin5', '123-456-7894',1),
(6, 'Admin6', '123-456-7895',1),
(7, 'Admin7', '123-456-7896',1),
(8, 'Admin8', '123-456-7897',1),
(9, 'Admin9', '123-456-7898',1),
(10, 'Admin10', '123-456-7899',1),
(11, 'Admin11', '222-333-4444',1),
(12, 'Admin12', '111-222-3333',1),
(13, 'Admin13', '555-666-7777',1),
(14, 'Admin14', '999-888-7777',1),
(15, 'Admin15', '444-555-6666',1);

select * from admin;

CREATE TABLE book
(
  book_id INT NOT NULL,
  book_author VARCHAR(25)  NOT NULL,
  book_title VARCHAR(100) NOT NULL,
  s_no INT NOT NULL,
  description VARCHAR(500)  NOT NULL,
  book_price FLOAT NOT NULL,
  admin_id INT NOT NULL,
  library_id INT NOT NULL,
  PRIMARY KEY (book_id),
  FOREIGN KEY (admin_id) REFERENCES admin(admin_id)
);

INSERT INTO book (book_id, book_author, book_title, s_no,description, book_price, admin_id,library_id)
VALUES
(1, 'George Orwell', '1984', 101, 'A dystopian novel', 15.99,  1,1),
(2, 'J.K. Rowling', 'Harry Potter', 102, 'Fantasy fiction', 19.99,  2,1),
(3, 'Harper Lee', 'To Kill a Mockingbird', 103, 'Novel dealing with racial injustice', 12.50,  3,1),
(4, 'F. Scott Fitzgerald', 'The Great Gatsby', 104, 'American classic', 10.99,  4,1),
(5, 'Gabriel Garcia Marquez', 'One Hundred Years', 105, 'Magical realism', 14.75,5,1),
(6, 'Jane Austen', 'Pride and Prejudice', 106, 'Romantic novel', 9.99,  6,1),
(7, 'Leo Tolstoy', 'War and Peace', 107, 'Historical novel', 18.50,  7,1),
(8, 'J.R.R. Tolkien', 'The Lord of the Rings', 108, 'Fantasy epic', 24.99,  8,1),
(9, 'Ernest Hemingway', 'The Old Man', 109, 'Novella', 8.25,  9,1),
(10, 'Mark Twain', 'The Adventures', 110, 'American literature', 11.20, 10,1);
select * from book;

CREATE TABLE new_book
(
  book_id INT NOT NULL,
  book_author VARCHAR(25)  NOT NULL,
  book_title VARCHAR(100) NOT NULL,
  s_no INT NOT NULL,
  description VARCHAR(500)  NOT NULL,
  book_price FLOAT NOT NULL,
  admin_id INT NOT NULL,
  library_id INT NOT NULL,
  primary key (book_id),
  foreign key (admin_id)references admin(admin_id)
);
DELIMITER $$

CREATE TRIGGER after_new_book_insert
AFTER INSERT ON new_book
FOR EACH ROW
BEGIN
  INSERT INTO book (book_id, book_author, book_title, s_no,description, book_price, admin_id, library_id)
  VALUES (new.book_id, new.book_author, new.book_title, new.s_no,new.description, new.book_price, new.admin_id,new.library_id);

END $$

DELIMITER ;

DELIMITER $$

CREATE TRIGGER after_new_book_delete
AFTER DELETE ON new_book
FOR EACH ROW
BEGIN
  DELETE FROM book WHERE book_id = OLD.book_id;
END $$

DELIMITER ;

DELIMITER $$

CREATE TRIGGER after_new_book_update
AFTER UPDATE ON new_book
FOR EACH ROW
BEGIN
  UPDATE book
  SET book_title = NEW.book_title,
      book_author = NEW.book_author,
      description = NEW.description,
      s_no = new.s_no,
      book_price = NEW.book_price,
      library_id = 1  
  WHERE book_id = NEW.book_id;
END $$

DELIMITER ;

INSERT INTO new_book (book_id, book_author, book_title, s_no,description, book_price,admin_id,library_id) VALUES
(16, 'Tayari Jones', 'An American Marriage', 116, 'A novel about a marriage tested by racial injustice and wrongful incarceration.', 21.99, 2,1),
(17, 'Tommy Orange', 'There There', 117, 'A novel following the lives of twelve Native American characters as they converge at the Big Oakland Powwow.', 31.99, 1,1),
(18, 'Amor Towles', 'A Gentleman in Moscow', 118, 'A novel about a Russian aristocrat who is sentenced to house arrest in a luxury hotel for thirty years.', 37.99, 3,1),
(19, 'Glendy Vanderah', 'Where the Forest Meets the Stars', 119, 'A novel about a childless scientist who finds a mysterious child in the woods near her cabin.', 29.99, 2,1),
(20, 'Heather Morris', 'The Tattooist of Auschwitz', 120, 'A novel based on the true story of Lale Sokolov, a Holocaust survivor and tattooist at Auschwitz.', 44.99, 1,1),
(21, 'Taylor Jenkins Reid', 'Daisy Jones & The Six', 121, 'A novel about a fictional rock band in the 1970s, told through interviews with band members and associates.', 23.99, 3,1),
(22, 'Colson Whitehead', 'The Underground Railroad', 122, 'A novel about a young slave who escapes from a Georgia plantation and travels north via an actual underground railroad.', 18.99, 2,1),
(23, 'Markus Zusak', 'The Book Thief', 123, 'A novel narrated by Death, about a young girl in Nazi Germany who steals books and shares them with her neighbors.', 27.99, 1,1),
(24, 'Kristin Hannah', 'The Nightingale', 124, 'A novel about two sisters in France during World War II, each facing different challenges as they resist the German occupation.', 15.99, 3,1),
(25, 'Gail Honeyman', 'Eleanor Oliphant Is Completely Fine', 125, 'A novel about a socially awkward woman whose carefully timetabled life is disrupted by a simple act of kindness.', 21.99, 2,1),
(26, 'Anthony Doerr', 'All the Light We Cannot See', 126, 'A novel about a blind French girl and a German boy whose paths collide in occupied France during World War II.', 32.99, 1,1),
(27, 'Kevin Kwan', 'Crazy Rich Asians', 127, 'A novel about the lives of wealthy Chinese families living in Singapore, and the social status and conflicts that arise among them.', 24.99, 3,1),
(28, 'Liane Moriarty', 'Big Little Lies', 128, 'A novel about three women with seemingly perfect lives who become embroiled in a murder investigation.', 19.99, 2,1),
(29, 'Paula Hawkins', 'The Girl on the Train', 129, 'A psychological thriller about a woman who becomes entangled in a missing persons investigation.', 29.99, 1,1),
(30, 'Stieg Larsson', 'The Girl with the Dragon Tattoo', 130, 'A mystery novel about a journalist and a hacker who investigate the disappearance of a young woman.', 26.99, 3,1);
select * from new_book;
select * from book;
CREATE TABLE user_profile
(
  nic VARCHAR(25) NOT NULL,
  library_id INT NOT NULL ,
  PRIMARY KEY (nic)
);
INSERT INTO user_profile (nic,library_id) VALUES
('NIC001',1),
('NIC002',1),
('NIC003',1),
('NIC004',1),
('NIC005',1),
('NIC006',1),
('NIC007',1),
('NIC008',1),
('NIC009',1),
('NIC010',1),
('NIC011',1),
('NIC012',1),
('NIC013',1),
('NIC014',1),
('NIC015',1);
select * from user_profile;

CREATE TABLE user_login_portal
(
  user_email varchar (25) NOT NULL,
  user_password VARCHAR(8) NOT NULL,
  library_id INT NOT NULL,
  PRIMARY KEY (user_password)
);
INSERT INTO user_login_portal (user_email, user_password,library_id) VALUES
('user1@example.com', 'passwrd1',1),
('user2@example.com', 'passwrd2',1),
('user3@example.com', 'passwrd3',1),
('user4@example.com', 'passwrd4',1),
('user5@example.com', 'passwrd5',1),
('user6@example.com', 'passwrd6',1),
('user7@example.com', 'passwrd7',1),
('user8@example.com', 'passwrd8',1),
('user9@example.com', 'passwrd9',1),
('user10@example.com', 'passw10',1),
('user11@example.com', '111',1),
('user12@example.com', '112',1),
('user13@example.com', '113',1),
('user14@example.com', '114',1),
('user15@example.com', '115',1);

update user_login_portal set user_password = 'passwrd0' where user_password = 'passw10';
select * from user_login_portal;
CREATE TABLE admin_login_portal
(
  admin_pass VARCHAR(8)  NOT NULL,
  admin_email VARCHAR(25)  NOT NULL,
  library_id INT NOT NULL,
  PRIMARY KEY (admin_pass)
);
INSERT INTO admin_login_portal (admin_pass, admin_email,library_id) VALUES
('passwrd1', 'admin1@example.com',1),
('passwrd2', 'admin2@example.com',1),
('passwrd3', 'admin3@example.com',1),
('passwrd4', 'admin4@example.com',1),
('passwrd5', 'admin5@example.com',1),
('passwrd6', 'admin6@example.com',1),
('passwrd7', 'admin7@example.com',1),
('passwrd8', 'admin8@example.com',1),
('passwrd9', 'admin9@example.com',1),
('passwrd0', 'admin10@example.com',1),
('pass11', 'admin11@example.com',1),
('pass12', 'admin12@example.com',1),
('pass13', 'admin13@example.com',1),
('pass14', 'admin14@example.com',1),
('pass15', 'admin15@example.com',1);
select * from admin_login_portal;
CREATE TABLE Adminemail
(
  admin_email VARCHAR(25)  NOT NULL,
  admin_Emailpass VARCHAR(8)  NOT NULL,
  admin_id INT NOT NULL,
  library_id INT NOT NULL,
  PRIMARY KEY (admin_email),
  FOREIGN KEY (admin_id) REFERENCES admin(admin_id)
);
INSERT INTO Adminemail (admin_email, admin_Emailpass, admin_id,library_id) VALUES
( 'admin1@example.com','passwrd1',1,1),
( 'admin2@example.com','passwrd2',2,1),
( 'admin3@example.com','passwrd3',3,1),
( 'admin4@example.com','passwrd4',4,1),
( 'admin5@example.com','passwrd5',5,1),
('admin6@example.com','passwrd6', 6,1),
( 'admin7@example.com','passwrd7',7,1),
( 'admin8@example.com','passwrd8',8,1),
( 'admin9@example.com','passwrd9',9,1),
( 'admin10@example.com','passwrd0',10,1),
('admin11@example.com', 'pass11', 11,1),
('admin12@example.com', 'pass12', 12,1),
('admin13@example.com', 'pass13', 13,1),
('admin14@example.com', 'pass14', 14,1),
('admin15@example.com', 'pass15', 15,1);
select * from Adminemail;
CREATE TABLE client
(
  user_name VARCHAR(25)  NOT NULL,
  user_ph VARCHAR(15)  NOT NULL,
  user_address VARCHAR(40) NOT NULL,
  user_id INT NOT NULL,
  nic VARCHAR(25)  NOT NULL,
  library_id INT NOT NULL,
  PRIMARY KEY (user_id),
  FOREIGN KEY (nic) REFERENCES user_profile(nic)
);
INSERT INTO client (user_name, user_ph, user_address, user_id, nic,library_id) VALUES
('User1', '123-456-7890', '123 Main St', 1, 'NIC001',1),
('User2', '123-456-7891', '456 Elm St', 2, 'NIC002',1),
('User3', '123-456-7892', '789 Oak St', 3, 'NIC003',1),
('User4', '123-456-7893', '321 Pine St', 4, 'NIC004',1),
('User5', '123-456-7894', '654 Maple St', 5, 'NIC005',1),
('User6', '123-456-7895', '987 Cedar St', 6, 'NIC006',1),
('User7', '123-456-7896', '147 Birch St', 7, 'NIC007',1),
('User8', '123-456-7897', '258 Walnut St', 8, 'NIC008',1),
('User9', '123-456-7898', '369 Willow St', 9, 'NIC009',1),
('User10', '123-456-7899', '741 Poplar St', 10, 'NIC010',1),
('User11', '123-234-3456', '111 Orange St, CityK', 11, 'NIC011',1),
('User12', '234-345-4567', '444 Lemon St, CityL', 12, 'NIC012',1),
('User13', '345-456-5678', '333 Grape St, CityM', 13, 'NIC013',1),
('User14', '456-567-6789', '777 Banana St, CityN', 14, 'NIC014',1),
('User15', '567-678-7890', '888 Mango St, CityO', 15, 'NIC015',1);
select * from client;
CREATE TABLE borrow_book
(
  issue_date DATE NOT NULL,
  fine FLOAT NOT NULL,
  return_date DATE NOT NULL,
  due_date DATE NOT NULL,
  borrow_amount FLOAT NOT NULL,
  borrow_id INT NOT NULL,
  user_id INT,
  book_id INT NOT NULL,
  library_id INT NOT NULL,
  PRIMARY KEY (borrow_id),
  FOREIGN KEY (user_id) REFERENCES client(user_id),
  FOREIGN KEY (book_id) REFERENCES book(book_id)
);
INSERT INTO borrow_book (issue_date, fine, return_date, due_date, borrow_amount, borrow_id, user_id,book_id,library_id) VALUES
('2024-01-01', 5, '2024-01-15', '2024-01-10', 1.0, 1, 1,1,1),
('2024-01-05', 5, '2024-01-20', '2024-01-15', 2.0, 2, 2,1,1),
('2024-01-10', 5, '2024-01-25', '2024-01-20', 1.5, 3, 3,1,1),
('2024-01-15', 5, '2024-01-30', '2024-01-25', 3.0, 4, 4,1,1),
('2024-01-20', 0, '2024-01-30', '2024-02-04', 2.5, 5, 5,1,1),
('2024-01-25', 0, '2024-02-04', '2024-01-01', 1.0, 6, 6,1,1),
('2024-02-01', 0.0, '2024-02-09', '2024-02-10', 2.0, 7, 7,1,1),
('2024-02-05', 0.0, '2024-02-10', '2024-02-15', 1.5, 8, 8,1,1),
('2024-02-10', 0.0, '2024-02-5', '2024-02-20', 3.5, 9, 9,1,1),
('2024-02-15', 0.0, '2024-02-019', '2024-02-25', 2.0, 10, 10,2,1);
select * from borrow_book;
CREATE TABLE purchase_book
(
  purchase_date DATE NOT NULL,
  purchase_id INT NOT NULL,
  total_price FLOAT NOT NULL,
  user_id INT,
  book_id INT NOT NULL,
  library_id INT NOT NULL,
  PRIMARY KEY (purchase_id),
  FOREIGN KEY (user_id) REFERENCES client(user_id),
   FOREIGN KEY (book_id) REFERENCES book(book_id)
);
INSERT INTO purchase_book (purchase_date, purchase_id, total_price, user_id,book_id,library_id) VALUES
('2024-01-01', 1, 100.0, 1,1,1),
('2024-01-05', 2, 150.0, 2,1,1),
('2024-01-10', 3, 200.0, 3,1,1),
('2024-01-15', 4, 120.0, 4,1,1),
('2024-01-20', 5, 180.0, 5, 4,1),
('2024-01-25', 6, 90.0, 6, 4,1),
('2024-02-01', 7, 300.0, 7, 4,1),
('2024-02-05', 8, 250.0, 8, 7,1),
('2024-02-10', 9, 175.0, 9, 7,1),
('2024-02-15', 10, 210.0, 10, 7,1);
select * from purchase_book;
CREATE TABLE Notify
(
  new_password VARCHAR(8)  NOT NULL,
  newpass_message VARCHAR(100)  NOT NULL,
  user_id INT NOT NULL,
  library_id INT NOT NULL,
  PRIMARY KEY (new_password),
  FOREIGN KEY (user_id) REFERENCES client(user_id)
);
INSERT INTO Notify (new_password, newpass_message, user_id,library_id) VALUES
('passwrd1', 'Your password has been updated.', 1,1),
('passwrd2', 'Please use this new password for login.', 2,1),
('passwrd3', 'New password issued for security reasons.', 3,1),
('passwrd4', 'Ensure to keep your new password safe.', 4,1),
('passwrd5', 'Notification: password changed successfully.', 5,1);
select * from Notify;
CREATE TABLE admin_profile
(
  admin_nic VARCHAR(25)  NOT NULL,
  admin_id INT NOT NULL,
  admin_email VARCHAR(25)  NOT NULL,
  library_id INT NOT NULL,
  PRIMARY KEY (admin_nic),
  FOREIGN KEY (admin_id) REFERENCES admin(admin_id),
  FOREIGN KEY (admin_email) REFERENCES Adminemail(admin_email)
);
INSERT INTO admin_profile (admin_nic, admin_id, admin_email,library_id) VALUES
('NIC016', 1, 'admin1@example.com',1),
('NIC017', 2, 'admin2@example.com',1),
('NIC018', 3, 'admin3@example.com',1),
('NIC019', 4, 'admin4@example.com',1),
('NIC020', 5, 'admin5@example.com',1),
('NIC021', 6, 'admin6@example.com',1),
('NIC022', 7, 'admin7@example.com',1),
('NIC023', 8, 'admin8@example.com',1),
('NIC024', 9, 'admin9@example.com',1),
('NIC025', 10, 'admin10@example.com',1),
('NIC026', 11, 'admin11@example.com',1),
('NIC027', 12, 'admin12@example.com',1),
('NIC028', 13, 'admin13@example.com',1),
('NIC029', 14, 'admin14@example.com',1),
('NIC030', 15, 'admin15@example.com',1);
select * from admin_profile;
CREATE TABLE admin_loggedin
(
  admin_pass  VARCHAR(8)NOT NULL,
  admin_email VARCHAR(25)  NOT NULL,
  library_id INT NOT NULL,
  FOREIGN KEY (admin_pass) REFERENCES admin_login_portal(admin_pass),
  FOREIGN KEY (admin_email) REFERENCES Adminemail(admin_email)
);
INSERT INTO admin_loggedin (admin_pass, admin_email,library_id) VALUES
('passwrd1', 'admin1@example.com',1),
('passwrd2', 'admin2@example.com',1),
('passwrd3', 'admin3@example.com',1),
('passwrd4', 'admin4@example.com',1),
('passwrd5', 'admin5@example.com',1),
('passwrd6', 'admin6@example.com',1),
('passwrd7', 'admin7@example.com',1),
('passwrd8', 'admin8@example.com',1),
('passwrd9', 'admin9@example.com',1),
('passwrd0', 'admin10@example.com',1),
('pass11', 'admin11@example.com',1),
('pass12', 'admin12@example.com',1),
('pass13', 'admin13@example.com',1),
('pass14', 'admin14@example.com',1),
('pass15', 'admin15@example.com',1);
select * from admin_loggedin;
CREATE TABLE client_email
(
  user_email VARCHAR(25) NOT NULL,
  user_emialpassw VARCHAR(8)  NOT NULL,
  user_id INT NOT NULL,
  nic VARCHAR(25) NOT NULL,
  library_id INT NOT NULL,
  PRIMARY KEY (user_email),
  FOREIGN KEY (user_id) REFERENCES client(user_id),
  FOREIGN KEY (nic) REFERENCES user_profile(nic)
);
INSERT INTO client_email (user_email, user_emialpassw, user_id, nic,library_id) VALUES
('user1@example.com', 'passwrd1', 1, 'NIC001',1),
('user2@example.com', 'passwrd2', 2, 'NIC002',1),
('user3@example.com', 'passwrd3', 3, 'NIC003',1),
('user4@example.com', 'passwrd4', 4, 'NIC004',1),
('user5@example.com', 'passwrd5', 5, 'NIC005',1),
('user6@example.com', 'passwrd6', 6, 'NIC006',1),
('user7@example.com', 'passwrd7', 7, 'NIC007',1),
('user8@example.com', 'passwrd8', 8, 'NIC008',1),
('user9@example.com', 'passwrd9', 9, 'NIC009',1),
('user10@example.com', 'passwrd0', 10, 'NIC010',1),
('user11@example.com', '111', 11, 'NIC011',1),
('user12@example.com', '112', 12, 'NIC012',1),
('user13@example.com', '113', 13, 'NIC013',1),
('user14@example.com', '114', 14, 'NIC014',1),
('user15@example.com', '115', 15, 'NIC015',1);
select * from client_email;

CREATE TABLE user_loggedin
(
  user_password VARCHAR(8)  NOT NULL,
  user_email VARCHAR(25)  NOT NULL,
  library_id INT NOT NULL,
  PRIMARY KEY (user_password, user_email),
  FOREIGN KEY (user_password) REFERENCES user_login_portal(user_password),
  FOREIGN KEY (user_email) REFERENCES client_email(user_email)
);
INSERT INTO user_loggedin (user_password, user_email,library_id) VALUES
('passwrd1', 'user1@example.com',1),
('passwrd2', 'user2@example.com',1),
('passwrd3', 'user3@example.com',1),
('passwrd4', 'user4@example.com',1),
('passwrd5', 'user5@example.com',1),
('passwrd6', 'user6@example.com',1),
('passwrd7', 'user7@example.com',1),
('passwrd8', 'user8@example.com',1),
('passwrd9', 'user9@example.com',1),
('passwrd0', 'user10@example.com',1),
('111', 'user11@example.com',1),
('112', 'user12@example.com',1),
('113', 'user13@example.com',1),
('114', 'user14@example.com',1),
('115', 'user15@example.com',1);
select * from user_loggedin;
CREATE TABLE has
(
  borrow_id INT NOT NULL,
  book_id INT NOT NULL,
  library_id INT NOT NULL,
  PRIMARY KEY (borrow_id, book_id),
  FOREIGN KEY (borrow_id) REFERENCES borrow_book(borrow_id),
  FOREIGN KEY (book_id) REFERENCES book(book_id)
);

-- list of book from author a to z 
SELECT *
FROM book
ORDER BY book_author ASC
LIMIT 10;

-- list book by specific author
SELECT book_title
FROM book
WHERE book_author = 'Tolkien';

-- user with id 1
SELECT * FROM client
WHERE user_id = 1;

-- list purchase book with price greater than 10 
SELECT * FROM purchase_book
WHERE total_price > 10;

-- list of purchase book withdate after 2024-01-25
SELECT * FROM purchase_book
WHERE purchase_date >= '2024-01-25';

-- list of client never borrow book(sub query)
SELECT * 
FROM client c
WHERE NOT EXISTS (SELECT 1 FROM  borrow_book b WHERE b.user_id = c.user_id);

-- list of user with higher number of borrow (group by)
SELECT c.user_name, COUNT(b.borrow_id) AS borrowCount
FROM client c
JOIN borrow_book b ON c.user_id = b.user_id
GROUP BY c.user_name;

-- list of book with specific author and admin
select book_title
from book
where book_author = 'jhon' and admin_id = 2;

-- find the oldest borrow book
SELECT *
FROM borrow_book
ORDER BY issue_date ASC
LIMIT 1;

-- find the newest borrow book
SELECT *
FROM borrow_book
ORDER BY issue_date desc
LIMIT 1;

-- count of book by author
SELECT book_author, COUNT(*) AS BookCount
FROM book
GROUP BY book_author;

-- find client who purchase book last month
SELECT bb.book_id
FROM borrow_book bb
JOIN book b ON bb.book_id = b.book_id
WHERE bb.user_id = 1 AND bb.issue_date > CURRENT_DATE - INTERVAL 1 MONTH;


-- --List members with overdue books: 
SELECT m.user_name,COUNT(*) AS OverdueBooks
FROM client m
JOIN borrow_book l ON m.user_id = l.user_id
WHERE fine > 0
GROUP BY m.user_name;

-- total number of purchase
SELECT COUNT(*) AS total_purchase
FROM purchase_book;

-- delete book from library
DELETE FROM borrow_book WHERE book_id = (SELECT book_id FROM book WHERE book_title = '1984');
DELETE FROM purchase_book WHERE book_id = (SELECT book_id FROM book WHERE book_title = '1984');
DELETE FROM book WHERE book_title = '1984';

-- update book info
UPDATE book
SET book_title = 'The Broken Ring'
WHERE book_id = 1;

-- specific client history
SELECT bb.*, b.book_title
FROM borrow_book bb
JOIN book b ON bb.book_id = b.book_id
WHERE bb.user_id = 1;

-- book that are currently on loan
SELECT l.*, b.book_title, m.user_name
FROM borrow_book l
JOIN book b ON l.book_id = b.book_id
JOIN client m ON l.user_id = m.user_id
WHERE l.issue_date IS NOT NULL;

-- most frequently purchase book
SELECT b.book_title, COUNT(l.purchase_id) AS TimesPurchase
FROM purchase_book l
JOIN book b ON l.book_id = b.book_id
GROUP BY b.book_title
ORDER BY TimesPurchase DESC;

-- total memebers
SELECT COUNT(*) AS TotalMembers
FROM client;

-- return borrowbook
UPDATE borrow_book
SET return_date = CURRENT_DATE
WHERE borrow_id = 1;

-- changing data type
alter table user_login_portal change user_email user_email varchar(25);

-- find all borrow book that are due in next 7 days
 SELECT l.*, b.book_title, m.user_name
FROM borrow_book l
JOIN book b ON l.book_id = b.book_id
JOIN client m ON l.user_id = m.user_id
WHERE l.return_date BETWEEN CURRENT_DATE AND CURRENT_DATE + INTERVAL 7 DAY; 

-- book author ka name jis nay aik say zyada book likhi hai 
SELECT book_title,book_author
FROM book
HAVING COUNT(DISTINCT book_title) > 1;

-- book return late
SELECT l.*, b.book_title, m.user_name
FROM borrow_book l
JOIN book b ON l.book_id = b.book_id
JOIN client m ON l.user_id = m.user_id
WHERE l.return_date > l.due_date;

-- sort all borrow by due date
SELECT l.*, b.book_title, m.user_name
FROM borrow_book l
JOIN book b ON l.book_id = b.book_id
JOIN client m ON l.user_id = m.user_id
ORDER BY l.due_date;

-- total author
-- SELECT COUNT(DISTINCT book_author) AS TotalBookAuthor;

-- book never borrow
SELECT * FROM book b
WHERE NOT EXISTS (SELECT 1 FROM borrow_book l WHERE l.book_id = b.book_id);



SELECT 
    a.admin_id,
    a.ad_name,
    a.admin_phone,
    nb.book_title AS book_title,
    nb.book_id AS book_id,
    nb.s_no AS s_no,
    nb.book_author AS book_author,
    nb.book_price AS book_price,
     up.nic,
    ulp.user_email AS user_login_email,
    ulp.user_password AS user_login_password,
    alp.admin_pass,
    alp.admin_email,
    ae.admin_Emailpass,
    c.user_name,
    c.user_ph,
    c.user_address,
    c.user_id,
    bb.issue_date,
    bb.fine,
    bb.return_date,
    bb.due_date,
    bb.borrow_amount,
    pb.purchase_date,
    pb.purchase_id,
    pb.total_price,
    n.new_password,
    n.newpass_message,
    ap.admin_nic,
    ap.admin_email AS admin_profile_email,
    al.admin_pass AS admin_loggedin_pass,
    al.admin_email AS admin_loggedin_email,
    ce.user_emialpassw,
    b.book_id AS book_id_from_book,
    b.book_author AS book_author_from_book,
    b.book_title AS book_title_from_book,
    b.s_no AS s_no_from_book,
    b.description,
    b.book_price AS book_price_from_book,
    ul.user_password AS user_loggedin_pass,
    ul.user_email AS user_loggedin_email,
    h.borrow_id AS has_borrow_id,
    h.book_id AS has_book_id
FROM 
    admin a
JOIN 
    new_book nb ON a.admin_id = nb.admin_id AND a.library_id = nb.library_id
JOIN 
    admin_profile ap ON a.admin_id = ap.admin_id AND a.library_id = ap.library_id
JOIN 
    Adminemail ae ON a.admin_id = ae.admin_id AND a.library_id = ae.library_id
JOIN 
    admin_login_portal alp ON ae.admin_email = alp.admin_email AND ae.library_id = alp.library_id
JOIN 
    admin_loggedin al ON alp.admin_pass = al.admin_pass AND ae.admin_email = al.admin_email AND ae.library_id = al.library_id
JOIN 
    client c ON -- c.nic = up.nic AND
    c.library_id = a.library_id
JOIN 
    user_profile up ON  up.library_id = c.library_id
JOIN 
    client_email ce ON c.user_id = ce.user_id -- AND up.nic = ce.nic 
    AND c.library_id = ce.library_id
JOIN 
    user_login_portal ulp ON ce.user_email = ulp.user_email AND ce.library_id = ulp.library_id
JOIN 
    user_loggedin ul ON ulp.user_password = ul.user_password AND ce.user_email = ul.user_email AND ce.library_id = ul.library_id
JOIN 
    borrow_book bb ON c.user_id = bb.user_id AND c.library_id = bb.library_id
JOIN 
    purchase_book pb ON c.user_id = pb.user_id AND c.library_id = pb.library_id
JOIN 
    Notify n ON c.user_id = n.user_id AND c.library_id = n.library_id
JOIN 
    book b ON a.library_id = b.library_id
JOIN 
    has h ON bb.borrow_id = h.borrow_id AND b.book_id = h.book_id AND bb.library_id = h.library_id
WHERE 
    a.library_id = 1  -- Replace with the appropriate library_id
LIMIT 0, 1000;















