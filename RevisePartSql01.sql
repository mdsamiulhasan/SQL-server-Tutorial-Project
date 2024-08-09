 -----create database
CREATE DATABASE RevisePart01
GO

/*
1.SELECT
2.FROM
3.WHERE
4.GROUP BY
5.HAVING

6.ORDER BY
7.TOP
8.DISTINCT
9.AND
10.OR
11.NOT
12.IN
13.BETWEEN
14.LIKE
15.IS NULL

*/
--------Now explain with example declaration

---CREATE TABLE
CREATE TABLE InvoicesTable
(
lnvoiceID INT PRIMARY KEY,
VendorID varchar(30),
InvoiceNumber varchar(20),
InvoiceDate VARCHAR(20),
InvoiceTotal FLOAT,
PaymentTotal FLOAT,
CreditTotal FLOAT,
)
GO
Alter table InvoicesTable
add constraint 
---ADD COLUMN
ALTER TABLE InvoicesTable
ADD InvoiceName VARCHAR(30) Not null 

--modify table




----insert into data Invoices Table
INSERT INTO InvoicesTable

VALUES
(1,4564458544,45678,'08-20-2023',120.56,7896,020.00),
(2,4564558544,46678,'03-20-2023',130.56,7996,02.00),
(3,455458544,47678,'04-20-2023',140.56,7096,02.00),
(4,4524458544,48678,'02-20-2023',150.56,7396,02.00),
(5,4562448544,49678,'01-20-2023',160.56,7296,02.00),
(6,4564658544,40678,'17-20-2023',127.56,7496,02.00),
(7,4564858544,41678,'18-20-2023',190.56,7696,02.00),
(8,454458544,42678,'27-20-2023',100.56,7876,02.00),
(9,4564958544,43678,'16-20-2023',220.56,7866,02.00),
(10,4564358544,41678,'20-20-2023',320.56,7836,02.00),
(11,4564458544,35678,'30-20-2023',420.56,7846,02.00),
(12,4564895844,43678,'10-20-2023',320.56,7796,02.00),
(13,4564458744,35678,'13-20-2023',320.56,7996,02.00)
GO

---read data
SELECT * FROM InvoicesTable
GO


SELECT InvoiceTotal FROM InvoicesTable
GO

SELECT lnvoiceID,InvoiceDate,InvoiceTotal FROM
InvoicesTable
GO
--------WHERE CLAUSE

SELECT lnvoiceID,InvoiceDate,InvoiceTotal,InvoiceName FROM InvoicesTable
WHERE lnvoiceID>=5
GO
--------example
SELECT lnvoiceID,InvoiceDate,InvoiceTotal+VendorID as InvoiceTotal_VendorID,InvoiceName FROM InvoicesTable
WHERE lnvoiceID>=5
GO
-------example

SELECT lnvoiceID+'+'+InvoiceName as 'NewTable',InvoiceDate,InvoiceTotal+VendorID as InvoiceTotal_VendorID,InvoiceName FROM InvoicesTable
WHERE lnvoiceID>10
GO

-----example
SELECT lnvoiceID,InvoiceDate,
InvoiceTotal+','+VendorID AS semicolon,InvoiceTotal+VendorID as InvoiceTotal_VendorID,InvoiceName FROM InvoicesTable
WHERE lnvoiceID>10
GO

-----The * is used to retrieve all columns
/* A function is used to calculate CurrentDate 
--SELECT InvoiceNumber, InvoiceDate, 
---GETDATE() AS CurrentDate 

Use SELECT * only when you need to retrieve all of the columns from a table. 
Otherwise, list the names of the columns you need. 
*/

----------DISTINCT------
 ---The ALL and DISTINCT keywords and the TOP clause let you control the number 
----of rows that are returned by a query.

----A SELECT statement that uses parentheses 
----to control the sequence of operations 

SELECT lnvoiceID+16 AS NewId,InvoiceDate,InvoiceTotal,VendorID
FROM InvoicesTable
GO

---A SELECT statement that uses the LEFT function

--create table 2
Create table LeftFunction
(
Id Int Primary key,
[First Name] Varchar(30),
[Last Name] Varchar(20)
)
Go
--add column


Insert Into LeftFunction
Values
(1,'samiul','Hasan'),
(2,'arif','Hasan'),
(3,'Bosir','uddin'),
(4,'samir','hossain'),
(5,'Liyakot','Hossain')
Go


---read
Select * from LeftFunction
Go
----A SELECT statement that uses the LEFT function 
Select [First Name],[Last Name],
Left([First Name],1)+Left([Last Name],1) as Short_Name
From LeftFunction
Go
-----Re example
Select  [First Name],[Last Name],
Left([First Name],7) + Left([Last Name],7) as Rearrage_Name
From LeftFunction
Go
----example
select [First Name],[Last Name],
left( [First Name],2) +left([Last Name],2) as Unknown
From LeftFunction
Go

----A SELECT statement that returns all rows
SELECT [First Name],[Last Name]
FROM LeftFunction
Order by [Last Name]
Go

/*
The DISTINCT keyword prevents duplicate (identical) rows from being included in 
the result set. It also causes the result set to be sorted by its first column. 

• The ALL keyword causes all rows matching the search condition to be included in 
the result set, regardless of whether rows are duplicated. Since this is the default, 
it's a common practice to omit the ALL keyword.

*/

----------Distinct &&& All Keywords

SELECT Distinct lnvoiceID,InvoiceDate,InvoiceTotal+VendorID as InvoiceTotal_VendorID,InvoiceName FROM InvoicesTable
WHERE lnvoiceID>5
GO
---------all keyword
SELECT All lnvoiceID,InvoiceDate,InvoiceTotal+VendorID as InvoiceTotal_VendorID,InvoiceName FROM InvoicesTable
WHERE lnvoiceID>5
GO

---------Top keywords
---------A SELECT statement with a TOP clause 

SELECT Distinct TOP 5 lnvoiceID,InvoiceName FROM InvoicesTable
WHERE lnvoiceID>5
GO

---------TOP 5 WITH PERCENT

SELECT ALL TOP 5 PERCENT lnvoiceID,InvoiceName 
FROM InvoicesTable
ORDER BY InvoiceName DESC
GO
----Another example
SELECT Distinct TOP 5 PERCENT lnvoiceID,InvoiceName 
FROM InvoicesTable
ORDER BY lnvoiceID DESC
GO  
--------Ties clause

SELECT Distinct TOP 8  WITH TIES lnvoiceID,InvoiceName
FROM InvoicesTable
Order by  lnvoiceID ASC

GO

-----where clause with or, and, not operator 

SELECT Distinct lnvoiceID,InvoiceDate,InvoiceTotal+VendorID as InvoiceTotal_VendorID FROM InvoicesTable
WHERE InvoiceDate='04-20-2023' or lnvoiceID>10
GO

/*You can use the AND and OR logical operators to create compound conditions that 
consist of two or more conditions. You use the AND operator to specify that the 
search must satisfy both of the conditions, and you use the OR operator to specify 
that the search must satisfy at least one of the conditions. 

• You can use the NOT operator to negate a condition. Because this operator can 
make the search condition difficult to read, you should rephrase the condition if 
possible so it doesn't use NOT.

*/
---------------------IN operator

where  InvoiceID IN(

SELECT  InvoiceID
FROM InvoicesTable
WHERE InvoiceDate='04-20-2023' or InvoiceID>10)
GO
 

 --You can use the IN phrase to test whether an expression is equal to a value in a list 
---of expressions. Each of the expressions in the list must evaluate to the same type of 
---data as the test expression

-------Between Operator
/*
You can use the BETWEEN phrase to test whether an expression falls within a 
range of values. The lower limit must be coded as the first expression, and the 
upper limit must be coded as the second expression. Otherwise, the result set will 
be empty. 
*/

SELECT All lnvoiceID,InvoiceDate,InvoiceTotal+VendorID as InvoiceTotal_VendorID,InvoiceName FROM InvoicesTable
WHERE  InvoiceDate between '04-20-2023'and '27-20-2023'
GO

----------------How to use the LIKE operator ------

/*
% Matches any string of zero or more characters. 
Matches any single character. 
[ 1 Matches a single character listed within the brackets. 
- 1 Matches a single character within the given range. 
[ " 1 Matches a single character not listed after the caret.

*/

------------------------Null value -----------

/*
• A null value represents a value that's unknown, unavailable, or not applicable. It 
isn't the same as a zero, a blank space(' '), or an empty string("). 

• To test for a null value, you can use the IS NULL clause. You can also use the NOT 
keyword with this clause to test for values that aren't null.

*/


-------------------How to code the ORDER BY clause 

/*
The ORDER BY clause specifies how you want the rows in the result set sorted. 
You can sort by one or more columns, and you can sort each column in either 
ascending (ASC) or descending (DESC) sequence. ASC is the default. 
*/

  -------------example as An ORDER BY clause that uses an alias
SELECT All lnvoiceID,InvoiceDate,InvoiceTotal+VendorID as InvoiceTotal_VendorID,InvoiceName FROM InvoicesTable
WHERE  InvoiceDate between '04-20-2023'and '27-20-2023'
Order by lnvoiceID ASC
OFFSET 0 ROWS
FETCH FIRST 5 ROWS ONLY
GO

-------
SELECT All lnvoiceID,InvoiceDate,InvoiceTotal+VendorID as InvoiceTotal_VendorID,InvoiceName FROM InvoicesTable
WHERE  InvoiceDate between '04-20-2023'and '27-20-2023'
Order by lnvoiceID ASC
OFFSET 5 ROWS
FETCH NEXT 5 ROWS ONLY
GO
-------
SELECT All lnvoiceID,InvoiceDate,InvoiceTotal+VendorID as InvoiceTotal_VendorID,InvoiceName FROM InvoicesTable
WHERE  InvoiceDate between '04-20-2023'and '27-20-2023'
Order by lnvoiceID ASC
OFFSET 3 ROWS
FETCH NEXT 4 ROWS ONLY
GO
-------------------------we have learned
/*

keyword 
filter 
Boolean expression 
predicate 
expressiOn 
column alias 
substitute name 
string expression 
concatenate 
concatenation operator 
literal value 
string literal 
string constant 
arithmetic expression 
arithmetic operator 
order of precedence 
function 
parameter 
argument 
date literal 
comparison operator 
logical operator 
compound condition 
subquery 
string pattern 
mask 
wildcard 
Full-Text Search 
null value 
nested sort 

*/

----------------------------JOIN FUNCTION------------------
---------------------------How to work with inner joins-----------------
/* Structure of inner function

SELECT select_ list 
FROM table_ l 
[INNER) JOIN table_ 2 
ON join_ condition_ 1 
[[INNER) JOIN table_ 3 
ON join_ condition_ 2] •••

*/

-------------------------example-----------------------------------------------
Select * from InvoicesTable


ALTER TABLE  InvoicesTable
Add InvoiceNames varchar(30)
go
ALTER TABLE  InvoicesTable
Add FullName varchar(30)
----drop table
alter table InvoicesTable
Drop Column FullName
Select * from InvoicesTable
Go

------------create table
Create table InvoicesTableTwo(
InvoiceId INT PRIMARY KEY IDENTITY,
InvoiceName Varchar(30),
VendorID varchar(30),
VendorName Varchar(20),
InvoiceNumber varchar(20),
InvoiceDate VARCHAR(20),
InoviceTotal Varchar(30) 
)

-----insert into data
Insert into InvoicesTableTwo
Values
('Samiul',123,'SonarBank',223345,'20-07-2024',Null),
('Hasan',123,'SonarBank',423345,'21-07-2024',Null),
('Roxy',123,'SonarBank',523345,'22-07-2024',Null),
('Abir',123,'SonarBank',323345,'23-07-2024',Null),
('Sohel',123,'SonarBank',333345,'24-07-2024',Null),
('Rubel',123,'SonarBank',552345,'25-07-2024',Null),
('Cahmak',123,'SonarBank',723345,'26-07-2024',Null),
('CHAMAK',123,'SonarBank',623345,'27-07-2024',Null),
('Ahosan',123,'SonarBank',123345,'28-07-2024',Null),
('Monowar',123,'SonarBank',553345,'29-07-2024',Null),
('Shahin',123,'SonarBank',333345,'10-07-2024',Null),
('Mahin',123,'SonarBank',443345,'07-07-2024',Null),
('Kabir',123,'SonarBank',663345,'09-07-2024',Null),
('Bosir',123,'SonarBank',363345,'08-07-2024',Null)
Go
---Read Data
Select * From InvoicesTableTwo
Go

---create table 3
Create table InvoicesTableThree(
InvoiceId INT PRIMARY KEY IDENTITY,
InvoiceName Varchar(30),
VendorID varchar(30),
VendorName Varchar(20),
InvoiceNumber varchar(20),
InvoiceDate VARCHAR(20),
InoviceTotal Varchar(30) 
)
Insert into InvoicesTableThree
Values
('Samiul',123,'SonarBank',223345,'20-07-2024',Null),
('Hasan',123,'SonarBank',423345,'21-07-2024',Null),
('Roxy',123,'SonarBank',523345,'22-07-2024',Null),
('Abir',123,'SonarBank',323345,'23-07-2024',Null),
('Sohel',123,'SonarBank',333345,'24-07-2024',Null),
('Rubel',123,'SonarBank',552345,'25-07-2024',Null),
('Cahmak',123,'SonarBank',723345,'26-07-2024',Null),
('CHAMAK',123,'SonarBank',623345,'27-07-2024',Null),
('Ahosan',123,'SonarBank',123345,'28-07-2024',Null),
('Monowar',123,'SonarBank',553345,'29-07-2024',Null),
('Shahin',123,'SonarBank',333345,'10-07-2024',Null),
('Mahin',123,'SonarBank',443345,'07-07-2024',Null),
('Kabir',123,'SonarBank',663345,'09-07-2024',Null),
('Bosir',123,'SonarBank',363345,'08-07-2024',Null)
Go

Select * from InvoicesTableThree
Go
-----Join
select I2.InvoiceName,I3.VendorId
From InvoicesTableTwo as I2 inner join
InvoicesTableThree as I3 
ON I2.InvoiceId=I3.InvoiceId

---Left Join
select I2.InvoiceName,I3.VendorName
From InvoicesTableTwo as I2 LEFT JOIN
InvoicesTableThree as I3 
ON I2.InvoiceId=I3.InvoiceId
----Right join
Select I2.InvoiceName,I3.InvoiceDate
From InvoicesTableTwo as I2 Right Join
InvoicesTableThree as I3 
ON I2.InvoiceId=I3.InvoiceId
-------------------Full join
Select I2.InvoiceName,I3.InvoiceDate
From InvoicesTableTwo as I2 Full Outer Join
InvoicesTableThree as I3 
ON I2.InvoiceId=I3.InvoiceId

----Cross join

Select I2.InvoiceID,I3.VendorName
From InvoicesTableTwo as I2 cross join
InvoicesTableThree as I3 


----create another Table

CREATE TABLE Product
(
ProductId INT PRIMARY KEY,
[Name] VARCHAR(30) NOT NULL,
UnitPrice MONEY NOT NULL
)
GO
INSERT INTO Product(ProductId,Name,UnitPrice)
VALUES
(1,'RAM',12000.00),
(2,'ROM',11000.00),
(3,'CPU',10000.00),
(4,'PC',1200.00),
(5,'Monitor',5000.00)
GO

SELECT *
FROM Product
GO

CREATE TABLE SalesSamary
(
Id INT PRIMARY KEY IDENTITY,
Date DATE NOT NULL,
Quantity INT NOT NULL,
ProductId INT REFERENCES Product(ProductId)
)
GO
---insert Data
INSERT INTO SalesSamary
VALUES
(GETDATE(),10,3),
('2022-05-15',3,1),
('2022-05-15',2,2),
('2021-05-16',3,3)
GO
----read data
SELECT *
FROM SalesSamary
GO
SELECT *
FROM Product
GO


-------------------inner join
Select p.Name,s.Quantity
FROM Product as p
INNER JOIN SalesSamary as s
ON p.ProductId=s.ProductId
GO
-------LEFT JOIN
SELECT Product.Name,SalesSamary.Quantity
FROM Product
LEFT JOIN SalesSamary
ON Product.ProductId=SalesSamary.ProductId
GO

--3. RIGHT JOIN
SELECT Product.Name,SalesSamary.Quantity
FROM Product
RIGHT JOIN SalesSamary
ON Product.ProductId=SalesSamary.ProductId
GO
---------Full join
SELECT Product.Name,SalesSamary.Quantity
FROM Product
FULL OUTER JOIN SalesSamary
ON Product.ProductId=SalesSamary.ProductId
GO

--5. CROSS JOIN
SELECT P.Name,S.Quantity
FROM Product P
CROSS JOIN SalesSamary S
GO

-----self join
CREATE TABLE EmployeeName
(
EmpId INT PRIMARY KEY,
Name VARCHAR(30) NOT NULL,
ManId INT NULL
)
GO
--insert data 
INSERT INTO EmployeeName
VALUES
(1,'Rina',3),
(2,'Bina',3),
(3,'Teacher',4),
(4,'CM',5),
(5,'Consultant',NULL),
(6,'ACM',5)
GO


----------------read
SELECT *
FROM EmployeeName
GO

/*
union
inersect
except

*/

Select ProductId
from Product
where ProductId=3
UNION ALL
SELECT Id
from SalesSamary
where ProductId=3
GO
------Intersect
Select ProductId
from Product
where ProductId=3
INTERSECT
SELECT Id
from SalesSamary
where ProductId=3
GO

------EXCEPT
Select ProductId
from Product
where ProductId=3
EXCEPT
SELECT Id
from SalesSamary
where ProductId=3
GO


------How to code subqueries
-----create new table
Create Table VendorTable
(
 InvoiceNumber Int,
 InvoiceId Int  Primary key Identity,
 InoiceName Varchar(30),
 InvoiceDate varchar(30),
 InvoiceTotal Float
 
)
Go


go

---insert into data
Insert Into  VendorTable
values
(122132,'Samiul','15-07-2024',201.20),
(222132,'Hasan','16-07-2024',401.20),
(322132,'Roxy','17-07-2024',301.20),
(122532,'Abir','18-07-2024',601.20),
(122532,'Shihab','19-07-2024',701.20),
(122932,'Pallab','20-07-2024',801.20),
(122832,'Shahin','21-07-2024',321.20),
(922132,'Samiul Hasan','22-07-2024',661.20)
Go
insert into  VendorTable values(922132,'Samiul Hasan','22-07-2024',661.20)
Go


Select * from  VendorTable
Go
-------subquery
Select  InvoiceNumber, InvoiceDate, InoiceName
from  VendorTable
where  InvoiceId in
(Select  InvoiceId 
from   VendorTable
where InvoiceTotal=321.2
)
order by InvoiceDate desc
Go

----example 2
Select InvoiceNumber, InvoiceDate,InoiceName 
From VendorTable
where InoiceName in
(
Select InoiceName from VendorTable
where  InvoiceId=5
)
Group by InoiceName 
order by InvoiceNumber desc
go


------Not in 
Select InvoiceNumber, InvoiceDate,InoiceName 
From VendorTable
where InoiceName  not in
(
Select distinct InoiceName from VendorTable
)
go

----------QUEREY EXAMPL
Select InvoiceNumber, InvoiceDate,InoiceName 
From VendorTable Join SalesSamary On SalesSamary.ProductId=VendorTable.InvoiceNumber
Where  InvoiceId>All
(
Select InvoiceId From VendorTable
where InvoiceNumber<
(
Select Max(InvoiceNumber)
From VendorTable where InvoiceId=4
)
)
Order by InoiceName
Go

-------create table again
Create Table VendorsTable
(
 InvoiceNumber Int,
 InvoiceId Int  Primary key Identity,
 InoiceName Varchar(30),
 InvoiceDate varchar(30),
 InvoiceTotal Float
 
)
Go
----- inset into data vendorstable
Insert Into  VendorsTable
values
(122132,'Samiul','15-07-2024',201.20),
(222132,'Arman','16-07-2024',401.20),
(322132,'Noman','17-07-2024',301.20),
(122532,'Bolivia','18-07-2024',601.20),
(782532,'Shihab','19-07-2024',701.20),
(562932,'Kamran','20-07-2024',801.20),
(632832,'Shahin','21-07-2024',321.20),
(922132,'Samiul Hasan','22-07-2024',661.20)
Go

----read
Select  * From VendorsTable 
Go
-------------------The syntax of a subquery that uses the EXISTS operator
Select InvoiceNumber, InvoiceDate,InoiceName 
From  VendorsTable 
Where Not Exists
(
Select * from VendorTable 
Where   VendorTable.InvoiceNumber=VendorsTable.InvoiceNumber
)
Go

------select clause
Select  Distinct InoiceName,
(Select Max(InvoiceDate) From VendorsTable
Where VendorsTable.InvoiceNumber=VendorsTable.InvoiceNumber 
) AS Latestinfo
FROM VendorsTable
Order BY Latestinfo
Go

----------CTE table relationship
With Summary as
(
Select  InvoiceNumber, InvoiceDate,InoiceName,Sum(InvoiceTotal) as TotalBalance
From VendorsTable Join VendorTable
On  VendorsTable.InvoiceNumber=VendorTable.InvoiceNumber

Group by InvoiceDate,InoiceName
),SummaryTable as
(
Select  InvoiceNumber, InvoiceDate,InoiceName,Sum(InvoiceTotal) as TotalMoney
From VendorTable 
Group by InoiceName
)
Select Summary.InvoiceNumber,Summary.InoiceName,Summary.TotalMoney
From Summary Join SummaryTable ON
SummaryTable.InvoiceNumber=Summary.InvoiceNumber AND
SummaryTable.InoiceName=Summary.InoiceName
ORDER BY Summary.InvoiceDate
Go


---------------How to insert, update, and delete data

/*
The syntax of the SELECT INTO statement 
SELECT select_ list 
INTO table_name 
FROM table_ source 
[WHERE search_ condition] 
[GROUP BY group_by_ list] 
[HAVING search_ condition] 
[ORDER BY order_by_ list] 
*/

/*
The syntax of the INSERT statement for inserting rows selected 
from another table 
INSERT [INTO] table_name [(column_ list)] 
SELECT column_list 
FROM table_source 
[WHERE search_condition]


*/


-------------------How to work with data types 


-------The syntax of the CAST function
--create a new table
Create table Invoices(
InvoiceDate Varchar(20),
InvoiceTotal float,
VarcharDate varchar(20),
IntegerTotal INT,
VarcharTotal Float
)
-------------inseet into data
Drop Table Invoices
Go


Insert into Invoices
Values

('20-07-2024',20.45,'20-06-2024',50,65.45),
('21-07-2024',22.45,'22-06-2024',50,65.45),
('21-07-2024',22.45,'23-06-2024',55,60.45),
('26-08-2024',20.45,'27-06-2024',56,70.45),
('20-07-2024',20.45,'20-06-2024',50,65.45),
('20-07-2024',20.45,'20-06-2024',50,65.45),
('22-07-2024',25.45,'23-06-2024',60,66.45),
('26-06-2024',26.45,'22-06-2024',51,67.45),
('20-07-2024',20.45,'20-06-2024',50,70.45),
('25-07-2024',21.45,'06-06-2024',50,65.45)
Go
---read
Select * From Invoices
Go

Select distinct InvoiceTotal,InvoiceDate,
Cast(InvoiceTotal as varchar)  as varchardate,
cast(InvoiceTotal as int) as Integertotal,
cast(InvoiceDate as varchar) as varchardate 
From Invoices
Go

---------The syntax of the CONVERT function 
Select distinct  CONVERT(varchar,InvoiceDate) as InvoiceInt
from Invoices
Go

-------------Try convert fucntion

Select Try_convert(tinyint,InvoiceTotal,1) as TryconvertInvoiceTotal,
Try_convert(Int,InvoiceTotal,2) as IntInvoiceTotal
From Invoices
Go

---------The syntax of the CONVERT function 
Select CONVERT(varchar,InvoiceTotal,5) as InvoiceVarchar
from Invoices
Go

-------------------How to work with string data 
------------------Function---------------------

/*
LEN(string) ----------Returns the number of characters in the string.
LTRIM(string) ---Returns the string with any leading spaces removed.
RTRIM(string)---Returns the string with any trailing spaces removed. 
TRIM(string) ----Returns the string with any leading and trailing spaces removed
LEFT(string,length) ---Returns the specified number of characters from the beginning of the string.
RIGHT(string,length)--- 
SUBSTRING(string,start,length) --Returns the specified number of characters from the end of the string. 
REPLACE(search,find,replace)--
TRANSLATE(search,find,replace) 
REVERSE(string) 
CHARINDEX(find,search[,start]) 


details
REPLACE(search,find,replace) =Returns the search string with characters in the find 
string replaced with the characters in the replace string

*/



-----------DOL statements to create, modify, and delete objects

/*
CREATE DATABASE 
CREATE TABLE 
CREATE INDEX 
CREATE SEQUENCE 
CREATE FUNCTION 
CREATE PROCEDURE 
CREATE TRIGGER 
CREATE VIEW 
ALTER TABLE 
ALTER SEQUENCE 
ALTER FUNCTION 
ALTER PROCEDURE 
ALTER TRIGGER 
ALTER VIEW 
DROP DATABASE 
DROP TABLE 
DROP SEQUENCE 
DROP INDEX 
DROP FUNCTION 
DROP PROCEDURE 
DROP TRIGGER 
DROP VIEW 

Details:     

Creates a new database. 
Creates a new table in the current database. 
Creates a new index for the specified table. 
Creates a new sequence in the current database. 
Creates a new function in the current database. 
Creates a new stored procedure in the current database. 
Creates a new trigger in the current database. 
Creates a new view in the current database. 
Modifies the structure of the specified table. 
Modifies the attributes of a sequence. 
Modifies the specified function. 
Modifies the specified stored procedure. 
Modifies the specified trigger. 
Modifies the specified view. 
Deletes the specified database. 
Deletes the specified table. 
Deletes the specified sequence. 
Deletes the specified index. 
Deletes the specified function. 
Deletes the specified stored procedure. 
Deletes the specified trigger. 
Deletes the specified view. 


*/


 ----index
 Use InvoiceDB
 GO

 USE InvoiceDB
 GO

 Create CLUSTERED VendorID
 On Invoices (VendorID)
 GO

 -------Sql final exam with soluton

 --1. Write a query to retrieve last 5 those invoices record whose invoice total is equal to the 
--sum of payment total & credit total.

--SOLUTION:
USE AP
Go

Select Top 5*
From Invoices
Where InvoiceTotal=PaymentTotal+CreditTotal
Order By InvoiceDate DESC
GO

--2. Write a query to retrieve those invoices record whose date is later then 01/01/2016 or 
--invoice total is more than 500 and invoice total must be greater than sum of payment total 
--and credit total

--Solution
Select * 
From Invoices
Where (InvoiceDate>'01/01/2016' OR InvoiceTotal>500) AND
InvoiceTotal>(PaymentTotal+CreditTotal)
Go

---3. Write a query to retrieve those invoices whose vendor states are all except ‘CA’, ‘NV’, ‘OR’ 
--and invoice dates are later than 01/01/2016.
SELECT * 
From Invoices, Vendors
Where VendorState Not in('CA', 'NV', 'OR') AND
InvoiceDate>'01/01/2016'
Go

--4. Write a query to retrieve invoices from 01/05/2016 to 31/05/2016
SELECT * 
FROM Invoices
where InvoiceDate BETWEEN '2016-05-01' AND '2016-05-31'
Go

--5. Write a query to retrieve vendors whose vendor city starts with ‘SAN’. 
---Solution
Select *
From Vendors
Where VendorCity Like 'SAN%'
Go
----extra question soleve
---5. Write a query to retrieve vendors whose vendor city ending with ‘SAN’. 
---Solution
Select * From
Vendors
Where VendorCity LIKE '%SAN'
Go

---6. Write a query to retrieve vendors whose contact name has one of the following characters: 
--a, e, i, o, u.
--Solution:

Select *
From Vendors
Where VendorContactFName Like '%[aeiou]'
Go

--7. Write a query to find all vendors whose first letter of state starts with N and the next letter 
--is one of A through J. 
--Solution
Select *
From Vendors
Where VendorState Like 'N[A-Z]%'
Go

---8. Write a query to find all vendors whose first letter of state starts with N and the next letter 
--is not in K through Y
 Select *
 From Vendors
 Where VendorState Like  'N[^K-Y]'
 GO

 --09  Write a query to retrieve 11 through 20 records of vendors.
--Solution
Select *
From Vendors
Where	VendorID Between 11 and 20
GO
---or
Select *
From Vendors
Order By VendorID
OFFSET 10 ROWS FETCH NEXT 10 ROWS ONLY
Go
--10. Write a group query to retrieve invoices those average of invoice total is more than 2000
--Solution
Select InvoiceID,AVG(InvoiceTotal) AS [AVG INVOICE]
From Invoices
GROUP BY InvoiceID
Having AVG(InvoiceTotal)>2000
GO
-----extra solution
Select InvoiceID, AVG(InvoiceTotal) as [average]
from Invoices
Group by InvoiceID
Having  AVG(InvoiceTotal)>2000
Go
--Or
Select InvoiceID,InvoiceDate,InvoiceTotal
From Invoices
Where InvoiceTotal>2000
Go

--11. Give an example of CUBE operator. 
--Solution

Select InvoiceID,SUM(InvoiceTotal) as TotalMoney
From Invoices
GROUP BY CUBE(InvoiceID)
GO

--12. Give an example of ROLLUP operator. 

Select VendorID,InvoiceDate,Sum(InvoiceTotal) as RollupF
From Invoices
Group By RollUP(VendorID,InvoiceDate)
GO

--13. Give an example of GROUPING SETS operator.
--Solution
Select VendorID,InvoiceDate,Sum(InvoiceTotal) as SETupF
From Invoices
GROUP BY GROUPING SETS ((VendorID),(InvoiceDate),(VendorID,InvoiceDate))
GO
------MoreEver
SELECT VendorID,InvoiceDate,Sum(InvoiceTotal) as SetFunction
From Invoices
group by Grouping sets((VendorID),(InvoiceDate),(VendorID,InvoiceDate))
Go


---14. Give an example of OVER clause. 
Select VendorID,InvoiceDate,Sum(InvoiceTotal) over(partition by VendorID order by VendorID) as OverP
FROM Invoices
Go

--15. Write a subquery to retrieve vendors who have invoices.
SELECT *
FROM Vendors
where exists
(
Select 1
FROM Invoices
WHERE Invoices.VendorID=Vendors.VendorID
)
GO
-----More example
SELECT *
FROM Vendors
WHERE EXISTS
(
select 5
FROM Invoices
where Invoices.VendorID=Vendors.VendorID
)
Go

---16. Give an example of ANY keyword.

SELECT *
FROM Invoices
WHERE InvoiceTotal>ANY
(
SELECT PaymentTotal
From Vendors
)
Go
--------17. Give an example of ALL keyword.

SELECT * 
FROM Invoices
where InvoiceTotal>ALL(
SELECT PaymentTotal
From Vendors
)
Go

-----18. Give an example of SOME keyword.
SELECT *
FROM Invoices
where InvoiceTotal>some(
SELECT PaymentTotal
From Vendors

)
Go

---------19. Give an example of correlated subquery. 
Select *,
(
SELECT COUNT(*)
FROM Invoices as I
WHERE I.VendorID=V.VendorID
)
FROM Vendors as V
Go

-----example
Select *,
(
SELECT Count(*)
From Invoices AS I
WHERE I.VendorID=V.VendorID

)
FROM Vendors AS V
GO

---20. Give an example of EXISTS operator.

SELECT *
FROM Invoices as I
where exists
(
Select *
FROM Vendors AS V
WHERE V.VendorID=I.VendorID

)

GO

----21. Give an example on CTE. 
with InvoiceCTE
AS
(
Select * FROM Invoices
Where TermsID=1
)
SELECT *
FROM  InvoiceCTE 


---
WITH CTE AS
(
SELECT * FROM Invoices
Where TermsID=2

)
SELECT * FROM  CTE
GO


-------22. Insert a vendor record.
SET IDENTITY_INSERT Vendors ON;
INSERT INTO Vendors
(
VendorID,VendorName,VendorCity,VendorState,VendorZipCode,VendorContactFName
)
Values(1001,'ABC Company','Dhaka','CA','94105','Samiul Hasan')
GO
SET IDENTITY_INSERT Vendors OFF

-----23. Delete a vendor record.
DELETE FROM Vendors
WHERE VendorName=205
GO

----24. Write a code to merge two rows.
--CREATE MyTable TABLE 
CREATE TABLE MyTable (
    ID INT PRIMARY KEY,
    Name NVARCHAR(50),
    Age INT
);
INSERT INTO MyTable
VALUES 
(1, 'John', 30),
(2, 'Jane', 25)
GO
----create a new table for merge opreation
CREATE TABLE NewTable (
    ID INT PRIMARY KEY,
    Name NVARCHAR(50),
    Age INT
);
INSERT INTO NewTable

VALUES 
(10, 'Mimma', 06),
(20, 'Shihan', 05)
GO
----------------Merge operation


MERGE MyTable as Target
Using NewTable as Source
ON Target.ID=SOURCE.ID
WHEN NOT MATCHED THEN
INSERT (ID,Name,Age)
VALUES(SOURCE.ID,SOURCE.Name,Source.Age);
GO

SELECT * FROM MyTable
GO
SELECT * FROM NewTable
GO
-------25. CASE function
SELECT InvoiceTotal,
case
    WHEN InvoiceTotal>1000 THEN 'HIGH' 
	WHEN InvoiceTotal>500  THEN 'MEDIUM'
	ELSE 'LOW'
END
FROM Invoices
GO
--------26. IIF and CHOOSE functions
USE AP
GO

SELECT VendorID,
IIF(VendorState='CA','California','others') as Statec,
CHOOSE(VendorID,'John','Mary','David') as Country
From Vendors
GO
----27. COALESCE and ISNULL functions












































