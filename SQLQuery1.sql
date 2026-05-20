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
select Product.Name, ProductNumber,ListPrice,
ProductModel.Name as [Product Model Name],
Product.ProductModelId, ProductModel.ProductModeId
--mõnikord peab ka tabeli ette kirjuama täpsustava info
--nagu on SelesLt.Product
from SalesLt.Product
inner join SalesLt.ProductModel
--antud juhul Producti tabelis ProductModelId võõrvõti,
--mis productModeli tabelis on primaarvõtti
on Product.ProductModelId = PRODUCTModel.productModelId


--inner join--
------------------
select p.Name AS ProductName, pc.Name AS CategoryName
from SalesLT.Product p
inner join SalesLT.ProductCategory pc
on p.ProductCategoryID = pc.ProductCategoryID

--left join--
------------------
select p.Name as ProductName, pc.Name as CategoryName
from SalesLT.Product p
left join SalesLT.ProductCategory pc
on p.ProductCategoryID = pc.ProductCategoryID

--right join--
-----------------
select p.Name as ProductName, pc.Name as CategoryName
from SalesLT.Product p
right join SalesLT.ProductCategory pc
on p.ProductCategoryID = pc.ProductCategoryID

--full join--
-----------------
select p.Name as ProductName, pc.Name as CategoryName
from SalesLT.Product p
full join SalesLT.ProductCategory pc
on p.ProductCategoryID = pc.ProductCategoryID

--cross join--
-----------------
select p.Name as ProductName, pc.Name as CategoryName
from SalesLT.Product p
cross join SalesLT.ProductCategory pc

          --Tund nr 6  12.03.2026--
------------------------------------------------

--isnull funktsiooni kasutamine
select ISNULL ('Ingvar', 'No Manager') as Manager

--NULL asemel kuvab No Manager
select coalesce (NULL, 'No Manager') as Manager

alter table Employees
add ManagerId int

--neile, kellel ei ole ülemust, siis paneb neile No Manager teksti
--kasutage left joini
select E.Name as Employee, ISNULL(M.Name, 'No Manager') as manager
from Employees E
left join Employees M
on E.ManagerId = M.Id

--kasutame inner joini
--kuvab ainult Managerid all olevate isikute väärtuseid
select E.Name as Employee, ISNULL(M.Name, 'No Manager') as manager
from Employees E
inner join Employees M
on E.ManagerId = M.Id

--kõik saavad kõikide ülemused olla
select E.Name as Employee, M.Name as manager
from Employees E
cross join Employees M 

--lisame Employees tabelise uued veerud 
alter table Employees
add MiddleName nvarchar(30), LastName nvarchar(30)

--rename
--muudame olemasoleva veeru nimetust
sp_rename 'Employees.Name', 'FirstName'

UPDATE Employees
SET FirstName = 'Tom', MiddleName = 'Nick', LastName = 'Jones'
WHERE Id = 1;

UPDATE Employees
SET FirstName = 'Pam', MiddleName = NULL, LastName = 'Anderson'
WHERE Id = 2;

UPDATE Employees
SET FirstName = 'John', MiddleName = NULL, LastName = NULL
WHERE Id = 3;

UPDATE Employees
SET FirstName = 'Sam', MiddleName = NULL, LastName = 'Smith'
WHERE Id = 4;

UPDATE Employees
SET FirstName = NULL, MiddleName = 'Todd', LastName = 'Someone'
WHERE Id = 5;

UPDATE Employees
SET FirstName = 'Ben', MiddleName = 'Ten', LastName = 'Sven'
WHERE Id = 6;

UPDATE Employees
SET FirstName = 'Sara', MiddleName = NULL, LastName = 'Connor'
WHERE Id = 7;

UPDATE Employees
SET FirstName = 'Valarine', MiddleName = 'Balerine', LastName = NULL
WHERE Id = 8;

UPDATE Employees
SET FirstName = 'James', MiddleName = '007', LastName = 'Bond'
WHERE Id = 9;

UPDATE Employees
SET FirstName = NULL, MiddleName = NULL, LastName = 'Crowe'
WHERE Id = 10;

--igast reast võtab esimesena täidetud lahtri ja kuvab ainult seda
--
select *from Employees
select Id, coalesce(FirstName, MiddleName, LastName) as Name 
from Employees

--loome kaks tabelit 
create table IndianCustomers
(
Id int identity(1,1),
Name nvarchar(25),
Email nvarchar(25)
)
create table UKcustomers
(
Id int identity(1,1),
Name nvarchar(25),
Email nvarchar(25)
)
--sisestame tabelisse andmeid
insert into IndianCustomers(Name,Email)
values('Rai', 'R@R.com'),
('Sam', 'S@S.com')
insert into UKCustomers(Name,Email)
values('Ben', 'B@B.com'),
('Sam', 'S@S.com')

select *from IndianCustomers
select *from UKcustomers

--kasutame union all, mis näitab kõiki ridu
--union all ühendab tabelid ja nätab sisu
select Id, Name, Email from IndianCustomers
union all
select Id, Name, Email from UKcustomers

--kordavate väärtusega read pannakse ühte ja ei korrata
select Id, Name, Email from IndianCustomers
union 
select Id, Name, Email from UKcustomers

--kasutada union all, aga sorteerid nime järgi
select Id, Name, Email from IndianCustomers
union all
select Id, Name, Email from UKcustomers
order by name

--stored procedure
--tavaliselt pannkse nimetuse ette sp, mis tähendab stored procedure
create procedure spGetEmployees
as begin
	select FirstName, Gender from Employees
end

--nüüd saab kasutada selle nimelist sp-d
spGetEmployees
exec spGetEmployees
execute spGetEmployees

create proc spGetEmployeesByGenderAndDepartment
--@ - tähendab muutujat
@Gender nvarchar (20),
@DepartmentId int
as begin
	select FirstName, Gender, DepartmentId from Employees where Gender = @Gender
	and DepartmentId = @DepartmentId
end

--kui nüüd allolevat käsklust käima panna , siis nõuab gender parametriid 
spGetEmployeesByGenderAndDepartment

--õige variant 
spGetEmployeesByGenderAndDepartment 'Male', 1

--niimodi saab sp kirja pandud järjekorrast mööda minna, kui ise paned muutuja palka
spGetEmployeesByGenderAndDepartment @DepartmentId = 1, @Gender = 'Male'

--saab vaadata sp sisu result vaates
sp_helptext spGetEmployeesByGenderAndDepartment

--kuidas muuta sp-d ja panna sina võti peale,
--et keegi teine peale teile ei saaks muuta 
--kuskile tuleb lisada with encryption
alter proc spGetEmployeesByGenderAndDepartment
@Gender nvarchar(20),
@departmentId int
with encryption
as begin
	select FirstName, Gender, DepartmentId from Employees where Gender = @Gender
	and DepartmentId = @DepartmentId
end

--sp tegemine
create proc spGetEmployeesCountByGender
@Gender nvarchar(20),
@EmployeeCount int out
as begin
	select @EmployeeCount = count(Id)from Employees where Gender = @Gender
end

--annab tul, kus loendab ära nõutele vastavad read
--prindib ka tulemuse kirja teel
--tuleb teha declare muutuja @TotalCount, mis on int
--execute spGetEmployeesCountByGender sp, kus on parametriid Male ja TotalCount 
--if ja else, kui TotalCount = 0, siis tuleb tekst TotalCount is null
--lõpus print kasuta @TotalCount puhul

-- Käivitamine
declare @TotalCount int

execute spGetEmployeesCountByGender 'Male', @TotalCount out

if (@TotalCount = 0)
    print '@TotalCount is null'
else
    print '@Total count is not null'
print @TotalCount

-näitab ära, mitu rida vastab nõuetele

--deklareerime muutuja @TotalCount, mis on int andmetüüp
declare @TotalCount int
--käivitame stored procedure spGetEmployeesCountByGender, kus on parameetrid
--@EmployeeCount = @TotalCount out ja @Gender
execute spGetEmployeesCountByGender @EmployeeCount = @TotalCount out, @Gender = 'Female'
--prindib konsooli välja, kui TotalCount on null või mitte null
print @TotalCount

--sp sisu vaatamine
sp_help spGetEmployeesCountByGender
--tabeli info vaatamine
sp_help Employees
--kui soovid sp teksti näha
sp_helptext spGetEmployeesCountByGender

--vaatame, millest sõltub meie valitud sp
sp_depends spGetEmployeesCountByGender
--näitab, et sp sõltub Employees tabelist, kuna seal on count(Id)
--ja Id on Employees tabelis

--vaatame tabelit
sp_depends Employees

--teeme sp, mis annab andmeid Id ja Name veergude kohta Employees tabelis
create proc spGetNameById
@Id int,
@Name nvarchar(20) output
as begin
select @Id = Id, @Name = FirstName from Employees
end

--annab kogu tabeli ridade arvu
create proc spTotalCount2
@TotalCount int output
as begin
select @TotalCount = count(Id) from Employees
end

--on vaja teha uus  päring, kus kasutame spTotalCount2 sp-d,
--et saada tabeli ridade arv

--tuleb deklareedida muutuja @TotalCount, mis on int andmetüüp
declare @TotalEmployees int
--tuleb execute spTotalCount2, kus on parameeter @TotalCount = @TotalCount out
exec spTotalCount2 @TotalEmployees out
select @TotalEmployees

--mis Id all on keegi nime järgi
create proc spGetNameById1
@Id int,
@FirstName nvarchar(20) output
as begin
select @FirstName =FirstName from Employees where Id = @Id
end
--annab tulemuse, kus id 1(seda numbrit saab muuta) real on keegi
--printi tuleb kasutada, et näidata tulemust
declare @FirstName nvarchar(20)
execute spGetNameById1 3, @FirstName output
print 'Name of the employee = ' + @FirstName

--tehke sama, mis eelmine aga kasutage spGetNameById sp-d
--FirstName lõpus on out
declare @FirstName nvarchar(20)
execute spGetNameById1 3, @FirstName out
print 'Name = ' + @FirstName

--output tagastab muudetud read kohe päringu tulemusena
--see on salvestatud protseduuris ja ühe väärtuse tagastamine
--out ei anna mitte midagi, kui seda ei määra execute käsus

          --Tund nr 8  19.03.2026--
------------------------------------------------

sp_help spGetNameById

create proc spGetNameById2
@Id int
--kui on begim, siis on ka end kuskil olemas
as begin
	return (select FirstName from Employees where Id = @Id)
end

--
--tuleb veateade kuna kutsusime välja int-i, aga Tom on nvarchar
declare @EmployeeName nvarchar(50)
execute @EmployeeName = spGetNameById2 1
print 'Name of the employee = ' + @EmployeeName


--sisseehitatud string funktsioonid
--see konverteerib ASCII tähe väärtuse numbriks
select ASCII ('A')

select CHAR(65)

--prindime kogu tähestiku välja
declare @Start int
set @Start = 97
while @Start <= 122
begin
    select char(@Start)
    set @Start = @Start + 1
end
--kasutate while, et näidata kogu tähestik ette

--emaldame  tühjad kohad lulgudes
select ltrim ('                    hello')
select  ('                    hello')

--tühikute eemaldamine veerust, mis on tabelis 
select FirstName, MiddleName, LastName from Employees
--eemaldage tühikud FirstName veerust ära
select ltrim (FirstName) as FirstName, MiddleName, LastName from Employees

--paremalt poolt tühjad stringid lõikab ära
select RTRIM ('    hello     ')
--keerab kooloni sees olevad andmed vastupidiseks
--vastavalt lower-ga ja upper-ga saan muuta märkide suurus
--reverse funktsioon pöörab kõik umber
select REVERSE(UPPER(ltrim(FirstName))) as FirstName, MiddleName, lower(LastName),
rtrim(LTRIM(FirstName)) + ' ' + MiddleName + ' ' + LastName as FullName
from Employees

--left, right, substring
--vasakult poolt neil esimest tähte
select LEFT ('ABCDEF', 4)
--paremalt poolt kolm tähte
select right ('ABCDEF', 4)

--kuvab @-tähtemärgi asetust e mitmes on @-märk
select CHARINDEX('@', 'sara@aaa.com')

--esimene nr peale komakohta näitab, et mitmendast alustab ja 
--siis mitu nr peale seda kuvada
select SUBSTRING ('pam@bbb.com', 5, 2)

--@-märgist kuvab kolm tähemärki. viimase nr saab määrata pikkust
select SUBSTRING('pam@bbb.com', CHARINDEX('@', 'pam@bbb.com') + 1, 3)

--peale @-märki hakkkab kuvama tulemus, nr saab kaugust seadistada
select SUBSTRING('pam@bbb.com', CHARINDEX('@', 'pam@bbb.com') + 2,
LEN('pam@bbb.com') - charindex('@', 'pamm@bbb.com'))

alter table Employees
add Email nvarchar(20)

select * from Employees
update Employees set Email = 'tom@aaa.com' where Id = 1
update Employees set Email = 'pam@bbb.com' where Id = 2
update Employees set Email = 'john@aaa.com' where Id = 3
update Employees set Email = 'sam@bbb.com' where Id = 4
update Employees set Email = 'todd@bbb.com' where Id = 5
update Employees set Email = 'ben@ccc.com' where Id = 6
update Employees set Email = 'sara@ccc.com' where Id = 7
update Employees set Email = 'valarie@aaa.com' where Id = 8
update Employees set Email = 'james@bbb.com' where Id = 9
update Employees set Email = 'russell@bbb.com' where Id = 10

--soovime teada saada domeeninimesid emailides
select SUBSTRING (Email, CHARINDEX ('@', Email)+1,
len(Email) - charindex('@', Email)) as EmailDomain
from Employees

--alates teisest tähest emilis kuni @ märgini on tärnid
select FirstName, LastName, 
	substring(Email, 1, 2) +replicate('*', 5) +
	substring(Email, charindex('@', Email),
	len(Email)- charindex('@', Email) + 1) as Email
from Employees	

--kolm korda näitab strings olevat väärtus
select REPLICATE ('asd', 3)

--tühiku sissestamine
select SPACE (5)

--tühiku sissestamine FirstName ja LastName vahele
select FirstName + SPACE(25) + LastName as FullName 
from Employees

--PATINDEX
--saama, mis charindex, aga dünaamilissem ja saab 
--kasutada wildcardi
select Email, PATINDEX('%@aaa.com', Email) as Firstoccurence
from Employees
where PATINDEX('%@aaa.com', Email) > 0
--leian kõik selle domeeni esinejad ja alates mitmendast märgist algab @

--kõik .com emailid asendab .net-ga
select Email, REPLACE(Email, '.com', '.net') as ConvertedEmail
from Employees

--soovin asendada peale esimest märki kolm tähte viie tärniga
select FirstName, LastName, Email,
	stuff(Email, 2, 3, '*****') as StuffedEmail
from Employees

create table DateTime
(
	c_time time,
	c_date date,
	c_smalldatetime smalldatetime,
	c_detetime datetime,
	c_detetime2 datetime2,
	c_datetimeoffset datetimeoffset
)

select * from DateTime

--konkreetse masina kellaaeg
select GETDATE(), 'GETDATE()'

insert into DateTime
values (GETDATE(), GETDATE(), GETDATE(),GETDATE(),GETDATE(),GETDATE())

select * from DateTime

update DateTime set c_datetimeoffset = '2026-03-19 14:26:02.9833333 +10:00'
where c_datetimeoffset = '2026-03-19 14:26:02.9833333 +00:00'

select CURRENT_TIMESTAMP, 'CURRENT_TIMESTAMP' -- aja päring
select SYSDATETIME(), 'SYSDATETIME'  --veel täpsena aja päring
select SYSDATETIMEOFFSET(), 'SYSDATETIME'   --täpne aeg koos ajaliste nihkena
select GETUTCDATE(), 'GETUTCDATE'   --UTC aeg

--saab kontrolida, kas on õige andmetüüp
select ISDATE('asd') --tagastab 0 kuna string ei ole date

select ISDATE(GETDATE())--kuidas saada vastuseks 1 isdate puhul?
select ISDATE ('2026-03-19 14:26:02.9833333') --tagastab 0 kuna max kolm komakohta võib olla
select ISDATE ('2026-03-19 14:26:02.983') --tagaastab 1

select DAY(GETDATE()) --annab tänase päeva nr
select DAY('01/24/2026') --annab stringis oleva kp ja järjestus peab olema õige
select MONTH(GETDATE()) --annab tänase kuu nr
select MONTH('01/24/2026')--annab stringis oleva kuu ja järjestus peab olema õige
select year(GETDATE()) --annab tänase aasta nr
select year('01/24/2026')--annab stringis oleva aasta ja järjestus peab olema õige

select DATENAME(DAY, '2026-03-19 14:26:02.983') --annab stringis oleva päeva nr
select DATENAME(Month, '2026-03-19 14:26:02.983') --annab stringis oleva kuu nr
select DATENAME(WEEKDAY, '2026-03-19 14:26:02.983') --annab stringis oleva nädala nr

create table EmployeeWithDates
(
	Id nvarchar(2),
	Name nvarchar(20),
	DateOfBirth datetime
)

insert into EmployeeWithDates (Id, Name,DateOfBirth)
values (1, 'Sam', '1999-01-10 15:56:02.983');
insert into EmployeeWithDates (Id, Name,DateOfBirth)
values (2, 'Ken', '2000-02-21 10:16:02.983');
insert into EmployeeWithDates (Id, Name,DateOfBirth)
values (3, 'Andrew', '2010-01-26 02:26:02.983');
insert into EmployeeWithDates (Id, Name,DateOfBirth)
values (4, 'Katy', '2007-08-20 09:35:02.983')

select * from EmployeeWithDates

 --Tund nr 9  24.03.2026--
------------------------------------------------

--kuidas võtta ühest veerust andmeid ja selle abil luua uued veerud

--vaatab DoB veerust päeva ja kuvab päeva nimetuse sõnana
select Name, DateOfBirth, Datename(weekday, DateOfBirth) as [Day],
 --vaatab VoB veerust kuupäevasi ja kuvab kuu nr
 Month(DateOfBirth) as MonthNumber,
 --vaatab DoB veerust kuud ja kuvab sõnana
 DateName(Month, DateOfBirth) as [MonthName],
 --võtab DoB veerust aasta
 Year(DateOfBirth) as [Year]
 from EmployeeWithDates

 --kuvab 3 kuna USA nädal algab pühapäevaga
 select Datepart(weekday, '2026-03-24 09:35:02.983')
 --tehke sama aga, kasutame kuu-d
 select Datepart(month, '2026-03-24 09:35:02.983')
 --liidab stringis oleva kp 20 päeva juurde
 select Dateadd(day, 20, '2026-03-24 09:35:02.983')
 --lahutab 20 päeva maha
 select Dateadd(day, -20, '2026-03-24 09:35:02.983')
 --kuvab kahe stringis oleva kuudevahelist aega nr-na
 select datediff(month, '11/20/2026', '01/20/2024')
 --tehke sama, aga kasutage aastat
 select datediff(year, '11/20/2026', '01/20/2028')

 --alguse uurigte, mis on funktsioon MS SQL
 --eelkirjutatud toimingud,salvestatud tegevus,andmebaasis salvestatud alamprogramm.

 --miks seda on vaja
 --pakkuda DB-s korduvkasutatud funktsionaalsus, korduvate arvutuste lihtsustamiseks.
 
 --mis on selle eelised ja puudused
--saada kiiresti kasutada toiminguid ja ei pea uuesti koodi kirjutama
--Funktsioonid ei tohi muuta andmebaasi olekut

create function fnComputeAge(@DOB datetime)
returns nvarchar(50)
as begin
    declare @tempdate datetime, @years int, @months int, @days int
    select @tempdate = @DOB

    select @years = datediff(year, @tempdate, getdate()) - case when (month(@DOB) >
    month(getdate())) or (month(@DOB) = month(getdate()) and day (@DOB) > day(getdate()))
    then 1 else 0 end
    select @tempdate = dateadd(year, @Years, @tempdate)

select @months  = datediff(month, @tempdate, getdate()) - case when day(@DOB) > day(getdate())
then 1 else 0 end
select @tempdate = dateadd(month, @months, @tempdate)

select @days = datediff(day, @tempdate, getdate())

declare @Age nvarchar(50)
      set @Age = cast(@years as nvarchar(4)) + ' Years ' + cast(@months as nvarchar(2))
      + ' Months ' + cast(@days as nvarchar(2)) + ' Days old '
  return @Age
end
create function fnComputeAge(@DOB datetime)
returns nvarchar(50)
as begin
    declare @tempdate datetime, @years int, @months int, @days int
select @tempdate = @DOB

select @years = DATEDIFF(YEAR, @tempdate, GETDATE()) - case when (month(@DOB)>
MONTH(GETDATE())) or (MONTH(@DOB) = MONTH(GETDATE())and day(@DOB) > DAY(GETDATE()))
then 1 else 0 end
select @tempdate = DATEADD(YEAR, @years, @tempdate)

select @months = DATEDIFF(MONTH, @tempdate, GETDATE()) - case when DAY(@DOB) >
DAY(getdate()) then 1 else 0 end
select @tempdate = DATEADD(MONTH, @months, @tempdate)

select @days = datediff(day, @tempdate, GETDATE())

declare @Age nvarchar(50)
   set @Age = CAST (@years as nvarchar(4)) + 'Years' + CAST(@months as nvarchar(2))
+ 'Months' + CAST (@days as nvarchar(2)) + 'Days old'
    return @Age
end

select Id, Name, DateOfBirth, dbo.fnComputeAge(DateOfBirth)
as Age from EmployeeWithDates
          --Tund nr 10  31.03.2026--
------------------------------------------------
--kui kasutame seda funktsiooni, siis same tänase päeva vahet stringis välja tooduga
select dbo.fnComputeAge('02/24/2010') as Age

--na peale DOB muutujat, et mismoodi kuvada DOB-d
select Id, Name, DateOfBirth,
CONVERT (nvarchar, DateOfBirth, 126) as ConvertedDOB
from EmployeeWithDates

select Id, Name, Name + ' - ' + CAST(Id as nvarchar) as
[Name-Id] from EmployeeWithDates

select CAST(GETDATE() as date) -- tänane kp
--tänane kp, aga kasutage convert-i, et kuvada stringina
select convert(nvarchar,
cast(getdate() as date), 126) as TänaneKuupäev

--matemaatilised funktsioonid
select ABS (-5) -- ABS on absoluutväärtusega number ja tulemuseks
--saame ilma miinus närgiga 5
select CEILING(4.2) --ceiling on funktsioon, mis ümardab ülespoole ja tulemuseks saame 5
select CEILING(-4.2) --ceiling on funktsioon, mis ümardab ülespoole ja tulemuseks saame 4
select floor(15.2) --floor on funktsioon, mis ümbritseb alla ja tulemuseks saame 15
select floor(-15.2)--floor ümmardab ka miinus numbri alla, mis tähendab, et saame -16
select power(2, 4) --kaks astems neli
select square(9) --antud juhul üheksa ruudus
select sqrt(16) --antud juhul 16 ruutjuur

select RAND() -- rand on funktsioon, mis genereerib
--juhuliku numbri vahemikus 0 kuni 1
--kuidas sada täisnumber iga kord?
select floor(RAND() * 100)

--iga kord näitab 10 suvalist numbrit
declare @counter int
set @counter = 1
while (@counter <= 10)
begin
    print floor(rand() * 100)
    set @counter = @counter + 1
end

select ROUND(850.556, 2)
--round on fnktsioon, mis ümardab kaks komakohta 
--ja tulemuseks same 850.56
select ROUND (850.556, 2, 1)
--round on funktsioon , mis ümardab kaks komakohta ja 
--kui kolmas parameeter on 1, siis ümmardab alla
select ROUND(850.556, 1) 
--round on funktsioon , mis ümardab ühe komakohta ja 
--ja tulemuseks same 850.6
select ROUND(850.556, 1, 1 )
--round on funktsioon , mis ümardab ühe komakohta ja 
--pealt tulemuseks saame 850.5
select ROUND(850.556, -2) --ümardab täisnumber ülessepoole
--ja tulemuseks saame 900
select ROUND(850.556, -1)--ümardab täisnumber alla
--ja tulemuseks saame 850

--
create  function dbo.CalculateAge(@DOB date)
returns int
as begin 
declare @Age int

	set @Age = DATEDIFF(year, @DOB, GETDATE()) 
	- case
		when (MONTH(@DOB) > MONTH(GETDATE())) or
		(MONTH(@DOB) = MONTH(GETDATE()) and DAY(@DOB) > DAY(GETDATE()))
		then 1 else 0 end 
	return @Age
end

--kui valmis proovige ja vaadake, kas annab õige vanuse
exec dbo.CalculateAge '1990-05-15'
SELECT dbo.CalculateAge('1990-05-15') AS Vanus

--arvutab välja, kui vana on isik ja võtab arvesse kuud ning pävad
--antud juhul näitab kõike, kes on üle 36 a vanad
select Id, Name, dbo.CalculateAge(DateOfBirth) as Age from EmployeeWithDates
where dbo.CalculateAge(DateOfBirth) < 36

	---Tund nr 11  02.04.2026---
------------------------------------

---inline table valued functions---
alter table EmployeeWithDates
add DepartmentId int
alter table EmployeeWithDates
add Gender nvarchar(10)

select * from EmployeeWithDates
-- DepartmentId
UPDATE EmployeeWithDates SET DepartmentId = 1 WHERE Id = 1;
UPDATE EmployeeWithDates SET DepartmentId = 2 WHERE Id = 2;
UPDATE EmployeeWithDates SET DepartmentId = 1 WHERE Id = 3;
UPDATE EmployeeWithDates SET DepartmentId = 3 WHERE Id = 4;

-- Gender
UPDATE EmployeeWithDates SET Gender = 'Male'   WHERE Id = 1;
UPDATE EmployeeWithDates SET Gender = 'Female' WHERE Id = 2;
UPDATE EmployeeWithDates SET Gender = 'Male'   WHERE Id = 3;
UPDATE EmployeeWithDates SET Gender = 'Female' WHERE Id = 4;

--kutsuta nullid
SELECT * FROM EmployeeWithDates
WHERE Id IS NULL;

DELETE FROM EmployeeWithDates
WHERE Id IS NULL;

SELECT * FROM EmployeeWithDates;

insert into EmployeeWithDates (Id, Name, DateOfBirth,DepartmentId, Gender)
values (5, 'Todd', '2000-03-24 09:35:02.983', 1, 'Male')

--scalar function annab mingis vahemikus olevaid andmeid,
--inline table values ei kasuta begin ja end funktsioone
--scalar annab väärtused ja inline annab tabeli
create function fn_EmployeesByGender(@Gender nvarchar(10))
returns table 
as
return (select Id, Name, DateOfBirth, DepartmentId, Gender
				from EmployeeWithDates
				where Gender = @Gender)
--kuidas leida kõik naised tabelis EmployeeWithDates
--ja kasutada funktsiooni fn_EmployeesByGender
select * from fn_EmployeesByGender('Female')

--tahaks ainult Pami nime näha
select * from fn_EmployeesByGender('Female') where Name = 'Pam';

select *from Department

--kahest erinevast tabelist andmete võtmine ja 
--koos kuuvamiine 
--esimene on funktsioon ja teine tabel
select Name, Gender, DepartmentName
from fn_EmployeesByGender('Male') E
join Department D on D.Id = E.DepartmentId

--multi tabel statment
--inline funktsioon 
create function fn_GetEmployees()
returns table as
return (select Id, Name, CAST(DateOfBirth as date)
		as DOB
		from EmployeeWithDates)

select * from fn_GetEmployees()

--multi state puhul peab defineerima uue tabeli veerud koos muutujatega
--funktsiooni nimi on fn_MS_GetEmployees()
--peab edastama meile, Id, Name, DOB tabelist EmployeeWithDates
create function fn_MS_GetEmployees()
returns @Table Table(Id int ,Name nvarchar(20), DOB date)
as begin
	insert into @Table
	select Id, Name, CAST (DateOfBirth as date)
	from EmployeeWithDates
return
end

select * from fn_MS_GetEmployees()

--inline tabeli funktsioonid on paremini töötmas kuna käsiletakse vaatrna
--multi puhul on pm tegemist stored proceduriga ja kulutab ressursi rohkem

--muudame andmeid ja vaatame , kas inline funktsioonis on muutused kajastatud
update fn_GetEmployees() set Name = 'Sam1' where Id = 1
select *from fn_GetEmployees() -- saab muuta andmeid

update fn_MS_GetEmployees() set Name = 'Sam2' where Id = 1
--ei saa muuta andmeid multi state funktsioonis,
--kuna see on nagu stored procedure

--deterministic vs non-deterministic functions
--deterministic funktsioonid annavad erineva tulemuse, kui sissend on sama
select COUNT(*) from EmployeeWithDates
select SQUARE(4)
--non-deterministic funktsioonid annavad erineva tulemuse, kui sisend on sama
select GETDATE()
select CURRENT_TIMESTAMP
select RAND()


--------------16.04.2026---------------
			---tund 12---
----------------------------------------
		--funktsioonid--
--loome funktsiooni
alter function fn_GetNameById(@id int)
returns nvarchar(30)
as begin
	return (select Name from EmployeeWithDates where Id = @id)
end

--kasutame funktsiooni, leides Id 1 all oleva inimene
select dbo.fn_GetNameById(1)

select * from EmployeeWithDates

--saab näha funktsiooni sisu
sp_helptext fn_GetNameById

--nüüd muudate funktswiooni nimega fn_GetNameById
--ja panete sinna encryption, et keegi peale teie ei saaks sisu näha
alter function fn_GetNameById(@id int)
returns nvarchar(30)
with encryption
as begin
    return (select Name from EmployeeWithDates where Id = @id)
end

--kui nüüd sp_helptext kasutada, siis ei näe function sisu
sp_helptext fn_GetNameById

--kasutame scemabindingud, et näha , mis on funktsiooni sisu
alter function fn_GetNameById(@Id int)
returns nvarchar(30)
with schemabinding
as begin
    return (select Name from dbo.EmployeeWithDates where Id = @id)
end

--schembinding tähndab, et kui keegi üritab muuta employeesWithDates
--tabelist, siis ei lase seda teha, kuna see on seotud
--fm_GetNameById funktsiooniga

--ei saa kutsutada ega muuta tabelist EmployeeWithdates
--kuna see on antd seotud fn_GetNameById funktsiooniga 
drop table dbo.EmployeeWithDates

-------------------------------------------------
			---temporary tables---
--see on olemas ainult selle sesssioni jooksul 
--kasutatakse # sümboliit, et saada aru, et tegemist on temporary tabeliga
create table #PersonDetails (Id int, Name nvarchar (20))

insert into #PersonDetails values (1, 'Sam')
insert into #PersonDetails values (2, 'Pam')
insert into #PersonDetails values (3, 'John')

select * from #PersonDetails

--temporary tabelitte nimekirja ei näe, kui kasutada sysobjects
--tabelit, kuna need on ajutised
select Name from sysobjects
where name like '#PersonDetails'

--kustutame temporary tabeli
drop table #PersonDetails

--loome sp, mis loob temporary tabelii ja paneb sinna andmed
create proc spCreateLocalTempTable
as begin
create table #PersonDetails (Id int, Name nvarchar(20))

insert into #PersonDetails values (1, 'Sam')
insert into #PersonDetails values (2, 'Pam')
insert into #PersonDetails values (3, 'John')

select * from #PersonDetails
end
---
exec spCreateLocalTempTable


--globaalne temp tabel on olemas kogu
--serveris ja kõigile kasutajale, kes on ühendatud
create table ##GlobalPersonDetails (Id int, Name  nvarchar(20))

--index
create table EmployeeeWithSalary
(
  Id int Primary key,
  Name nvarchar(20),
  Salary int, 
  Gender nvarchar(10)
)
 select * from EmployeeeWithSalary

 insert into EmployeeeWithSalary values (1, 'Sam', 2500, 'Male')
 insert into EmployeeeWithSalary values (2, 'Pam', 6500, 'Female')
 insert into EmployeeeWithSalary values (3, 'John', 4500, 'Male')
 insert into EmployeeeWithSalary values (4, 'Sara', 5500,'Female')
 insert into EmployeeeWithSalary values (5, 'Todd', 3100, 'Male') 

 --otsime inimesi, kelle palhavahemikon 5000 kuni 7000
select * from EmployeeWithSalary
where Salary between 5000 and 7000

--loome indexi Salry veerule, et kiirendada otsingut
--mis asetab andmed Salary veeru järgi järjestatult
create index IX_EmployeeeSalary
on EmployeeeWithSalary(Salary asc)

--saame teada, et mis on selle tabeli primaarvõtti ja index
exec sys.sp_helpindex @objname = 'EmployeeWithSalary'

--tahaks IX_EmployeeSalary indexi kasutada, et otsing oleks kiirem
select * from EmployeeeWithSalary
where Salary between 5000 and 7000

--näitab, et kasutatakse indexi 
--kuna see on järjestatud Salary veeru järgi
select  * from EmployeeeWithSalary with (index(IX_EmployeeeSalary))

--indexi kustutamine
drop index IX_EmployeeeSalary on EmployeeeWithSalary --1
drop EmployeeWithSalary.IX_EmployeeSalary --2

-------indexi tüübid
--1. Klasitrites olevad
--2. Mitte-klastis olevad
--3. Unikaalsed
--4. Filtreeritud
--5. XML
--6. Täistekst
--7. Ruumline
--8. Veerusälitav
--9. Veergude indexid
--10. Välja arvatud veergudega indeksid

--klastid olev index määrab ära tabelis oleva füüsilise järjestuse
--ja selle tulemusel saab tabelis olla ainult üks klastist olev index

create table EmployeeCity
(
  Id int Primary key,
  Name nvarchar(20),
  Salary int, 
  Gender nvarchar(10),
  City nvarchar(50)
)

exec sp_helpindex EmployeeCity

-- andmete õige järjestuse loovad klstrist olevad indeksid 
-- ja kasutab selleks Id nr-t
-- põhjus, miks antud kasutab Id-d, tuleneb primaarvõtmest
 insert into EmployeeeWithSalary values (3, 'John', 4500, 'Male', 'New York'),
 insert into EmployeeeWithSalary values (1, 'Sam', 2500,'Male', 'London'),
 insert into EmployeeeWithSalary values (4, 'Sara', 5500, 'Female', 'Tokyo'),
 insert into EmployeeeWithSalary values (5, 'Todd', 3100, 'Male', 'Toronto'),
 insert into EmployeeeWithSalary values (2, 'Pam', 6500, 'Female', 'Sydney')

 --klastis olevad indexid dikteerivad sälistatud andmete järjestuse tabelis
 --ja seda saab oleva klastrise puhul olla ainult üks

 select * from EmployeeCity
 create clustered index IX_EmployeeCityName
 on EmployeeCity(Name)
 --põhjus , miks ei saa luua klastist olevat
 --indexid Name veerule, on seed, et tabelis on juba klastis
 --olev index Id veerul, kuna see on primarvõti

 --lome composite indexi, mis tähendab, et see on mitme veeru index
 --enne tuleb kustutada klastis oleb index, kuna composite index
 --on klastid olev indexi tüüp
 create clustered IX_EmployeeGenderSalary
 on EmployeeCity(Gender desc, Salary asc)
 --kui teed select päringu sellele tabelile, siis peaksid nägema andmeid,
 -- mis on järjestatud sellelist : Esimeseks võetakse aluseks Gender veerg
 -- kahanevas järjestuses ja siis Salary veerg tõusvas järjestuses

 select * from EmployeeCity

 --mitte klastris olev index on eraldi structuur,
 -- mis hoioab indexi väärtusi
 create nonclustered index IX_EmployeeCityName,
 on EmployeeCity(Name)
 --kui nüüd teed select päringu, siis näed, et andmed on 
 -- järjestatud Id järgi
 select * from EmployeeCity

 --erinevused kahe indeksi vahel
 --1. ainult üks klastis olev index saab olla tabeli peale,
 --mitte klastis olevaid indekseid saab olla mitu
 --2. klastis olevad indeksid on kiiremad kuna indekxs peab tagasi
 --viitama tabellisse juhul, kui selekteeritud veerg ei ole olemas indeksis
 --3. Klastris olev index määrateleb ära tabeli ridade salvestusjärjestuse
 -- ja ei nõua kettal lisa ruumi. Samal mitte klastis olevad indeksid on
 -- salvestatud tabelist eraldi ja nõuab lisa ruumi

create table EmployeeFirstName
(
  Id int Primary key,
  FirstName nvarchar(20),
  LastName nvarchar(20),
  Salary int, 
  Gender nvarchar(10),
  City nvarchar(50)
)

exec sp_helpindex EmployeeFirstName

insert into EmployeeFirstName values (1, 'John', 'Smith', 2500,'Male', 'New York')
insert into EmployeeFirstName values (1, 'Mike', 'Sandoz', 2500,'Male', 'London')

drop index EmployeeFirstName.PK__Employee__3214EC07CCCCBDED
--kui käivitab ülevalpol oleva koodi, siiis tuleb vaeteade
-- et sql server kasutab unique indexid jõutamaks väärtuste
-- unikaalsust ja primaarvõtit koodiga unilaasseid indekseid 
-- ei saa kasutada , aga käsitsi saab

create unique nonclustered index UIX_Employee_FirstName_LastName
on EmployeeFirstName (FirstName, LastName)

--lisame uue piirang peale
alter table EmplojeeFirstName
add constraint UQ_EmployeeFirstNameCity
unique nonclustered (City)

--sisestage kolmas rida andmetega , mis om id-s 3, FirstName-s John,
--LastName-s Menco ja linn on London
insert into EmployeeFirstName values (3, 'John', 'Menco', 3000, 'Male', 'London')

--saab vaadata indeksite inot
exec sp_helpconstraint EmployeeFirstName

-- 1. Vaikimisi primaarvöti loob unikaalse klastris oleva indeksi,
-- samas unikaalne piirang loob unikaalse mitte-klastris oleva indeksi
-- 2. Unikaalset indeksit või piirangut ei saa luua olemasolevasse tabelis
-- kui tabel juba sisaldab väärtusi vötmeveerus
-- 3. Vaikimisi korduvaid väärtusied ei ole veerus lubatud,
-- kui peaks olema unikaalne indeks vöi piirang. Nt, kui tahad sisestada 10 rida andmeid,
-- millest 5 sisaldavad korduviad andmeid, siis köik 10 lükatakse tagasi. kui soovin ainult 5
-- rea tagasi lükkamist ja ülejäänud 5 rea sisestamist, siis selleks
--kasutatakse IGNORE_DUP_KEY

--koodi näide
create unique index IX_EmployeeFirstName 
on EmployeeFirstName(City)
with ignore_dup_key

insert into EmployeeFirstName values (1, 'John', 'Menco', 3120,'Male', 'London')
insert into EmployeeFirstName values (1, 'John', 'Menco', 3213,'Male', 'London1')
insert into EmployeeFirstName values (3, 'John', 'Menco', 3220, 'Male', 'London1')
--enne ignore käsku kõik rida tagasi lükatud, aga
-- nüüd läks keskmine rida kuna linna nimi oli unikaalne 
select * from EmployeeFirstName

----------------------------------
			--View--
--view on virtuaalne tabel, mis on lobu uhe või mitmi tabeli põhjal
select FirstName, Salary, Gender, DepartmentName
from Employees
join Department
on Department.Id = Employees.DepartmentId

create view vw_EmployeesByDetails
as
select FirstName, Salary, Gender, DepartmentName
from Employees
join Department
on Department.Id = Employees.DepartmentId
--otsige ülesse view

--kuidas view-d kasutada : vw_EmployeesByDetails
select * from vw_EmployeesByDetails
-- view ei salvesta andmeid vaikimisi
-- seda tasub vötta, kui salvestatud virtuaalse tabelina
-- milleks vaja:
-- saab kasutada andmebaasi skeemi keerukuse lihtsutamiseks,
-- mitte IT-inimesele
-- piiratud ligipääs andmetele, ei näe köiki veerge

--teeme view, kus näeb ainult IT-töötajad
create view vITEmployeesInDepartment
as
select FirstName, Salary, Gender, DepartmentName
join Department
on Department.Id = Employees.DepartmentId
where Department.DepartmentName = 'IT'

--ülevapool olevat päringut saab liigitada reataseme turvalisuse
--alla. Tahan ainult näidata IT osakonna töötajaid 

select from * vITEmployeesInDepartment

			--23.04.2026--
	-----------tund nr 13------------

--veeru taseme turvalisus
--peale selecti määratled veergude näitamise ära
create view vEmployeesInDepartmentSalaryNoShow
as 
select FirstName, Gender, DepartmentName
from Employees
join Department 
on Employees.DepartmentId = Department.Id

select * from vEmployeesInDepartmentSalaryNoShow

--saab kasutada esitlemaks koondandmeid ja üksikasjalike andmeid
--view , mis tagastab summeritud andmeid 

create view vEmployeesCountByDepartment
as
select DepartmentName, COUNT (Employees.Id) as TotalEmployees
from Employees
join Department
on Employees.DepartmentName
group by DepartmentName

select * from vEmployeesCountByDepartment

--kui soovid vaadata view sisu?
sp_helptext vEmployeesCountByDepartment
--kui soovid muuta, siis kasutad alter view

--kui soovid kustutada, siis kasutad drop view
drop view vEmployeesCountByDepartment

--andmete uuendamine läbi view
create view vEmployeesDataExceptSalary
as
select Id, FirstName, Gender, DepartmentId
from Employees

update vEmployeesDataExceptSalary
set [FirstName] = 'Pam' where Id = 2

--kustutage Id 2 rida ära
drop from vEmployeesDataExceptSalary
where Id = 2
--Andemete sisestamine läbi view: vEmployeeDataExceptSalary
--Id 2, Female, 2, Pam
insert into vEmployeeDataExceptSalary (Id, Gender, DepartmentId, FirstName)
values (2, 'Female', 2, 'Pam')

--indekseeritud view
--MS SQL-s on indekseeritud view nime all ja 
--Oracles materjaliseeritud view nimega 

DROP TABLE IF EXISTS ProductSales;
DROP TABLE IF EXISTS Product;

CREATE TABLE Product
(
    Id int PRIMARY KEY,
    Name nvarchar(20),
    UnitPrice int
);

INSERT INTO Product (Id, Name, UnitPrice)
VALUES
(1, 'Books', 20),
(2, 'Pens', 14),
(3, 'Pencils', 11),
(4, 'Clips', 10);

CREATE TABLE ProductSales
(
    Id int,
    QuantitySold int
);

SELECT * FROM Product;
SELECT * FROM ProductSales;

INSERT INTO ProductSales (Id, QuantitySold)
VALUES
(1, 10),
(3, 23),
(4, 21),
(2, 12),
(1, 13),
(3, 12),
(4, 13),
(1, 11),
(2, 12),
(1, 14);

SELECT * FROM ProductSales;

--loome view mis annab veerud TotalSales ja TotalTranscription

create view vTotalSalesByProduct
with schemabinding
as
select Name,
sum(isnull((QuantitySold + UnitPrice), 0)) as TotalSales,
count_big(*) as TotalTranscriptions
from dbo.ProductSales
join dbo.Product
on dbo.Product.Id = dbo.ProductSales.Id
group by Name

select * from vTotalSalesByProduct

--- kui soovid luua indeksi view sisse, siis peab järgima teatud reegleid
-- 1. view tuleb luua koos schemabinding-ga
-- 2. kui lisafunktsioon select list viitab väljendile ja selle tulemuseks
-- võib olla NULL, siis asendusväärtus peaks olema täpsustatud.
-- Antud juhul kasutasime ISNULL funktsiooni asendamaks NULL väärtust
-- 3. kui GroupBy on täpsustatud, siis view select list peab
-- sisaldama COUNT_BIG(*) väljendit
-- 4. Baastabelis peaks view-d olema viidatud kahesosalie nimega
-- e antud juhul dbo.Product ja dbo.ProductSales.

CREATE UNIQUE CLUSTERED INDEX UIX_vTotalSalesByProduct_Name
ON vTotalSalesByProduct(Name);

select * from vTotalSalesByProduct

--view piirangud
create view vEmployeeDetails
@Gender nvarchar(20) 
as
Select Id, FirstName, Gender, DepartmentId
from Employees
where Gender = @Gender
--mis on sellel view valesti???
--vaatesse e viewisse ei saa kaasa panna parametriid e antud juhul Gender


--teha funktsioon, kus parameetriks on Gender
--soovin näha veerge: Id, FirstName, Gender, DepartmentId
--tabeli nimi on Employees
--funktsiooni nimi on fnEmployeeDetails
DROP FUNCTION IF EXISTS fnEmployeeDetails;
CREATE FUNCTION fnEmployeeDetails(@Gender nvarchar(20))
RETURNS TABLE
AS RETURN
(
    SELECT Id, FirstName, Gender, DepartmentId
    FROM Employees
    WHERE Gender = @Gender
)

--kasutame funktsiooni fnEmployeeDetails koos parameetriga
SELECT * FROM fnEmployeeDetails('Female');


--order by kasutamine 
create view vEmployeeDetailsStored
as
select Id, FirstName, Gender, DepartmentIdfrom Employees
order by Id
--order by-d ei saa kasutada

--temp tabeli kasutamine 
create table ##TestTempTable (Id int, FirstName nvarchar(20), Gender nvarchar (20))
insert into ##TestTempTable values (101, 'Mart', 'Male')
insert into ##TestTempTable values (102, 'Joe', 'Female')
insert into ##TestTempTable values (103, 'Pam', 'Female')
insert into ##TestTempTable values (104, 'James', 'Male')

--view nimi on vOnTempTable
--kasutame ##TestTempTable
--
create view vOnTempTable
as
select Id, FirstName, Gender
from ##TestTempTable
--view-id ja funktsioone ei saa teha ajutistele tabelitele

-----------------------------------------------------
	------------------Triggerid-----------------

--DMÖ trigger
--kokku n kolme tüppi : DML, DDL ja LOGON

--- trigger on stored procedure eriliik, mis automaatselt käivitub,
--- kui mingi tegevus
--- peaks andmebaasis aset leidma

--- DML – data manipulation language
--- DML-i põhilised käsklused: insert, update ja delete

-- DML triggereid saab klassifitseerida kahte tüüpi:
-- 1. After trigger (kutsutakse ka FOR triggeriks)
-- 2. Instead of trigger (selmet trigger e selle asemel trigger)

--- after trigger käivitub peale sündmust, kui kuskil on tehtud insert,
--- update ja delete

--- loome uue tabeli
create table EmployeeAudit
(
Id int identity (1, 1) primary key,
AuditData nvarchar(1000)
)
-- peale iga töötaja sisestamist tahame teada saada töötaja Id-d,
-- päeva ning aega (millal sisestati)
-- kõik andmed tulevad EmployeeAudit tabelisse
-- andmeid sisestame Employees tabelisse
create trigger trEmployeeForInsert
on Employees
for insert
as begin
declare @Id int 
select @Id = Id from inserted
insert into EmployeeAudit
values ('New employee with Id = ' + CAST (@Id as nvarchar(5)) + 'is added at'
+ CAST(GETDATE() as nvarchar(20)))
end

select * from Employees

insert into Employees values 
(11, 'Bob', 'Blob', 'Bomb', 'Male', 3000, 1, 3, 'bob@bob.com')
go
select * from EmployeeAudit

--delete trigger
create trigger trEmployeeForDelete
on Employees
for delete 
as begin
	DECLARE @Id int
	select @Id = Id from deleted

	insedrt into EmployeeAudit
	values ('An existing employee with Id = ' + cast(@Id as nvarchar(5)) +
	' is deleted at' + cast (getdate() as nvarchar(20)))
end

delete from Employees where Id = 11
select * from EmployeeAudit

--update trigger

create trigger trEmployeeForUpdate
on Employees
for update
as begin
	--muutujate deklareerimine
	declare @Id int
	declare @OldGender nvarchar(20), @NewGender nvarchar(20)
	declare @OldSalary int, @NewSalary int
	declare @OldDepartmentId int, @NewDepartmentId int
	declare @OldManagerId int, @NewManagerId int
	declare @OldFirstName nvarchar(20), @NewFirstName nvarchar(20)
	declare @OldMiddleName nvarchar(20), @NewMiddleName nvarchar(20)
	declare @OldLastName nvarchar(20), @NewLastName nvarchar(20)
	declare @OldEmail nvarchar(50), @NewEmail nvarchar(50)

	---muutuja, kuhu läheb lõpptekst
	declare @AuditString nvarchar(1000)

	-- laeb kõik uuendatud andmed temp tabeli alla
	select * into #TempTable
	from inserted

	-- käib läbi kõik andmed temp tabelist
	while(exists(select Id from #TempTable))
	begin
		set @AuditString = ''
		-- selekteerib esimese rea andmed temp tabel-st
		select top 1 @Id = Id, @NewGender = Gender,
		@NewSalary = Salary, @NewDepartmentId = DepartmentId,
		@NewManagerId = ManagerId, @NewFirstName = FirstName,
		@NewMiddleName = MiddleName, @NewLastName = LastName,
		@NewEmail = Email
		from #TempTable
		--võtab vanad andmed kustutatud tabelist
		select @OldGender = Gender,
		@OldSalary = Salary, @OldDepartmentId = DepartmentId,
		@OldManagerId = ManagerId, @OldFirstName = FirstName,
		@OldMiddleName = MiddleName, @OldLastName = LastName,
		@OldEmail = Email
		from deleted where Id = @Id

		  --Tund nr 14  30.04.2026--
------------------------------------------------
		--hakkab võrdlema igat muutujat, et kas toimus andmete muutus
		set @AuditString = 'Employee with Id = ' + cast(@Id as nvarchar(4)) + ' changed '
		if(@OldGender <> @NewGender)
			set @AuditString = @AuditString + ' Gender from ' + @OldGender + ' to ' +
			@NewGender

		if(@OldSalary <> @NewSalary)
			set @AuditString = @AuditString + ' Salary from ' + cast(@OldSalary as nvarchar(20)) + ' to ' +
			cast(@NewSalary as nvarchar(20))

		if(@OldDepartmentId <> @NewDepartmentId)
			set @AuditString = @AuditString + ' DepartmentId from ' + cast(@OldDepartmentId as nvarchar(20)) + ' to ' +
			cast(@NewDepartmentId as nvarchar(20))

		if(@OldManagerId <> @NewManagerId)
			set @AuditString = @AuditString + ' ManagerId from ' + cast(@OldManagerId as nvarchar(20)) + ' to ' +
			cast(@NewManagerId as nvarchar(20))

		if(@OldFirstName <> @NewFirstName)
			set @AuditString = @AuditString + ' FirstName from ' + @OldFirstName + ' to ' +
			@NewFirstName

		if(@OldMiddleName <> @NewMiddleName)
			set @AuditString = @AuditString + ' Middlename from ' + @OldMiddleName + ' to ' +
			@NewMiddleName

		if(@OldLastName <> @NewLastName)
			set @AuditString = @AuditString + ' Lastname from ' + @OldLastName + ' to ' +
			@NewLastName

		if(@OldEmail <> @NewEmail)
			set @AuditString = @AuditString + ' Email from ' + @OldEmail + ' to ' +
			@NewEmail

		insert into dbo.EmployeeAudit values (@AuditString)
		--kustutab temp tabelist rea
		delete from #TempTable where Id = @Id
	end
end
update Employees set FirstName = 'test123', Salary = 4000, MiddleName = 'test456'
where Id = 10

select * from Employees 
select * from EmployeeAudit

---
--instead of trigger
create table Employee
(
Id int primary key,
Name nvarchar(30),
Gender nvarchar(10),
DepartmentId int
)

 insert into Employee values (1, 'Sam', 'Male', 3)
 insert into Employee values (2, 'Pam', 'Female', 2)
 insert into Employee values (3, 'John', 'Male', 1)
 insert into Employee values (4, 'Sara', 'Female', 4)
 insert into Employee values (5, 'Todd',  'Male', 3)

select * from Employee

create view vEmployeeDetails
as
select Employee.Id, Name, Gender, DepartmentName
from Employee
join Department
on Employee.DepartmentId = Department.Id

select * from vEmployeeDetails
-- tuleb veateade
insert into vEmployeeDetailsvalues (7, 'Valerie', 'Female', 'IT')

--nüüd proovime lahendada probleemi, kui kasutame instead of triggerit
create trigger tr_vEmployeeDetails_InsteadOfInsert
on vEmployeeDetails
instead of insert
as begin
	declare @DeptId int

	select @DeptId = dbo.Department.Id
	from Department
	join inserted
	on inserted.DepartmentName = Department.DepartmentName

	if(@DeptId is null)
		begin
		raiserror ('Invalid department name. Statement terminated', 16, 1)
		return
	end
	insert into dbo.Employee(Id, Name, Gender, DepartmentId)
	select Id, Name, Gender, @DeptId
	from inserted
end
-- raiserror funktsioon
--selle eesmärk on tuua välja veateade, kui depname veerus ei ole väärtust
-- ja ei klapi uue sissestatud väärtusega.
-- esimene on parameeter ja veateade sisu, teine non veatetaseme nr (nt 16 tähendab
-- üldiseid vigu) ja kolmas on olek 

--nüüd saab läbi view sisestada andmeid 
insert into vEmployeeDetails values (7, 'Valerie', 'Female', 'IT')

--uuendame andmeid
update vEmployeeDetails
set Name = 'Johny', DepartmentName = 'IT'
where Id = 1
--ei saa uuendada andmeid kuna mitu tabelit on sellest mõjutatud

update vEmployeeDetails
set DepartmentName = 'IT'
where Id = 1

select * from vEmployeeDetails


--instead of update trigger
create trigger tr_vEmployeeDetails_InsteadOfUpdate
on vEmployeeDetails
instead of update 
as begin 
	
	if (UPDATE (Id))
	begin 
		raiserror('Id cannot be changed ', 16, 1)
		return
	end

	if (UPDATE (DepartmentName))
	begin 
		declare @DeptId int
		select @DeptId = Department.Id 
		from Department 
		join inserted
		on inserted.DepartmentName = Department.DepartmentName

		if (@DeptId is null)
		begin
			raiserror ('Invalid Department Name', 16, 1)
			return 
		end 

		update Employee set DepartmentId = @DeptId 
		from inserted
		join Employee
		on Employee.Id = inserted.id 
	end 

	if (UPDATE (Gender))
	begin
		update Employee set Gender = inserted.Gender
		from inserted
		join Employee
		on Employee.Id = inserted.id
	end

	if (UPDATE (Name))
	begin
		update Employee set Name = inserted.Name
		from inserted
		join Employee
		on Employee.Id = inserted.id
	end
end


--uuendame andmeid, kasutada vEmployeeDetails
--uuendada seal, kus Id on 1
update Employee set Name = 'John123', Gender = 'Male', DepartmentId = 3
where Id = 1

select * from vEmployeeDetails

--delete trigger
create view vEmployeeCount
as
select DepartmentId, DepartmentName, COUNT(*) as TotalEmployees
from Employee
join Department
on Employee.DepartmentId = Department.Id
group by DepartmentName, DepartmentId

select * from vEmployeeCount

--vaja teha päring, kus on töötajad 2tk või rohkem
--kasutada vEmployeeCount

select * from vEmployeeCount
where TotalEmployees >= 2
order by TotalEmployees desc

select DepartmentName, TotalEmployees from vEmployeeCount
where TotalEmployees >= 2

--
select DepartmentName, DepartmentId, count (*) as TotalEmployees
into #TempEmployeeCount 
from Employee
join Department
on Employee.DepartmentId = Department.Id
group by DepartmentName, DepartmentId

select * from #TempEmployeeCount 


--läbi ajutise saab samu andmeid vaadata, kui seal on info olemas
select DepartmentName, TotalEmployees from #TempEmployeeCount 
where TotalEmployees >= 2

--tuleb teha trigger nimega trEmployeedetails_InsteadOfDelete
--ja kasutada vEmployeedetails
--triggeri tüüp on instead of delete

--create trigger trEmployeeDetails_InsteadOfDelete
--on vEmployeeDetails
--instead of delete
--as begin
    
--    delete Employee
--    from deleted
--    join Employee
--    on Employee.Id = deleted.Id

--end
--delete from vEmployeeDetails
--where Id = 1

create trigger tr_vEmployeeDetails_InsteadOfDelete 
on vEmployeeDetails 
instead of delete
as
begin
    delete Employee
	from Employee
	join deleted
	on Employee.Id = deleted.Id
end

delete from vEmployeeDetails where Id = 7

---------------------------------------------
			-------CTE-------

--CTE e comon table expression
select * from Employee

--CTE näide
with EmployeeCount(DepartmentName , DepartmentId, TotalEmployees)
as
	(
	select DepartmentName, DepartmentId, COUNT (*) as TotalEmployees
	from Employee
	join Department
	on Employee.DepartmentId = Department.Id
	group by DepartmentName, DepartmentId
	)
select DepartmentName, TotalEmployees
from EmployeeCount
where TotalEmployees >= 2

--CTE-d võivad sarnaneda temp tabeliga
--sarnane päritud tabelile ja ei ole salvestatud objektina
-- ning kestab päringu ulatused

--päritud tabel
select DepartmentName, TotalEmployees
from
(
	select DepartmentName, DepartmentId, COUNT (*) as TotalEmployees
	from Employee
	join Department
	on Employee.DepartmentId = Department.Id
	group by DepartmentName, DepartmentId
)
as EmployeeCount 
where TotalEmployees >= 2

--tehke päring, kus on kaks CTE päringut sees
with EmployeeCountBy_Payroll_IT_Dept(DepartmentName, Total)
as
(
    select DepartmentName, count(Employee.Id) as TotalEmployees
    from Employee
    join Department
    on Employee.DepartmentId = Department.Id
    where DepartmentName in ('Payroll', 'IT')
    group by DepartmentName
),
EmployeeCountBy_HR_Admin_Dept(DepartmentName, Total)
as
(
    select DepartmentName, count(Employee.Id) as TotalEmployees
    from Employee
    join Department
    on Employee.DepartmentId = Department.Id
    group by DepartmentName
)
--kui on kaks CTE-d, siis unioni abil ühendab päringu 
select * from EmployeeCountBy_Payroll_IT_Dept
union
select * from EmployeeCountBy_HR_Admin_Dept

--teha CTE päring nimega EmployeeCount
--järjestaks DepartmentName järgi ära

with EmployeeCount(DepartmentId, TotalEmployees)
as
    (
    select DepartmentId, COUNT(*) as TotalEmployees
    from Employee
    group by DepartmentId
    )

--select 'hello'
--peale cte- d peab kohe tulema käsklus select, insert, update delete
--kui proovid midagi muud, siis tuleb veateade
select DepartmentName
from Department
join Employee
on Department.Id = EmployeeAudit.DepartmentId
order by  DepartmentName

----------------------------------------------
	-------Tund 15  14.05.2026------
----------------------------------------------

-- uuemdamine CTE-s

with Employees_Name_Gender
as
(
	select Id, Name, Gender from Employees
)
select * from Employees_Name_Gender

--kasutame JOIN-i CTE tegemiseks

with EmployeesByDepartment
as
(
select Employee.Id, Employee.Name, Department.DepartmentName
from Employee
join Department
on Employee.DepartmentId = Department.Id
)
select * from EmployeesByDepartment

--nüüd muudame andmeid CTE-s

with EmployeesByDepartment
as
(
select Employee.Id, Employee.Name, Gender, DepartmentName
from Employee
join Department
on DepartmentId = Department.Id
)
update EmployeesByDepartment set Gender = 'Male' where Id = 1

--kasutage eelmist CTE andmete mutmiseks,
--aga seekord mutke Id 1 töötaja Gender female peale ja 
--DepartmentName payroll peale
with EmployeesByDepartment
as
(
select Employee.Id, Employee.Name, Gender, DepartmentName
from Employee
join Department
on DepartmentId = Department.Id
)
update EmployeesByDepartment set Gender = 'Female', DepartmentName = 'Payroll' where Id = 1
--ei luba mitmes tabelis korraga andmeid muuta, kui on tegemist CTE-ga

---kokkuvõtte CTE-st
-- 1. kui CTE baseerub ühel tabelil, siis uuendab töötab
-- 1. kui CTE baseerub mitmel tabelil, siis tuleb veateade
-- 1. kui CTE baseerub ühel tabelil ja tahame muuta ainult ühte tebelit,
--    siis uuedndus saab tehtud

-- korduv CTE
--- CTE, mis iseendale viitab, kutsutakse korduvaks CTE-ks
--- kui tahad andmeid näidata hierarhiliselt

Create Table Employee
(
	EmployeeId int Primary key,
	Name nvarchar(20),
	ManagerId int 
)

select * from Employee

--lisame andmed
insert into Employee (EmployeeId, Name, ManagerId) VALUES
(1, 'Tom',   2),
(2, 'Josh',  NULL),
(3, 'Mike',  2),
(4, 'John',  3),
(5, 'Pam',   1),
(6, 'Mary',  3),
(7, 'James', 1),
(8, 'Sam',   5),
(9, 'Simon', 1);
select * from Employee 

--kasutame left joini, et näha kõiki töötajad ja nende juhte
select Emp.Name as [Employee Name],
ISNULL (Manager.Name, 'Super Boss') as [Manager Name]
from dbo.Employee Emp
left join Employee Manager
on Emp.ManagerId = Manager.EmployeeId

--peab samasugune tulemuse saavutama, aga kasutage CTE-d
--kasutab joini koos union all
--minu variant
with EmployeeCTE
as 
(
    select Emp.Name as [Employee Name],
	Manager.Name as [Manager Name]
    from Employee Emp
    join Employee Manager
    on Emp.ManagerId = Manager.EmployeeId
		union all
		select Emp.Name as [Employee Name],
		'Super Boss' as [Manager Name]
		from Employee Emp
		where Emp.ManagerId is null
)
select * from EmployeeCTE

--õpeteja variant
-- seat sees kasutab joini koos union all
with EmployeeCTE(Id, Name, ManagerId, [Level])
as
(
    select Employee.EmployeeId, Employee.Name, Employee.ManagerId, 1
    from Employee
    where ManagerId is null

    union all

    select Employee.EmployeeId, Employee.Name, Employee.ManagerId,
    EmployeeCTE.[Level] + 1
    from Employee
    join EmployeeCTE
    on Employee.ManagerId = EmployeeCTE.Id
)
select EmpCTE.Name as Employee,
isnull(MgrCTE.Name, 'Super Boss') as [Manager Name],
EmpCTE.Level as [Boss Level]
from EmployeeCTE EmpCTE
left join EmployeeCTE MgrCTE
on EmpCTE.ManagerId = MgrCTE.Id

-------------------------------------
			---PIVOT---

--mis on pivot? 
--PIVOT on SQL-i operatsioon, mis võimaldab teisendad ridu veergudeks
create table Sales
(
	SalesAgent nvarchar(20),
	SalesCountry nvarchar(20),
	SalesAmount int
)

insert into Sales (SalesAgent, SalesCountry, SalesAmount) values
('Tom',   'UK',    200),
('John',  'US',    180),
('John',  'UK',    260),
('David', 'India', 450),
('Tom',   'India', 350),
('David', 'US',    200),
('Tom',   'US',    130),
('John',  'India', 540),
('John',  'UK',    120),
('David', 'UK',    220),
('John',  'UK',    420),
('David', 'US',    320),
('Tom',   'US',    340),
('Tom',   'UK',    660),
('John',  'India', 430),
('David', 'India', 230),
('David', 'India', 280),
('Tom',   'UK',    480),
('John',  'UK',    360),
('David', 'UK',    140);
select * from Sales

select SalesCountry, SalesAgent, SUM(SalesAmount) as TotalSales
from Sales 
group by SalesCountry, SalesAgent 
order by SalesCountry, SalesAgent

--kasuta pivotit, et saada sama tulemus nagu ülemises päringus
select SalesAgent, India, US, UK
from Sales
pivot
(
	sum(SalesAmount)
	for SalesCountry in (India, US, UK)
)
as PivotTable

-- päring muudab unikaalsete veergude väärtust (India, Us ja UK) salescountry veerus
--omaette vergudeks koos vergudele salesamount liitmisega 

create table SalesWithId
(
Id int primary key,
SalesAgent nvarchar (20),
SalesCountry nvarchar (20),
salesAmount int 
)
insert into SalesWithId  values
(1, 'Tom',   'UK',    200),
(2, 'John',  'US',    180),
(3, 'John',  'UK',    260),
(4, 'David', 'India', 450),
(5, 'Tom',   'India', 350),
(6, 'David', 'US',    200),
(7, 'Tom',   'US',    130),
(8, 'John',  'India', 540),
(9, 'John',  'UK',    120),
(10, 'David', 'UK',    220),
(11, 'John',  'UK',    420),
(12, 'David', 'US',    320),
(13, 'Tom',   'US',    340),
(14, 'Tom',   'UK',    660),
(15, 'John',  'India', 430),
(16, 'David', 'India', 230),
(17, 'David', 'India', 280),
(18, 'Tom',   'UK',    480),
(19, 'John',  'UK',    360),
(20, 'David', 'UK',    140);
select * from Sales

--tehke uuesti pivot, aga SalesWithId tabelit
select SalesAgent, India, US, UK
from SalesWithId
pivot
(
	sum(SalesAmount)
	for SalesCountry in (India, US, UK)
)
as PivotTable

--põhjuseks on Id veeru olemasolu SalesWithId, mida võrtakse arvese
--pöördamise ja grupeerimise järgi

select SalesAgent, India, US, UK
from
(
	select SalesAgent, SalesCountry, SalesAmount
    from SalesWithId
)
as SourceTable
pivot
(
    sum(SalesAmount)
    for SalesCountry in (India, US, UK)
) 
as PivotTable

-----------------------------------------
			---Transaction---

--transactioonid
--transaction jälgib järgmici samme:
--- 1. selle algus
--- 2. käivitab DB käske
--- 3. kontrollib vigu. kui on viga, siis taastab algse oleku

create table MailingAddress
(
	Id int not null primary key, 
	EmployeeNumber int,
	HouseNumber nvarchar(10),
	StreetAddress nvarchar(50),
	City nvarchar(50),
	PostalCode nvarchar(20)
)

insert into MailingAddress
values (1, 101, '#10', 'King Street', 'Londoon', 'CR27W')

create table PhysicalAddress
(
	Id int not null primary key, 
	EmployeeNumber int,
	HouseNumber nvarchar(10),
	StreetAddress nvarchar(50),
	City nvarchar(50),
	PostalCode nvarchar(20)
)

insert into PhysicalAddress
values (1, 101, '#10', 'King Street', 'Londoon', 'CR27W')

create proc spUpdateAddress
	as begin 
		begin try
			begin transaction 
				update MailingAddress set City = 'LONDON'
				where MailingAddress.Id = 1 and EmployeeNumber = 101

			    update PhysicalAddress set City = 'LONDON'
				where PhysicalAddress.Id = 1 and EmployeeNumber = 101
			commit transaction 
		end try
	begin catch 
rollback tran
end catch
end

--käivitame spUpdateAddress stored procedure-i
spUpdateAddress

select * from MailingAddress
select * from PhysicalAddress

-- kui teine uuendus ei lähe läbi, siis esimene ei lähe ka läbi
-- kõik uuendused peavad läbi minema

				--- transaction ACID test ---

-- edukas transaction peab läbima ACID testi:
-- A - atomic e aatomlikus
-- C - consistent e järjepidevus
-- I - isolated e isoleeritus
-- D - durable e vastupidav

--- Atomic - kõik tehingud transactionis on kas edukalt täidetud või need
-- lükatakse tagasi. Nt, mõlemad käsud peaksid alati õnnestuma. Andmebaas
-- teeb sellisel juhul: võtab esimese update tagasi ja veeretab selle algasendisse
-- e taastab algsed andmed.

--- Consistent - kõik transactioni puudutavad andmed jäetakse loogiliselt
-- järjepidevasse olekusse. Nt, kui laos saadaval olevaid esemete hulka
-- vähendatakse, siis tabelis peab olema vastav kanne. Inventuur ei saa
-- lihtsalt kaduda.

--- Isolated - transaction peab andmeid mõjutama, sekkumata teistesse
-- samaaegsetesse transactionitesse. See takistab andmete muutmist, mis
-- põhinevad sidumata tabelitel. Nt, muudatused kirjas, mis hiljem tagasi
-- muudetakse. Enamik DB-d kasutab tehingute isoleerimise säilitamiseks
-- lukustamist.

--- Durable - kui muudatus on tehtud, siis see on püsiv. Kui süsteemiviga või
-- voolukatkestus ilmneb enne käskude komplekti valmimist, siis tühistatakse need
-- käsud ja andmed taastatakse algsesse olekusse. Taastamine toimub peale
-- süsteemi taaskäivitamist.

CREATE TABLE Product
(
    Id int PRIMARY KEY,
    Name nvarchar(20),
    UnitPrice int
);

INSERT INTO Product (Id, Name, UnitPrice)
VALUES
(1, 'Books', 20),
(2, 'Pens', 14),
(3, 'Pencils', 11),
(4, 'Clips', 10);

--subquries e alamkäsud
--alamkäsud on sql-i käsud, mis on pesatutud teise sql-i käsu sisse

create table ProductSales
(
	Id int primary key identity,
	ProductId int foreign key references Product(Id),
	UnitPrice int,
	QuantitySold int
)


-------------- Tund 16 - 20.05.2026 ----------------
----------------------------------------------------

insert into ProductSales values (3, 450, 5)
insert into ProductSales values (2, 250, 7)
insert into ProductSales values (3, 450, 4)
insert into ProductSales values (3, 450, 9)


select * from Product
select * from ProductSales

--kirjutame päringu, mis annab infot müümata toodetest
select Id, Name, Description
from Product
where Id not in (select ProductId from ProductSales)

--sulgude sees on squery, mis tagastab asendada join-iga
--teha päring join-iga , et saada müümata toodete infot (left join)
select p.Id, p.Name, p.Description
from Product p
left join ProductSales ps on p.Id = ps.ProductId
where ps.ProductId is null


--teeme subquery kus kasutatakse selecti
select Name,
(select SUM (QuantitySold) from ProductSales where ProductId = Product.Id) as
[Total Quantity]
from Product
order by Name

-- sama tulemus, aga join-iga
select p.Name,
SUM (QuantitySold) as [Total Quantity]
from Product p
left join ProductSales ps on p.Id = ps.ProductId
group by p.Name
order by p.Name

--subqueryt saab subquery sisse panna
--subquery on alati sulgudes ja neid nimetatase sissemisteks päringiteks


-----ronkete andmetega testimise table----
------------------------------------------

truncate table Product
truncate table ProductSales

select * from Product
select * from ProductSales

--sisestame näidisandmed Product tabelisse
declare @Id int;
set @Id = 1;

declare @RandomProductId int;
declare @RandomUnitPrice int;
declare @RandomQuantitySold int;

-- productId piirangud
declare @LowerLimitForProductId int;
declare @UpperLimitForProductId int;
set @LowerLimitForProductId = 1;
set @UpperLimitForProductId = 100000;

-- Unit Price piirangud
declare @LowerLimitForUnitPrice int;
declare @UpperLimitForUnitPrice int;
set @LowerLimitForUnitPrice = 1;
set @UpperLimitForUnitPrice = 100;

-- Quantity Sold piirangud
declare @LowerLimitForQuantitySold int;
declare @UpperLimitForQuantitySold int;
set @LowerLimitForQuantitySold = 1;
set @UpperLimitForQuantitySold = 10;

declare @Counter int;
set @Counter = 1;


-- 2. ESIMENE TSÜKKEL (Tooted)
while(@Id <= 3000000)
begin 
    insert into Product
    values (
        'Product - ' + cast(@Id as nvarchar(20)),
        'Description for product' + cast(@Id as nvarchar(20))
    ); -- SULG JA SEMIKOOLON LISATUD (Vea parandus)

    set @Id = @Id + 1;
end;


-- 3. TEINE TSÜKKEL (Müügid)
while(@Counter <= 4500000)
begin
    set @RandomProductId = round(((@UpperLimitForProductId - @LowerLimitForProductId) * rand() + @LowerLimitForProductId), 0);
    set @RandomUnitPrice = round(((@UpperLimitForUnitPrice - @LowerLimitForUnitPrice) * rand() + @LowerLimitForUnitPrice), 0);
    set @RandomQuantitySold = round(((@UpperLimitForQuantitySold - @LowerLimitForQuantitySold) * rand() + @LowerLimitForQuantitySold), 0);

    insert into ProductSales
    values(@RandomProductId, @RandomUnitPrice, @RandomQuantitySold);

    set @Counter = @Counter + 1;
end;
------------------------------

CREATE TABLE Product
(
    Id int PRIMARY KEY,
    Name nvarchar(50),
    Description nvarchar(250)
);
-------------------------------

create table ProductSales
(
	Id int primary key identity,
	ProductId int foreign key references Product(Id),
	UnitPrice int,
	QuantitySold int
)