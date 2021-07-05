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

--Medium Questions
--1) A "Single Item Order" is a customer order where only one item is ordered. Show the SalesOrderID and the UnitPrice for every Single Item Order.
--Output: SalesOrderID | UnitPrice
--Where OrderQty = 1

SELECT sod.salesorderid
    ,sod.unitprice
FROM 
    salesorderdetail sod
WHERE
    orderqty = 1;

--2) Where did the racing socks go? List the product name and the CompanyName for all Customers who ordered ProductModel 'Racing Socks'.
--Output Product.Name | Customer.CompanyName
--WHERE ProductModel.Name = 'Racing Socks'

SELECT 
    prod.name
    ,cust.companyname
FROM 
    customer cust
    INNER JOIN salesorderheader soh
    ON cust.customerid = soh.customerid
    INNER JOIN salesorderdetail sod
    ON soh.salesorderid = sod.salesorderid
    INNER JOIN product prod
    ON sod.productid = prod.productid
    INNER JOIN productmodel prodmod
    ON prod.productmodelid = prodmod.productmodelid
WHERE
    (1=1)
    AND prodmod.name = 'Racing Socks';

--3)