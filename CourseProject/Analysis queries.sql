SELECT
    COUNT(order_id) AS total_orders,
    SUM(total_amount) AS total_sales
FROM FactOrders;

SELECT
    AVG(total_amount) AS average_order_value
FROM FactOrders;

SELECT
    COUNT(certificate_id) AS active_gift_certificates
FROM DimGiftCertificates
WHERE status = 'active';

SELECT
    SUM(value) AS redeemed_value
FROM DimGiftCertificates gc
JOIN FactGiftCertificateRedemptions gcr ON gc.certificate_id = gcr.certificate_id;

SELECT
    u.name,
    COUNT(o.order_id) AS orders_count,
    SUM(o.total_amount) AS total_spent
FROM FactOrders o
JOIN DimUsers u ON o.user_id = u.user_id
GROUP BY u.name;

SELECT
    p.name,
    SUM(oi.quantity) AS total_quantity_sold,
    SUM(oi.price * oi.quantity) AS total_sales
FROM FactOrders o
JOIN OrderItems oi ON o.order_id = oi.order_id
JOIN DimProducts p ON oi.product_id = p.product_id
GROUP BY p.name;

SELECT
    c.name,
    SUM(oi.quantity) AS total_quantity_sold,
    SUM(oi.price * oi.quantity) AS total_sales
FROM FactOrders o
JOIN OrderItems oi ON o.order_id = oi.order_id
JOIN DimProducts p ON oi.product_id = p.product_id
JOIN ProductCategories pc ON p.product_id = pc.product_id
JOIN Categories c ON pc.category_id = c.category_id
GROUP BY c.name;

SELECT
    u.name,
    COUNT(gcr.redemption_id) AS redemptions_count,
    SUM(gc.value) AS total_value_redeemed
FROM FactGiftCertificateRedemptions gcr
JOIN DimGiftCertificates gc ON gcr.certificate_id = gc.certificate_id
JOIN FactOrders o ON gcr.order_id = o.order_id
JOIN DimUsers u ON o.user_id = u.user_id
GROUP BY u.name;