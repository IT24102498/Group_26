package com.eventticket.model;

import com.eventticket.utils.UserStore;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
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

        // Check for admin credentials (using file-based validation)
        if ("admin".equals(username) && UserStore.validateUser(username, "admin", getServletContext())) {
            HttpSession session = request.getSession();
            session.setAttribute("username", username);
            response.sendRedirect("http://localhost:8080/EventTicketSystem/adminpanel.jsp");
            return;
        }

        // Check user existence and validate credentials
        if (!UserStore.userExists(username, getServletContext())) {
            response.sendRedirect("login.jsp?error=invalid");
            return;
        }

        // Validate password
        if (!UserStore.validateUser(username, password, getServletContext())) {
            response.sendRedirect("login.jsp?error=invalid");
            return;
        }

        // Successful login for regular users
        HttpSession session = request.getSession();
        session.setAttribute("username", username);
        response.sendRedirect("index.jsp?login=success");
    }
}