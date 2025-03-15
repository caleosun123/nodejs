/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package com.bumbleb.website;

import com.bumbleb.security.bcrypt;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.security.SecureRandom;
import java.util.Base64;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Cookie;

/**
 *
 * @author Carissa
 */
@WebServlet(name="LoginServlet", urlPatterns={"/login"})
public class LoginServlet extends HttpServlet {
    
    private static final String DATABASE_URI = "jdbc:mysql://trolley.proxy.rlwy.net:47251/railway?user=root&password=QRiXtoCbsvFyKbWsaBpkLsouwhAeCuwJ";
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        try {
            
            Class.forName("com.mysql.cj.jdbc.Driver");
            
            Connection conn = DriverManager.getConnection(DATABASE_URI);
            
            String query = "SELECT * FROM users WHERE email = ?";
            
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, email);
            
            ResultSet rs = stmt.executeQuery();
            if(rs.next()) {
                String storedPassword = rs.getString("password");
                int userId = rs.getInt("id");
                
                if(bcrypt.checkPassword(password, storedPassword)) {
                    
                    SecureRandom secureRandom = new SecureRandom();
                    byte[] token = new byte[24];
                    secureRandom.nextBytes(token);
                    String tokenString = Base64.getUrlEncoder().withoutPadding().encodeToString(token);
                    
                    String updateQuery = "UPDATE users SET session_token = ? WHERE id = ?";
                    PreparedStatement updateStmt = conn.prepareStatement(updateQuery);
                    updateStmt.setString(1, tokenString);
                    updateStmt.setInt(2, userId);
                    
                    updateStmt.executeUpdate();
                    updateStmt.close();
                    
                    Cookie cookie = new Cookie("sessionToken", tokenString);
                    cookie.setMaxAge(60 * 60 * 24);
                    cookie.setPath("/");
                    cookie.setHttpOnly(true);
                    response.addCookie(cookie);
                    
                    Cookie userIdCookie = new Cookie("userId", String.valueOf(userId));
                    userIdCookie.setMaxAge(60 * 60 * 24);
                    userIdCookie.setPath("/");
                    response.addCookie(userIdCookie);
                    
                    out.println("Login successful");
                } else {
                    out.println("Invalid email or password");
                }
            } else {
                out.println("Invalid email or password");
            }
            stmt.close();
            rs.close();
            conn.close();
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
    }
}
