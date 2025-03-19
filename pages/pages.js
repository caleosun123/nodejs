const express = require('express');
const auth = require("../controllers/auth");
const { checkToken, redirectDashboard } = require('../check');

const router = express.Router();

router.get("/", redirectDashboard, (req, res) => {
    res.render("index.hbs");
});

router.get("/register", redirectDashboard, (req, res) => {
    res.render("register.hbs");
});

router.get("/login", redirectDashboard, (req, res) => {
    res.render("login.hbs");
});

router.get("/dashboard", checkToken, (req, res) => {
    res.render("dashboard.hbs", { user: req.user });
});

router.get("/logout", (req, res) => {
    res.clearCookie("token");
    res.redirect("/login");
});

router.post("/auth/register", auth.register);
router.post("/auth/login", auth.login);

module.exports = router;