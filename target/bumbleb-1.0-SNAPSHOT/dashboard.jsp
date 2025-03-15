<%-- 
    Document   : dashboard
    Created on : Mar 15, 2025, 12:05:54 PM
    Author     : Carissa
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="jakarta.servlet.http.Cookie" %>
<%@page import="jakarta.servlet.http.HttpServletRequest" %>
<%@page import="jakarta.servlet.http.HttpServletResponse" %>
<%@page import="java.sql.Connection" %>
<%@page import="java.sql.DriverManager" %>
<%@page import="java.sql.PreparedStatement" %>
<%@page import="java.sql.ResultSet" %>

<%

    String DATABASE_URI = "jdbc:mysql://trolley.proxy.rlwy.net:47251/railway?user=root&password=QRiXtoCbsvFyKbWsaBpkLsouwhAeCuwJ";
    
    Cookie[] cookies = request.getCookies();

    boolean isLoggedIn = false;
    int userId = -1;
    String sessionToken = null;

    if (cookies != null) {
        for (Cookie cookie : cookies) {
            if("sessionToken".equals(cookie.getName())) {
                sessionToken = cookie.getValue();
            }
            if("userId".equals(cookie.getName())) {
                userId = Integer.parseInt(cookie.getValue());
            }
        }
    }
    
    if(sessionToken != null) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(DATABASE_URI);
            
            String query = "SELECT id FROM users WHERE session_token = ?";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, sessionToken);
            
            ResultSet rs = stmt.executeQuery();
            if(rs.next()) {
                isLoggedIn = true;
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
    }
    
    if(!isLoggedIn) {
        response.sendRedirect("/login.jsp");
        return;
    }
    
    String email = "";
    String name = "";
    
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection(DATABASE_URI);
        
        String query = "SELECT email, name FROM users WHERE id = ?";
        PreparedStatement stmt = conn.prepareStatement(query);
        stmt.setInt(1, userId);
        
        ResultSet rs = stmt.executeQuery();
        
        if(rs.next()) {
            email = rs.getString("email");
            name = rs.getString("name");
        }
        stmt.close();
        rs.close();
        conn.close();
    } catch (Exception e) {
        System.out.println(e.getMessage());
    }

%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1 align="center">Dashboard</h1>
        <p>Hello, <%= name %></p>
    </body>
</html>
