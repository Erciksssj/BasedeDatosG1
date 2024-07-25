use NORTHWND

--Declaracion y use de variables es transact-SQL
--Declaracion de una variable
DECLARE @numerocal INT
DECLARE @calif DECIMAL(10,2)
--Asignacion de varables
SET @numerocal=10
IF @numerocal<=0
BEGIN
    SET @numerocal=1
    END
DECLARE @i=1
    WHILE(@i<=@numerocal)
    BEGIN
    WHILE(@i<=@numerocal)
    BEGIN
    SET @calif=@calif+10
    SET @i=@i+1
    END
    SET @calif=@calif/@numerocal
    PRINT('El reultado es')

	use NORTHWND
	--Prarametros salida
create or ALTER PROCEDURE calcula_area
--parametros de entrada
@radio float,
--Parametro de salida
@area float OUTPUT
as
BEGIN
 set @area=PI()*@radio*@radio
END
go

declare @resp float
exec calcula_area @radio=22.3, @area=@resp output
print 'El area es: '+ cast(@resp as varchar)

--================================================
select CONCAT(FirstName,' ',LastName) from
Employees
where EmployeeID=3
go
--Mostrar un numero mcompleto de un empleado
create or alter procedure sp_obtenerdatosempleado
@numeroEmpleado int,--parametro entrada
@fullname varchar(35) output--parametro salida
as
begin
select @fullname=CONCAT(FirstName,' ',LastName) 
from
Employees
where EmployeeID=@numeroEmpleado
end;
go

declare @nombrecompleto nvarchar(35)
execute sp_obtenerdatosempleado @numeroEmpleado=10,@fullname=@nombrecompleto output
print @nombrecompleto
go

	create or alter procedure sp_obtenerdatosempleadom
	@numeroEmpleado int,--parametro entrada
		@fullname varchar(35) output--parametro salida
	as
	begin
	select @fullname=CONCAT(FirstName,' ',LastName) 
	from
	Employees
	where EmployeeID=@numeroEmpleado
	if @fullname is null
	begin
print 'No existe'
end
end;
go
use NORTHWND

declare @nombrecompleto nvarchar(35)
execute sp_obtenerdatosempleadom @numeroEmpleado=11,@fullname=@nombrecompleto output
print @nombrecompleto
go

select * from Customers

create database etlempresa

use etlempresa

create table Cliente
(
clienteid int not null identity(1,1),
clientebk nchar(5) not null,
empresa nvarchar(40) not null,
ciudad nvarchar(15) not null,
region nvarchar(15) not null,
pais nvarchar(15) not null,
constraint pk_cliente
primary key(clienteid)
)
GO

create table Producto(
	productoid int not null IDENTITY(1,1),
	productodk nchar(5) not null,
	nombre_producto NVARCHAR(40) not null,
	categoria NVARCHAR(20) not null, 
	precio money null,
	existencia smallint null,
	descontinuado bit null,
	constraint pk_producto
	primary key(productoid)
)
GO

create table Empleado(
	empleadoid int not null IDENTITY(1,1),
	empleadodk nchar(5) not null,
	nombre_completo NVARCHAR(50) not null,
	ciudad NVARCHAR(15)null,
	region NVARCHAR(15)null,
	pais NVARCHAR(15) not null,
	CONSTRAINT pk_empleado
	PRIMARY KEY (empleadoid)
)
GO

create table Proveedor( 
	proveedorid int not null IDENTITY(1,1),
	proveedordk nchar(5) not null,
	empresa NVARCHAR(40) not null,
	ciudad NVARCHAR(15)null,
	region NVARCHAR(15)null,
	country NVARCHAR(15)null,
	homepage NVARCHAR(30)null,
	CONSTRAINT pk_proveedor
	PRIMARY KEY (proveedorid)
)
GO

create table Ventas(
	clienteid int not null,
	productoid int not null,
	empleadoid int not null,
	proveedorid int not null,
	cantidad int not null,
	precio money not null,
	constraint pk_venta 
	primary key(clienteid, productoid, empleadoid, proveedorid),
	constraint fk_venta_cliente 
	foreign key(clienteid) 
	references cliente(clienteid),
	constraint fk_venta_producto 
	foreign key(productoid)
	references producto(productoid),
	constraint fk_venta_empleado 
	foreign key(empleadoid) 
	references empleado(empleadoid),
	constraint fk_venta_proveedor 
	foreign key(proveedorid) 
	references proveedor(proveedorid)
)
GO

insert into etlempresa.dbo.cliente
select CustomerID,upper(CompanyName) as 'Empresa',
upper(City) as 'Ciudad',
upper (isnull(nc.Region,'Sin Region')) as Region,
upper(Country)
from NORTHWND.dbo.Customers as nc
left join etlempresa.dbo.Cliente as etle
on nc.CustomerID=etle.clientebk
where etle.clientebk is null
go

update cl
set 
cl.empresa=upper(CompanyName),
cl.ciudad=upper(City),
cl.pais=upper(Country),
cl.region=upper (isnull(c.Region,'Sin Region'))
from NORTHWND.dbo.Customers as c
inner join etlempresa.dbo.Cliente as cl
on c.CustomerID=cl.clientebk

select * from NORTHWND.dbo.Customers
where CustomerID='CLIB1'

update NORTHWND.dbo.Customers
set CompanyName='pepsi'

select * from etlempresa.dbo.Cliente
where clientebk='CLIB1'

truncate table etlempresa.dbo.cliente
go
--------------------------------------------
CREATE PROC sp_etl_carga_cliente
AS
begin
insert into etlempresa.dbo.cliente
select CustomerID, UPPER(CompanyName) AS 'Empresa',UPPER(city) as Ciudad,
upper(ISNULL(nc.region, 'SIN REGION')) AS Region, UPPER(country) as pais
from Northwind.dbo.Customers as nc
left join etlempresa.dbo.cliente etle
on nc.CustomerID = etle.clientebk
where etle.clientebk is null;

update cl
set
cl.empresa = UPPER(c.CompanyName),
cl.ciudad = UPPER(c.City),
cl.pais = UPPER(c.Country),
cl.region = UPPER(isnull(c.Region, 'Sin Region'))
from Northwind.dbo.Customers as c
inner join etlempresa.dbo.cliente as cl
on c.CustomerID =cl.clientebk;
end

 