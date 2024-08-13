-- Create database
CREATE DATABASE CollegeDB
ON PRIMARY
(
    NAME = 'CollegeDB_Data_1',
    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\CollegeDB\CollegeDB_Data_1.mdf',
    SIZE = 25MB,
    MAXSIZE = 100MB,
    FILEGROWTH = 5MB
)
LOG ON
(
    NAME = 'CollegeDB_Log_1',
    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\CollegeDB\CollegeDB_Log_1.ldf',
    SIZE = 2MB,
    MAXSIZE = 50MB,
    FILEGROWTH = 1MB
)
GO

---use database
USE CollegeDB
GO
----create all table
CREATE TABLE Teacher
(
TeacherId INT PRIMARY KEY NONCLUSTERED NOT NULL,
TeacherName VARCHAR(30)
)
---Create table student
CREATE TABLE Student
(
StudentId INT PRIMARY KEY NOT NULL,
StudentName VARCHAR(30)
)
---Create table semister
CREATE TABLE Semister
(
SemisterId INT PRIMARY KEY NOT NULL,
SemisterName VARCHAR(30)
)
-----Create table Subjects
CREATE TABLE [Subject]
(
SubjectId INT PRIMARY KEY NOT NULL,
SubjectName VARCHAR(30)
)
----Make a relationship BETWEEEN THEM
CREATE Table CourseAssignment
(
TeacherId INT references Teacher(TeacherId),
StudentId INT references Student(StudentId),
SemisterId INT references Semister(SemisterId),
SubjectId INT references Subject(SubjectId),
PRIMARY KEY(TeacherId,StudentId,SemisterId,SubjectId)
)
GO

---insert into data teacher
Insert into Teacher
values 
(1,'A'),
(2,'B'),
(3,'C')
Go
----insert into data student
Insert into Student
values 
(1,'AA'),
(2,'BB'),
(3,'CC'),
(4,'DD'),
(5,'EE'),
(6,'FF'),
(7,'GG'),
(8,'HH'),
(9,'II')
go
----insert data into semister
insert into Semister
values
 (1,'Spring'),
 (2,'Summer'),
 (3,'Fall'),
 (4,'Winter')
Go
----insert data into subject
Insert into  Subject
values
(1,'C#'),
(2,'Database'),
(3,'Web Mining')
Go
---insert data into relationship
-- Insert data into CourseAssignment
INSERT INTO CourseAssignment(TeacherId, StudentId, SemisterId, SubjectId)
VALUES 
(1, 1, 1, 1),  
(1, 2, 1, 1),  
(1, 3, 1, 1),
(2, 7, 1, 2), 
(2, 8, 1, 2), 
(2, 9, 1, 2),  
(3, 4, 1, 3), 
(3, 5, 1, 3),  
(3, 6, 2, 3)
Go

SELECT * FROM Teacher;
GO
SELECT * FROM Student;
GO
SELECT * FROM Semister;
GO
SELECT * FROM Subject
GO





