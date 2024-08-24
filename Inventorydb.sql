--CREATE DATABASE
IF OBJECT_ID('InventoryDB','DB') IS NOT NULL
Drop Database InventoryDB
Go
------
Create database InventoryDB
on
(
	name=CollegeDB_Data,
	FileName='C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\CollegeDB_Data.mdf',
	Size=25mb,
	Maxsize=100mb,
	FileGrowth=5%
)
log on
(
	name=CollegeDB_Data_Log,
	FileName='C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\CollegeDB_Data_log.ldf',
	Size=2mb,
	Maxsize=25mb,
	FileGrowth=1%
)
Go
----use dataabse
use InventoryDB
Go

if object_id('Teacher') is not null
Drop table Teacher
Go
Create table Teacher
(
	TeacherId int primary key nonClustered not null ,
	TeacherName varchar (30) 
)
Go
----stdent table
if object_id('Student') is not null
Drop table Student
Go
Create table Student
(
	StudentId int primary key not null,
	StudentName varchar (30)
)
Go
---Semester table
if object_id('Subjects') is not null
Drop table Subjects
Go
Create table Semester
(
	SemesterId int primary key not null,
	SemesterName varchar (30)
)
Go
-----create subject table
if object_id('Subjects') is not null
Drop table Subjects
Go
Create table Subjects
(
	SubjectId int primary key not null,
	SubjectName varchar (30)
)
Go
------Create relation tabel
if object_id('Relation') is not null
Drop table Relation
Go
create table Relation
(
RelationId int primary key identity(1,1),
TeacherId int references Teacher(TeacherId),
StudentId int references Student(StudentId),
SemesterId int references Semester(SemesterId),
SubjectsId int references Subjects(SubjectId),
)
Go
--insert into data



Insert into Teacher
values (1,'A'),(2,'B'),(3,'C')
Go
Insert into Student
values (1,'AA'),(2,'BB'),(3,'CC'),(4,'DD'),(5,'EE'),(6,'FF'),(7,'GG'),(8,'HH'),(9,'II')
go
INSERT INTO Semester
Values (1,'Spring'),(2,'Summer'),(3,'Fall'),(4,'Winter')
Go
Insert into Subjects
values 
(1,'C#'),(2,'Database'),(3,'Web Design'),(4,'Data Mining'),
(5,'MIS'),
(6,'PHP'),
(7,'Project Manager'),
(8,'PCL'),
(9,'Software Engineering')
GO
Insert into Relation(TeacherId,StudentID,SemesterID,SubjectsId)
Values 
(1,1,1,1),
(1,2,1,1),
(1,4,1,1),
(2,1,1,2),
(2,3,1,2),
(2,9,1,2),
(3,9,1,3),
(3,8,1,3),
(3,5,1,3),
(3,7,1,3),
(1,5,2,1),
(1,7,2,1),
(2,2,2,4),
(2,9,2,4),
(2,8,2,4),
(3,1,2,5),
(3,2,2,5),
(3,3,2,5),
(1,8,3,6),
(1,9,3,5),
(2,5,3,2),
(2,7,3,2),
(2,4,3,2),
(2,5,3,2),
(2,7,3,2),
(1,3,4,8),
(1,6,4,8),
(3,1,4,3),
(3,3,4,3),
(3,4,4,3)
GO
SELECT * FROM Teacher
SELECT * FROM Student
SELECT * FROM Semester
SELECT * FROM Subjects
SELECT * FROM Relation
Go

---crate view
Create view simple_view
as
Select TeacherId,TeacherName
From Teacher
--read
Select * FROM simple_view
Go
---view with encryption and schema
Create view Sam_View 
with encryption,schemabinding
as
Select TeacherId,TeacherName
FROM dbo.Teacher
Go
--READ
Select * from dbo.Sam_View
Go

-----index
Create nonclustered index Sam
On Student(StudentName)
Go

----sequence
Create sequence dbo.Seq
start with 1
increment by 1
Minvalue 1
Maxvalue 2
cycle
Go
---READ
Select  Count(*) as TotalRows FROM Teacher
Go


-----create function
IF OBJECT_ID('ScalarFu','FN') IS NOT NULL
DROP function ScalarFu
Go
Create Function ScalarFu()

returns int
as
begin
declare @Count int
select @Count=Count(*) 
from dbo.Teacher
return @Count
end
Go
---read
SELECT dbo.ScalarFu() AS Teacherroew;
GO
----Table value function

create function multifu()
returns table
as
return 
(Select * from Teacher)
Go
---read
Select * from dbo.multifu()
Go
----------Multitable value function
Create function mul_Fu()
returns @table
table(TeacherId int, ExTeacherId int,TeacherName
varchar(30))
begin
insert into @table(TeacherId,ExTeacherId,TeacherName)
Select TeacherId,TeacherId+20,TeacherName from Teacher
return
end
Go
Select * from dbo.mul_Fu()
Go

----function reagain
create function multifunciton()
returns @table
table(SemesterId int,exSemesterId int,SemesterName varchar(30))
begin
insert into @table(SemesterId,ExSemesterId,SemesterName)
Select SemesterId,SemesterId+20,SemesterName from Semester
RETURN
END
Go
---read
Select * from dbo.multifunciton()
Go

----triggrt
Create table Logtable
(
LogId int Primary key identity(1,1),
TeacherId int,
TeacherName varchar(30)

)
Go
---crate trigger
Create trigger Tr_newtr
On Teacher
instead of delete
as
begin
declare @TeacherId INT
Select @TeacherId=deleted.TeacherId
from deleted
if @TeacherId=2
begin
raiserror ('can not permission',16,1)
rollback
insert into Logtable
values(@TeacherId,'invalid')
end
else 
begin
delete Logtable
insert into Logtable
values(@TeacherId,'delete')
end
end
----update
update Teacher
set TeacherName='Samiul'
where TeacherId=2
Go
---delete
delete Teacher
where TeacherId=1
Go

delete Teacher
where TeacherId=3
Go
----select

Select * from Teacher
GO
Select * from Logtable
Go

-----Store Procedure
CREATE PROCEDURE storeprocedure
(
    @TeacherId INT,
    @TeacherName VARCHAR(30),
    @Statement VARCHAR(30) = '',
    @Status VARCHAR(30) OUTPUT
)
AS
BEGIN
    IF @Statement = 'Select'
    BEGIN
        SET @Status = 'Selected';
        SELECT * FROM Teacher;
        RETURN;
    END

    IF @Statement = 'Insert'
    BEGIN
        INSERT INTO Teacher (TeacherId, TeacherName)
        VALUES (@TeacherId, @TeacherName);
        SET @Status = 'Inserted';
        SELECT * FROM Teacher;
        RETURN;
    END

    IF @Statement = 'Update'
    BEGIN
        UPDATE Teacher
        SET TeacherName = @TeacherName  
        WHERE TeacherId = @TeacherId; 
        SET @Status = 'Updated';
        SELECT * FROM Teacher;
        RETURN;
    END

    IF @Statement = 'Delete'
    BEGIN
        DELETE FROM Teacher  
        WHERE TeacherId = @TeacherId; 
        SET @Status = 'Deleted';
        SELECT * FROM Teacher;
        RETURN;
    END
END
GO

-- View
DECLARE @Status VARCHAR(30);

EXEC storeprocedure 
    @TeacherId = NULL,
    @TeacherName = NULL,
    @Statement = 'Select',
    @Status = @Status OUTPUT;

-- Check Status
SELECT @Status AS Output_Parameter;

-- Update
EXEC storeprocedure 
    @TeacherId = 3,
    @TeacherName = 'Samiul',
    @Statement = 'Update',
    @Status = @Status OUTPUT;

--view
SELECT @Status AS Output_Parameter;

-- Delete
EXEC storeprocedure 
    @TeacherId = 1,
    @TeacherName = NULL,
    @Statement = 'Delete',
    @Status = @Status OUTPUT;

--view
SELECT @Status AS Output_Parameter;




















