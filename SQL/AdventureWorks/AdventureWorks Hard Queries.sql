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
--GROUP BY CustomerID in both customer and address tables.
--Need to re-solve