-- Загрузка данных в таблицы измерений
INSERT INTO DimDate (DateID, Date, Day, Month, Year, Quarter, WeekOfYear)
SELECT DISTINCT 
    CONVERT(INT, CONVERT(VARCHAR, YEAR(OrderDate)) + RIGHT('00' + CONVERT(VARCHAR, MONTH(OrderDate)), 2) + RIGHT('00' + CONVERT(VARCHAR, DAY(OrderDate)), 2)) AS DateID,
    OrderDate,
    DAY(OrderDate),
    MONTH(OrderDate),
    YEAR(OrderDate),
    DATEPART(QUARTER, OrderDate),
    DATEPART(WEEK, OrderDate)
FROM staging_orders;

INSERT INTO DimCustomer (CustomerID, CompanyName, ContactName, ContactTitle, Address, City, Region, PostalCode, Country, Phone)
SELECT CustomerID, CompanyName, ContactName, ContactTitle, Address, City, Region, PostalCode, Country, Phone
FROM staging_customers;

INSERT INTO DimProduct (ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock)
SELECT ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock
FROM staging_products;

INSERT INTO DimEmployee (EmployeeID, LastName, FirstName, Title, BirthDate, HireDate, Address, City, Region, PostalCode, Country, HomePhone, Extension)
SELECT EmployeeID, LastName, FirstName, Title, BirthDate, HireDate, Address, City, Region, PostalCode, Country, HomePhone, Extension
FROM staging_employees;

INSERT INTO DimCategory (CategoryID, CategoryName, Description)
SELECT CategoryID, CategoryName, Description
FROM staging_categories;

INSERT INTO DimShipper (ShipperID, CompanyName, Phone)
SELECT ShipperID, CompanyName, Phone
FROM staging_shippers;

INSERT INTO DimSupplier (SupplierID, CompanyName, ContactName, ContactTitle, Address, City, Region, PostalCode, Country, Phone)
SELECT SupplierID, CompanyName, ContactName, ContactTitle, Address, City, Region, PostalCode, Country, Phone
FROM staging_suppliers;

-- Загрузка данных в фактологическую таблицу
INSERT INTO FactSales (SalesID, DateID, CustomerID, ProductID, EmployeeID, CategoryID, ShipperID, SupplierID, QuantitySold, UnitPrice, Discount, TotalAmount, TaxAmount)
SELECT 
    ROW_NUMBER() OVER (ORDER BY od.OrderID) AS SalesID,
    CONVERT(INT, CONVERT(VARCHAR, YEAR(o.OrderDate)) + RIGHT('00' + CONVERT(VARCHAR, MONTH(o.OrderDate)), 2) + RIGHT('00' + CONVERT(VARCHAR, DAY(o.OrderDate)), 2)) AS DateID,
    o.CustomerID,
    od.ProductID,
    o.EmployeeID,
    p.CategoryID,
    o.ShipperID,
    p.SupplierID,
    od.Quantity,
    od.UnitPrice,
    od.Discount,
    (od.Quantity * od.UnitPrice) - od.Discount AS TotalAmount,
    (od.Quantity * od.UnitPrice - od.Discount) * 0.1 AS TaxAmount -- Предполагая налоговую ставку 10% для примера
FROM staging_orders o
JOIN staging_order_details od ON o.OrderID = od.OrderID
JOIN staging_products p ON od.ProductID = p.ProductID;
