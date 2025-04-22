    -- LibraryBranch Table
    CREATE TABLE LibraryBranch (
        BranchID VARCHAR(10) PRIMARY KEY,
        HeadLibrarianID VARCHAR(10),
        Location VARCHAR(120),
        PhoneNumber VARCHAR(15)
    );

    -- Staff Table
    CREATE TABLE Staff (
        StaffID VARCHAR(10) PRIMARY KEY,
        FullName VARCHAR(60),
        Role VARCHAR(30),
        MonthlyPay NUMERIC(10,2),
        BranchID VARCHAR(10),
        FOREIGN KEY (BranchID) REFERENCES LibraryBranch(BranchID) ON DELETE SET NULL
    );

    -- Members Table
    CREATE TABLE Members (
        MemberID VARCHAR(10) PRIMARY KEY,
        Name VARCHAR(60),
        Address VARCHAR(120),
        MembershipDate DATE
    );

    -- LibraryBooks Table
    CREATE TABLE LibraryBooks (
        BookCode VARCHAR(25) PRIMARY KEY,
        Title VARCHAR(90),
        Genre VARCHAR(40),
        DailyRentalRate NUMERIC(10,2),
        AvailableStatus VARCHAR(5),
        Writer VARCHAR(60),
        PublishingHouse VARCHAR(60),
        AddedDate DATE
    );

    -- BookIssues Table
    CREATE TABLE BookIssues (
        IssueCode VARCHAR(10) PRIMARY KEY,
        MemberID VARCHAR(10),
        BookCode VARCHAR(25),
        DateIssued DATE,
        FOREIGN KEY (MemberID) REFERENCES Members(MemberID) ON DELETE CASCADE,
        FOREIGN KEY (BookCode) REFERENCES LibraryBooks(BookCode) ON DELETE CASCADE
    );

    -- BookReturns Table
    CREATE TABLE BookReturns (
        ReturnCode VARCHAR(10) PRIMARY KEY,
        MemberID VARCHAR(10),
        BookCode VARCHAR(25),
        DateReturned DATE,
        Penalty NUMERIC(6,2),
        FOREIGN KEY (BookCode) REFERENCES LibraryBooks(BookCode) ON DELETE CASCADE
    );
    -- Insert Branches
    INSERT INTO LibraryBranch VALUES ('LB01', 'L201', 'Sector 10, Noida', '+911234567890');
    INSERT INTO LibraryBranch VALUES ('LB02', 'L202', 'Jayanagar, Bengaluru', '+919812345678');

    -- Insert Staff
    INSERT INTO Staff VALUES ('S101', 'Anjali Mehta', 'Head Librarian', 58000.00, 'LB01');
    INSERT INTO Staff VALUES ('S102', 'Rohit Das', 'Assistant', 32000.00, 'LB02');

    -- Insert Members
    INSERT INTO Members VALUES ('M001', 'Tanya Singh', 'Sector 10, Noida', '2022-03-01');
    INSERT INTO Members VALUES ('M002', 'Karan Joshi', 'Jayanagar, Bengaluru', '2023-07-11');

    -- Insert Books
    INSERT INTO LibraryBooks VALUES ('BK101', 'Sapiens', 'History', 8.00, 'Yes', 'Yuval Noah Harari', 'Harper', '2021-08-20');
    INSERT INTO LibraryBooks VALUES ('BK102', '1984', 'Dystopian', 6.50, 'Yes', 'George Orwell', 'Penguin', '2020-05-15');

    -- Insert Book Issues
    INSERT INTO BookIssues VALUES ('ISS001', 'M001', 'BK101', '2024-02-10');

    -- Insert Book Returns
    INSERT INTO BookReturns VALUES ('RET001', 'M001', 'BK101', '2024-03-01', 0.00);

    -- Another Issue
    INSERT INTO BookIssues VALUES ('ISS002', 'M002', 'BK102', '2024-04-10');

    CREATE VIEW MemberActivity AS
    SELECT 
        M.MemberID,
        M.Name AS MemberName,
        B.Title AS BookTitle,
        B.Genre,
        B.Writer,
        BI.DateIssued,
        BR.DateReturned,
        BR.Penalty
    FROM Members M
    LEFT JOIN BookIssues BI ON M.MemberID = BI.MemberID
    LEFT JOIN BookReturns BR ON M.MemberID = BR.MemberID AND BI.BookCode = BR.BookCode
    LEFT JOIN LibraryBooks B ON B.BookCode = BI.BookCode;


    SELECT * FROM LibraryBranch;
    SELECT * FROM Staff;
    SELECT * FROM Members;
    SELECT * FROM LibraryBooks;
    SELECT * FROM BookIssues;
    SELECT * FROM BookReturns;
    SELECT * FROM MemberActivity;
