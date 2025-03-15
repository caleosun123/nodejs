<%-- 
    Document   : login
    Created on : Mar 15, 2025, 8:34:53 AM
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
        <h1>Login</h1><hr>
        <form action="login" method="post">
            <label for="email">Email:</label>
            <input type="email" name="email" id="email" placeholder="Email..." required><br><br>
            <label for="password">Password:</label>
            <input type="password" name="password" id="password" placeholder="Password..." required><br><br>
            <input type="submit" value="Login">
        </form>
    </body>
</html>
