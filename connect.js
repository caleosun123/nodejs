const mysql = require("mysql2");

const con = mysql.createConnection({
    host: "localhost",
    user: "root",
    password: "Caleb07038111(1)",
    database: "userdb"
});

con.connect(function(err) {
    if(err) throw err;
    console.log("Connected!");
});

module.exports = con;