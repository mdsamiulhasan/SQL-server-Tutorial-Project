-- Create database

CREATE DATABASE InventoryDB
ON PRIMARY
(
    NAME = 'InventoryDB_Data_1',
    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\InventoryDB\InventoryDB_Data_1.mdf',
    SIZE = 25MB,
    MAXSIZE = 100MB,
    FILEGROWTH = 5MB
)
LOG ON
(
    NAME = 'InventoryDB_Log_1',
    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\InventoryDB\InventoryDB_Log_1.ldf',
    SIZE = 2MB,
    MAXSIZE = 50MB,
    FILEGROWTH = 1MB
);
GO
---use database
USE InventoryDB
Go

Create table Color
(
Colorid int primary key,
Colorname varchar (30)
)
Create table lots
(
lotno int primary key,
quantity int

)
Create table items
(
itemno int primary key,
itemname varchar (50),
colorid int references color(colorid)
)
Create table itemdetails
(
itemno int references items(itemno),
lotno int references lots(lotno),
unitprice money,
vat numeric(8,5)
)


----Insert value color table
insert into color
values(1,'Red'),
(2,'Blue')
----Insert value lots table
insert into lots
values(1,6),
(2,12)
Select * from lots
-------Insert value items table
insert into items
values(1,'Denim Shirt',1),
(2,'Denim Shirt',2),
(3,'Champ Dress',1),
(4, 'Champ Dress',2),
(5,'T-Shirt',1),
(6,'T-Shirt',2),
(7,'Polo Shirt',1),
(8,'Polar Shirt',2)
------insert value item details
Insert into itemdetails
values(1,1,1100,0.15),
(2,1,1200,0.15),
(3,1,1300,0.15),
(4,1,1400,0.15),
(5,1,1500,0.15),
(6,1,1600,0.15),
(7,1,1700,0.15),
(8,1,1800,0.15),
(1,2,1150,0.15),
(2,2,1250,0.15),
(3,2,1350,0.15),
(4,2,1450,0.15),
(5,2,1550,0.15),
(6,2,1650,0.15),
(7,2,1750,0.15),
(8,2,1850,0.15)
Go
------------CREATE VIEW
CREATE VIEW Viewas
WITH ENCRYPTION,SCHEMABINDING
AS
SELECT itemno FROM dbo.items
Go
SELECT * FROM Viewas
GO

--CREATE LOG TABLE
CREATE TABLE Log_file
(
logid int identity,
Itemno int,
Itemname varchar (30)
)
Go
----USING TRIGGER
CREATE TRIGGER usetrigger
on Items
instead of delete
as
begin
Declare @Itemno int
select @Itemno=deleted.Itemno
from deleted

if @Itemno=1
begin
raiserror ('can not deleted',16,1)
rollback
insert into Log_file values(@Itemno,'Invalid')
end

Else
begin 
delete items
where @Itemno=Itemno
insert into Log_file values(@Itemno,'Delete')
end
end
Delete items
where Itemno=1
----read data
Select * from Log_file
Go
Select * from items
Go
---Sclar function
Create Function Fn_Sclar()
returns int 
begin
declare @Count int
Select @Count=count(*) from itemdetails
return @Count
end
Go

Select dbo.Fn_Sclar();
Go
-------Table valued
Create function Fn_table()
returns table
return (Select * from items)
Go
Select* from Fn_table()
Go
------Multi table fuction
Create Function Fn_MultiFunction()
Returns @table
Table (itemno int,exitemno int,itemname varchar(30))
Begin
insert into @table(itemno,exitemno,itemname)
Select itemno,itemno+100,itemname
from items
return
end
GO
Select * From Fn_MultiFunction()
Go