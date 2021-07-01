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

/*Sample queries. Relatively easy problems.*/

--1) Show the CompanyName for James D. Kramer
--Output: | CompanyName |
--Will only need to refer to customer table for this. Filter for name = "James D. Kramer"
--Customer table has names broken into parts. Where statement needs to match all three.
--Multiple AND statements to match the first, middle, and last name. Use (1=1) convention to make it easier to troubleshoot.

SELECT CompanyName
FROM Customer
WHERE 
    (1=1)
    AND FirstName = 'James'
    AND MiddleName = 'D.'
    AND LastName = 'Kramer'

--2) Show all the addresses listed for 'Modular Cycle Systems'
--"Modular Cycle Systems" is a company name (in the customer table)
--Output: | Address ID | Address Line 1 | Address Line 2
--Will join customer table with customeraddress with address

SELECT cust.companyname AS CompanyName
    ,addr.addressid     AS AddressID
    ,addr.addressline1  AS AddressLine1
    ,addr.addressline2  AS AddressLine2
FROM customer cust
    INNER JOIN customeraddress custaddr
    ON cust.customerid = custaddr.customerid 
    INNER JOIN addr
    ON custaddr.addressid = addr.addressid
WHERE
    (1=1)
    AND cust.companyname = "Modular Cycle Systems"

--3) Show OrderQty, the Name and the ListPrice of the order made by CustomerID 635
--Output: | Qrder Quantity | NameOfProduct | ListPrice |
--OrdeQty is from SalesOrderDetail, NameOfProduct and ListPrice are from Product
--Need to filter by CustomerID from Customer. 

SELECT salesorderdetail.orderqty    AS OrderQuantity
    ,product.name                   AS NameOfProduct
    ,product.listprice              AS ListPrice
FROM salesorderdetail
    INNER JOIN product
    ON salesorderdetail.productid = product.productid
    INNER JOIN salesorderheader
    ON salesorderdetail.salesorderid = salesorderheader.salesorderid
    INNER JOIN customer
    ON salesorderheader.customerid = customer.customerid
WHERE 
    (1=1)
    AND customer.customerid = 635