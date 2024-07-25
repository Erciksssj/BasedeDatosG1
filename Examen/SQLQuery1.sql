use NORTHWND
use AdventureWorks2019
go

go
create or alter proc usp_GetCustomerOrdersInfo
@CustomerID int
as 
begin
select *
from Sales.Customer as c
where CustomerId=@CustomerID
end
go


select PersonID, case
when c.CustomerID is null then 'No existe'
end as CustomerID 
from Sales.Customer as c
where c.CustomerID='2'
go

exec usp_GetCustomerOrdersInfo 198210
go

create  or alter proc
as 
begin
end

create procedure create or alter proc
as 
begin
end

create table OrderHistory(
OrderID int,
CustomerID int,
OrderDate DATETIME DEFAULT GETDATE(),
TotalAmount Money
)
go
create or alter proc usp_CreateCustomerOrder
@Cantidad int,
@Precio money,

@ope float OUTPUT
as 
begin
set @ope=(@Cantidad*@Precio)
end
go

declare @res float
exec usp_CreateCustomerOrder @Cantidad=2,@Precio=20,@ope=@res output
print 'La suma es '+ cast(@res as varchar)

select * from Production.Product