--teeme andmebaasi e bd
create database IKT25tar

--andmebaasi valiine
use  IKT25tar

--andmebaasi kutsutamine koodiga
drop database IKT25tar

--teeme uuesti andmebaasi IKT25tar
create database IKT25tar

--teeme tabeli
create table Gender
(
--meil on muutuja Id,
--mis on täisarv andmetüüp,
--kui sisesta andmed,
--siis veerg peab olema täidetud,
--tegemist on primaarvõtmega
Id int not null primary key,
--veeru nimi on Gender,
--10 tähemärki on max pikkus,
--admed peavad olema sisestanud
--ei tohi olla tühi!!!
Gender nvarchar(10) not null
)

--andmete sisestamine
insert into Gender (Id,Gender)
values (1, 'Male'),
(2, 'Female')
--Id = 1, Gender = Male
--Id = 2, Gender = Female

--vaatame tabeli sisu
-- * tähendab, ey näita kõike seal sees olevat infot
select *from Gender

--teeme tabeli nimega Person
--veru nimed: Id int not null primary key,
--Name nvarchar (30)
--Email nvarchar (30)
--genderId int
create table Person
(
Id int not null primary key,
Name nvarchar(30),
Email nvarchar(30),
GenderId int
)
insert into Person (Id, Name, Email, GenderId)
values (1, 'Superman', 's@s.com', 2),
(2, 'Wonderwomen', 'w@w.com', 1),
(3, 'Batman', 'b@b.com', 2),
(4, 'Aquamen', 'a@a.com', 2),
(5, 'Catwomen', 'c@c.com', 1),
(6, 'Atman', 'ant"ant.com', 2),
(8, NULL, NULL, 2)

--näen tebelis olevat info
select *from Person

--võõrvõtme ühenduse loomine kahe tebeli vahel
alter table Person add constraint tblPerson_GenderId_Fk
foreign key (GenderId) references Gender(Id)

--kui sisestad uue rea andemid ja ei ole sisestanud genderId alla
--väärtust, siis automaatselt sisetab sellele reale väärtuse 3
--e unknown
alter table Person
add constraint DP_Person_GenderId
default 3 for GenderId

insert into Gender (Id, Gender)
values (3, 'Unknown')

insert into Person (Id, Name, Email, GenderId)
values (7, 'Black Panter', 'b@b.com', NULL)

insert into Person (Id, Name, Email )
values (9, 'Spiderman', 'spaidei@man.com')

select *from Person

--piirangu kustutamine
alter table Person
drop constraint DF_Person_GenderId

--kuidas liisada veergu tabelile Person
--veeru  nini on Age nvarchar(10)
alter table Person
add Age nvarchar(10)

alter table Person
add constraint CK_Person_Age check (Age > 0 and Age < 155)

--kuidas uuendada andmeid
update Person
set Age = 159
where Id = 7

select *from Person

--soovin kustutada ühe rea
--kuidas seda teha?
delete from Person
where Id = 8

select *from Person

--liisame uue veeru City nvarchar(50) 
alter table Person
add City nvarchar(50)

--kõik, kes elavad Gothami linnas
select * from Person where City = 'Gotham'
--kõik, kes ei ela Gothamis 
select * from Person where City != 'Gotham'
--variant nr 2. Kõõik, kes ei ela Gothamis
select * from Person where City <> 'Gotham'

--näitab teadud vanusega inimesi
--valime 151, 35, 25
--v1
select *from Person
where Age in (120, 35, 26)
--v2
select *from Person where Age = 120 or Age = 35 or Age = 26)

--sovin näha inimesi vahemikus 22 kuni 41
select *from Person where Age between 22 and 41

--wildcard e näitab kõik g-tähega linnad
select *from Person where City like 'G%'
--otsib emaillid @-märgiga
select *from Person where Email like '%@%'

--tahan näha, kellel on emaillis ees ja peale @-märki üks täht
select *from Person where Email like '%_@_.%'

--kõik, kelle nimes ei ole esimene täht W, A, S
--v1
select *from Person where Name not like 'W%'
and Name not like 'A%'
and Name not like 'S%'
--v2
select *from Person where Name  like '[^WAS]%'

--kõik, kes elavad Gothamis ja New Yorkis
select *from Person where (City  = 'Gotham' or City = 'New York')

--kõik, kes elavad Gothamis ja New YOrkis ja ning peavad olema
--vanemad, kui 29
select *from Person where (City  = 'Gotham' or City = 'New York')
and (Age >= 29)

--kuuvab tähestikulises järjekorras inimesi ja võtab aluseks 
--Name veeru
select *from Person
select *from Person order by Name

--võtab kolm esimest riida person tabelis
select top 3 *from Person
        --Tund nr 3  25.02.2026--
------------------------------------------------

--kolm esimest, aga tabeli järjestus on Age ja siis Name
select top 3 Age, Name from Person

--näita esimesed 50% tabelist
select top 3 Age, Name from Person

select top 50 PERCENT * from Person

--järjestab vanuse järgi isikud

--muudab Age muutuja int-ks ja näitab vanulises järjestuses
--cast abil saab andmetüüpi muuta
select * from Person order by cast (Age as int )desc


--aga kõikide isikute koondvanus e liidab kõik kokku
select sum(cast(Age as int))as KoondVanus from Person
-- "as KoondVanus" annab nimetuse

--kõige noorem isik tuleb üles leida
select min(cast(Age as int)) from Person

--kõige vanem isik tuleb üles leida
select max(cast(Age as int)) from Person

--muudame Age muutuja int peale
--näeme konkreetse linnades olevate isikute koondvanust
select City, sum(Age)as TotalAge from Person group by City


--kuidas saab koodiga muuta andmetüüpi ja selle pikkust
alter table Person
alter column Name nvarchar(25)

--kuvab esimeses reas välja toodud järjestuses ja kuvab Age-i
--TotalAge-ks
--järjest City-s olevate nimed järgi ja siis Genderid järgi
--kasutada group by-d ja order gy-d
select City, GenderId, sum(Age) as TotalAge from Person
group by City, GenderId
order by GenderId;

--näitab, et mitu rida andmeid on selles tabelis
select count(*) from Person
--näitab tulemust mitu inimest on Genderid väärtusega 2
--konkreetses linnas
--arvutab kokku selles linnas
select GenderId, City, sum(Age) as TotalAge, count(Id) as
[Total person(s)] from person
Where GenderId = '2'
group by GenderId, City

--näitab ära inimeste koondvanuse, mis on üle 41 a ja
--kui palju neid igas linnas elab
--eristab inimese soo ära
select GenderId, City, sum(Age) as TotalAge, count(Id) as
[Total person(s)] from person
Where GenderId = '1'
group by GenderId, City having SUM(Age) > 41

--loome tabelid Employees ja Drpartment
create table Department
(
Id int primary key,
DepartmentName nvarchar(50),
Location nvarchar(50),
DepartmentHead nvarchar(50),
)

create table Employees
(
Id int primary key,
Name nvarchar(50),
Gender nvarchar(50),
Salary nvarchar(50),
DepartmentId int
)
insert into Employees (Id, Name, Gender, Salary, DepartmentId)
values (1, 'Tom', 'Male',4000, 1),
(2, 'Pam', 'Female',3000, 3),
(3, 'John', 'Male', 3500, 1),
(4, 'Sam', 'Male', 4500, 2),
(5, 'Todd', 'Male',2800, 2),
(6, 'Ben', 'Male', 7000, 1),
(7, 'Sara', 'Female',4800, 3),
(8, 'Valarie', 'Female', 5500, 1),
(9, 'James', 'Male',6500, NULL),
(10, 'Russell', 'Male',8800, NULL)

insert into Department (Id, DepartmentName, Location, DepartmentHead)
Values(1, 'IT', 'London','Rick'),
(2, 'Payroll', 'Delhi','Ron'),
(3, 'HR', 'New York', 'Christie'),
(4, 'Other Department', 'Syndey', 'Cindrella')

select *from  Department
select *from  Employees

---

select Name, Gender, Salary, DepartmentName
from Employees
left join Department
on Employees.DepartmentId = Department.Id
---

--arvutab kõikide palgad kokku Emloyees tabelist
select sum(cast(salary as int))from Employees--arvutab kõikide palgad kokku
--kõige väiksem palga saaja
select min(cast(salary as int))from Employees
--näitab veerge Location ja Palka.Palga veerg kuvatakse TotalSalary-ks
--teha left join Department tabeliga
--grupitab Locationiga
select Location,sum(cast(salary as int)) as TotalSalary
from Employees
left join Department
on Employees.DepartmentId = Department.Id
group by Location
         
 --Tund nr 4  03.03.2026--

select *from Employees
select SUM(CAST(Salary as int)) from Employees --arvutab kõikide kokku

--lisame veeru City ja pikkus on 30 peale
--Employees tabelisse lisada
alter table Employees
add City nvarchar(30)

select City, Gender, SUM(CAST(Salary as int)) as TotalSalary
from Employees
group by City, Gender

--peaaegu sama päring, aga linnad
--on tähestlikulises järjestuses

select City, Gender, SUM(CAST(Salary as int)) as TotalSalary
from Employees
group by City, Gender
order by City

select *from Employees
--on vaja teada, et mitu inimest on nimekirjas selles tabellis
select count(Name) from Employees --1v
select count(distinct Name) from Employees --2v

--mitu töötajad on soo ja linna kaupa töötamas
select City, Gender, SUM(CAST(Salary as int)) as TotalSalary,
count (Id) as [Total Employee(s)]
from Employees
group by City, Gender

--kuuvab kas naised või mehed linnade kaupa
--kasutage where
select City, Gender, SUM(CAST(Salary as int)) as TotalSalary,
count (Id) as [Total Employee(s)]
from Employees
where Gender = 'Female'
group by City, Gender

--sama tulemuse nagu eelmine kord, aga kasutage: having
select City, Gender, SUM(CAST(Salary as int)) as TotalSalary,
count (Id) as [Total Employee(s)]
from Employees
group by City, Gender
having Gender = 'Female'

--kõik, kes teenivad rohkem, kui 4000
select *from Employees
where Salary > 4000
--having
select City, Gender, SUM(CAST(Salary as int)) as TotalSalary,
count (Id) as [Total Employee(s)]
from Employees
group by City, Gender
having SUM(CAST(Salary as int)) > 4000

--loome tabeli, milles hakkatakse
--autumaatselt numerdama Id-d
create table Test1
(
Id int identity(1,1),
Value nvarchar(20)
)
insert into Test1 values ('x')
select *from Test1

--Tund 5 (04.03.2026)--

--kustutame veeru nimega City Employees tabelis
alter table Employees
drop column City
-------------------
--inner join--

--kuvab neid, kellel on Department all olemas väärtus
--mitte kattuva read eemaldatakse tulemusest
--ja sellepärast ei näidata Jamesi ja Rasselit tabelis
--kuna neil on DepartmentId NULL
select Name, Gender, Salary, DepartmentName
from Employees
inner join Department
on Employees.DepartmentId = Department.Id
--  INNER JOIN on SQL-is kõige levinum andmete ühendamise viis,
--mis tagastab kirjed ainult siis, kui vastavus
--(kattuv väärtus) eksisteerib mõlemas tabelis
------------
--left join
select Name, Gender, Salary, DepartmentName
from Employees
left join Department  --võib kasutada ka left outer join-i
on Employees.DepartmentId = Department.Id
--uurige, mis on -left join-
-- LEFT JOIN on SQL-i päringu tüüp, mis tagastab kõik
--read vasakpoolsest (esimesest) tabelist
--ja vastavad read parempoolsest (teisest) tabelist,
--siis kui seal puudub võõrvõtme reas väärtus
-----------
--right join
select Name, Gender, Salary, DepartmentName
from Employees
right join Department
on Employees.DepartmentId = Department.Id
--right jion näitab paremas(Department) tabelis olevaid väärtuseid,
--mis ei ühti vasaku(Employees) tabeliga
-----------
--outer join
select Name, Gender, Salary, DepartmentName
from Employees
full outer join Department
on Employees.DepartmentId = Department.Id
--mõlema tabeli read kuvab

--teha cross join
select Name, Gender, Salary, DepartmentName
from Employees
cross join Department
--korrutab kõik omavahel läbi

--teha left join, kus Employees tabilist Department on null
select Name, Gender, Salary, DepartmentName
from Employees
left join Department
on Employees.DepartmentId = Department.Id
where Employees.DepartmentId is NULL
--teine variant
select Name, Gender, Salary, DepartmentName
from Employees
left join Department
on Employees.DepartmentId = Department.Id
where Department.Id is NULL
--näitab ainult neid, kellel on vasakus tabelis (Employees)
--DepartmentId null


select Name, Gender, Salary, DepartmentName
from Employees
right join Department
on Employees.DepartmentId = Department.Id
where Employees.DepartmentId is NULL
--näitab ainult paremas tabelis olevar rida,
--mis ei kattu Employees-ga

--full join
--mõlema tabeli mitte-kattuvate väärtustega read kuvab välja
select Name, Gender, Salary, DepartmentName
from Employees
full join Department
on Employees.DepartmentId = Department.Id
where Employees.DepartmentId is null
or Department.Id is null

--teete AdventureWorksLT2019 andmebaasile join päringuid:
--inner join, left join, right join, cross join, full join
--tabeleid sellesse andmebaasi juurde ei tohi teha

--inner join--
select p.Name AS ProductName, pc.Name AS CategoryName
from SalesLT.Product p
inner join SalesLT.ProductCategory pc
on p.ProductCategoryID = pc.ProductCategoryID

--left join--
select p.Name as ProductName, pc.Name as CategoryName
from SalesLT.Product p
left join SalesLT.ProductCategory pc
on p.ProductCategoryID = pc.ProductCategoryID

--right join--
select p.Name as ProductName, pc.Name as CategoryName
from SalesLT.Product p
right join SalesLT.ProductCategory pc
on p.ProductCategoryID = pc.ProductCategoryID

--full join--
select p.Name as ProductName, pc.Name as CategoryName
from SalesLT.Product p
full join SalesLT.ProductCategory pc
on p.ProductCategoryID = pc.ProductCategoryID

--cross join--
select p.Name as ProductName, pc.Name as CategoryName
from SalesLT.Product p
cross join SalesLT.ProductCategory pc

--inner join--
select PRODUCT.Name as [Product Name], ProductNumber, Listprice,
ProductModel.Name as [Product Model Name],
Product.ProductModelId,
ProductModel.ProductModelID
--mõnikord peab ka tabeli ette kirjutama  täpsustama info
--nagu on SalesLT.Product
from SalesLT.Product
inner join SalesLT.ProductModel
--antud juhul Producti tabelis ProductMOdelId võõrvõti,
--mis ProductModeli tabelis on primaarvõti
on Product.ProductModelID = ProductModel.ProductModelId
--mõnikord pesb muutuja ette kirjutama tabeli nimetuse nagu on product.Name
--et editor saaks aru, et kumma tabeli muutujat soovitakse ja ei tekiks
--segadust