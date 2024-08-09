--CREATE TABLE

CREATE DATABASE Summation_Quries
GO

---CREATE A TABLE
CREATE  TABLE Summation
(
Employee_Id INT PRIMARY KEY IDENTITY,
[Name] Varchar(255),
Department varchar(255),
[Job title] varchar(25),
Salary  Money,
[Hire Date] Date
)

----insert into data summation table
insert into Summation
values
('John Doe','HR','Manager',7000,'2024-01-15'),
('Jane Smith','IT','Developer',8000,'2020-02-15'),
('John abraham','HR','Manager',10000,'2020-03-15'),
('nelson loe','IT','manager',12000,'2020-04-15'),
('arafat foe','manager','peon',7000,'2022-01-15'),
('arif Do','CM','CareTaker',15000,'2020-06-15'),
('Joi De','PM','Manager',16000,'2024-09-15')
GO



Select *From Summation
GO

---count function
Select count(*) as 'Total Employes'
From Summation
Go

Select count(Name) as 'Name'
From Summation
GO

Select COUNT(Salary)  AS 'Salary'
From Summation
GO

----USING SUM FUNCTION

select sum(salary) as 'Total salary'
From Summation
GO
----using average function

Select avg(salary) as 'Average_Salary'
From Summation
go

Select Max(Salary) as 'Max_salary'
From Summation
GO


Select MIN(Salary) as 'Min salary'
From Summation
GO

 ----Group claues

Select Department, Sum(Salary) as 'Salary'
From Summation
Group By Department
Go

Select [Name], sum(salary) as 'Average Salary'
From Summation
Group By[Name]
Go

Select [Name], Department,Sum(Salary) as 'Salary'
From Summation
Group By [Name],Department,Salary
Go



Select [Name], Department,Sum(Salary) as 'Salary',[Hire Date]
From Summation
Group By [Name],Department,Salary,[Hire Date]
Having salary>10000
Go

----ROLL UP CLAUSE(GRAND TOTAL)

Select [Name], Sum(Salary) as Salary
From Summation
Group By
Rollup(Name )
GO

----COALESCE CLAUSE

SELECT COALESCE(Name,'TOTAL') AS NAME, SUM(Salary)AS 'SALARY'
FROM Summation
GROUP BY ROLLUP(Name)
GO
 
Select Coalesce ([Name],'Total') as [Name], Sum(Salary) as Salary
From Summation 
Group by Rollup([Name])
Go

-----CUBE OPERATOR
SELECT COALESCE(Name,'TOTAL') AS NAME,COALESCE(Department,'All Department') AS 
Department, SUM(Salary)AS 'SALARY'
FROM Summation
GROUP BY Cube(Name,Department)
GO
-------agian
select  coalesce([Name],'Total') as [Name],coalesce (Department,'DepartName') as Department, sum(Salary) as Salary
from Summation
group by cube([Name],Department)
go

---grouping set using
select Name,Department,
sum(Salary) as salary,
Grouping([Name]) as Name_group,
Grouping(Department) as Department_Group
From Summation

group by
grouping sets(
(Name,Department,Salary),
(Name),
(Department)

)
 -----------OVER OPERATOR USE
 Select [Name],Department,sum(Salary) over(partition by Department order by [Hire Date])
 From Summation
 Go
 /*
select 
from
where 
group by
having
order by 
top/limit


 */

 USE Northwind
 GO
	
	--from
SELECT *FROM Products
GO
--where clause

SELECT *FROM Products
where ProductID>15
GO

---GROUP BY
SELECT  ProductID,SUM(UnitPrice) as unitPrice
FROM Products
Where ProductID>10
GROUP BY ProductID
GO
---again
SELECT ProductID, SUM(UnitPrice) as Price
From Products
where ProductID>5
group by ProductID
go

----Having

SELECT ProductID, SUM(UnitPrice) as Price
From Products
where ProductID>10
group by ProductID
having sum(UnitPrice)>50
go

	---ORDERBY GROUPS
SELECT *FROM Orders
GO

SELECT P.CategoryID, P.ProductID,P.ProductName,P.UnitPrice,
O.OrderDate
From Products P
 INNER JOIN Orders O
 ON P.ProductID=O.EmployeeID
 GO

 SELECT TOP 5*
 FROM Orders
 ORDER BY CustomerID DESC
 GO

 --again

 Select P.CategoryID, P.ProductID,P.ProductName,P.UnitPrice,
O.OrderDate
FROM Products P
INNER JOIN Orders O 
ON P.ProductID=O.EmployeeID
GO

SELECT TOP 5*
FROM Orders
ORDER BY CustomerID ASC
go

DROP DATABASE Round61
GO
----using database

USE Summation_Quries
Go
CREATE TABLE Employee
(
Id INT PRIMARY KEY IDENTITY,
Name VARCHAR(30) NOT NULL,
Gender VARCHAR (30) NOT NULL,
Salary INT NOT NULL,
Department VARCHAR(30) NOT NULL
)
GO

INSERT INTO Employee
VALUES
('Rina','FeMale',1000,'HR'),
('Bina','FeMale',1000,'HR'),
('Tina','FeMale',3000,'Accounts'),
('Mina','FeMale',4000,'Accounts'),
('Rana','Male',1000,'HR'),
('Rani','FeMale',6000,'Markating'),
('Runa','FeMale',7000,'Markating'),
('Samiul','Male',8000,'HR'),
('Samaul','Male',1000,'Salse'),
('Rina','FeMale',1000,'HR')
GO

SELECT *
FROM Employee
GO

--group by

SELECT Department,sum(Salary) as salary
from Employee
where Salary>5000
group by Department
having sum(salary)>8000
go

---ROLL UP
SELECT Department,sum(Salary)
from Employee
group by rollup (Department,salary)
go

---coalsesce
select coalesce (Department,'Total') as  Department,
sum(Salary) as 'salary'
From Employee
Group by Rollup(Department)
go

--cube
select coalesce(Department,'Total') as Department,

coalesce(Gender,'All Gender') as gender,sum(Salary) as  salary
from Employee
Group by cube(Department,Gender)
go

-----class 06

USE Northwind
GO
SELECT * FROM Customers
Select * from Orders
GO


SELECT *
FROM Customers
WHERE CustomerID NOT IN(
SELECT CustomerID 
FROM Orders

)

select *From customers
where CustomerID NOT IN(
SELECT CustomerID from
orders
)
go


select *
from Products
where UnitPrice=(select sum(UnitPrice)
from Products
)
go

SELECT C.CustomerId,
(
SELECT SUM(OD.UnitPrice * OD.Quantity)
FROM Orders O
INNER JOIN [Order Details] OD
ON O.OrderID=OD.OrderID
WHERE O.CustomerID=O.CustomerID
) AS 'Total order amount'
FROM Customers C
GO


SELECT O.CustomerID,OD.UnitPrice*Quantity 'Total Price'
FROM Orders O
INNER JOIN [Order Details] OD
ON O.OrderID=OD.OrderID
GO


------new equipment

CREATE TABLE T1
(
Id INT
)
GO
INSERT INTO T1
VALUES
(1),
(2),
(3),
(4)
GO
SELECT * FROM T1
GO

----SOME FUNCTION
if 4<=some(select * from t1)
print 'TRUE'
ELSE
PRINT 'FALSE'
GO

----ANY FUNCTION

IF 4<=ANY(SELECT *FROM T1)
PRINT 'TRUE'
ELSE
PRINT 'FALSE'
GO

---ALL

IF 4<=SOME(SELECT * FROM T1)
PRINT 'True'
else
print 'false'
go


------create new table
use Northwind
go

-----EXIST OPEATOR

SELECT * FROM Customers
SELECT * FROM Orders
GO
---EXIST OPERATOR
SELECT * FROM Customers
WHERE NOT EXISTS
(
SELECT * FROM Orders 
WHERE Customers.CustomerID=Orders.CustomerID
)


GO


-------AGAIN CREATE TABLE
USE Round61
GO
CREATE TABLE Employee
(
Id INT PRIMARY KEY IDENTITY,
Name VARCHAR(30) NOT NULL,
Gender VARCHAR(30) NOT NULL,
Salary INT NOT NULL,
Department VARCHAR(30) NOT NULL
)
GO
INSERT INTO Employee
VALUES
('Rina','FeMale',1000,'HR'),
('Bina','FeMale',1000,'IT'),
('Tina','FeMale',1000,'Salse'),
('Mina','FeMale',1000,'HR'),
('Katrina','FeMale',1000,'HR'),
('Rana','Male',1000,'HR'),
('Rakib','Male',1000,'IT'),
('Runa','FeMale',1000,'HR'),
('Rani','FeMale',1000,'Salse'),
('jina','Male',1000,'HR'),
('Mina','Male',1000,'Accounts')
GO
SELECT * FROM Employee
GO

-----WITH

WITH EmployeeCTE AS (
SELECT * FROM Employee
WHERE Department='IT'

)
SELECT * FROM
EmployeeCTE
GO

WITH SAMIUL AS(
SELECT *FROM Employee
where Department='IT'
)
SELECT * FROM
SAMIUL
GO

--WITH MULTIPLE
with  EmployeecityCTE_It as(
select *from Employee Where Department='IT') as
EmployeecityCTE_HR as (
 select *from Employee where Department='HR'
 )
)

SELECT * FROM EmployeecityCTE_It
UNION ALL
SELECT * FROM EmployeecityCTE_HR
GO


--RECURSIVE CTE
WITH
OddNumberCTE (Id, Number)
AS
(SELECT 1,1
UNION ALL SELECT Id+1, Number + 2 FROM OddNumberCTE
WHERE Id<11
)
SELECT * FROM OddNumberCTE

--RANKING
WITH ExecuteCTE 
AS
(
SELECT Salary,DENSE_RANK() OVER(ORDER  BY Salary) AS MaxSalary 
FROM Employee
)
SELECT * FROM ExecuteCTE
WHERE ExecuteCTE.MaxSalary=1
GO



-----CLASS 07
---CREATE TABLE

CREATE TABLE Employees
(
id INT,
Name VARCHAR(30),
Salary FLOAT,
MobileNo VARCHAR(30)
)
GO
--INSERT
INSERT INTO Employees
VALUES
(1,'Rina',1000,'01518317509'),
(2,'Bina',2000,'01518317508'),
(3,'Tina',3000,'01518317507'),
(4,'Mina',4000,'01518317506'),
(5,'Runa',5000,'01518317505')
GO

--READ
SELECT * FROM Employees
GO

CREATE TABLE Candidat
(
id INT identity(50,1),
Name VARCHAR(30)
)
GO
INSERT INTO Candidate
VALUES
(50,'Tusar'),
(51,'Samrat')
GO

SELECT * FROM Employees
SELECT * FROM Candidat
GO


---marge


MERGE Employee AS TERGET
USING Candidat  AS SOURCE 
ON SOURCE.id=TERGET.id
WHEN NOT MATCHED THEN
INSERT(id,Name)
VALUES(SOURCE.id,SOURCE.Name);
GO





---DELETE
MERGE Employee as target
using Candidat as source
on source.Id=target.Id
When not matched by source then
delete;

---insert into data


INSERT INTO Candidat
VALUES
(60,'Samaul'),
(61,'Rabbi')
GO
INSERT INTO Candidat
VALUES
(60,'Pabel')
GO


---update
update Employees
set Salary=6000
Where Id=61
go

--update


Update Employees
set MobileNo='01728081275'
where Id=50
go

--delete

use Round61
go
select cast(1000 as decimal(38,6))AS  decimalNumber
select cast(2500 as decimal(16,6) )as decimalNumber
go

DECLARE @CURRENTIME DATETIME=GETDATE()

SELECT CONVERT (VARCHAR,@CURRENTIME ,108) AS VarcharTime
go

declare @currenttime datetime=getdate()
select convert(varchar,@currenttime,108) as  returvalue
go


---current time

declare @timevalue datetime=getdate()
select convert(varchar,@timevalue,108) as reurnVaLUE
go

--cast
select cast(500 as decimal(38,2)) as ConvertNumber
go
select cast(100 as decimal(10,3)) as convertSum

 SELECT DATEDIFF(day,'2024-2-2',GETDATE()) AS today
GO


CREATE TABLE HomeSales
(
	Date DATETIME DEFAULT GETDATE(),
	ItemSold VARCHAR(30) NOT NULL,
	UnitPrice MONEY NOT NULL,
	Quantity VARCHAR(30) NOT NULL,
	DiscountPercent FLOAT DEFAULT .05
)
GO
CREATE TABLE HomeSales
(
	Date DATETIME DEFAULT GETDATE(),
	ItemSold VARCHAR(30) NOT NULL,
	UnitPrice MONEY NOT NULL,
	Quantity VARCHAR(30) NOT NULL,
	DiscountPercent FLOAT DEFAULT .05
)
GO


--scaler value function
create function scalarCalculatFunction(
@unitPrice Money,
@quantitySold INT,
@discountPercent FLOAT
)
RETURNS MONEY
AS 
BEGIN
DECLARE @DiscountEarned MONEY
SET @DiscountEarned=@unitPrice*@quantitySold*@discountPercent
RETURN @DiscountEarned
END
GO
select dbo.ScalarCalculatFunction(1500.00,10,.10) AS 'Discount'
select dbo.ScalarCalculatFunction(2000,5,.05) AS 'Discount'
go
----
DECLARE @P MONEY
SELECT @P=UnitPrice FROM HomeSales WHERE Date='2023-07-07'

DECLARE @Q INT
SELECT @Q=Quantity FROM HomeSales WHERE Date='2023-07-07'

DECLARE @D FLOAT
SELECT @D=DiscountPercent FROM HomeSales WHERE Date='2023-07-07'


declare @samiul money
select @samiul=UnitPrice from HomeSales where date='2023-07-07'
go
SELECT dbo.ScalarCalculatFunction(@P,@Q,@D);
GO


---table valued function


CREATE FUNCTION CreateTabularFunction
(
@Year INT,
@Month INT
)
returns table
as
return(
	SELECT 
	SUM(UnitPrice*Quantity) as [TotalSales],
	SUM(UnitPrice*Quantity*DiscountPercent)as [Total Discount],
	SUM(UnitPrice*Quantity*(1-DiscountPercent)) as [Net Amount]
	FROM HomeSales
	WHERE YEAR(DATE)=@Year AND MONTH(DATE)=@Month
)
GO
--TEST
SELECT *
FROM dbo.CreateTabularFunction(2022,07)
GO

-----class 10


--1. PRIMARY KEY
CREATE TABLE Cricketers
(
	Cricketer_Id INT PRIMARY KEY,
	First_Name VARCHAR(30) NOT NULL,
	Last_Name VARCHAR(30) NOT NULL,
	Salary MONEY
)
GO

CREATE TABLE Cricketers2
(
	Cricketer_Id INT,
	First_Name VARCHAR(30) NOT NULL,
	Last_Name VARCHAR(30) NOT NULL,
	Salary MONEY,
	constraint Cricketers2_pk primary key(Cricketer_Id )
)
GO

-----its impossible to more primary key in one table
drop table Cricketers2
go
alter table Cricketers2

add constraint Cricketers2_pk primary key(Cricketer_Id)
go


----------foreign key

CREATE TABLE Cricketers5
(
	Cricketer_Id INT primary key,
	First_Name VARCHAR(30) NOT NULL,
	Last_Name VARCHAR(30) NOT NULL,
	Salary MONEY
	
)
GO


------for foreign key

CREATE TABLE Cricketers6
(
	Cricketer_Id INT,
	First_Name VARCHAR(30) NOT NULL,
	Last_Name VARCHAR(30) NOT NULL,
	Salary MONEY,
	foreign key (Cricketer_Id) references  Cricketers5(Cricketer_Id)
)
GO

select *from Cricketers5
select *from Cricketers6
go


----create table
create table StudentList
(ID INT PRIMARY KEY,
Name varchar(255)
)

INSERT INTO StudentList
VALUES
(1,'Rina'),
(2,'Bina'),
(3,'Mina')
GO

create table SubjectsList
(
Id int primary key,
SaubjectName Varchar(255)
)
go

INSERT INTO SubjectsList
VALUES
(1,'PHP'),
(2,'Java'),
(3,'C#')
GO


SELECT * FROM StudentList
SELECT * FROM SubjectsList
GO

----another example

CREATE TABLE Customer
(
	Id INT NOT NULL PRIMARY KEY,
	Name NVARCHAR(30),
	Email NVARCHAR(30),
	Payment NVARCHAR(30)
)
GO
CREATE TABLE OrderInfo
(
	Id INT NOT NULL PRIMARY KEY,
	OrderDescription NVARCHAR(30),
	OrderDate NVARCHAR(30),
	Price INT,
	Customer_Id INT REFERENCES Customer(Id)
)
GO

select * from Customer go
select *from  OrderInfo go

----class 11

---1. NOT NULL CONSTRAINT
CREATE TABLE Customer1
(
	Customer_Id INT NOT NULL,
	Name VARCHAR(30) NOT NULL,
	Age INT NOT NULL
)
GO

exec sp_helpconstraint 'Customer1'
go


--2. UNIQUE KEY CONSTRAINT


CREATE TABLE Customer2
(
	Customer_Id INT NOT NULL UNIQUE,
	Name VARCHAR(30) NOT NULL,
	Age INT NOT NULL
)
GO
exec sp_helpconstraint 'Customer2'
GO

---3. PRIMARY KEY CONSTRAINT
CREATE TABLE Customer3
(
	Customer_Id INT NOT NULL PRIMARY KEY,
	Name VARCHAR(30) NOT NULL,
	Age INT NOT NULL
)
GO
EXEC sp_helpconstraint 'Customer3'
GO

----foreign key with example

CREATE TABLE Customer4
(
	Customer_Id INT NOT NULL PRIMARY KEY,
	Name VARCHAR(30) NOT NULL,
	Age INT NOT NULL
)
GO
INSERT INTO Customer4
VALUES
(1,'R',20),
(2,'B',20),
(3,'M',20)
GO

EXEC sp_helpconstraint 'Customer4'
EXEC sp_helpconstraint 'Orders'
GO
CREATE TABLE Orders
(
	Order_Id INT NOT NULL PRIMARY KEY,
	Customer_Id INT,
	FOREIGN KEY(Customer_Id) REFERENCES Customer4(Customer_Id)
)


---5. CHECK CONSTRAINT
CREATE TABLE Customer5
(
	Customer_Id CHAR(5) NOT NULL CHECK(Customer_Id LIKE 'P-[0-9][0-9][0-9]'),
	Name VARCHAR(30) NOT NULL,
	Age INT NOT NULL
)
GO
EXEC sp_helpconstraint 'Customer5'
GO

--another example
create table anotherTable

(
CustomerId char(5) not null check(CustomerId LIKE 'A-[0-9][0-9][0-9]'),
[Name] varchar(255) not null,
age int not null
)

EXEC sp_helpconstraint 'anotherTable'
GO
---another table
create table TableNo2(
	Customer_Id INT NOT NULL,
	Name varchar(30) not null CONSTRAINT Ds_Name DEFAULT 'Rina',
		Age INT NOT NULL,
		check (Age>18)
)
go


---all constraint

CREATE TABLE Customs
(
	Custom_Id INT NOT NULL,
	Order_Id INT UNIQUE,
	Student_Id INT PRIMARY KEY,
	Customer_Id INT NOT NULL,
	FOREIGN KEY(Custom_Id) REFERENCES Customer4(Customer_Id),
	Name VARCHAR(30) NOT NULL DEFAULT 'Rina',
	Age INT NOT NULL,
	CHECK (Age>20)
)
GO
EXEC sp_helpconstraint 'Customs'
GO
INSERT INTO Customs
VALUES
(1,13,23,1,'Rina',55),
(1,11,21,2,'Rina',22),
(1,12,22,3,'Rina',11)
GO


------learn index

CREATE TABLE Customer10
(
	Customer_Id INT,
	Name VARCHAR(30) NOT NULL,
	Age INT NOT NULL
)
GO

INSERT INTO Customer10
VALUES
(NULL,'Rina',20),
(NULL,'Bina',21),
(NULL,'Tina',22)
GO

SELECT * FROM Customer10
GO


--CREATE SEQUENCE
CREATE SEQUENCE S_Customer10
AS INT
START WITH 1
INCREMENT BY 1
MINVALUE 1
MAXVALUE 7
CYCLE
GO

UPDATE Customer10 SET Customer_Id=NEXT 
VALUE FOR S_Customer10
GO



----class 13

CREATE TABLE Trainees
(
	TraineeId CHAR(7) PRIMARY KEY,
	TraineeName VARCHAR(30) NOT NULL,
	TSP CHAR(4)
)
GO


INSERT INTO Trainees
VALUES
('1210975','Rina','USSL'),
('1210976','Bina','PNTL'),
('1210977','Mina','STAR')
GO
SELECT * FROM Trainees
GO
---as view
create view vTrainees
as 
select  TraineeId,TraineeName,TSP

FROM Trainees
GO

SELECT * FROM vTrainees
GO

alter view vTrainees
with ENCRYPTION
AS 
SELECT  TraineeId,TraineeName,TSP
FROM Trainees
GO

--WITH CHECK OPTION
CREATE VIEW vTraineesUSSL
AS
SELECT TraineeId,TraineeName,TSP
FROM dbo.Trainees
WHERE TSP='USSL'
WITH CHECK OPTION
GO
SELECT * FROM vTraineesUSSL
GO
DROP VIEW vTraineesUSSL
GO

use Northwind

SELECT Invo
From Invoices

---------------------Revise Part-----------------------------------------


















































