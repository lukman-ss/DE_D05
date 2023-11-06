-- Nama Lukman

-- Create Students table
CREATE TABLE Students (
    StudentNo INT PRIMARY KEY,
    StudentName VARCHAR(255),
    Major VARCHAR(255)
);

-- Create Courses table
CREATE TABLE Courses (
    CourseNo INT PRIMARY KEY,
    CourseName VARCHAR(255)
);

-- Create Instructors table
CREATE TABLE Instructors (
    InstructorNo INT PRIMARY KEY,
    InstructorName VARCHAR(255),
    InstructorLocation VARCHAR(255)
);

-- Create Grades table with relationships to Students, Courses, and Instructors
CREATE TABLE Grades (
    StudentNo INT REFERENCES Students(StudentNo),
    CourseNo INT REFERENCES Courses(CourseNo),
    InstructorNo INT REFERENCES Instructors(InstructorNo),
    Grade VARCHAR(2),
    PRIMARY KEY (StudentNo, CourseNo)
);


-- Sample data for Students table
INSERT INTO Students (StudentNo, StudentName, Major)
VALUES
    (1, 'Alice Smith', 'Computer Science'),
    (2, 'Bob Johnson', 'Engineering'),
    (3, 'Charlie Brown', 'Mathematics');

-- Sample data for Courses table
INSERT INTO Courses (CourseNo, CourseName)
VALUES
    (101, 'Introduction to Programming'),
    (102, 'Database Management'),
    (103, 'Linear Algebra');

-- Sample data for Instructors table
INSERT INTO Instructors (InstructorNo, InstructorName, InstructorLocation)
VALUES
    (201, 'John Doe', 'Building A, Room 101'),
    (202, 'Jane Smith', 'Building B, Room 205'),
    (203, 'David Wilson', 'Building C, Room 301');

-- Sample data for Grades table
INSERT INTO Grades (StudentNo, CourseNo, InstructorNo, Grade)
VALUES
    (1, 101, 201, 'A'),
    (1, 102, 202, 'B'),
    (2, 101, 201, 'B'),
    (2, 103, 203, 'A'),
    (3, 102, 202, 'C');