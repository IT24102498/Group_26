package com.example.servlet;

import com.example.model.Booking;
import com.example.model.Event;
import com.example.service.BookingService;
import com.example.service.EventService;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class HistoryServlet extends HttpServlet {
    private BookingService bookingService = new BookingService();
    private EventService eventService = new EventService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Booking> bookings = bookingService.getBookings();
        List<Event> events = eventService.getEvents(null);
        Map<String, String> eventNames = new HashMap<>();
        for (Event event : events) {
            eventNames.put(event.getId(), event.getName());
        }
        req.setAttribute("bookings", bookings);
        req.setAttribute("eventNames", eventNames);
        req.getRequestDispatcher("/history.jsp").forward(req, resp);
    }
}