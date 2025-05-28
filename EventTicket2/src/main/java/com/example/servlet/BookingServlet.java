package com.example.servlet;

import com.example.model.Booking;
import com.example.service.BookingService;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.UUID;

public class BookingServlet extends HttpServlet {
    private BookingService bookingService = new BookingService();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String eventId = req.getParameter("eventId");
            String userName = req.getParameter("userName");
            String seat = req.getParameter("seat");

            // Validate parameters
            if (eventId == null || eventId.isEmpty() || userName == null || userName.isEmpty() || seat == null || seat.isEmpty()) {
                throw new IllegalArgumentException("Missing required fields: eventId, userName, or seat");
            }

            String ticketId = UUID.randomUUID().toString();
            Booking booking = new Booking(ticketId, eventId, userName, seat);
            bookingService.addBookingToQueue(booking);
            bookingService.processBookings();
            resp.sendRedirect(req.getContextPath() + "/history");
        } catch (Exception e) {
            // Log the error and redirect to an error page or show a message
            req.setAttribute("error", "Failed to process booking: " + e.getMessage());
            req.getRequestDispatcher("/error.jsp").forward(req, resp);
        }
    }
}