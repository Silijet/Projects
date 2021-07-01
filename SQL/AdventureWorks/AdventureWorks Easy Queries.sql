/*Based on Microsoft's AdventureWorks database. PKs are always listed first. Refer to image for FKs if needed

Customer(CustomerID, FirstName, MiddleName, LastName, CompanyName, EmailAddress)
CustomerAddress(CustomerID, AddressID, AddressType)
Address(AddressID, AddressLine1, AddressLine2, City, StateProvince, CountyRegion, PostalCode)
SalesOrderHeader(SalesOrderID, RevisionNumber, OrderDate, CustomerID, BillToAddressID, ShipToAddressID, ShipMethod, SubTotal, TaxAmt, Freight)
SalesOrderDetail(SalesOrderID, SalesOrderDetailID, OrderQty, ProductID, UnitPrice, UnitPriceDiscount)
Product(ProductID, Name, Color, ListPrice, Size, Weight, ProductModelID, ProductCategoryID)
ProductModel(ProductModelID, Name)
ProductCategory(ProductCategoryID, ParentProductCategoryID, Name)
ProductModelProductDescription(ProductModelID, ProductDescriptionID, Culture)
ProductDescription(ProductDescriptionID, Description)*/

--Easy questions
--1) Show the first name and the email address of customer with CompanyName 'Bike World'
--Output | FirstName | EmailAddress |
--All info from customer table
--Where companyname = 'Bike World'

SELECT cust.firstname
    ,cust.emailaddress
FROM customer cust
WHERE
    cust.companyname = 'Bike World'

--2) Show the CompanyName for all customers with an address in City 'Dallas'.
--Output | CompanyName |
--Where city is located in Dallas
-- CompanyName from customer, city is in address, linked through salesorderheader or customeraddress

SELECT cust.companyname
FROM 
    customer cust
    INNER JOIN customeraddress custaddr
    ON cust.customerid = custaddr.customerid
    INNER JOIN address addr
    ON custaddr.addressid = addr.addressid
WHERE 
    addr.city = 'Dallas'