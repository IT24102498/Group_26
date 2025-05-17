package com.eventticket.model;

import com.eventticket.utils.UserStore;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

@WebServlet("/LoginServlet")
public class login extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // Validate input
        if (username == null || password == null || username.isEmpty() || password.isEmpty()) {
            response.sendRedirect("login.jsp?error=missing");
            return;
        }

        // Check user existence
        if (!UserStore.users.containsKey(username)) {
            response.sendRedirect("login.jsp?error=invalid");
            return;
        }

        // Hash and validate password
        String hashedPassword = hashPassword(password);
        if (!hashedPassword.equals(UserStore.users.get(username))) {
            response.sendRedirect("login.jsp?error=invalid");
            return;
        }

        // Successful login
        HttpSession session = request.getSession();
        session.setAttribute("username", username);
        response.sendRedirect("index.jsp?login=success");
    }

    // Local hashing method (matches the one in UserStore)
    private String hashPassword(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hashBytes = md.digest(password.getBytes());
            StringBuilder sb = new StringBuilder();
            for (byte b : hashBytes) {
                sb.append(String.format("%02x", b));
            }
            return sb.toString();
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("SHA-256 algorithm not found.", e);
        }
    }
}
