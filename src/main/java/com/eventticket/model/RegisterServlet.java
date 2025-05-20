package com.eventticket.model;

import com.eventticket.utils.UserStore;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        System.out.println("Register attempt: username=" + username + ", email=" + email);

        response.setContentType("text/plain;charset=UTF-8");

        try (PrintWriter out = response.getWriter()) {
            // Validate input fields
            if (username == null || email == null || password == null ||
                    username.isEmpty() || email.isEmpty() || password.isEmpty()) {
                System.out.println("Registration failed: missing fields");
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                out.print("All fields are required.");
                return;
            }

            // Check if username already exists
            if (UserStore.userExists(username, getServletContext())) {
                System.out.println("Registration failed: username already taken");
                response.sendRedirect("register.jsp?error=Username is already taken.");
                return;
            }

            // Store user with plaintext password and email
            UserStore.addUser(username, password, email, getServletContext());

            // Store username and email in session
            HttpSession session = request.getSession();
            session.setAttribute("username", username);
            session.setAttribute("email", email);

            System.out.println("Registration successful: redirecting to login.jsp");
            response.sendRedirect("login.jsp?regsuccess=Registration successful! Please login.");
        } catch (Exception e) {
            System.err.println("Registration error: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect("register.jsp?error=Registration failed due to server error.");
        }
    }
}