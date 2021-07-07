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
--6) A "Single Item Order" is a customer order where only one item is ordered. Show the SalesOrderID and the UnitPrice for every Single Item Order.
--Output: SalesOrderID | UnitPrice
--Where OrderQty = 1

SELECT sod.salesorderid
    ,sod.unitprice
FROM 
    salesorderdetail sod
WHERE
    orderqty = 1;

--7) Where did the racing socks go? List the product name and the CompanyName for all Customers who ordered ProductModel 'Racing Socks'.
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

--8) Show the product description for culture 'fr' for product with ProductID 736. 
--Output: ProductDescription.Description | ProductModelProductDescription.Culture | Product.ProductID
--Culture = 'fr'
--ProductID = '736'

SELECT pd.description AS Description
    ,pmpd.culture AS Culture
    ,prod.productid AS ProductID
FROM
    product prod
    INNER JOIN productmodel prodmod
    ON prod.productmodelid = prodmod.productmodelid
    INNER JOIN productmodelproductdescription pmpd
    ON prodmod.productmodelid = pmpd.productmodelid
    INNER JOIN productdescription pd
    ON pmpd.productdescriptionid = pd.productdescriptionid
WHERE 
    (1=1)
    AND pmpd.culture = 'fr'
    AND prod.productid = 736;

--9) Use the SubTotal value in SaleOrderHeader to list orders from the largest to the smallest. For each order show the CompanyName and the SubTotal and the total weight of the order.
--Total weight is NOT the freight cost.
--Output: CompanyName | SubTotal | SUM(salesorderdetail.orderqty * product.weight)
--Aggregate, so must use grouping (company, subtotal)
--ORDER BY SubTotal DESC

SELECT cust.companyname
    ,soh.subtotal
    ,SUM(sod.orderqty * prod.weight)
FROM 
    customer cust
    INNER JOIN salesorderheader soh
    ON cust.customerid = soh.customerid
    INNER JOIN salesorderdetail sod
    ON soh.salesorderid = sod.salesorderid
    INNER JOIN product prod
    ON sod.productid = prod.productid
GROUP BY cust.companyname, soh.subtotal
ORDER BY soh.subtotal DESC;

--10) How many products in ProductCategory 'Cranksets' have been sold to an address in 'London'?
--Productcategory is a self-referencing table. 'Cranksets' appears in the name under the productcategory of components.
--Address.City = 'London'
--Tried count at first but realized it should be sum of the orderqty instead. Count would just show how many different orderids fulfilled the requirements.

SELECT
    SUM(sod.orderqty) AS 'Number of Cranksets Sold to London'
FROM
    productcategory prodcat
    INNER JOIN product prod
    ON prodcat.productcategoryid = prod.productcategoryid
    INNER JOIN salesorderdetail sod
    ON prod.productid = sod.productid
    INNER JOIN salesorderheader soh
    ON sod.salesorderid = soh.salesorderid
    INNER JOIN address
    ON soh.shiptoaddressid = address.addressid
WHERE
    (1=1)
    AND prodcat.name = 'Cranksets'
    AND address.city = 'London'