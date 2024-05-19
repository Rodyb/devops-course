const express = require('express');
const mysql = require('mysql2');

const app = express();
const port = 3000;

const connection = mysql.createConnection({
    host: 'mysql-service',
    user: 'root',
    password: 'password',
    database: 'mydb'
});

// Create 'users' table if it doesn't exist
connection.query(`
  CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL
  )
`, (error, results) => {
    if (error) throw error;
    console.log('Users table created or already exists');

    // Insert sample data into 'users' table
    connection.query(`
    INSERT INTO users (username, email) VALUES
    ('john_doe', 'john.doe@example.com'),
    ('jane_smith', 'jane.smith@example.com')
  `, (insertError, insertResults) => {
        if (insertError) throw insertError;
        console.log('Sample data inserted into users table');
    });
});

// Serve static files from the "public" directory
app.use(express.static('public'));

app.get('/', (req, res) => {
    connection.query('SELECT * FROM users', (error, results) => {
        if (error) throw error;

        // Render the frontend with the user data
        res.send(`
      <html>
        <head>
          <title>User List</title>
        </head>
        <body>
          <h1>User List</h1>
          <ul>
            ${results.map(user => `<li>${user.username} - ${user.email}</li>`).join('')}
          </ul>
        </body>
      </html>
    `);
    });
});
app.get('/health', (req, res) => {
    res.status(200).send('OK');
});
app.listen(port, () => {
    console.log(`Server is running on http://localhost:${port}`);
});
