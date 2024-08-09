--- ------School Management Project
-----Create database

Create Database Depression
ON PRIMARY
(
NAME=StoreDatabase,
FILENAME='C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\StoreDatabase.mdf',
SIZE=5MB,
MAXSIZE=100MB,
FILEGROWTH=10%
)
LOG 
ON(
NAME=LOGStoreDatabase,
FILENAME='C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\LOGStoreDatabase.ldf',
SIZE=5MB,
MAXSIZE=100MB,
FILEGROWTH=10%
)
GO
----Use Database
Use Depression
Go

--------------Create Table
Create Table Employees_Table
(
Employee_ID Int Primary key,
Employee_Name Varchar(255),
Employee_Salary Int Not Null,
Employee_Position Varchar(50),
Employee_Address Varchar(30),
Employee_Hiring_Date Varchar(20)

)


-- Again Create table Management

Create Table ManageMent_Table
(
Employee_ID INT Not Null Primary Key,
Employee_Salary Money Not Null,
Employee_Position Varchar(30),
Employee_Hiring_Date DATE,
Foreign Key(Employee_ID) references Employees_Table(Employee_ID)
)

----Insert data into the Employee_Table

Insert Into Employees_Table
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
----Read
Select * From Employees_Table
GO

----Insert Into data into Management

Insert into ManageMent_Table
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
Select * From Employees_Table
GO
Select * From  ManageMent_Table
Go
-------JOIN THE TWO TABLE

Select E.Employee_ID,E.Employee_Salary,M.Employee_Position,M.Employee_Hiring_Date
From ManageMent_Table AS M  join  Employees_Table AS E
ON M.Employee_ID=E.Employee_ID
Go

----Create  Table Attendence

Create Table C_Attendance
(
Class_Roll INT Primary key,
Employee_ID INT, 
Attend_Student_Name varchar(20),
Attendance_Date Date
)
Go
------create a table  Teacher

Create Table Teacher_List
(
Employee_ID Int Primary key Not Null, 
Class_Code Int, 
Course_ID Int, 
Teacher_Email varchar(30),
Teacher_Phone Int, 
Teacher_Name varchar(30),
Foreign key (Employee_ID) references C_Attendance(Employee_ID )
)
Go

-----------insert data into Attendance
Insert Into C_Attendance
Values 
(100, 1, 'Malek', '2022/06/01'),
(101, 2, 'Abul', '2024/02/02'),
(102, 3, 'Imran', '2023/02/03'),
(103, 4, 'Islam', '2023/02/04'),
(104, 5, 'Raihan', '2021/02/05'),
(105, 6, 'Mannan', '2024/02/06'),
(106, 7, 'Jibon', '2021/02/07')
Go
--------
DECLARE @NextID INT;
SELECT @NextID = ISNULL(MAX(Employee_ID), 0) + 1 FROM Attendance;
GO
-----------------READ
Select * From Attendance

-----------------iNSERT DATA INTO TEACHER
Insert Into Teacher_Name
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
Select * From Teacher_Name
Go
