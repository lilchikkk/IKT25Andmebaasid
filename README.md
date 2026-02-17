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
