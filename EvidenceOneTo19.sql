----------------Evidence No: 1
---------Answer No A
Exec sp_helpdb
Go
-----------------Answer: B
-----------------Create database

Create Database ESAD
On Primary
(
NAME=userDatabase,
FILENAME="C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\Evidence1-19/userDatabase.mdf",
SIZE=10MB,
MAXSIZE=100MB,
FILEGROWTH=10%
)
Log On
(
NAME=userLogDatabase,
FILENAME="C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\Evidence1-19/userLogDatabase.ldf",
SIZE=10MB,
MAXSIZE=100MB,
FILEGROWTH=10%
)
Go
-------------Answer: C
EXEC SP_HELPDB 'ESAD'
GO
--------Answer: D
USE ESAD
GO

ALTER DATABASE ESAD
SET SINGLE_USER WITH ROLLBACK IMMEDIATE
GO

----EVIDENCE 2
-----ANSWER --A
ALTER DATABASE T_SQL
SET SINGLE_USER WITH ROLLBACK IMMEDIATE
GO
DROP DATABASE T_SQL
GO

CREATE DATABASE T_SQL
On Primary
(
NAME=user1Database,
FILENAME="C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\Evidence1-19/user1Database.mdf",
SIZE=10MB,
MAXSIZE=100MB,
FILEGROWTH=10%
)
Log On
(
NAME=user1LogDatabase,
FILENAME="C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\Evidence1-19/user1LogDatabase.ldf",
SIZE=10MB,
MAXSIZE=100MB,
FILEGROWTH=10%
)
Go
-----ANSWER B & C
ALTER DATABASE T_SQL
MODIFY FILE
(
NAME=user1Database,
SIZE=20MB
)
GO
----ADD FILE
ALTER DATABASE T_SQL
ADD FILE
(
NAME=ESAD_data1,
FILENAME="C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\Evidence1-19/user1LogDatabase.mdf",
SIZE=5MB
)
GO
----------------------Answer: D
ALTER DATABASE T_SQL
MODIFY NAME=TraineeDB
GO

-------Evidence 3
-----------Answer: A
IF EXISTS
(
SELECT * FROM sysobjects
WHERE NAME='Trainees' and xtype='U'
)
DROP TABLE Trainees
GO

CREATE TABLE Trainees
(
traineeid CHAR(7) CHECK(traineeid like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
PRIMARY KEY,
traineename VARCHAR(50) NOT NULL,
[batch] VARCHAR( 20) NOT NULL
)
GO
-----------------
EXEC sp_helpconstraint 'Trainees'
GO

INSERT INTO Trainees VALUES ( '1023338', 'Ruhul', 'ESAD-R10')
INSERT INTO Trainees VALUES ( '1023335', 'Amin', 'ESAD-R10')
GO

---READ
SELECT * FROM Trainees
GO

-----EVIDENCE----5
----CREATE TABLE 


CREATE TABLE tsps
(
tspid int identity primary key,
tspname varchar(50)
)
go
CREATE TABLE Trainee
(
traineeid int identity primary key,
traineename varchar(50) not null,
tspid int references tsps(tspid)
)
GO
INSERT INTO tsps(tspname) values ( 'BITL')
INSERT INTO tsps(tspname) values ( 'MCIT')
GO
INSERT INTO trainees ( traineename, tspid )VALUES ( 'Habib', 1)
INSERT INTO trainees ( traineename, tspid ) VALUES( 'Ave', 1)
INSERT INTO trainees ( traineename, tspid ) VALUES( 'Javed', 2)
GO
-----------------VIEW WITH JOIN
create view vTraineeTsp
as
select traineeid, traineename, tspname
from tsps ts
inner join trainees tr
on ts.tspid = tr.tspid
go
select * from vTraineeTsp
go

---------------SOLUTION-6
CREATE TABLE Personss
(
[Person id] INT IDENTITY( 100, 5),
[Person name] VARCHAR(30)

)
----insert data into Personss
INSERT INTO Personss ( [person name] ) values ( 'Kamal' )
INSERT INTO Personss ( [person name] ) values ( 'Jamal' )
INSERT INTO Personss ( [person name] ) values ( 'Aslam' )
go

----read data
SELECT * FROM Personss
GO

USE TraineeDB
GO

-----------SOLUTION OF 7(C)


-------SOLUTION 8(A)

CREATE TABLE Contacts
(
ContactID INT NOT NULL,
ContactName VARCHAR(30) NOT NULL
)
GO

----------SOLUTION 8(B)
ALTER TABLE Contacts
ALTER COLUMN ContactName varchar(50) NOT NULL
GO
-----SOLUTION 8(C)

ALTER TABLE Contacts
ADD ContactTel VARCHAR(12) NULL
ALTER TABLE Contacts
ADD ContactCell VARCHAR(16) NULL 
GO

--------------SOLUTION 8(D) 

insert into Contacts( contactId, ContactName, ContactCell) values( 1, 'Quazi Ashique',
'0172889933' )
-- insert into contacts values( 1, 'Quazi Ashique', null, '0172889933' )
-- will do the same
insert into contacts values( 2, 'Hasinur Shahid', '805098', '0152980890' )
insert into Contacts( contactId, ContactName, ContactCell) values( 3, 'Mir Mosharaf',
'0181076543' )
insert into Contacts( contactId, ContactName) values( 3, 'Shaheen akter' )
go

-----SOLUTION 9A
CREATE TABLE Books
(
[name] CHAR(30) NOT NULL, -- you should enclose name in [], as it has meaning in

publisher VARCHAR(30) NOT NULL Default 'N/A',
price MONEY,
publish SMALLDATETIME,
currentedition INT not null DEFAULT 1,
available BIT not null DEFAULT 0
)
GO

--------SOLUTION 9(B)

INSERT INTO books VALUES( 'Programming Practice', 'Show&Tell Consulting', 600, '2004-01-
01', 3, 1 )
-- since all column values are there, column name not needed
INSERT INTO books VALUES( 'Introducing C#', 'Show&Tell Consulting', 700, '2003-01-01', 4,
0 )
INSERT INTO books VALUES( 'SQL Server 2000', 'BPB', 1000, '2002-01-01', 2, 1 )
INSERT INTO books ( [name], price ) VALUES ( 'XML', 700 )-- only two column values needed others are default OR null
go
SELECT * FROM books
GO

USE TraineeDB
GO

-------------SOLUTION 10A

CREATE TABLE Expenses
(
[date] SMALLDATETIME NOT NULL ,
item VARCHAR(40) NOT NULL,
price MONEY NOT NULL,
quantity int NOT NULL,
amount as price*quantity
)
go

----------SOLUTION 10B

INSERT INTO Expenses ( [date], item, price, quantity )
values ( getdate(),
'Travel Bag',
450,
1 )
INSERT INTO Expenses ( [date], item, price, quantity )
values ( getdate(),
'Punjabi',
250,
2)
INSERT INTO Expenses ( [date], item, price, quantity )
values ( getdate(), -- today
'Tooth brush',
15,
3 )
GO
/*
-----------------Solution 10C
*/
SELECT * FROM  expenses
GO


-----SOLUTION 11(A)

CREATE TABLE Orders
(
orderid INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
orderdate SMALLDATETIME NOT NULL CONSTRAINT df_o_date default getdate(),
productid INT NOT NULL,
quantity INT NOT NULL CHECK( quantity > 0 ),
shipdate SMALLDATETIME,
CHECK ( shipdate > orderdate )
)
GO


----------------SOLUTION (11B)

sp_helpconstraint 'Orders'
GO

---------------SOLUTION 11C

ALTER TABLE Orders
DROP CONSTRAINT df_o_date
GO
------------------SOLUTION (11D)

DROP TABLE Orders
GO

-----SOLUTION 12(A)
CREATE TABLE Orders
(
orderid INT IDENTITY(1,1) NOT NULL,
orderdate SMALLDATETIME ,
productid INT NOT NULL,
quantity INT NOT NULL,
shipdate SMALLDATETIME)
GO

-----------solution 12B

alter table Orders
add constraint pk_orderid
primary key(Orderid)
go
/*
solution 12C
*/
alter table Orders
add constraint chk_quantity
check(quantity > 0)
go

------SOLUTION 12(B)
ALTER TABLE Orders
ADD  CONSTRAINT df_orderdate
DEFAULT  GETDATE() FOR OrderDate
GO

-------------SOLUTION 12(C)
sp_helpconstraint 'Orders'
go

-------------Solution 12D
ALTER TABLE Orders
ADD CONSTRAINT df_orderdate
DEFAULT getdate() FOR OrderDate
GO

-----SOLUTION (12E)
sp_helpconstraint 'Orders'
GO
-------SOLUTION (13 A)

CREATE TABLE Categories (
CategoryID int NOT NULL primary Key,
CategoryName nvarchar (15) NOT NULL ,
)
GO
CREATE TABLE Products (
ProductID int NOT NULL Primary Key ,
ProductName nvarchar (40) NOT NULL ,
CategoryID int NULL references Categories(CategoryID),
UnitPrice money NULL)
GO


----------solution 13B

INSERT INTO categories VALUES ( 1, 'Beverages' )
INSERT INTO categories VALUES ( 2, 'Condiments' )
INSERT INTO categories VALUES ( 3, 'Confections' )
GO


-----------Solution 13C

INSERT INTO products values ( 1, 'Chai', 1, 18.00 )
INSERT INTO products values ( 2, 'Chang', 1, 19.00 )
INSERT INTO products values ( 3, 'Chef Anton''s Cajun Seasoning', 2, 10.00 )-- for '

INSERT INTO products values ( 4, 'Aniseed Syrup', 2, 22.00 )
INSERT INTO products values ( 5, 'Chef Anton''s Gumbo Mix ', 2, 21.00 )
INSERT INTO products values ( 6, 'Grandma''s Boysenberry Spread ', 2, 25.00 )
GO

-------------SOLUTION NO: 14
CREATE TABLE Categorie (
CategoryID int NOT NULL primary Key,
CategoryName nvarchar (15) NOT NULL ,
)
GO
CREATE TABLE Product (
ProductID int NOT NULL Primary Key ,
ProductName nvarchar (40) NOT NULL ,
CategoryID int NULL ,
UnitPrice money NULL
)
GO

-----------SOLUTION 12B

ALTER TABLE Products
ADD CONSTRAINT fk_categoryid
FOREIGN KEY(CategoryID) REFERENCES Categories (CategoryID)
ON DELETE CASCADE
GO

----------solution 14C
INSERT INTO categories values ( 1, 'Beverages' )
INSERT INTO categories values ( 2, 'Condiments' )
INSERT INTO categories values ( 3, 'Confections' )
GO
--------SOLUTION 14(D)

INSERT INTO products values ( 1, 'Chai', 1, 18.00 )
INSERT INTO products values ( 2, 'Chang', 1, 19.00 )
INSERT INTO products values ( 3, 'Chef Anton''s Cajun Seasoning', 2, 10.00 )-- for '
INSERT INTO products values ( 4, 'Aniseed Syrup', 2, 22.00 )
INSERT INTO products values ( 5, 'Chef Anton''s Gumbo Mix ', 2, 21.00 )
INSERT INTO products values ( 6, 'Grandma''s Boysenberry Spread ', 2, 25.00 )
GO

----SOLUTION 14E

DELETE FROM Categories Where categoryid=1
GO
-------SOLUTION: 14F

---READ DATA
SELECT * FROM Categories
SELECT * FROM Products
GO

--------SOLUTION 15 A
CREATE TABLE Reservations
(
[Id] INT IDENTITY(1,1) NOT NULL,
Room INT NOT NULL,
[Date] DATETIME NOT NULL
)
GO
----------SOLUTION 16

CREATE TABLE [Promotion Sales]
(
Product VARCHAR(30) NOT NULL,
Price MONEY NOT NULL,
DiscountRate INT NOT NULL
)
GO

-----------Solution 16B

CREATE PROC spInsertPromoSale @p VARCHAR(30),
@pr MONEY,
@dr INT = 5
AS
INSERT INTO [Promotion Sales] VALUES (@p, @pr, @dr )
GO
/*Solution 16C
*/
execute spInsertPromoSale 'Jeans', 1050, 12
execute spInsertPromoSale 'Shoe', 1200, 7
execute spInsertPromoSale 'Shirt', 800
go

  -------Solution 16D
CREATE VIEW vwPromoSales
AS
SELECT *, (Price -(price*DiscountRate)/100) as SiscountedPrice
FROM [Promotion Sales]
GO
-- Test
SELECT * FROM vwPromoSales
GO

----------Solution 17A

CREATE TABLE Classes
(
ClassId INT NOT NULL,
[Description] VARCHAR(100) NOT NULL,
ClassHour INT NOT NULL
)
GO
/*
Solution 17B
*/
CREATE PROC spInsertClass @cid INT,
@desc VARCHAR(100),
@ch INT
AS
IF @ch < 2
BEGIN
RAISERROR( 'Class Hour must be 2 or more', 16, 1)
RETURN
END
ELSE
BEGIN
INSERT INTO Classes VALUES( @cid, @desc, @ch )
END
GO

-------------SOLUTION 17(B)
EXEC spInsertClass 1, 'C Sharp into', 1
GO

------------18 (A)
CREATE TABLE Trainees
(
[id] INT PRIMARY KEY,
[name] VARCHAR(30)
)
GO

CREATE TABLE exam_result
(
[id] int references trainees( [id] ),
marks FLOAT
)

---------- 18(B)

INSERT INTO Trainees values (1, 'Kamal')
INSERT INTO Trainees values (2, 'Rahmat')
INSERT INTO Trainees values (3, 'Salma')
INSERT INTO Trainees values (4, 'Enam')
GO
INSERT INTO Exam_result values (1, 75.5)
INSERT INTO Exam_result values (2, 89.3)
INSERT INTO Exam_result values (3, 67)
GO

-------Solution 18C

SELECT [name], marks
FROM trainees t
inner join exam_result e
ON t.[id] = e.[id]
GO

-------Solution 18E

SELECT top 1 [name], marks
FROM trainees t
left outer join exam_result e
on t.[id] = e.[id]
order by marks desc
go

------Solution 18F
SELECT TOP 1 [name], marks
FROM trainees t
left outer join exam_result e
ON t.[id] = e.[id]
WHERE marks is not null
ORDER BY marks
GO

-------Solution 18G

SELECT avg(marks)
FROM trainees t
left outer join exam_result e
ON t.[id] = e.[id]
GO

-----USE DATABASE
     USE Northwind
	 GO
	 ---19
----------Solution B
SELECT CustomerId, CompanyName, Country
FROM Customers
WHERE Country in('USA','UK', 'Germany')

ORDER BY Country DESC
GO

------------SOLUTION 19 C

SELECT CustomerID as 'Custmer Code',
CompanyName AS 'Company',
'Origin' = Country
FROM Customers
GO
----------SOLUTION D

SELECT *  FROM Orders
WHERE OrderDate BETWEEN '1997-01-01' AND '2000-12-31'
GO
----------------E
SELECT * From Customers
WHERE CompanyName LIKE 'A%'
GO
-------------F
SELECT TOP 3 * FROM Orders
ORDER BY Orderdate DESC
GO
---------G
SELECT TOP 3 * FROM Orders
ORDER BY Orderdate ASC
GO
------------
------------------------H
SELECT c.CustomerID, CompanyName, orderID, OrderDate
from Customers c
inner join Orders o
on c.CustomerID=o.CustomerID
GO


------------SOLUTION 
SELECT c.CustomerID, CompanyName, orderID, OrderDate
from Customers c
left outer join Orders o
on c.CustomerID=o.CustomerID
go
/*
solution H
*/
Select c.CustomerID, c.City as 'Cust. City', e.FirstName, e.City as 'Emp. City'
from employees e
full outer join customers c
on c.City=e.City
go

----------------I

Select Count(CustomerId)-- count(*) does the same
from customers
go


---------------K

Select Country,Count(CustomerId) as '# of Customers'-- count(*) does the same
from customers
group by Country
having country = 'USA'
go

-------------M

Select c.CustomerId, count(orderid) as '# of order placed'
from Customers c
inner join orders o
on c.CustomerId = o.CustomerId
group by c.CustomerId
go

-----------------N
SELECT c.CustomerId, sum(unitprice*quantity) as 'Order amount'
from Customers c
inner join orders o
on c.CustomerId = o.CustomerId
inner join [order details] od
on o.orderid = od.orderid
group by c.CustomerId
GO
------------0
Select DISTINCT city from customers
go

-------------------P
SELECT City from customers
union
SELECT City from Employees
Go

------------------- Q

SELECT * from customers
where city in ( select city from employees)
GO