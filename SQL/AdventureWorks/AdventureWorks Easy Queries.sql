/*Based on Microsoft's AdventureWorks database. PKs are always listed first. Refer to image for FKs if needed

Customer: CustomerID | FirstName | MiddleName | LastName | CompanyName | EmailAddress
CustomerAddress: CustomerID | AddressID | AddressType
Address: AddressID | AddressLine1 | AddressLine2 | City | StateProvince | CountyRegion | PostalCode
SalesOrderHeader: SalesOrderID | RevisionNumber | OrderDate | CustomerID | BillToAddressID | ShipToAddressID | ShipMethod | SubTotal | TaxAmt | Freight
SalesOrderDetail: SalesOrderID | SalesOrderDetailID | OrderQty | ProductID | UnitPrice | UnitPriceDiscount
Product: ProductID | Name | Color | ListPrice | Size | Weight | ProductModelID | ProductCategoryID
ProductModel: ProductModelID | Name
ProductCategory: ProductCategoryID | ParentProductCategoryID | Name
ProductModelProductDescription: ProductModelID | ProductDescriptionID | Culture
ProductDescription: ProductDescriptionID | Description */

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

--3) How many items with ListPrice more than $1000 have been sold? 
--Output | Count |
--Where listprice > 1000
-- "have been sold" probably means need to join with salesorderdetail?

SELECT COUNT(*) AS NumberofItems
FROM
    product prod
    INNER JOIN salesorderdetail sod
    ON prod.productid = sod.productid
WHERE prod.listprice > 1000

--4) Give the CompanyName of those customers with orders over $100000. Include the subtotal plus tax plus freight.
--Output | CompanyName | Subtotal | TaxAmt | Freight | Total |
--Orders > 100000, probably means subtotal+tax+freight

SELECT cust.companyname                     AS CompanyName
    ,soh.subtotal                           AS SubTotal
    ,soh.taxamt                             AS TaxAmt
    ,soh.freight                            AS Freight
    ,soh.subtotal+soh.taxamt+soh.freight    AS Total
FROM
    customer cust
    INNER JOIN salesorderheader soh
    ON cust.customerid = soh.customerid
WHERE
    (soh.subtotal+soh.taxamt+soh.freight) > 100000

--5) Find the number of left racing socks ('Racing Socks, L') ordered by CompanyName 'Riding Cycles'
--Output | CompanyName | Count | 
--Where Customer.CompanyName = 'Riding Cycles' AND Product.Name = 'Racing Socks, L'

SELECT cust.companyname AS CompanyName
    ,orderqty AS Quantity
FROM 
    customer cust
    INNER JOIN salesorderheader soh
    ON cust.customerid = soh.customerid
    INNER JOIN salesorderdetail sod
    ON sod.salesorderid = soh.salesorderid
    INNER JOIN product prod
    ON sod.productid = prod.productid
WHERE 
    (1=1)
    AND cust.companyname = 'Riding Cycles'
    AND prod.name = 'Racing Socks, L'