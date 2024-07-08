use NORTHWND

--Vistas (Objeto de la base de datos- SQL- LDD)
create or ALTER VIEW vistas_ventas
as
SELECT c.CustomerID as 'Clave',c.CompanyName as 'Cliente',
CONCAT(e.FirstName,' ',e.LastName) as 'Nombre',
o.OrderDate as 'Fechadelaorden', DATEPART(YEAR,o.OrderDate) as 'Anodecompra',
DATENAME (mm,o.OrderDate) as 'Mesdecompra',
DATEPART(QUARTER,o.OrderDate) as 'Trimestre',
UPPER(p.ProductName) as 'Nombredel6producto',
od.Quantity as 'CantidadVendida',
od.UnitPrice as 'PrecioVenta',
p.SupplierID as 'ProveedorId'
FROM 
Orders as o
INNER JOIN Customers as c
on o.CustomerID=c.CustomerID
INNER JOIN Employees as e
on e.EmployeeID=o.EmployeeID
INNER JOIN [Order Details] as od
on od.OrderID=o.OrderID
INNER JOIN Products as p
on p.ProductID=od.ProductID

SELECT Clave,Nombre,Nombredel6producto,Fechadelaorden,
(CantidadVendida * PrecioVenta) as 'Importe'
FROM vistas_ventas
WHERE Nombredel6producto='CHAI'
and (CantidadVendida * PrecioVenta)>600
and DATEPART(YEAR,Fechadelaorden)=1996

--INNER JOIN de la vista suplieers

select * FROM 
vistas_ventas as vv
inner JOIN Suppliers as s
on s.SupplierID= vv.ProveedorId

--funcion case
SELECT ProductName,UnitPrice,UnitsInStock,Discontinued,
Disponibilidda= case Discontinued
when 0 then 'No Disponibel'
when 1 then 'Disponible'
else 'No existente'
end 
FROM Products 

select ProductName,UnitsInStock,UnitPrice,
case 
when UnitPrice>=1 and UnitPrice<18
then 'Produto barato'
when UnitPrice>=18 and UnitPrice<=50
then 'Medio barato'
when UnitPrice BETWEEN 51 and 100 
then 'Pruducto caro'
else 'Carisimo'
end as 'Categorias de precios'
from Products 
 WHERE ProductID in (29,38)

 use AdventureWorks2019

SELECT
BusinessEntityID,SalariedFlag 
FROM HumanResources.Employee
Order by 
case SalariedFlag 
WHEN 1 THEN  BusinessEntityID
end desc,
case
when SalariedFlag=0 then BusinessEntityID
end asc;

SELECT BusinessEntityID,
LastName,
TerritoryName,
CountryRegionName 
from Sales.vSalesPerson
WHERE TerritoryName is NOT NULL
ORDER BY 
case CountryRegionName
when 'United States' then TerritoryName
else CountryRegionName
end ASC

--Funcion IS NULL
SELECT v.AccountNumber,
v.Name,
v.PurchasingWebServiceURL as 'PurchasinWebServiceURL'
from Purchasing.Vendor as v

SELECT v.AccountNumber,
v.Name,
isNULL ( v.PurchasingWebServiceURL,'NOURL') as 'PurchasinWebServiceURL'
from Purchasing.Vendor as v

SELECT v.AccountNumber,
v.Name,
case
when v.PurchasingWebServiceURL is null then 'NO URL'
END AS 'PurchasingWebServiceURL'
from Purchasing.Vendor as v
WHERE AccountNumber ='WIDEWOR0001'

--iif =funcion
--if = estructura de control
SELECT IIF(1=0,'Veradero','False')

use AdventureWorks2019;

-- FUNCION IIF
SELECT IIF(1=1,'Veradero','False') as 'Resultado'
CREATE VIEW vista_genero
as
SELECT e.LoginID, e.JobTitle,e.Gender,IIF(e.Gender='F','MUJER','HOMBRE') AS 'SEXO'
FROM 
HumanResources.Employee as e;

SELECT UPPER(JobTitle) AS 'titulo' FROM vista_genero
where SEXO = 'MUJER'

SELECT lower(JobTitle) AS 'titulo' FROM vista_genero
where SEXO = 'MUJER'

--MERGE
SELECT OBJECT_ID(N'tempdb..#StudentsC1')

IF OBJECT_ID (N'tempdb..#StudentsC1') is not NULL
begin
    drop table #StudentsC1;
end

CREATE TABLE #StudentsC1(
    StudentID       INT
    ,StudentName    VARCHAR(50)
    ,StudentStatus  BIT
);

INSERT INTO #StudentsC1(StudentID, StudentName, StudentStatus) VALUES(1,'Axel Romero',1)
INSERT INTO #StudentsC1(StudentID, StudentName, StudentStatus) VALUES(2,'Sofía Mora',1)
INSERT INTO #StudentsC1(StudentID, StudentName, StudentStatus) VALUES(3,'Rogelio Rojas',0)
INSERT INTO #StudentsC1(StudentID, StudentName, StudentStatus) VALUES(4,'Mariana Rosas',1)
INSERT INTO #StudentsC1(StudentID, StudentName, StudentStatus) VALUES(5,'Roman Zavaleta',1)




IF OBJECT_ID(N'tempdb..#StudentsC2') is not NULL
begin
drop table #StudentsC2
END


CREATE TABLE #StudentsC2(
    StudentID       INT
    ,StudentName    VARCHAR(50)
    ,StudentStatus  BIT
);


INSERT INTO #StudentsC2(StudentID, StudentName, StudentStatus) VALUES(1,'Axel Romero Rendón',1)
INSERT INTO #StudentsC2(StudentID, StudentName, StudentStatus) VALUES(2,'Sofía Mora Ríos',0)
INSERT INTO #StudentsC2(StudentID, StudentName, StudentStatus) VALUES(6,'Mario Gonzalez Pae',1)
INSERT INTO #StudentsC2(StudentID, StudentName, StudentStatus) VALUES(7,'Alberto García Morales',1)

SELECT * FROM #StudentsC1
SELECT * FROM #StudentsC2

SELECT * 
from #StudentsC1 as s1
 INNER JOIN #StudentsC2 as s2
 on s1.StudentID=s2.StudentID

 SELECT * 
from #StudentsC1 as s1
LEFT JOIN #StudentsC2 as s2
 on s1.StudentID=s2.StudentID

 SELECT * 
from #StudentsC1 as s1
 RIGHT JOIN #StudentsC2 as s2
 on s1.StudentID=s2.StudentID


INSERT into #StudentsC2(StudentID,StudentName,StudentStatus)
SELECT s1.StudentID,s1.StudentName,s1.StudentStatus
from #StudentsC1 as s1
LEFT JOIN #StudentsC2 as s2
 on s1.StudentID=s2.StudentID
 WHERE s2.StudentID is null

update s2
set s2.StudentName=s1.StudentName,
    s2.StudentStatus=s1.StudentStatus
FROM
#StudentsC1 as s1
INNER JOIN #StudentsC2 as s2
on s1.StudentID=s2.StudentID