const express = require('express');
const hbs = require("hbs");
const cookieParser = require('cookie-parser')
const router = require('./pages/pages.js');

const app = express();

app.set("view engine", "hbs");

app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(router);

app.listen(8080, () => {
    console.log("Listening on port 8080!")
});