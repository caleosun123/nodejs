<%-- 
    Document   : register
    Created on : Mar 14, 2025, 7:55:36 PM
    Author     : Carissa
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1 align="center">Register</h1><hr>
        <form action="register" method="post">
            <label for="name">Name:</label>
            <input type="text" name="name" id="name" placeholder="Name..." required><br><br>
            <label for="email">Email:</label>
            <input type="email" name="email" id="email" placeholder="Email..." required><br><br>
            <label for="password">Password:</label>
            <input type="password" name="password" id="password" placeholder="Password..." required><br><br>
            <input type="submit" value="Register">
        </form>
        Already have an account? <a href="login.jsp">Login</a>.
    </body>
</html>
