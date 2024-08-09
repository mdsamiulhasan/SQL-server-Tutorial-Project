-----Creater Database
Create Database InventoryDB
ON PRIMARY(
NAME=InventoryDB_Data_1,
FILENAME= 'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\InventoryDB_Data_1.mdf',
SIZE=25MB,
MAXSIZE=100,
FILEGROWTH=5%
)
LOG ON(
NAME=InventoryDB_Log_1,
FILENAME= 'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\InventoryDB_Log_1.ldf',
SIZE=25MB,
MAXSIZE=50,
FILEGROWTH=1MB
)
GO
----Use Database
USE InventoryDB
GO

----Create Table Colors
Create Table Lot
(
	LotId INT PRIMARY KEY,
	LotNo NVARCHAR(30) NOT NULL,
	Quantity INT NOT NULL,
	UnitPrice MONEY NOT NULL,
	Vat FLOAT NOT NULL
)
Go

---Create Table  Colors
Create Table Color
(
ColorId Int Primary key,
ColorName Varchar(30) Not Null
)
GO
----Create Table Items
Create Table Item
(
    ItemId INT PRIMARY KEY,
	ItemNo NVARCHAR(20) NOT NULL,
	ItemName NVARCHAR(30) NOT NULL,
	ColorId INT NOT NULL REFERENCES color(colorid),
	LotId INT NOT NULL REFERENCES lot(lotid)

)
Go

-----Insert data into Colors
Insert Into Color
Values
(1, 'Red'),
(2, 'Blue'),
(3, 'Pink'),
(4, 'Green'),
(5, 'White')
GO
---insert into value in Lot
Insert into Lot 
Values
(1, 'Lot 1', 6, 1200.00, .15),
(2, 'Lot 1', 6, 1250.00, .15),
(3, 'Lot 1', 6, 1300.00, .15),
(4, 'Lot 2', 12, 1350.00, .15),
(5, 'Lot 2', 12, 1400.00, .15),
(6, 'Lot 2', 12, 1500.00, .15)
GO

---Insert into data Item table
Insert into Item
Values
(1, 'Item 1', 'T-Shirt', 1, 1),
(2, 'Item 2', 'T-Shirt', 2, 1),
(3, 'Item 3', 'Dress Shirt', 1, 3),
(4, 'Item 4', 'Dress Shirt', 2, 3),
(5, 'Item 5', 'Polo-Shirt', 1, 4),
(6, 'Item 6', 'Polo-Shirt', 2, 4),
(7, 'Item 7', 'Camp Shirt', 1, 5),
(8, 'Item 8', 'Camp Shirt', 2, 5)
GO
---READ
Select *
From Item
Go

Select * From Color
Go

Select * From lot
Go
------Create View 
Create View vItemRed
With Encryption,Schemabinding
As
Select i.itemno, i.itemname, c.colorname, l.lotno, l.quantity, l.unitprice, 
	CAST(l.vat*100 as VARCHAR)+'%' 'vat'
FROM dbo.item i
INNER JOIN dbo.color c ON i.colorid = c.colorid
INNER JOIN dbo.lot l ON l.lotid = i.lotid
GO
SELECT * FROM vItemRed
GO 
Exec sp_helptext 'vItemRed'
GO

-------Case Function
Select itemno, colorid,
	Case colorid
		When 1 Then 'RED'
		When 2 Then 'BLUE'
		Else 'Green'
	END AS color
FROM item
GO

------IIF

Select ItemId, 
	IIF(ItemName='T-Shirt','Shirt','Other') Item,
	CHOOSE(ItemId,'One','Two','Three')
From Item
Go
------ii
Select ItemId,
	COALESCE(ItemName,'OTHER'),
	ISNULL(ItemName,'PANT')
From Item
GO



Select ColorName,
	COUNT(ColorId) AS 'Number',
	GROUPING(ColorName) AS 'Super Grouping'
From Color
Group BY ColorName WITH ROLLUP
GO
--OR
SELECT colorid, colorname, COUNT(*) AS Color
FROM color
Group BY GROUPING SETS (colorid, colorname)
GO

--v
--RANKING FUNCTION: ROW_NUMBER, RANK, DENSE_RANK, NTILE
Select colorname, Row_Number() OVER(ORDER BY colorid) As ROW_RANK
From color
GO
Select colorname, Rank() OVER(ORDER BY colorid) As RANKS
From color
GO
Select colorname, Dense_Rank() OVER(ORDER BY colorid) As DENSE_RANKS
From color
GO
Select colorname, NTile(3) OVER(ORDER BY colorid) As ROW_RANK
From color
Go
--OR
SELECT c.colorname, 
COUNT(i.itemid) OVER (PARTITION BY c.colorname) 'count',
ROW_NUMBER() OVER (ORDER BY c.colorname) 'row number',
RANK() OVER (ORDER BY c.colorname) 'rank',
DENSE_RANK() OVER (ORDER BY c.colorname) 'dense rank',
NTILE(2) OVER (ORDER BY c.colorname) 'ntile'
FROM dbo.item i
INNER JOIN dbo.color c ON i.colorid = c.colorid
GO
GO
--vi