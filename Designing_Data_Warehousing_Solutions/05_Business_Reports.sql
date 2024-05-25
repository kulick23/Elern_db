-- Примеры запросов для бизнес-отчетов

-- Общий объем продаж по клиентам
SELECT c.CompanyName, SUM(fs.TotalAmount) AS TotalSales
FROM FactSales fs
JOIN DimCustomer c ON fs.CustomerID = c.CustomerID
GROUP BY c.CompanyName
ORDER BY TotalSales DESC;

-- Ежемесячный отчет о продажах
SELECT 
    d.Year, d.Month, SUM(fs.TotalAmount) AS TotalSales
FROM FactSales fs
JOIN DimDate d ON fs.DateID = d.DateID
GROUP BY d.Year, d.Month
ORDER BY d.Year, d.Month;

-- Продажи по категориям продуктов
SELECT 
    cat.CategoryName, SUM(fs.TotalAmount) AS TotalSales
FROM FactSales fs
JOIN DimCategory cat ON fs.CategoryID = cat.CategoryID
GROUP BY cat.CategoryName
ORDER BY TotalSales DESC;

-- Эффективность продаж сотрудников
SELECT 
    e.FirstName, e.LastName, SUM(fs.TotalAmount) AS TotalSales
FROM FactSales fs
JOIN DimEmployee e ON fs.EmployeeID = e.EmployeeID
GROUP BY e.FirstName, e.LastName
ORDER BY TotalSales DESC;

-- Продажи по регионам
SELECT 
    c.Region, SUM(fs.TotalAmount) AS TotalSales
FROM FactSales fs
JOIN DimCustomer c ON fs.CustomerID = c.CustomerID
GROUP BY c.Region
ORDER BY TotalSales DESC;

