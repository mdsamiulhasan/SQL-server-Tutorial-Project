USE AP;
GO

-- Creating the first stored procedure SP_IN
CREATE PROCEDURE SP_IN
(
    @AccountNo INT OUTPUT
)
AS
BEGIN
    SELECT @AccountNo = COUNT(*)
    FROM GLAccounts;
END;
GO

-- Executing the SP_IN stored procedure
DECLARE @Count INT;
EXEC SP_IN @AccountNo = @Count OUTPUT;
PRINT @Count;  -- This will print the count of records in GLAccounts
GO

-- Creating the second stored procedure SP_Return
CREATE PROCEDURE SP_Return
(
    @AccountNo INT
)
AS
BEGIN
    SELECT AccountNo, AccountDescription
    FROM GLAccounts
    WHERE AccountNo = @AccountNo;
END;
GO

-- Executing the SP_Return stored procedure
DECLARE @return_value INT;
EXEC @return_value = SP_Return @AccountNo = 500;
GO


------SP Select Insert UpdateDelete------ 
create proc Sp_SelectInsertUpdateDelete
(@AccountNo int,
@AccountDescription varchar(100),
@StatementType varchar(20)='')
as
if @StatementType='Select'
begin
select * from GLAccounts
end
if @StatementType='Insert'
begin
insert into GLAccounts(AccountNo,AccountDescription)
values(@AccountNo,@AccountDescription) 
end
if @StatementType='Update'
begin
update GLAccounts set AccountDescription=@AccountDescription
where @AccountNo=AccountNo
end
if @StatementType='Delete'
begin
Delete GLAccounts 
where @AccountNo=AccountNo
end

exec Sp_SelectInsertUpdateDelete '633','USSl','Select'

select * from GLAccounts