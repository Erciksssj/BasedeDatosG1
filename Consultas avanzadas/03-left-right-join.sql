CREATE DATABASE pruebajoing3;
USE pruebajoing3;

CREATE TABLE proveedor(
    provid int NOT NULL IDENTITY(1,1),
    nombre VARCHAR(50) NOT NULL,
    limite_credito money NOT NULL
    CONSTRAINT pk_proveedor
    PRIMARY KEY(provid),
    CONSTRAINT unico_nombrepro
    UNIQUE(nombre)
);
 CREATE TABLE productos(
    productid int not null IDENTITY(1,1),
    nombre VARCHAR(50) NOT NULL,
    precio money  not null,
    existencia int not null,
    proveedor int,
    CONSTRAINT pk_producto
    PRIMARY KEY(productid),
    CONSTRAINT unic0_nombre_proveedor
    UNIQUE(nombre),
    CONSTRAINT fk_proveedor_producto
    FOREIGN KEY(proveedor)
    REFERENCES proveedor(provid)
 )

--agregar registros a las tablas proveedor y producto
INSERT INTO proveedor(nombre,limite_credito)
VALUES
('Proveedor1', 5000),
('Proveedor2', 6778),
('Proveedor3', 6778),
('Proveedor4', 5677),
('Proveedor5', 6666)

SELECT * FROM proveedor

INSERT INTO productos(nombre,precio,existencia,proveedor)
VALUES
('Producto1',56,34,1),
('Producto2',56.56,12,1),
('Producto3',45.6,33,2),
('Producto4',22.34,666,3)

select * FROM productos

SELECT * FROM
proveedor as p
INNER JOIN productos as pr
on pr.proveedor=p.provid

SELECT s.CompanyName as 'Proveedor',
 sum(od.UnitPrice* od.Quantity) as 'Total de ventas'
from Suppliers as s
INNER JOIN Products as p
on s.SupplierID=p.SupplierID
INNER JOIN[Order Details] as od
on od.ProductID=p.ProductID
INNER JOIN Orders as o
on o.OrderID=od.OrderID
WHERE o.OrderDate BETWEEN '1996-01-01' and '1996-12-31'
GROUP BY s.CompanyName 
ORDER by 'Total de ventas' DESC;

SELECT sum(pr.UnitPrice* od.Quantity) as 'Total de ventas'
FROM(
    SELECT UnitPrice FROM Products 
)as pr
use NORTHWND

SELECT * FROM Employees

select c.CategoryID,p.ProductName, p.UnitsInStock, p.Unitprice, p.discontinued
FROM (
    select categoryname, categoryid from Categories
) as c 
INNER JOIN 
(
    select productname, UnitsInStock, categoryID,UnitPrice,Discontinued from Products
) as p 
on c.CategoryID=p.CategoryID;

--left JOIN
use pruebajoing3

SELECT p.provid,p.nombre FROM
proveedor as p
LEFT JOIN productos as pr
on pr.proveedor=p.provid
WHERE pr.productid IS null


--1-Crear 2 tablas unq ue se llame empleados(Idempleado,PrimerNombre,Apellido,Direccion,Telefono,Salario)
-- y otra dmi_empleados(Idempleado,NombreCompleto,Direccion,Telefono,Salario)


