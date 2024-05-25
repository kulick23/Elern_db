
CREATE TABLE DimEmployees (
    EmployeeKey SERIAL PRIMARY KEY,  
    EmployeeID INT NOT NULL,        
    LastName VARCHAR(50),
    FirstName VARCHAR(50),
    Title VARCHAR(50),
    Address VARCHAR(100),
    City VARCHAR(50),
    Region VARCHAR(50),
    PostalCode VARCHAR(20),
    Country VARCHAR(50),
    StartDate DATE NOT NULL,
    EndDate DATE,
    IsCurrent BOOLEAN NOT NULL
);


INSERT INTO DimEmployees (EmployeeID, LastName, FirstName, Title, Address, City, Region, PostalCode, Country, StartDate, EndDate, IsCurrent)
SELECT EmployeeID, LastName, FirstName, Title, Address, City, Region, PostalCode, Country, CURRENT_DATE, NULL, TRUE
FROM Employees;


CREATE OR REPLACE FUNCTION update_employee(
    p_EmployeeID INT,
    p_LastName VARCHAR,
    p_FirstName VARCHAR,
    p_Title VARCHAR,
    p_Address VARCHAR,
    p_City VARCHAR,
    p_Region VARCHAR,
    p_PostalCode VARCHAR,
    p_Country VARCHAR
) RETURNS VOID AS $$
BEGIN
    UPDATE DimEmployees
    SET EndDate = CURRENT_DATE - INTERVAL '1 day', IsCurrent = FALSE
    WHERE EmployeeID = p_EmployeeID AND IsCurrent = TRUE;

    INSERT INTO DimEmployees (EmployeeID, LastName, FirstName, Title, Address, City, Region, PostalCode, Country, StartDate, EndDate, IsCurrent)
    VALUES (p_EmployeeID, p_LastName, p_FirstName, p_Title, p_Address, p_City, p_Region, p_PostalCode, p_Country, CURRENT_DATE, NULL, TRUE);
END;
$$ LANGUAGE plpgsql;

SELECT update_employee(1, 'Doe', 'John', 'Sales Manager', '123 New St', 'New York', 'NY', '10001', 'USA');

SELECT * FROM DimEmployees WHERE EmployeeID = 1 ORDER BY StartDate;


