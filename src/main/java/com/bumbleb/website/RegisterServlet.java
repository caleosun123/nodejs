/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package com.bumbleb.website;

import com.bumbleb.security.bcrypt;
import com.bumbleb.security.Check;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author Carissa
 */
@WebServlet(name="RegisterServlet", urlPatterns={"/register"})
public class RegisterServlet extends HttpServlet {
    
    private static final String DATABASE_URI = "jdbc:mysql://trolley.proxy.rlwy.net:47251/railway?user=root&password=QRiXtoCbsvFyKbWsaBpkLsouwhAeCuwJ";
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        
        PrintWriter out = response.getWriter();
        
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        String hashedPassword = bcrypt.hashPassword(password);
        
        Check check = new Check();
        
        try {
            
            Class.forName("com.mysql.cj.jdbc.Driver");
            
            if(check.ifEmailExists(email)) {
                out.println("User already exists");
                return;
            }
            
            // Connection conn = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/test", "root", "Caleb07038111(1)");
            
            Connection conn = DriverManager.getConnection(DATABASE_URI);
            
            String query = "INSERT INTO users (name, email, password)  VALUES(?, ?, ?)";
            
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, name);
            stmt.setString(2, email);
            stmt.setString(3, hashedPassword);
            
            int rowsInserted = stmt.executeUpdate();
            
            if(rowsInserted > 0) {
                out.println("User inserted successfully");
            } else {
                out.println("Failed to insert user");
            }
            
            stmt.close();
            conn.close();
            
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
    }
}
