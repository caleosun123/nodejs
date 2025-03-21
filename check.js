const jwt = require('jsonwebtoken');

exports.checkToken = (req, res, next) => {
    const token = req.cookies.token;

    if(!token) {
        return res.redirect('/login');
    }

    jwt.verify(token, process.env.JWT_SECRET, (err, decoded) => {
        if(err) {
            return res.redirect('/login');
        }

        req.user = decoded;
        next();
    });
}

exports.redirectDashboard = (req, res, next) => {
    const token = req.cookies.token;

    jwt.verify(token, process.env.JWT_SECRET, (err, decoded) => {
        if(err) {
            return next();
        }

        req.user = decoded;
        res.redirect("/dashboard");
    });
}