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

--Hard Questions
--11) For every customer with a 'Main Office' in Dallas show AddressLine1 of the 'Main Office' and AddressLine1 of the 'Shipping' address - if there is no shipping address leave it blank. Use one row per customer.
--AddressType separated into 'Main Office' and 'Shipping'. WHERE addresstype = 'Main Office' AND city = 'Dallas'

SELECT c.companyname
    ,MAX(CASE WHEN ca.addresstype = 'Main Office' THEN a.addressline1 ELSE ' ' END)
    ,MAX(CASE WHEN ca.addresstype = 'Shipping' THEN a.addressline1 ELSE ' ' END)
FROM 
    customer c
    INNER JOIN customeraddress ca
    ON c.customerid = ca.customerid
    INNER JOIN address a
    ON ca.addressid = a.addressid
WHERE a.city = 'Dallas'
GROUP BY c.companyname;

--12 For each order show the SalesOrderID and SubTotal calculated three ways: A) From the SalesOrderHeader, B) Sum of OrderQty*UnitPrice, C) Sum of OrderQty*ListPrice 
--Output: SalesOrderID | A | B | C
--GROUP BY salesorderid possibly?

SELECT
    sod.salesorderid AS Sales_Order_ID
    ,soh.subtotal AS Subtotal
    ,SUM(sod.orderqty*sod.unitprice) AS Unit_Price
    ,SUM(sod.orderqty*p.listprice) AS List_Price
FROM 
    product p
    INNER JOIN salesorderdetail sod
    ON p.productid = sod.productid
    INNER JOIN salesorderheader soh
    ON sod.salesorderid = soh.salesorderid
GROUP BY 
    sod.salesorderid
    ,soh.subtotal;

--13) Show the best selling item by value. 
--Ambiguous question, but makes me think that it's the sum of orderqty (grouped by productid) multiplied by the list price for that product. Unit price could be alternatively used.
--Order by the value DESC and limit the appropriate amount

SELECT TOP 10
    p.productid
    ,p.name
    ,SUM(sod.orderqty) AS Total_Order_Quantity
    ,MAX(p.listprice) AS List_Price
    ,SUM(sod.orderqty*p.listprice) AS Total_Value
FROM
    product p
    INNER JOIN salesorderdetail sod
    ON p.productid = sod.productid
GROUP BY 
    p.productid
    ,p.name
ORDER BY Total_Value DESC;

--14) Show how many orders are in the following ranges (in $)
/*
    RANGE       Num Orders      Total Value
    0-  99
    100- 999
    1000-9999
    10000-
*/
--Similar to 13. But need to add some conditional statements for the ranges. 

SELECT
    T0.range AS 'Range'
    ,COUNT(T0.Total_Value) AS 'Num Orders'
    ,SUM(T0.Total_Value) AS 'Total Value'
FROM
(
SELECT
    CASE 
        WHEN sod.orderqty*p.listprice BETWEEN 0 AND 99       THEN '0-99'
        WHEN sod.orderqty*p.listprice BETWEEN 100 AND 999     THEN '100-999'
        WHEN sod.orderqty*p.listprice BETWEEN 1000 AND 9999   THEN '1000-9999'
        WHEN sod.orderqty*p.listprice > 10000                 THEN '10000+'
        ELSE 'No range'
        END AS 'Range'
    ,sod.orderqty*p.listprice AS Total_Value
FROM
    product p
    INNER JOIN salesorderdetail sod
    ON p.productid = sod.productid
) AS T0
GROUP BY
    T0.range;

--Rework with unit price later

--15) Identify the three most important cities. Show the break down of top level product category against city.
--Not sure. Need to troubleshoot
FROM 
    productcategory pc
    INNER JOIN product p
    ON pc.productcategoryid = p.productcategoryid
    INNER JOIN salesorderdetail sod
    ON p.productid = sod.productid
    INNER JOIN salesorderheader soh
    ON sod.salesorderid = soh.salesorderid
    INNER JOIN address a
    ON soh.billtoaddressid = a.addressid