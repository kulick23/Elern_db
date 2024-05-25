-- Создание промежуточных таблиц
CREATE TABLE staging_orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    EmployeeID INT,
    OrderDate DATE,
    ShipperID INT
);

CREATE TABLE staging_order_details (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    UnitPrice DECIMAL(10, 2),
    Quantity INT,
    Discount DECIMAL(4, 2)
);

CREATE TABLE staging_products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(50),
    SupplierID INT,
    CategoryID INT,
    QuantityPerUnit VARCHAR(20),
    UnitPrice DECIMAL(10, 2),
    UnitsInStock INT
);

CREATE TABLE staging_customers (
    CustomerID INT PRIMARY KEY,
    CompanyName VARCHAR(50),
    ContactName VARCHAR(50),
    ContactTitle VARCHAR(50),
    Address VARCHAR(100),
    City VARCHAR(50),
    Region VARCHAR(50),
    PostalCode VARCHAR(20),
    Country VARCHAR(50),
    Phone VARCHAR(20)
);

CREATE TABLE staging_employees (
    EmployeeID INT PRIMARY KEY,
    LastName VARCHAR(50),
    FirstName VARCHAR(50),
    Title VARCHAR(50),
    BirthDate DATE,
    HireDate DATE,
    Address VARCHAR(100),
    City VARCHAR(50),
    Region VARCHAR(50),
    PostalCode VARCHAR(20),
    Country VARCHAR(50),
    HomePhone VARCHAR(20),
    Extension VARCHAR(10)
);

CREATE TABLE staging_categories (
    CategoryID INT PRIMARY KEY,
    CategoryName VARCHAR(50),
    Description TEXT
);

CREATE TABLE staging_shippers (
    ShipperID INT PRIMARY KEY,
    CompanyName VARCHAR(50),
    Phone VARCHAR(20)
);

CREATE TABLE staging_suppliers (
    SupplierID INT PRIMARY KEY,
    CompanyName VARCHAR(50),
    ContactName VARCHAR(50),
    ContactTitle VARCHAR(50),
    Address VARCHAR(100),
    City VARCHAR(50),
    Region VARCHAR(50),
    PostalCode VARCHAR(20),
    Country VARCHAR(50),
    Phone VARCHAR(20)
);


