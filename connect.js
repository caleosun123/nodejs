const mysql = require("mysql2");

const con = mysql.createConnection({
    host: "trolley.proxy.rlwy.net",
    port: 47251,
    user: "root",
    password: "QRiXtoCbsvFyKbWsaBpkLsouwhAeCuwJ",
    database: "railway"
});

con.connect(function(err) {
    if(err) throw err;
    console.log("Connected!");
});

module.exports = con;