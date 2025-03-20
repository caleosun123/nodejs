const express = require('express');
const hbs = require("hbs");
const cookieParser = require('cookie-parser');
const path = require('path');
const router = require('./pages/pages.js');

const app = express();

app.set("view engine", "hbs");

app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(router);
app.use(express.static(path.join(__dirname, "public")));

app.use((req, res, next) => {
    res.status(404).sendFile(path.join(__dirname, "public", "404.js"));
})

app.listen(8080, () => {
    console.log("Listening on port 8080!")
});
