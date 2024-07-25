--Erick Trejo resendiz
use BDEJEMPLO2
--Obtener el número de pedido, la fecha del pedido y la empresa de los clientes cuyo límite de crédito sea 50000, 100000 o 150000.
select p.Num_Pedido,p.Fecha_Pedido,c.Empresa,c.Limite_Credito 
from Pedidos as p
inner join Clientes as c
on p.Cliente=c.Num_Cli
where c.Limite_Credito =50000 and c.Limite_Credito =100000 and c.Limite_Credito =150000
go
--Obtener el nombre, las ventas y la ciudad de todos los representantes
--cuyas ventas están entre 5000 y 200000
select r.Nombre,o.Ventas,o.Ciudad
from Representantes as r
left join Oficinas as o
on r.Oficina_Rep=o.Oficina
where o.Ventas between 5000 and 200000
go
--Obtener el nombre del producto y la cantidad total pedida de cada producto.
select p.Descripcion, count(pe.Cantidad)
from Productos as p 
inner join Pedidos as pe
on p.Id_fab=pe.Fab
group by p.Descripcion
go
--Obtener el nombre, las ventas y la región de todos los representantes cuyas ventas sean mayores a 10000 y cuya región sea 'Este'.
select r.Nombre,o.Ventas,o.Region
from Representantes as r
inner join Oficinas as o
on r.Oficina_Rep=o.Oficina
where o.Ventas > 10000 and o.Region = 'Este'
go
--Obtener la empresa y el importe total de los pedidos para cada una de las empresas, aunque no hayan hecho pedidos, pero solo para cantidades de productos mayores a dos.
select c.Empresa,p.Importe,p.Cantidad
from Clientes as c
left join Pedidos as p 
on c.Num_Cli=p.Cliente
where p.Cantidad >2
