-----Evidence -1
---A

Exec sp_helpdb
GO

----B
CREATE DATABASE ESAD
GO
---C
EXEC sp_helpdb 'ESAD';

USE master
GO

DROP DATABASE ESAD
GO
-----evidence 2
------A

CREATE DATABASE T_SQL
ON(
NAME=mydatabase,
FILENAME='C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA/ESAD_data1.mdf',
SIZE=10MB,
MAXSIZE=100MB,
FILEGROWTH=10%
)
LOG ON(
NAME=ESAD_log,
FILENAME='C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA/‘ESAD_data1.ldf',
SIZE=10MB,
MAXSIZE=100MB,
FILEGROWTH=10%

)
GO
---2B
--CHANGE DATA IN DATABASE
ALTER DATABASE ESAD
MODIFY FILE(NAME='mydatabase', 
SIZE=20MB)
GO

--ALTER DATABASE 
--2(C)
ALTER DATABASE ESAD
ADD FILE
(
NAME=ESADR_data1,
FILENAME='C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA/‘ESAD_data1.mdf',
SIZE=5MB
)
GO

ALTER DATABASE ESAD
MODIFY FILE
(NAME='ESADDATA_1',
SIZE='20MB')
modify name=TraineeDB
GO

---RENAME DATABASE
EXEC sp_renamedb 'TraineeDB','ESAD'
GO

---evidencce 3
if exists
(
select *from sysobjects
where name ='Trainees' and xtype='U'

)
drop table Trainess
go

drop table Trainees
go

create table Trainees
(
traineeid char(7)  check (traineeid like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]') primary key,
traineename varchar(50) not null,
batch varchar(20) not null


)
go
insert into Trainees values ( '1023338777', 'Ruhul', 'ESAD-R10')
insert into Trainees values ( '1023335789', 'Amin', 'ESAD-R10')
go

exec sp_helpconstraints 'Trainees'
go

--4c

check (traineeid ' '


---create table 5a

create table tsps
(
tspid int identity primary key,
tspname varchar(50)
)
go

create table Trainees
(
traineeid int identity primary key,
traineename varchar(50) not null,
tspid int ,
foreign key(tspid) references tsps(tspid)
)
go

insert into tsps(tspname) values ( 'BITL')
insert into tsps(tspname) values ( 'MCIT')
go
insert into Trainees ( traineename, tspid ) values ( 'Habib', 1)
insert into Trainees ( traineename, tspid ) values ( 'Ave', 1)
insert into Trainees ( traineename, tspid ) values ( 'Javed', 2)
go


select * from Trainees
select * from tsps
go

-----create new data
create table persons(
personid int identity(100,5),
[person name] varchar(30),
foreign key(personid) references Trainees(tspid)
)
go

insert into persons
values
('kamal'),
('jamal'),
('ramal')
go

select *from persons
go

drop table solution7
go
---create retable

create table solution8
(
c1 int identity(1,1) ,
c2 uniqueidentifier rowguidcol default newid(),

)
go

insert solution8 default values
insert solution8 default values
insert solution8 default values
insert solution8 default values
insert solution8 default values
go
select *from solution8
go


set identity_insert solution8 on
insert into solution8(c1) values(250)
set identity_insert solution off
go


select @@identity as 'last value in c1'
select ident_current('solution8') as 'last valaue in c1'
go

--8
create table Contacts
(
ContactID int not null,
ContactName varchar(30) not null
)
go

alter table contacts
alter column ContactName varchar(50) not null
go

--add column
alter table contacts
add  ContactTel varchar(12) null
alter table contacts 
add Contactcell varchar(16) null
go


insert into Contacts( contactId, ContactName, ContactCell) values( 1, 'Quazi Ashique',
'0172889933' )
-- insert into contacts values( 1, 'Quazi Ashique', null, '0172889933' )
-- will do the same
insert into contacts values( 2, 'Hasinur Shahid', '805098', '0152980890' )
insert into Contacts( contactId, ContactName, ContactCell) values( 3, 'Mir Mosharaf',
'0181076543' )
insert into Contacts( contactId, ContactName) values( 3, 'Shaheen akter' )
go
/*
solution 8E
*/

alter table contacts 
add ContactAddress varchar(100) not null default 'Not available'
go

select *from contacts
go

--evidence 9

use ESAD
GO

create table Books
(
[name] char(30) not null,

publisher varchar(30) not null Default 'N/A',
price money,
publish smalldatetime,
currentedition int not null default 1,
available bit not null default 0
)
go

--INSERT DATA
insert into books values( 'Programming Practice', 'Show&Tell Consulting', 600, '2004-01-
01', 3, 1 )

insert into books values( 'Introducing C#', 'Show&Tell Consulting', 700, '2003-01-01', 4,
0 )
insert into books values( 'SQL Server 2000', 'BPB', 1000, '2002-01-01', 2, 1 )
insert into books ( [name], price ) values ( 'XML', 700 )
go

select * from books
go
--9

Create Table Expenses
(
date smalldatetime not null ,
item varchar(40) not null,
price money not null,
quantity int not null,
amount as price*quantity
)
go

insert into Expenses ( [date], item, price, quantity )
values ( getdate(), -- today
'Travel Bag',
450,
1 )
insert into Expenses ( [date], item, price, quantity )
values ( getdate(), -- today
'Punjabi',
250,
2)
insert into Expenses ( [date], item, price, quantity )
values ( getdate(), -- today
'Tooth brush',
15,
3 )
go


select * from expenses
go

---11

create table Orders
(
orderid int identity(1,1) not null primary key,
orderdate smalldatetime not null  default getdate(),
-- constraint name is optional, but you need to drop it later
-- you can use this name to drop
-- otherwise you have to find the name given by sql server
productid int not null,
quantity int not null check( quantity > 0 ),
shipdate smalldatetime,
check ( shipdate > orderdate ) -- it cant not defined in column level
-- it refers two coulms
)
go

alter table Orders
add constraint pk_Orders default dp for orderdate
go

EXEC sp_helpconstraint 'orders'
go

alter table Orders
drop constraint df_o_date
go


----12

create table Orderss
(
orderid int identity(1,1) not null,
orderdate smalldatetime ,
productid int not null,
quantity int not null,
shipdate smalldatetime,)
go

---orderid
alter table Orderss
add constraint  pk_orderid
primary key (orderid)
go

alter table Orderss
add constraint chk_quantity
check(quantity>0)
go


alter table Orderss
add constraint df_orderdate
default getdate() for OrderDate
go

select *from Orderss
go

----relationship
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

insert into categories values ( 1, 'Beverages' )
insert into categories values ( 2, 'Condiments' )
insert into categories values ( 3, 'Confections' )
go

insert into products values ( 1, 'Chai', 1, 18.00 )
insert into products values ( 2, 'Chang', 1, 19.00 )
insert into products values ( 3, 'Chef Anton''s Cajun Seasoning', 2, 10.00 )-- for '

insert into products values ( 4, 'Aniseed Syrup', 2, 22.00 )
insert into products values ( 5, 'Chef Anton''s Gumbo Mix ', 2, 21.00 )
insert into products values ( 6, 'Grandma''s Boysenberry Spread ', 2, 25.00 )
go