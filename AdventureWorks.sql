--AdventureWorksLT2019
--iseseisev töö--

--1.
--GetAllCustomers_ITVF--
create function fn_GetAllCustomers_ITVF()
returns table as
return (
    select CustomerID, FirstName, LastName, EmailAddress, Phone
    from SalesLT.Customer
);
go 
select * from fn_GetAllCustomers_ITVF()
-------------------------------------------------
--2. 
-- GetCustomerByID_ITVF--
create function fn_GetCustomerByID_ITVF(@CustomerID int)
returns table as
return (
    select FirstName, LastName
    from SalesLT.Customer
    where CustomerID = @CustomerID
);
go
select * from fn_GetCustomerByID_ITVF(1)
--------------------------------------------------
--3.
--GetOrdersByCustomer_ITVF--
create function fn_GetOrdersByCustomer_ITVF(@CustomerID int)
returns table as
return (
    select SalesOrderID, OrderDate, TotalDue, Status
    from SalesLT.SalesOrderHeader
    where CustomerID = @CustomerID
);
go
select * from fn_GetOrdersByCustomer_ITVF(29847)
-------------------------------------------------
--4.
-- GetProductsByPrice_ITVF--
create function fn_GetProductsByPrice_ITVF(@MinPrice money, @MaxPrice money)
returns table as
return (
    select ProductID, Name, ListPrice, Color, Size
    from SalesLT.Product
    where ListPrice between @MinPrice and @MaxPrice
);
go
select * from fn_GetProductsByPrice_ITVF(100, 500)
-------------------------------------------------
--5.
-- GetTopExpensiveProducts_ITVF--
create function fn_GetTopExpensiveProducts_ITVF()
returns table as
return (
    select top 10 ProductID, Name, ListPrice
    from SalesLT.Product
    order by ListPrice DESC
);
go
select * from fn_GetTopExpensiveProducts_ITVF()
------------------------------------------------
--6.
--GetCustomerFullInfo_MSTVF--
create function fn_GetCustomerFullInfo_MSTVF(@CustomerID int)
returns @Result table (
    FullName    nvarchar(100),
    Email       nvarchar(100),
    Phone       nvarchar(25)
)
as begin
    insert into @Result
    select 
        FirstName + ' ' + LastName,
        EmailAddress,
        Phone
    from SalesLT.Customer
    where CustomerID = @CustomerID
    return
end;
go
select * from fn_GetCustomerFullInfo_MSTVF(1)
---------------------------------------------
--7.
--GetCustomerOrderSummary_MSTVF--
create function fn_GetCustomerOrderSummary_MSTVF(@CustomerID int)
returns @Result table (
    TellimustArv    int,
    Kogusumma       money
)
as begin
    insert into @Result
    select 
        count(SalesOrderID),
        sum(TotalDue)
    from SalesLT.SalesOrderHeader
    where CustomerID = @CustomerID
    return
end;
go
select * from fn_GetCustomerOrderSummary_MSTVF(29847)
--------------------------------------------
--8.
--GetProductPriceCategory_MSTVF--
create function GetProductPriceCategory_MSTVF()
returns @Result table (
    ProductID int,
    Name nvarchar(100),
    ListPrice money,
    Category nvarchar (20)
)
as begin
    insert into @Result
    select ProductID, Name, ListPrice, case 
            when ListPrice < 100 then 'odav'
            when ListPrice BETWEEN 100 AND 1000 then 'keskmine'
            else 'kallis'
    end
    from SalesLT.Product
    return
end;
go
select * from fn_GetProductPriceCategory_MSTVF()
---------------------------------------------
--9.
-- GetCustomersWithOrders_MSTVF--
create function fn_GetCustomersWithOrders_MSTVF()
returns @Result table (
    CustomerID  int,
    FullName    nvarchar(100),
    Email       nvarchar(100)
)
as begin
    insert into @Result
    select distinct
        c.CustomerID,
        c.FirstName + ' ' + c.LastName,
        c.EmailAddress
    from SalesLT.Customer c
    inner join SalesLT.SalesOrderHeader o on c.CustomerID = o.CustomerID
    return
end;
go
select * from fn_GetCustomersWithOrders_MSTVF()
-----------------------------------------------
--10.
--GetTopCustomersBySpending_MSTVF--
create function fn_GetTopCustomersBySpending_MSTVF()
returns @Result table (
    CustomerID int,
    FullName nvarchar(100),
    Kogukulu money
)
as begin
    insert into @Result
    select top 5
        c.CustomerID,
        c.FirstName + ' ' + c.LastName,
        sum(o.TotalDue)
    from SalesLT.Customer c
    inner join SalesLT.SalesOrderHeader o on c.CustomerID = o.CustomerID
    group by c.CustomerID, c.FirstName, c.LastName
    order by sum(o.TotalDue) DESC
    return
end;
go
select * from fn_GetTopCustomersBySpending_MSTVF()