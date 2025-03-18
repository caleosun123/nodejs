const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");
const con = require("../connect.js");
require('dotenv').config();

exports.register = async (req, res) => {
    const {name, email, password} = req.body;

    const salt = await bcrypt.genSalt(12);
    const hashedPassword = await bcrypt.hash(password, salt);
    
    const checkEmailQuery = "SELECT * FROM users WHERE email = ?";
    con.query(checkEmailQuery, [email], (err, results) => {
        if(err) {
            console.log("Failed to check if email exists: " + err.stack);
            return;
        }
        if(results.length > 0) {
            res.status(400).send("Email already exists!");
            return;
        }

        const query = "INSERT INTO users (name, email, password) VALUES (?, ?, ?)";
        const values = [name, email, hashedPassword];

        con.query(query, values, (err, results) => {
            if(err) {
                console.log("Failed to insert user: " + e.stack);
                return;
            }
            console.log("User inserted successfully!");
            res.status(201).send("User inserted successfully!");
        });
    });
}

exports.login = async (req, res) => {
    const {email, password} = req.body;

    const query = "SELECT * FROM users WHERE email = ?";
    con.query(query, [email], async (err, results) => {
        if(err) {
            console.log("Failed to get user: " + err.stack);
            return;
        }
        if(results.length === 0) {
            res.status(400).send("Invalid email or password!");
            return;
        }

        const user = results[0];
        const isMatch = await bcrypt.compare(password, user.password);

        if(!isMatch) {
            res.status(400).send("Invalid email or password!");
            return;
        }

        const token = jwt.sign({ id: user.id, name: user.name, email: user.email }, process.env.JWT_SECRET, { expiresIn: "1h" });

        res.cookie("token", token, { httpOnly: true, maxAge: 3600000 });
        return res.redirect("/dashboard");
    });
}