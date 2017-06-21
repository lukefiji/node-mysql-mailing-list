require("dotenv").config();
const mysql = require("mysql");
const faker = require("faker");

// Create a connection to mySQL database
const connection = mysql.createConnection({
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  database: process.env.DB_NAME
});

// Generate email and insert into db
// var person = {
//   email: faker.internet.email(),
//   created_at: faker.date.past(5)
// };

// connection.query("INSERT INTO users SET ?", person, (err, results, fields) => {
//   if (err) throw err;
//   console.log(results);
// });

const data = [];

for (let i = 0; i < 500; i++) {
  data.push([faker.internet.email(), faker.date.past(7)]);
}

var q = "INSERT INTO users (email, created_at) VALUES ?";

connection.query(q, [data], (err, result) => {
  if (err) throw err;
  console.log(result);
});

connection.end();
