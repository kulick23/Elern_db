const { Client } = require('pg');

const olapClient = new Client({
    user: 'Danila',
    host: 'localhost',
    database: 'Gifts',
    password: '123',
    port: 5432,
});

const oltpClient = new Client({
    user: 'Danila',
    host: 'localhost',
    database: 'Gifts',
    password: '123',
    port: 5432,
});

async function loadDimUsers() {
    const res = await oltpClient.query('SELECT * FROM Users');
    for (const row of res.rows) {
        const insertQuery = `INSERT INTO DimUsers (user_id, name, email, created_at) VALUES ($1, $2, $3, $4) ON CONFLICT DO NOTHING`;
        await olapClient.query(insertQuery, [row.user_id, row.name, row.email, row.created_at]);
    }
}

async function loadDimProducts() {
    const res = await oltpClient.query('SELECT * FROM Products');
    for (const row of res.rows) {
        const insertQuery = `INSERT INTO DimProducts (product_id, name, description, price) VALUES ($1, $2, $3, $4) ON CONFLICT DO NOTHING`;
        await olapClient.query(insertQuery, [row.product_id, row.name, row.description, row.price]);
    }
}

async function loadDimGiftCertificates() {
    const res = await oltpClient.query('SELECT * FROM GiftCertificates');
    for (const row of res.rows) {
        const insertQuery = `INSERT INTO DimGiftCertificates (certificate_id, code, value, status, created_at) VALUES ($1, $2, $3, $4, $5) ON CONFLICT DO NOTHING`;
        await olapClient.query(insertQuery, [row.certificate_id, row.code, row.value, row.status, row.created_at]);
    }
}

async function loadFactOrders() {
    const res = await oltpClient.query('SELECT * FROM Orders');
    for (const row of res.rows) {
        const insertQuery = `INSERT INTO FactOrders (order_id, user_id, order_date, total_amount) VALUES ($1, $2, $3, $4) ON CONFLICT DO NOTHING`;
        await olapClient.query(insertQuery, [row.order_id, row.user_id, row.order_date, row.total_amount]);
    }
}

async function loadFactGiftCertificateRedemptions() {
    const res = await oltpClient.query('SELECT * FROM GiftCertificateRedemptions');
    for (const row of res.rows) {
        const insertQuery = `INSERT INTO FactGiftCertificateRedemptions (redemption_id, certificate_id, order_id, redeemed_at) VALUES ($1, $2, $3, $4) ON CONFLICT DO NOTHING`;
        await olapClient.query(insertQuery, [row.redemption_id, row.certificate_id, row.order_id, row.redeemed_at]);
    }
}

async function main() {
    await olapClient.connect();
    await oltpClient.connect();
    
    await loadDimUsers();
    await loadDimProducts();
    await loadDimGiftCertificates();
    await loadFactOrders();
    await loadFactGiftCertificateRedemptions();
    
    await oltpClient.end();
    await olapClient.end();
}

main().catch(err => console.error('Error executing ETL process:', err));
