const express = require('express');
const { Pool } = require('pg');
const path = require('path');

const app = express();
const port = 3000;

const pool = new Pool({
    user: 'your_username',
    host: 'postgres',
    database: 'your_database',
    password: 'your_password',
    port: 5432,
});

// Function to create the database table if it does not exist
async function createTableIfNotExists() {
    try {
        const createTableQuery = `
            CREATE TABLE IF NOT EXISTS data (
                id SERIAL PRIMARY KEY,
                message TEXT
            );
        `;
        await pool.query(createTableQuery);
        console.log('Database table created or already exists.');
    } catch (error) {
        console.error('Error creating table:', error);
        throw error;
    }
}

// Call the function to create the table on startup
createTableIfNotExists();

// Serve static files from the 'public' directory
app.use(express.static(path.join(__dirname, 'public')));

app.use(express.json());

// API endpoint to fetch data from the backend
app.get('/api/data', async (req, res) => {
    try {
        const result = await pool.query('SELECT * FROM data ORDER BY id DESC LIMIT 1');
        res.json(result.rows[0]);
    } catch (error) {
        console.error('Error fetching data:', error);
        res.status(500).json({ error: 'Internal Server Error' });
    }
});

// API endpoint to save new data to the backend
app.post('/api/data', async (req, res) => {
    const { newData } = req.body;

    try {
        // Insert new data into the database
        const insertResult = await pool.query('INSERT INTO data (message) VALUES ($1) RETURNING *', [newData]);

        // Fetch the latest data to send back in the response
        const result = await pool.query('SELECT * FROM data ORDER BY id DESC LIMIT 1');

        res.json(result.rows[0]);
    } catch (error) {
        console.error('Error saving data:', error);
        res.status(500).json({ error: 'Internal Server Error' });
    }
});

// Catch-all route to serve the index.html page
app.get('*', (req, res) => {
    res.sendFile(path.join(__dirname, 'public', 'index.html'));
});

app.listen(port, '0.0.0.0', () => {
    console.log(`App listening at http://localhost:${port}`);
});
