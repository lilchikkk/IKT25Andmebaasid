	-- Hindeline töö 2 --
----------------------------
--1. mitu klienti on tabelis Customer(count)
select COUNT (*) from SalesLT.Customer

--2. telimuste koguarv tabelist SalesOrderHeader(count big)
select COUNT_BIG (*) from SalesLT.SalesOrderHeader

--3. suurim tellimuse summa (TotalDue, Kasuta MAX)
select MAX(CAST(TotalDue as int)) from SalesLT.SalesOrderHeader 

--4. väiksem tellimuse summa (TotalDue, Kasuta MIN)
select MIN(CAST(TotalDue as int)) from SalesLT.SalesOrderHeader 

--5. kõigi tellimuste kogusumma (TotalDue, SUM)
select SUM(CAST(TotalDue as int)) from SalesLT.SalesOrderHeader 

--6. mitu toodet on tabelis Product,
--mille hind (ListPrice) on suurem kui 100.(count + where)
select COUNT (*) as Toodete_arv from SalesLT.Product
where ListPrice > 100;

--7. kõige kallim toode (ListPrice), mille hind 
--on väiksem kui 1000.(kasuta max + where)
select max(ListPrice) as Kkaliim_hind from SalesLT.Product
where ListPrice < 1000;

--8. kõige odavam toode (ListPrice), mille hind
--on suurem kui 0. (kasuta min + where)
select min(ListPrice) as Odavam_hind from SalesLT.Product
where ListPrice > 0;

--9. kõikide toodete koguhind (ListPrice), mille värv
--(color) ei ole NULL. (kasuta sum + where)
select sum(ListPrice) as Sum_hind from SalesLT.Product
where Color is not null;

--10 Mitu klienti on liitunud pärast aastat 2010(ModifiedDate, kasuta count + where)
select COUNT (*) as klientide_arv from SalesLt.Customer
where ModifiedDate > '2010-12-31'

--11.kõige varasem muutus (ModifaiedDate) SalesOrderDetail seast, kus on tehtud muutus enne 2009 a.
select MIN(ModifiedDate) as varasem_muutus from SalesLt.SalesOrderDetail
where ModifiedDate < '2009-01-01'

--12.tellimuste kogusumma (TotalDue) iga kliendi kohta. (kasuta sum + group by CustomerID)
select CustomerID, SUM(TotalDue) as Kogusumma from SalesLT.SalesOrderHeader
group by CustomerID


--13. iga klienti tellimuste arv. (join customer + SalesOrderHeader, kasuta count + group by)
select CustomerID
from SalesLT.Customer
(
	select SalesOrderId, COUNT (*) as tellimust_arv
	from SalesLT.SalesOrderHeader
	join SalesLT.Customer
	on CustomerID = Customer.ID
	group by CustomerID
)
go
--14. iga tootekategooria toodete arv (join product + 
--ProductSubCategory + ProductCategory, kasuta COUNT + group by)
select Name as kategooria,
COUNT(SalesLT.ProductCategory) as Toodete_arv
from SalesLT.Product
join SalesLt.ProductCategory
on ProductSubCategoryID = SalesLt.ProductCategory
join SalesLT.ProductCategory
on ProductCategoryID = ProductCategoryID
group by Name
--15. iga kliendi tellimuste kogusumma (TotalDue), kuid näita ainult neid,
--kelle kogusumma on üle 10000. (join customer,
--SalesOrderHeader, kasuta sum + group by + having)
select CustomerID,
SUM(TotalDue) as kogusumma
from SalesLT.SalesOrderHeader
group by CustomerID
having SUM(TotalDue) > 10000