select avg(cost) as AverageCost from sales
where Sdate between '1992-01-01' and '1992-12-31';

select customers.Cname as CustomerName, products.Pdescr as ProductName, sales.Quant as Quantity
from products, sales, customers
where sales.Pcode = 1312 and 
customers.Ccode = sales.Ccode and
products.Pcode = sales.Pcode and
quant between 3 and 7;

select products.Pdescr as ProductDescription, products.Pcode as ProductCode, avg(sales.Quant) as AveragePiecesSold 
from products, sales
where products.Pcode = sales.Pcode
group by products.Pcode;

select * from salesmen
where Scomm between 0.15 and 0.18
and Scomm <> 0.165;

select salesmen.Sname as SalesmanName, salesmen.Scode as SalesmanCode
from family, salesmen 
where salesmen.Scode = family.salesman
having count(*) >= 2;

select products.Pcode as ProductCode, sum(sales.Cost) as TotalCost
from products, sales
where products.Pcode = sales.Pcode
group by products.Pcode
having sum(sales.cost) > 1500;