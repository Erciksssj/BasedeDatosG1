SELECT c.CategoryName as 'Nombre de Caegorias',
p.ProductName as 'Nombre del producto',
p.UnitPrice as 'Precio',
p.UnitsInStock as 'Existencia'
from Categories as C
INNER JOIN Products as P
on c.CategoryID= p.CategoryID
where CategoryName in ('Beverages', 'Produce')
--Sewleccionar todas las ordenes que fueron emitidas por los empleados 
--Nancy Davolio, Anna Dodsworth y Andrew Fuller
SELECT * from Orders
WHERE EmployeeID IN(1,9,2)
select * FROM Employee 1,9,2
--Seleccionar todas las ordenes dividiendo la fecha de orden en ano,mes y dia
SELECT OrderDate as 'fecha de orden',
year(OrderDate) as 'Ano',
MONTH(OrderDate) as 'Mes',
DAY(OrderDate) as 'dia'
FROM Orders
--Sleccionar todos los nombres de los empleados
SELECT CONCAT(FirstName,' ',LastName) as 'Nombre conpleto'
from Employees
--Seleccionar todos los productos donde la existencia sea mayor o igual a 40
--y el precio sea menor a 19
SELECT 
ProductName as 'Nombre del producto', 
UnitPrice as 'Precio', 
UnitsInStock as 'Existencia' 
FROM Products
WHERE UnitPrice <19 and UnitsInStock >=40

--Seleccion ar todas las ordenes realizadas de abril a agosto de 1996

SELECT CustomerID,OrderID,OrderDate,EmployeeID FROM Orders
where OrderDate >='1996-04-01' and OrderDate <= '1996-08-31'

SELECT CustomerID,OrderID,OrderDate,EmployeeID
FROM Orders
where OrderDate BETWEEN '1996-04-01' and  '1996-08-31'

--Seleccionar todas las ordenes entre 1996 y 1998
SELECT OrderDate from Orders
WHERE OrderDate BETWEEN '1996' and '1998'
--Seleccionar todas las ordenes entre 1996 y 1999
SELECT * from
Orders WHERE year(OrderDate) in ('1996','1999')

--Seleccionar todos los productos que comiencen con c
SELECT  * FROM
Products
WHERE ProductName LIKE 'c%'

--seleccionar todos los productos que terminene con s
SELECT  * FROM
Products
WHERE ProductName LIKE '%s'

--Seleccionar todos los productos que en el nombre del producto contengan la palabtra no
SELECT  * FROM
Products
WHERE ProductName LIKE '%no%'

--seleccionar todos los p[roductos que cointengan las letyras a o n
SELECT  * FROM
Products
WHERE ProductName LIKE '%[AN]%'
--Seleccinar todos los productos que comiencen entre la letgra a y n
SELECT  * FROM
Products
WHERE ProductName LIKE '[A-N]%'
--seleccionar toas las ordenes que fueron emitidas por lo empleados Nancy Davoli, Anne Dodsworth y Andrew Fuller (inner Joing)
SELECT o.OrderID AS 'Numero Orden',
o.orderDate as 'Fecha Orden',
CONCAT(FirstName, ' ', LastName) as 'Nomre Empleado'
FROM
Employees as e
INNER JOIN
orders as o
on E.EmployeeID = o.EmployeeID
where e.FirstName IN ('Nancy','Anne','Andrew')
and e.LastName in ('Davolio','Dosswort','Fuller')

--crear base de datos
create DATABASE pruebaxyz;
--utilizar base de datos
use pruebaxyz;
--crear una tabla a apartir de una cosulta con cero registros
SELECT TOP 0 *
into pruebaxyz.dbo.products2
from NORTHWND.dbo.Products;

SELECT * FROM products2
--agregar un contraint a la tabla product 2
ALTER TABLE products2 
add CONSTRAINT pk_products2 
PRIMARY KEY(Productid);


--llenar una tabla a partir de una cosulta 

insert into pruebaxyz.dbo.products2(ProductName,SupplierID,CategoryID,QuantityPerUnit,
UnitPrice,UnitsInStock,UnitsOnOrder,ReorderLevel,Discontinued)
select ProductName,SupplierID,CategoryID,QuantityPerUnit,
UnitPrice,UnitsInStock,UnitsOnOrder,ReorderLevel,Discontinued 
from NORTHWND.dbo.Products;

-- Ejercicio 1: Obtener el nombre del cliente y el nombre del empleado
-- del representante de ventas de cada pedido.
--Nombre del cliente(Costumers)
--Nombre del empleado(Employees)
--Pedido
use NORTHWND
SELECT o.CustomerID,o.EmployeeID,o.OrderID,o.OrderDate FROM
Orders as o

select  CompanyName as'Nombre del cliente'
FROM Customers
INNER JOIN
Orders
ON Orders.CustomerID=Customers.CustomerID;

select  CompanyName as'Nombre del cliente',
CONCAT(e.FirstName,'',e.LastName) as 'Nombre del empleado',
e.FirstName,e.LastName,o.OrderID ,o.OrderDate,(od.Quantity * od.UnitPrice) as 'Importe'
FROM Customers as c
INNER JOIN
Orders AS o
ON o.CustomerID=c.CustomerID
INNER JOIN Employees as e 
ON o.EmployeeID=e.EmployeeID
INNER JOIN[Order Details]as od 
on od.OrderID=o.OrderID
where YEAR(OrderDate) IN('1996','1998')
--seleccionar cuantas ordenes se han realizado en 1996 y 1998 count(*),count(campo),max(),min(),avg(), sum()
select  COUNT(*)as 'Total ordenes'
FROM Customers as c
INNER JOIN
Orders AS o
ON o.CustomerID=c.CustomerID
INNER JOIN Employees as e 
ON o.EmployeeID=e.EmployeeID
INNER JOIN[Order Details]as od 
on od.OrderID=o.OrderID
where YEAR(OrderDate) IN('1996','1998')

SELECT * FROM Orders
--Ejercicio 2: Mostrar el nombre del producto, el nombre del proveedor y el precio unitario de cada producto.
select * from Products
select * from Suppliers

select p.ProductName,p.UnitPrice,s.CompanyName
FROM Products as p
INNER JOIN
Suppliers AS s
ON p.SupplierID=s.SupplierID

--FUNCIONES DE AGREGADO Y AGRUPACIÓN

--utilizar base de datos
use NORTHWND;

--funciones de agregado

--seleccionar el numero total de ordenes de compra
--COUNT(*)
select count(*) as 'NumeroOrdenes' from orders 

select count(*) from Customers

--Seleccionar el numero de productos pedido
select * from  [Order Details]
--seleccionar el minimo de numeros de producto pedido
SELECT MIN(Quarterly) as 'Cantidad'
from order [Order Details Extended]
--Sleccionar el total de dinero que he vendido
--FUNCIONES DE AGREGADO Y AGRUPACIÓN

--utilizar base de datos
use NORTHWND;

--funciones de agregado

--seleccionar el numero total de ordenes de compra
--COUNT(*)
select count(*) as 'NumeroOrdenes' from orders 

select count(*) from Customers

select count(region) from customers

--seleccionar el maximo numero de productos pedidos
select max(Quantity) as 'Cantidad' from [order Details]

select min(Quantity) as 'Cantidad' from [order Details]

--seleccionar el total de la cantidad de predictos pedidos
select sum(UnitPrice) from [order Details]

--seleccionar el total de dinero que he vendido 
select sum(Quantity * od.UnitPrice) as 'Total' 
from [order Details] as od
INNER JOIN Products as p
on od.ProductID=p.ProductID
WHERE p.ProductName='Aniseed Syrup';
--Seleccionar el promedio de las ventas del producto 3
select  avg (Quantity * od.UnitPrice) as 'Promedio de ventas' 
from [order Details] as od
INNER JOIN Products as p
on od.ProductID=p.ProductID
WHERE p.ProductName='Aniseed Syrup';
--Seleccionar elk numero de productos por categoria
SELECT SUM(CategoryID), COUNT(*) as 'numero de productos'
from Products

SELECT CategoryID, COUNT(*) as 'Total de productos'
 from Products
 GROUP BY CategoryID

 --seleccionar el numero de de productos por nombre de categoria
SELECT c.CategoryName,COUNT(ProductID) as 'Total de producto'
From Categories as c
INNER join Products as p
on c.CategoryID=p.CategoryID
 WHERE c.CategoryName IN('Beverages','Confections')
GROUP by c.CategoryName

SELECT CategoryID from Products 

USE NORTHWND


--Ejercicio 3: Listar el nombre del cliente, el ID del pedido y la fecha del pedido para cada pedido.
SELECT CompanyName, o.OrderID,o.OrderDate
FROM Customers as c
INNER JOIN Orders as o
ON c.CustomerID=o.CustomerID
--Ejercicio 4: Obtener el nombre del empleado, el título del cargo y el departamento del empleado para cada empleado.
SELECT * from Territories
 SELECT  CONCAT(FirstName,' ',LastName) as 'Nombre completo',TitleOfCourtesy ,Title 
 from Employees
--Ejercicio 5: Mostrar el nombre del proveedor, el nombre del contacto y el teléfono del contacto para cada proveedor.
SELECT CompanyName,ContactName,Phone 
from Suppliers
--Ejercicio 6: Listar el nombre del producto, la categoría del producto y el nombre del proveedor para cada producto.
SELECT p.ProductName,c.CategoryName,s.CompanyName 
from Products as p
INNER JOIN Categories as c
ON p.CategoryID=c.CategoryID
INNER JOIN Suppliers as s
ON p.SupplierID=s.SupplierID
--Ejercicio 7: Obtener el nombre del cliente, el ID del pedido, el nombre del producto y la cantidad del producto para cada detalle del pedido.
SELECT c.CompanyName,o.OrderID,p.ProductName,od.Quantity
from Customers as c
INNER JOIN Orders as o
on c.CustomerID=o.CustomerID
INNER JOIN [Order Details] as od
on o.OrderID=od.OrderID
INNER JOIN Products as p
ON od.ProductID=p.ProductID
--Ejercicio 8: Obtener el nombre del empleado, el nombre del territorio y la región del territorio para cada empleado que tiene asignado un territorio.
SELECT CONCAT(e.FirstName,' ',e.LastName) as 'Nombre completo',t.TerritoryDescription,r.RegionDescription
from Employees as e
INNER JOIN EmployeeTerritories as et
on e.EmployeeID=et.EmployeeID
INNER JOIN Territories as t
on et.TerritoryID=t.TerritoryID
INNER JOIN Region as r
ON t.RegionID=r.RegionID
--Ejercicio 9: Mostrar el nombre del cliente, el nombre del transportista y el nombre del país del transportista para cada pedido enviado por un transportista.
SELECT c.CompanyName, o.ShipName,o.ShipCountry 
from Customers as c
INNER JOIN Orders as o
on c.CustomerID=o.CustomerID
--Ejercicio 10: Obtener el nombre del producto, el nombre de la categoría y la descripción de la categoría para cada producto que pertenece a una categoría.
SELECT p.ProductName,c.CategoryName,c.[Description]
from Products as p
INNER JOIN Categories as c
on p.CategoryID=c.CategoryID
--11-seleccionar el total de ordenes hechas por cada uno de los probedores
SELECT s.CompanyName as 'Proveedor', count(od.orderId) as 'TotalOrdenes' 
from Suppliers as s
inner join products as p
on s.SupplierID = p.SupplierID
inner join [Order Details] as od
on od.ProductID = p.ProductID
group by s.CompanyName;
--Seleccionar el total de dinero que he vendido por proveedor del primer trimestre de 1996
SELECT s.CompanyName as 'proveedor', COUNT(*) as 'Total de Ordenes'
from Suppliers as s
INNER JOIN Products as p
on s.SupplierID=p.SupplierID
INNER JOIN[Order Details] as od
ON od.ProductID=p.ProductID
GROUP BY s.CompanyName

SELECT s.CompanyName as 'Proveedor', sum(od.UnitPrice* od.Quantity) as 'Total de ventas'
from Suppliers as s
INNER JOIN Products as p
on s.SupplierID=p.SupplierID
INNER JOIN[Order Details] as od
on od.ProductID=p.ProductID
INNER JOIN Orders as o
on o.OrderID=od.OrderID
WHERE o.OrderDate BETWEEN '1996-01-01' and '1996-12-31'
GROUP BY s.CompanyName 
ORDER by 'Total de ventas' DESC

select SUM(UnitPrice*Quantity) 
from [Order Details]

--Seleccionar el total del dinero vendido por categoria
SELECT ac.CategoryName,
sum(od.Quantity * od.UnitPrice) as 'Total de ventas'
from [Order Details] as od 
INNER JOIN Products as p
on od.ProductID=p.ProductID
inner JOIN Categories as ac
on ac.CategoryID=p.CategoryID
GROUP BY ac.CategoryName
ORDER by 2 DESC

SELECT ac.CategoryName,
sum(od.Quantity * od.UnitPrice) as 'Total de ventas'
from [Order Details] as od 
INNER JOIN Products as p
on od.ProductID=p.ProductID
inner JOIN Categories as ac
on ac.CategoryID=p.CategoryID
GROUP BY ac.CategoryName
ORDER by 2 DESC

USE NORTHWND
--Seleccionar el total de dinero vendido por categoria y dentro por producto
SELECT  c.CategoryName as [Nombre de la categoria],
p.ProductName as [producto],
SUM(od.Quantity*od.UnitPrice) as [Total]
FROM [Order Details] as [od]
INNER JOIN Products as [p]
on od.ProductID=p.CategoryID
INNER JOIN Categories as [c]
ON c.CategoryID=p.CategoryID
GROUP BY c.CategoryName,p.ProductName
ORDER BY 1 asc