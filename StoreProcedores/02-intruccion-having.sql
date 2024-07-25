use NORTHWND
go
select o.OrderID, o.OrderDate,c.CompanyName, c.City, od.Quantity, od.UnitPrice
from Orders as o
inner join [Order Details] as od
on o.OrderID = od.OrderID
inner join Customers as c
on c.CustomerID=o.CustomerID
where c.City in('San Cristóbal', 'México D.F.')
go
----------------------------------------------------------------------------------
select c.CompanyName, 
COUNT(o.OrderID) as [numero ordenes]
from Orders as o
inner join [Order Details] as od
on o.OrderID = od.OrderID
inner join Customers as c
on c.CustomerID=o.CustomerID
group by c.CompanyName
go
-----------------------------------------------------------
select c.CompanyName, count(o.OrderID) as 'NumeroOrdenes'
from orders as o
inner join [Order Details] as od
on o.OrderID = od.OrderID
inner join Customers as c
on c.CustomerID = o.CustomerID
where c.City in ('San Cristóbal', 'México D.F.')
group by c.CompanyName;
go
------------------------------------------------------------
select c.CompanyName, count(o.OrderID) as 'NumeroOrdenes'
from orders as o
inner join [Order Details] as od
on o.OrderID = od.OrderID
inner join Customers as c
on c.CustomerID = o.CustomerID
where c.City in ('San Cristóbal', 'México D.F.')
group by c.CompanyName
having COUNT(*)>18
go
-----------------------------------------
--Obtener los nombres de los productos y sus categorias donde el precio
--promedio de los productos en la misma categoria sea mayor a 20
select c.CategoryName, 
AVG(p.UnitPrice) as 'Promedio de precios' from 
Categories as c
left join Products as p 
on c.CategoryID = p.CategoryID
where p.CategoryID is not  null
group by c.CategoryName,p.ProductName
having AVG(p.UnitPrice) >20
order by c.CategoryName
----------------------------------------
select c.CategoryName,p.ProductName,
avg(p.UnitPrice) as 'Promedio de precios' from 
Categories as c
left join Products as p 
on c.CategoryID = p.CategoryID
where p.CategoryID is not  null
group by c.CategoryName,p.ProductName
having max(p.UnitPrice) >200
order by c.CategoryName