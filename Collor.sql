
CREATE DATABASE InventoryDB
ON
(
	NAME='InventoryDB _Data_1',
	FILENAME='C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\InventoryDB _Data_1.mdf',
	SIZE=25MB,
	MAXSIZE=100,
	FILEGROWTH=5%
)
LOG ON
(
	NAME='InventoryDB _Log_1',
	FILENAME='C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\InventoryDB _Log_1.ldf',
	SIZE=2MB,
	MAXSIZE=50,
	FILEGROWTH=1MB
)
GO
---USE DATABASE
USE InventoryDB
GO

CREATE TABLE Colors(ColorId INT PRIMARY KEY  NOT NULL,
ColorName VARCHAR (30) NOT NULL)
GO
CREATE TABLE ItemTypes
(
	ItemTypeId INT PRIMARY KEY,
	ItemTypeName VARCHAR(30) NOT NULL
)
GO

CREATE TABLE ITEMDETAILS
(ItemId INT PRIMARY KEY NOT NULL,
IteamName VARCHAR (30) NOT NULL,
ColorId INT REFERENCES Colors (ColorId),ItemTypeId
 INT REFERENCES ItemTypes (ItemTypeId))
GO
CREATE TABLE Lots
(LotId INT PRIMARY KEY NOT NULL,
LotName VARCHAR (30)NOT NULL)
GO
CREATE TABLE LotDetails
(Quantity INT NOT NULL,
UnitPrice MONEY NOT NULL,
Vat FLOAT NOT NULL,
LotId INT REFERENCES Lots(LotId),
ItemId INT REFERENCES ITEMDETAILS(ItemId)
)
GO
INSERT INTO Colors
VALUES(1,'Red'),
(2,'Blue')
GO
INSERT INTO ItemTypes
VALUES (1,'Camp Shirt'),
(2,'Dress Shirt'),
(3,'T-Shirt'),
(4,'Polo Shirt')
GO
INSERT INTO ITEMDETAILS
VALUES (1,'Item 1',1,1),
(2,'Item 2',2,1),
(3,'Item 3',1,2),
(4,'Item 4',2,2),
(5,'Item 5',1,3),
(6,'Item 6',2,3),
(7,'Item 7',1,4),
(8,'Item 8',2,4)
GO
INSERT INTO Lots
VALUES (1,'Lot 1'),
(2,'Lot 2')
GO
INSERT INTO LotDetails
VALUES(6,1100.00,15,1,1),
(6,12000.00,15,1,2),(6,13000.00,15,1,3),(6,1400.00,15,1,4),
(6,1500.00,15,1,5),(6,1600.00,15,1,6),
(6,1700.00,15,1,7),(6,1800.00,15,1,8),
(12,1150.00,15,2,1),
(12,1250.00,15,2,2),
(12,1350.00,15,2,3),(12,1450.00,15,2,4),
(12,1550.00,15,2,5),
(12,1650.00,15,2,6),
(12,1750.00,15,2,7),
(12,1850.00,15,2,8)
GO
SELECT * FROM Colors
SELECT * FROM ItemTypes
SELECT * FROM ITEMDETAILS
SELECT * FROM Lots
SELECT * FROM LotDetails
GO
--SCALAR FUNCTION
CREATE FUNCTION S_FUNCTION ()
RETURNS INT
AS
BEGIN
DECLARE @COUNT INT
SELECT @COUNT=(SELECT SUM (UnitPrice*Quantity)as 'Total' FROM LotDetails)
RETURN @COUNT
END
GO
SELECT dbo.S_FUNCTION ()
GO
--TABLE VALUE--
CREATE FUNCTION FU_TABLE()
RETURNS TABLE
AS
RETURN
(SELECT ItemId ,SUM (UnitPrice*Quantity)as 'Total' FROM LotDetails
GROUP BY ItemId)
GO
SELECT * FROM dbo.FU_TABLE()
GO
--MULTI TABLE FUNCTION--
CREATE FUNCTION FU_MULTI()
RETURNS @DETAILS
TABLE (LotId INT,ExLotId INT,UnitPrice MONEY)
AS
BEGIN
INSERT INTO @DETAILS(LotId,ExLotId,UnitPrice)
SELECT LotId,LotId+100 ,UnitPrice FROM LotDetails
RETURN
END
GO
SELECT * FROM DBO.FU_MULTI()
GO
--RAISERROR TRIGGER--
CREATE TABLE Usingtrigger
(TryDeleteId INT IDENTITY(1,1),
ColorId INT,
ColorName VARCHAR(50))
GO

CREATE TRIGGER Tr_Color
ON Colors
INSTEAD OF DELETE
AS
BEGIN
DECLARE @ColorId INT
SELECT @ColorId=DELETED.ColorId 
FROM DELETED 
IF @ColorId=1
BEGIN
RAISERROR ('can not delete',16,1)
ROLLBACK
INSERT INTO Usingtrigger
VALUES (@ColorId,'Invalid')
END
ELSE 
BEGIN 
DELETE Colors
WHERE @ColorId=ColorId
INSERT INTO Usingtrigger
VALUES (@ColorId,'Delete')
END
END
GO
DELETE Colors
WHERE ColorId=1
SELECT * FROM Usingtrigger
GO
--TRANSACTION WITH SP--
CREATE PROCEDURE SP_InstantSearch
(@ItemTypeId INT,
@ItemTypeName VARCHAR (50),
@StatementType VARCHAR (40))
AS
IF @StatementType='SELECT'
BEGIN 
SELECT * FROM ItemTypes
END
IF @StatementType='INSERT'
BEGIN
INSERT INTO ItemTypes (ItemTypeId,ItemTypeName)
VALUES (@ItemTypeId,@ItemTypeName)
END
IF @StatementType='UPDATE'
BEGIN 
UPDATE ItemTypes
SET ItemTypeName=@ItemTypeName
WHERE ItemTypeId=@ItemTypeId
END
IF @StatementType='DELETE'
BEGIN
DELETE ItemTypes
WHERE ItemTypeId=@ItemTypeId
END
EXECUTE SP_InstantSearch '5','Jeans','INSERT'
EXECUTE SP_InstantSearch '5','Pants','UPDATE'
EXECUTE SP_InstantSearch '5','Jeans','SELECT'
EXECUTE SP_InstantSearch '5','Jeans','DELETE'


SELECT * FROM ItemTypes
GO
--VIEW WITH ENCRPTION,SCHEMABINDING--
CREATE VIEW sim_view
WITH ENCRYPTION,SCHEMABINDING
AS
SELECT 
Colorid,ColorName FROM dbo.Colors
GO
SELECT * FROM sim_view
EXEC SP_HELPTEXT 'sim_view'
GO