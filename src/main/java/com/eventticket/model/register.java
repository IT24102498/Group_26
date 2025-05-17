package com.eventticket.model;

import com.eventticket.utils.UserStore;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

@WebServlet("/RegisterServlet")
public class register extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        response.setContentType("text/plain;charset=UTF-8");

        try (PrintWriter out = response.getWriter()) {
            // Validate input fields
            if (username == null || email == null || password == null ||
                    username.isEmpty() || email.isEmpty() || password.isEmpty()) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                out.print("All fields are required.");
                return;
            }

            // Check if username already exists
            if (UserStore.users.containsKey(username)) {
                response.sendRedirect("register.jsp?error=Username is already taken.");
                return;
            }

            // Hash and store password
            String hashedPassword = hashPassword(password);
            UserStore.users.put(username, hashedPassword);

            // Store username and email in session for access during payment
            HttpSession session = request.getSession();
            session.setAttribute("username", username);
            session.setAttribute("email", email);

            // Redirect to payment page (update URL if you use a servlet or JSP)
            //response.sendRedirect("processPayment.jsp");
        }
    }

    // Hash password with SHA-256
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
            throw new RuntimeException("Hashing algorithm not found.");
        }
    }
}
