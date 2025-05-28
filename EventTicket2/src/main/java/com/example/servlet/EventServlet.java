package com.example.servlet;

import com.example.model.Event;
import com.example.service.EventService;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;
import java.util.UUID;

public class EventServlet extends HttpServlet {
    private EventService eventService = new EventService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String sortBy = req.getParameter("sortBy");
        List<Event> events = eventService.getEvents(sortBy);
        if (events == null) {
            events = new java.util.ArrayList<>(); // Default to empty list if null
        }
        req.setAttribute("events", events);
        req.getRequestDispatcher("/index.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String name = req.getParameter("name");
        String date = req.getParameter("date");
        String time = req.getParameter("time");
        String popularityStr = req.getParameter("popularity");
        String picture = req.getParameter("picture");

        if (name != null && date != null && time != null && popularityStr != null && picture != null) {
            try {
                int popularity = Integer.parseInt(popularityStr);
                Event event = new Event(UUID.randomUUID().toString(), name, date, time, popularity, picture);
                eventService.addEvent(event);
            } catch (NumberFormatException e) {
                req.setAttribute("error", "Invalid popularity value.");
                req.getRequestDispatcher("/error.jsp").forward(req, resp);
                return;
            }
        }

        resp.sendRedirect(req.getContextPath() + "/events");
    }
}