require("dotenv").config();
const express = require("express");
const mysql = require("mysql");
const faker = require("faker");
const bodyParser = require("body-parser");
const flash = require("express-flash");
const cookieParser = require("cookie-parser");
const session = require("express-session");

const app = express();

// Set Pug as view engine
app.set("view engine", "pug");

app.use(bodyParser.urlencoded({ extended: true }));

// Set up flash
app.use(cookieParser("Node MySQL Mailing List"));
app.use(session({ cookie: { maxAge: 600000 } }));
app.use(flash());

const SERVER_PORT = 8080;

// Create a connection to mySQL database
const connection = mysql.createConnection({
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  database: process.env.DB_NAME
});

app.get("/", (req, res) => {
  //Find count of users in DB
  const q = "SELECT COUNT(*) AS count FROM users";
  connection.query(q, function(err, results) {
    if (err) {
      req.flash("info", `Error: ${err.code}`);
      console.log(err.code);
    }

    // Render Pug template /w count
    res.render("index", { count: results[0].count });
  });
});

app.post("/register", (req, res) => {
  // Collect post and send query to MySQL
  const register = { email: req.body.email };
  const q = "INSERT INTO users SET ?";
  connection.query(q, register, (err, result) => {
    if (err) {
      // Flash message if there is an error
      req.flash("info", "This email has already been registered.");
      console.log(err.code);
    } else {
      // Flash message if no error
      req.flash("info", "Thank you for registering!");
    }
    res.redirect("/");
  });
});

//404 Route (ALWAYS Keep this as the last route)
app.get("*", function(req, res) {
  res.send("404 - Not Found", 404);
});

app.listen(SERVER_PORT, () => {
  console.log(`App listening on port ${SERVER_PORT}!`);
});

function getNumUsers() {}
