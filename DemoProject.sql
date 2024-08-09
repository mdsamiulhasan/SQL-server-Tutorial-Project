-------------School Management System_
-------------------Create Database 
Create Database SchoolManageMentSystem
ON PRIMARY(
NAME=MdfSchool,
FILENAME='C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\SchoolManagementSytem/MdfSchool.mdf',
SIZE=5MB,
MAXSIZE=100MB,
FILEGROWTH=10%
)
LOG ON(
NAME=LogSchool,
FILENAME='C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\SchoolManagementSytem/LogSchool.ldf',
SIZE=5MB,
MAXSIZE=100MB,
FILEGROWTH=10%
)
GO
-----use Database
USE SchoolManageMentSystem
GO

-----Create Table Employee

Create Table Employee_Table
(
Employee_ID Int Primary Key,
Employee_Name Varchar(255),
Employee_Salary Int Not Null,
Employee_Position Varchar(50),
Employee_Address Varchar(30),
Employee_Hiring_Date Varchar(20)

)
Insert Into Employee_Table
Values
(1,'Md Samiul Hasan',25000,'Head Master','Dhaka','20-04-2018'),
(2,'Md Rakibul Hasan',20000,'Assistant Teacher','Gazipur','20-04-2022'),
(3,'Md Tushar Khan',20000,'Assistant Teacher','Dhaka','10-05-2019'),
(4,'Md Naimul Hasan',20000,'Assistant Teacher','Dhaka','11-11-2019'),
(5,'Mst.Nargis Banu',18000,'Assistant Teacher','Dhaka','10-12-2004'),
(6,'Sree Varoti Rani',17000,'Assistant Teacher','Dhaka','12-04-2013'),
(7,'Md Ashraf Ali',16000,'Assistant Teacher','Dhaka','13-05-2015'),
(8,'Md Jobed Ali',15000,'Assistant Teacher','Dhaka','16-07-2020'),
(9,'Md Kader khan',12000,'Care Taker','Dhaka','12-10-2010'),
(10,'Md Najmul Huda Papon',12000,'Peon','Dhaka','25-04-2012'),
(11,'Mst.Bilkis Akhter',10000,'Shave','Dhaka','20-09-2016'),
(12,'Mst.Rokeya Khatun',9000,'Cleaner','Dhaka','20-09-2016')
Go

Select * From Employee_Table
GO

--- Again Create table Management

Create Table Management
(
Employee_ID INT Not Null Primary Key,
Employee_Salary Money Not Null,
Employee_Position Varchar(30),
Employee_Hiring_Date DATE

)
---------Insert data into the Management Table
Insert into Management
Values(1, 10000, 'Director', '2020-01-01'),
(2, 9000, 'Head of the dept', '2020-01-02'),
(3, 8000, 'principal', '2020-01-03'),
(4, 7000, 'classteacher', '2020-01-04'),
(5, 6000, 'classmonitor', '2020-01-05'),
(6, 5000, 'sports trainer', '2020-01-06'),
(7, 4000, 'clerk', '2020-01-07'),
(8, 3000, 'Attender', '2020-01-08'),
(9, 2000, 'cleaner', '2020-01-09'),
(10, 1000, 'Bus Drivers', '2020-01-10')
Go
---Read
Select * From  Management
Go

----Create  Table Attendence
Create Table Attendance
(
Class_Roll INT,
Employee_ID INT Primary key, 
Attend_Student_Name varchar(20),
Attendance_Date Date
)
Go
Insert Into Attendance
Values 
(100, 1, 'Malek', '2022/06/01'),
(101, 2, 'Abul', '2024/02/02'),
(102, 3, 'Imran', '2023/02/03'),
(103, 4, 'Islam', '2023/02/04'),
(104, 5, 'Raihan', '2021/02/05'),
(105, 6, 'Mannan', '2024/02/06'),
(106, 7, 'Jibon', '2021/02/07')
Go
-----------------READ
Select * From Attendance
Go

--------------------Create table Teacher

Create Table Teacher
(
Employee_ID Int Primary key Not Null, 
Class_Code Int, 
Course_ID Int, 
Teacher_Email varchar(30),
Teacher_Phone Int, 
Teacher_Name Varchar(30)

)
Go

-----------------iNSERT DATA INTO TEACHER
Insert Into Teacher
values
(1, 101, 1500, 'toma@gmail.com', 45687545, 'Toma'),
(2, 102, 1501,'lisa@gmail.com', 54526554, 'lisa'),
(3, 103, 1502, 'tina@gmail.com', 54754740, 'tina'),
(4, 104, 1503, 'rina065@gmail.com',5645640, 'rina'),
(5, 105, 1504, 'mita@gmail.com', 541540, 'Mita'),
(6, 106, 1505, 'laboni@gmail.com', 3542440, 'Laboni'),
(7, 107, 1506, 'shekh@gmail.com', 542340, 'shekh')
GO
------------read
Select * From Teacher
Go

--------Create table Course
Create Table Course
(
Course_ID Int, 
Employee_ID Int Primary key, 
Course_Hours Int, 
Course_Name varchar(30)

)

-----Insert data into Course
Insert Into Course
Values
(1500, 1, 10 , 'English'),
(1501, 2, 9, 'Bangla'),
(1502, 3, 8, 'Math'),
(1503, 4, 7, 'sql'),
(1504, 5, 6, 'History'),
 (1505, 6, 5, 'science'),
 (1506, 7, 4, 'labs')
 Go

-----Read
Select * From Course
Go
-------Create table Grade
Create Table Grade
(
Employee_ID Int Primary Key,
Course_ID Int, 
Student_Name varchar(30),
Student_Group Varchar(40),
Average_Grade Char(5),
Foreign key(Employee_ID) references  Course(Employee_ID)

)
Go
----------------Insert into data Grade
Insert Into Grade
Values
(600, 2500, 'Samiul', 'Science', 'A+' ),
(601, 2501, 'Sajal', 'Science', 'A+' ),
(602, 2502, 'Norman', 'Arts', 'A' ),
(603, 2510, 'Apu', 'Science', 'A' ),
(604, 2400, 'Lina', 'Arts', 'B' ),
(605, 2300, 'Nila', 'Social Sceince', 'B' ),
(606, 220, 'Arjun', 'Science', 'C' ),
(607, 1100, 'Dalim', 'Arts', 'D' ),
(608, 1500, 'Sujan', 'Music', 'F' )
Go
------------read
Select * From Grade
GO
-------------Creeate event table

Create Table [Event]
(
Employee_ID INT Primary key Not Null,
Event_ID INT,
Mangement_Employee_Email varchar(20),
Mangement_Employee_Phone INT,
Mangement_Employee_Name varchar(40),

Foreign key (Employee_ID) references Management(Employee_ID),
Foreign key (Employee_ID) references Attendance(Employee_ID),
Foreign key (Employee_ID) references Teacher(Employee_ID),
Foreign key (Employee_ID) references Course(Employee_ID),
Foreign key (Employee_ID) references Employee_Table(Employee_ID),
Foreign key (Event_ID) references Event(Employee_ID)
)
GO
Insert Into [Event]
Values 
(1, 101, 'abul@gmail.com', '01725254652', 'Abul'),
(2, 102, 'kashem@gmail.com', '01820352245', 'Kashem'),
(3, 103, 'joshim@gmail.com', '01932852558', 'Borkot'),
(4, 104, 'bulbul@gmail.com', '01356894585', 'Joshim'),
(5, 105, 'jobed@gmail.com', '01421856445', 'Bulbul'),
(6, 106, 'alia@gmail.com', '01535812845', 'jobed'),
(7, 107, 'bangla@gmail.com', '01268748454', 'Jara'),
(8, 108, 'malek@gmail.com', '01345875545', 'Malek'),
(09, 109, 'nargis@gmail.com', '01954345857', 'Nargis'),
(10, 110, 'bela@gmail.com', '01627418544', 'Bela')
Go
----read
Select *
from [Event]
Go

-- Check Employee table
SELECT * FROM [Employee_Table]

-- Check Event table
SELECT * FROM [Event];



-------Insert Data into the Table 

---1..Find Out the Data From [Management] table that people Event_ID Highest 107

SELECT Distinct Employee_ID,Employee_Salary,Employee_Position          
FROM Management
WHERE Employee_ID Between 101 And 105
Order by Employee_Position ASC
GO

--2.-. Find out Employee_details along with Management_Name?

-----Join Here
Select E.Employee_ID, E.Employee_Hiring_Date, Ev.Mangement_Employee_Name
From Employee_Table AS E Full outer join [Event] AS Ev
ON E.Employee_ID=Ev.Employee_ID
Go

--3.Find Out  attendance Details With Its Teachers Name
Select A.Employee_ID,A.Attend_Student_Name,A.Attendance_Date,A.Class_Roll,T.Teacher_Name
From Attendance  as A join Teacher As T
ON A.Employee_ID=T.Employee_ID
GO

----4. Find Out Student_Grade_Details with their Course_code

Select Student_Group,Average_Grade
From Grade
Go
--5. Present all employee_Table ID who got hired on ‘16-07-2020’?
Select Employee_ID,Employee_Name
From Employee_Table
Where Employee_Hiring_Date='2020-01-06'
Go

----------------------------------The END OF THE PROJECT








----searching data

























