
CREATE TABLE sales_data (
    sale_id SERIAL PRIMARY KEY,
    product_id INTEGER,
    region_id INTEGER,
    salesperson_id INTEGER,
    sale_amount NUMERIC,
    sale_date DATE
) PARTITION BY RANGE (sale_date);

DO $$
BEGIN
    FOR i IN 0..11 LOOP
        EXECUTE format(
            'CREATE TABLE sales_data_%s PARTITION OF sales_data FOR VALUES FROM (%L) TO (%L)',
            to_char(current_date - interval '1 month' * i, 'YYYY_MM'),
            date_trunc('month', current_date - interval '1 month' * i)::date,
            date_trunc('month', current_date - interval '1 month' * (i-1))::date
        );
    END LOOP;
END $$;
	
DO $$
BEGIN
    FOR i IN 1..1000 LOOP
        INSERT INTO sales_data (product_id, region_id, salesperson_id, sale_amount, sale_date)
        VALUES (
            (random() * 10)::INT,
            (random() * 5)::INT,
            (random() * 20)::INT,
            (random() * 1000)::NUMERIC,
            (current_date - interval '1 day' * (random() * 365)::INT)
        );
    END LOOP;
END $$;


SELECT * FROM sales_data
WHERE sale_date >= '2024-04-01' AND sale_date < '2024-05-01';


SELECT to_char(sale_date, 'YYYY-MM') AS month, SUM(sale_amount) AS total_sales
FROM sales_data
GROUP BY month
ORDER BY month;


SELECT region_id, salesperson_id, SUM(sale_amount) AS total_sales
FROM sales_data
WHERE region_id = 2
GROUP BY region_id, salesperson_id
ORDER BY total_sales DESC
LIMIT 3;


DO $$
BEGIN
    -- Drop partitions older than 12 months
    FOR i IN 12..12 LOOP
        EXECUTE format(
            'DROP TABLE IF EXISTS sales_data_%s',
            to_char(current_date - interval '1 month' * i, 'YYYY_MM')
        );
    END LOOP;

    -- Create partitions for the next 12 months
    FOR i IN 1..12 LOOP
        EXECUTE format(
            'CREATE TABLE IF NOT EXISTS sales_data_%s PARTITION OF sales_data FOR VALUES FROM (%L) TO (%L)',
            to_char(current_date + interval '1 month' * i, 'YYYY_MM'),
            date_trunc('month', current_date + interval '1 month' * i)::date,
            date_trunc('month', current_date + interval '1 month' * (i+1))::date
        );
    END LOOP;
END $$;



	
		




	
	
	
	
	
	