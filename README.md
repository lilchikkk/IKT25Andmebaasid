# IKT25Andmebaasid
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
