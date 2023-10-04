const mysql = require("mysql2");
require('dotenv').config();

let db_con  = mysql.createConnection({
    host: 'db',
    user: 'Ferius',
    password: 'Ferius1901',
    database: "gfg_db",
});

db_con.connect((err) => {
    if (err) {
      console.log("Database Connection Failed !!!", err);
    } else {
      console.log("connected to Database");
    }
});

module.exports = db_con;