-- Создание таблиц измерений
CREATE TABLE DimDate (
    DateID INT PRIMARY KEY,
    Date DATE,
    Day INT,
    Month INT,
    Year INT,
    Quarter INT,
    WeekOfYear INT
);

CREATE TABLE DimCustomer (
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

CREATE TABLE DimProduct (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(50),
    SupplierID INT,
    CategoryID INT,
    QuantityPerUnit VARCHAR(20),
    UnitPrice DECIMAL(10, 2),
    UnitsInStock INT
);

CREATE TABLE DimEmployee (
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

CREATE TABLE DimCategory (
    CategoryID INT PRIMARY KEY,
    CategoryName VARCHAR(50),
    Description TEXT
);

CREATE TABLE DimShipper (
    ShipperID INT PRIMARY KEY,
    CompanyName VARCHAR(50),
    Phone VARCHAR(20)
);

CREATE TABLE DimSupplier (
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

-- Создание фактологической таблицы
CREATE TABLE FactSales (
    SalesID INT PRIMARY KEY,
    DateID INT,
    CustomerID INT,
    ProductID INT,
    EmployeeID INT,
    CategoryID INT,
    ShipperID INT,
    SupplierID INT,
    QuantitySold INT,
    UnitPrice DECIMAL(10, 2),
    Discount DECIMAL(4, 2),
    TotalAmount DECIMAL(10, 2),
    TaxAmount DECIMAL(10, 2),
    FOREIGN KEY (DateID) REFERENCES DimDate(DateID),
    FOREIGN KEY (CustomerID) REFERENCES DimCustomer(CustomerID),
    FOREIGN KEY (ProductID) REFERENCES DimProduct(ProductID),
    FOREIGN KEY (EmployeeID) REFERENCES DimEmployee(EmployeeID),
    FOREIGN KEY (CategoryID) REFERENCES DimCategory(CategoryID),
    FOREIGN KEY (ShipperID) REFERENCES DimShipper(ShipperID),
    FOREIGN KEY (SupplierID) REFERENCES DimSupplier(SupplierID)
);


