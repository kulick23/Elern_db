-- Загрузка данных в промежуточные таблицы
INSERT INTO staging_orders
SELECT OrderID, CustomerID, EmployeeID, OrderDate, ShipperID
FROM Orders;

INSERT INTO staging_order_details
SELECT OrderDetailID, OrderID, ProductID, UnitPrice, Quantity, Discount
FROM [Order Details];

INSERT INTO staging_products
SELECT ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock
FROM Products;

INSERT INTO staging_customers
SELECT CustomerID, CompanyName, ContactName, ContactTitle, Address, City, Region, PostalCode, Country, Phone
FROM Customers;

INSERT INTO staging_employees
SELECT EmployeeID, LastName, FirstName, Title, BirthDate, HireDate, Address, City, Region, PostalCode, Country, HomePhone, Extension
FROM Employees;

INSERT INTO staging_categories
SELECT CategoryID, CategoryName, Description
FROM Categories;

INSERT INTO staging_shippers
SELECT ShipperID, CompanyName, Phone
FROM Shippers;

INSERT INTO staging_suppliers
SELECT SupplierID, CompanyName, ContactName, ContactTitle, Address, City, Region, PostalCode, Country, Phone
FROM Suppliers;

