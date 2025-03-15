/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.bumbleb.security;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.PreparedStatement;

/**
 *
 * @author Carissa
 */
public class Check {
    
    private static final String DATABASE_URI = "jdbc:mysql://trolley.proxy.rlwy.net:47251/railway?user=root&password=QRiXtoCbsvFyKbWsaBpkLsouwhAeCuwJ";
    
    public Check() {
        
    }
    
    public boolean ifEmailExists(String email) {
        String checkEmailQuery = "SELECT COUNT(*) FROM users WHERE email = ?";
        
        try {
            // Connection conn = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/test", "root", "Caleb07038111(1)");
            
            Connection conn = DriverManager.getConnection(DATABASE_URI);
            
            PreparedStatement stmt = conn.prepareStatement(checkEmailQuery);
            
            stmt.setString(1, email);
            
            ResultSet rs = stmt.executeQuery();
            if(rs.next()) {
                return rs.getInt(1) > 0;
            }
            
            stmt.close();
            rs.close();
            conn.close();
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return false;
    }
}
