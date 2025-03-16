<%-- 
    Document   : dashboard
    Created on : Mar 15, 2025, 12:05:54 PM
    Author     : Carissa
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="jakarta.servlet.http.Cookie" %>
<%@page import="jakarta.servlet.http.HttpServletRequest" %>
<%@page import="jakarta.servlet.http.HttpServletResponse" %>
<%@page import="java.sql.*" %>
<%

    String DATABASE_URI = "jdbc:mysql://trolley.proxy.rlwy.net:47251/railway?user=root&password=QRiXtoCbsvFyKbWsaBpkLsouwhAeCuwJ";
    
    Cookie[] cookies = request.getCookies();
    String sessionToken = null;
    int userId = -1;
    
    if (cookies != null) {
        for(Cookie cookie : cookies) {
            if("sessionToken".equals(cookie.getName())) {
                sessionToken = cookie.getValue();
            } else if ("userId".equals(cookie.getName())) {
                try {
                    userId = Integer.parseInt(cookie.getValue());
                } catch (NumberFormatException ignored) {}
            }
        }
    }
    
    boolean isLoggedIn = false;
    String email = "";
    String name = "";
    
    if(sessionToken != null) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(DATABASE_URI);
            
            String query = "SELECT name, email FROM users WHERE id = ? and session_token = ?";
            stmt = conn.prepareStatement(query);
            stmt.setInt(1, userId);
            stmt.setString(2, sessionToken);
            rs = stmt.executeQuery();
            
            if(rs.next()) {
                isLoggedIn = true;
                email = rs.getString("email");
                name = rs.getString("name");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if(rs != null) try {rs.close();} catch(SQLException ignored) {}
            if(stmt != null) try {stmt.close();} catch (SQLException ignored) {}
            if(conn != null) try {conn.close();} catch (SQLException ignored) {}
        }
    }
    
    if(!isLoggedIn) {
        response.sendRedirect("/login.jsp");
        return;
    }

%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1 align="center">Dashboard</h1><hr>
        <p>Hello, <%= name %></p>
    </body>
</html>
