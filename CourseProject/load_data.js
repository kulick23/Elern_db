const { Client } = require('pg');
const fs = require('fs');
const csv = require('csv-parser');

const client = new Client({
    user: 'Danila',
    host: 'localhost',
    database: 'Gifts',
    password: '123',
    port: 5432,
});

client.connect();

function insertData(table, columns, values) {
    const query = `INSERT INTO ${table} (${columns}) VALUES (${values}) ON CONFLICT DO NOTHING;`;
    return client.query(query);
}

function loadDataFromCsv(filePath) {
    const results = [];

    fs.createReadStream(filePath)
        .pipe(csv())
        .on('data', (data) => results.push(data))
        .on('end', () => {
            let currentTable = '';
            let columns = '';
            let promises = [];

            results.forEach(row => {
                if (row.Table !== currentTable) {
                    currentTable = row.Table;
                    columns = row.Columns;
                }

                const values = row.Values.split(',').map(value => `'${value.trim()}'`).join(', ');
                promises.push(insertData(currentTable, columns, values));
            });

            Promise.all(promises)
                .then(() => {
                    console.log('Data loaded successfully');
                    client.end();
                })
                .catch(error => {
                    console.error('Error loading data:', error);
                    client.end();
                });
        });
}

loadDataFromCsv('./data.csv');
