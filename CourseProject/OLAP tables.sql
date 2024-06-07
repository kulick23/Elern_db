CREATE TABLE DimUsers (
    user_id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    email VARCHAR(255),
    created_at TIMESTAMP
);

CREATE TABLE DimProducts (
    product_id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    description TEXT,
    price DECIMAL(10, 2)
);

CREATE TABLE DimTime (
    date_id SERIAL PRIMARY KEY,
    date DATE,
    year INT,
    quarter INT,
    month INT,
    day INT
);

CREATE TABLE DimGiftCertificates (
    certificate_id SERIAL PRIMARY KEY,
    code VARCHAR(255),
    value DECIMAL(10, 2),
    status VARCHAR(50),
    created_at TIMESTAMP
);

CREATE TABLE FactOrders (
    order_id SERIAL PRIMARY KEY,
    user_id INT REFERENCES DimUsers(user_id),
    order_date TIMESTAMP,
    total_amount DECIMAL(10, 2)
);

CREATE TABLE FactGiftCertificateRedemptions (
    redemption_id SERIAL PRIMARY KEY,
    certificate_id INT REFERENCES DimGiftCertificates(certificate_id),
    order_id INT REFERENCES FactOrders(order_id),
    redeemed_at TIMESTAMP
);
