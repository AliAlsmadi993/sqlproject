
use minyprogectdatabase;
-- جدول الموظفين
CREATE TABLE LibraryStaff (
    ID INT PRIMARY KEY IDENTITY(1,1),
    Name VARCHAR(255) NOT NULL,
    ContactInfo VARCHAR(100),
    EmploymentDate DATE NOT NULL
);

-- جدول التصنيفات
CREATE TABLE Categories (
    ID INT PRIMARY KEY IDENTITY(1,1),
    Name VARCHAR(100) NOT NULL UNIQUE,
    Description TEXT
);

-- جدول الكتب
CREATE TABLE Books (
    ID INT PRIMARY KEY IDENTITY(1,1),
    Title VARCHAR(255) NOT NULL,
    Author VARCHAR(255) NOT NULL,
    Genre VARCHAR(100),
    PublicationYear INT CHECK (PublicationYear > 0),
    AvailabilityStatus VARCHAR(50) CHECK (AvailabilityStatus IN ('Available', 'Borrowed')),
    CategoryID INT FOREIGN KEY REFERENCES Categories(ID)
);

-- جدول الأعضاء
CREATE TABLE Members (
    ID INT PRIMARY KEY IDENTITY(1,1),
    Name VARCHAR(255) NOT NULL,
    ContactInfo VARCHAR(100),
    MembershipType VARCHAR(50) CHECK (MembershipType IN ('Student', 'Teacher', 'Visitor')),
    RegistrationDate DATE NOT NULL
);

-- جدول الحجوزات
CREATE TABLE Reservations (
    ID INT PRIMARY KEY IDENTITY(1,1),
    MemberID INT FOREIGN KEY REFERENCES Members(ID),
    BookID INT FOREIGN KEY REFERENCES Books(ID),
    StaffID INT FOREIGN KEY REFERENCES LibraryStaff(ID),
    ReservationDate DATE NOT NULL,
    Status VARCHAR(50) CHECK (Status IN ('Pending', 'Cancelled', 'Completed'))
);

-- جدول الاستعارات
CREATE TABLE Borrowing (
    ID INT PRIMARY KEY IDENTITY(1,1),
    MemberID INT FOREIGN KEY REFERENCES Members(ID),
    BookID INT FOREIGN KEY REFERENCES Books(ID),
    BorrowingDate DATE NOT NULL,
    DueDate DATE NOT NULL,
    ReturnDate DATE NULL
);

-- جدول الغرامات المالية
CREATE TABLE FinancialFines (
    ID INT PRIMARY KEY IDENTITY(1,1),
    MemberID INT FOREIGN KEY REFERENCES Members(ID),
    BorrowingID INT FOREIGN KEY REFERENCES Borrowing(ID),
    StaffID INT FOREIGN KEY REFERENCES LibraryStaff(ID),
    Amount DECIMAL(10,2) CHECK (Amount > 0),
    PaymentStatus VARCHAR(50) CHECK (PaymentStatus IN ('Paid', 'Unpaid'))
);


-- إدخال بيانات الموظفين
INSERT INTO LibraryStaff (Name, ContactInfo, EmploymentDate) VALUES
('John Doe', '1231231234', '2020-06-15'),
('Sarah Connor', '4564564567', '2019-09-22'),
('Mark Spencer', '7897897891', '2021-03-10'),
('Jane Austen', '1472583690', '2018-11-05'),
('Albert Einstein', '9638527410', '2017-08-30');

-- إدخال بيانات التصنيفات
INSERT INTO Categories (Name, Description) VALUES 
('Science Fiction', 'Books about futuristic concepts and advanced science.'),
('History', 'Books covering historical events and biographies.'),
('Technology', 'Books about programming, networking, and IT.'),
('Philosophy', 'Books discussing philosophical ideas and concepts.'),
('Literature', 'Classical and modern literary books.');

-- إدخال بيانات الكتب
INSERT INTO Books (Title, Author, Genre, PublicationYear, AvailabilityStatus, CategoryID) VALUES
('The Time Machine', 'H.G. Wells', 'Science Fiction', 1895, 'Available', 1),
('Sapiens: A Brief History of Humankind', 'Yuval Noah Harari', 'History', 2011, 'Available', 2),
('Introduction to Algorithms', 'Thomas H. Cormen', 'Technology', 2009, 'Available', 3),
('The Republic', 'Plato', 'Philosophy', 380, 'Available', 4), -- تم تعديل السنة من -380 إلى 380 للحفاظ على القيد
('Pride and Prejudice', 'Jane Austen', 'Literature', 1813, 'Available', 5);

-- إدخال بيانات الأعضاء
INSERT INTO Members (Name, ContactInfo, MembershipType, RegistrationDate) VALUES
('Alice Johnson', '1234567890', 'Student', '2023-02-15'),
('Bob Smith', '9876543210', 'Teacher', '2024-01-10'),
('Charlie Brown', '1122334455', 'Visitor', '2022-11-30'),
('David White', '5566778899', 'Student', '2024-01-01'),
('Eve Black', '6677889900', 'Teacher', '2023-06-05');

INSERT INTO Reservations (MemberID, BookID, StaffID, ReservationDate, Status) VALUES
(1, 17, 2, '2024-02-05', 'Pending'),   -- كتاب "The Time Machine"
(2, 18, 4, '2024-01-22', 'Completed'), -- كتاب "Sapiens: A Brief History of Humankind"
(3, 19, 5, '2024-01-15', 'Cancelled'), -- كتاب "Introduction to Algorithms"
(4, 20, 1, '2024-01-08', 'Pending'),   -- كتاب "The Republic"
(5, 21, 3, '2024-02-10', 'Completed'); -- كتاب "Pride and Prejudice"

select* from books


-- إدخال بيانات الاستعارات
INSERT INTO Borrowing (MemberID, BookID, BorrowingDate, DueDate, ReturnDate) VALUES
(1, 17, '2024-02-01', '2024-02-15', NULL);  -- كتاب "The Time Machine";

(5, 21, '2024-02-02', '2024-02-16', NULL), -- كتاب "Pride and Prejudice"
(1, 17, '2024-02-01', '2024-02-15', NULL),  -- كتاب "The Time Machine"
(2, 18, '2024-01-20', '2024-02-10', '2024-02-08'),  -- كتاب "Sapiens: A Brief History of Humankind"
(3, 19, '2024-01-10', '2024-01-25', NULL),  -- كتاب "Introduction to Algorithms"
(4, 20, '2024-01-05', '2024-01-20', '2024-01-18'),  -- كتاب "The Republic"
(5, 21, '2024-02-02', '2024-02-16', NULL);  -- كتاب "Pride and Prejudice"
select * from  Borrowing

INSERT INTO FinancialFines (MemberID, BorrowingID, StaffID, Amount, PaymentStatus) VALUES
(1, 4, 1, 5.00, 'Unpaid'),
(2, 5, 2, 1.00, 'Paid'),
(3, 6, 3, 10.00, 'Unpaid'),
(4, 7, 4, 1.00, 'Paid'),
(5, 8, 5, 15.00, 'Unpaid');

SELECT * FROM Borrowing;


--Q1
SELECT * FROM Members
WHERE RegistrationDate = '2023-02-15';

--O2

SELECT * FROM Books
WHERE Title = 'The Time Machine';

--Q3

ALTER TABLE Members
ADD Email VARCHAR(100) ;

--Q4

INSERT INTO Members (Name, ContactInfo, MembershipType, RegistrationDate, Email) 
VALUES ('Omar', '9876543210', 'Student', '2024-06-05', 'Omar@gmail.com');

--Q5

SELECT * FROM Members
JOIN Reservations ON Members.ID = Reservations.MemberID;

--Q6

SELECT DISTINCT Members.*
FROM Members
JOIN Borrowing ON Members.ID = Borrowing.MemberID
JOIN Books ON Borrowing.BookID = Books.ID
WHERE Books.Title = 'Introduction to Algorithms';

--Q7

SELECT Members.*
FROM Members
JOIN Borrowing ON Members.ID = Borrowing.MemberID
JOIN Books ON Borrowing.BookID = Books.ID
WHERE Books.Title = 'The Republic' and  Borrowing.ReturnDate is not null ;


--Q8


SELECT Members.*
FROM Members
JOIN Borrowing ON Members.ID = Borrowing.MemberID
WHERE Borrowing.DueDate>Borrowing.ReturnDate;

--Q9

SELECT Books.Title,Author, COUNT (Borrowing.BookID) AS BorrowNumbberBorrowed 
FROM Borrowing
JOIN Books ON Borrowing.BookID = Books.ID
GROUP BY Books.Title,Author
HAVING COUNT (Borrowing.BookID) >3;


--Q10

SELECT members.*
FROM Members
JOIN Borrowing ON Members.ID = Borrowing.MemberID
WHERE Borrowing.BorrowingDate BETWEEN '2024-02-01' AND '2024-02-05';

 --Q11

SELECT COUNT(*) AS TotalAvailableBooks
FROM Books
WHERE AvailabilityStatus = 'Available' 
and ID not in (
select bookID from Borrowing
where ReturnDate is  null);


