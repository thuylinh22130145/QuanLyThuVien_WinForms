
PRAGMA foreign_keys = ON;

CREATE TABLE IF NOT EXISTS Users (
                                     UserId INTEGER PRIMARY KEY AUTOINCREMENT,
                                     Username TEXT NOT NULL UNIQUE,
                                     PasswordHash TEXT NOT NULL,
                                     FullName TEXT NOT NULL,
                                     Email TEXT UNIQUE,
                                     Phone TEXT,
                                     Role TEXT NOT NULL DEFAULT 'READER'
                                     CHECK (Role IN ('ADMIN', 'LIBRARIAN', 'READER'))
    );

CREATE TABLE IF NOT EXISTS Categories (
                                          CategoryId INTEGER PRIMARY KEY AUTOINCREMENT,
                                          CategoryName TEXT NOT NULL UNIQUE,
                                          Description TEXT
);

CREATE TABLE IF NOT EXISTS Books (
                                     BookId INTEGER PRIMARY KEY AUTOINCREMENT,
                                     Title TEXT NOT NULL,
                                     Author TEXT NOT NULL,
                                     ISBN TEXT UNIQUE,
                                     CategoryId INTEGER,
                                     Quantity INTEGER NOT NULL DEFAULT 0
                                     CHECK (Quantity >= 0),
    AvailableQuantity INTEGER NOT NULL DEFAULT 0
    CHECK (AvailableQuantity >= 0),
    FOREIGN KEY (CategoryId)
    REFERENCES Categories(CategoryId),
    CHECK (AvailableQuantity <= Quantity)
    );

CREATE TABLE IF NOT EXISTS BorrowRecords (
                                             BorrowId INTEGER PRIMARY KEY AUTOINCREMENT,
                                             UserId INTEGER NOT NULL,
                                             BookId INTEGER NOT NULL,
                                             BorrowDate TEXT NOT NULL,
                                             DueDate TEXT NOT NULL,
                                             ReturnDate TEXT,
                                             Status TEXT NOT NULL DEFAULT 'BORROWED'
                                             CHECK (Status IN ('BORROWED', 'RETURNED', 'OVERDUE')),
    FOREIGN KEY (UserId) REFERENCES Users(UserId),
    FOREIGN KEY (BookId) REFERENCES Books(BookId)
    );

CREATE INDEX IF NOT EXISTS idx_books_title
    ON Books(Title);

CREATE INDEX IF NOT EXISTS idx_borrow_user
    ON BorrowRecords(UserId);

CREATE INDEX IF NOT EXISTS idx_borrow_book
    ON BorrowRecords(BookId);
