package com.eventticket.model;

import com.eventticket.dao.ReservationDAO;
import com.eventticket.dao.SeatDAO;
import com.eventticket.model.Seat;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.*;
import java.util.stream.Collectors;



    @Override
    public void init() throws ServletException {
        super.init();
        seatDAO = new SeatDAO();
        reservationDAO = new ReservationDAO(seatDAO);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String eventId = request.getParameter("eventId");
        String action = request.getParameter("action");

        if ("getSeats".equals(action) && eventId != null) {
            try {
                List<Seat> seats = seatDAO.getSeatsByEvent(eventId);
                String jsonResponse = convertSeatsToJson(seats);
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write(jsonResponse);
                return;
            } catch (Exception e) {
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error processing seat data");
                return;
            }
        }

        // Forward to JSP for regular page load
        request.getRequestDispatcher("/seatManagement.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String eventId = request.getParameter("eventId");
        String action = request.getParameter("action");

        if (eventId == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Event ID is required");
            return;
        }

        try {
            switch (action) {
                case "addSeats":
                    handleAddSeats(request, response, eventId);
                    break;
                case "reserveSeats":
                    handleReserveSeats(request, response, eventId);
                    break;
                case "modifyReservation":
                    handleModifyReservation(request, response);
                    break;
                default:
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
            }
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid numeric value");
        } catch (Exception e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Server error: " + e.getMessage());
        }
    }

    private String convertSeatsToJson(List<Seat> seats) {
        StringBuilder json = new StringBuilder("[");
        for (Seat seat : seats) {
            if (json.length() > 1) {
                json.append(",");
            }
            json.append(String.format(
                    "{\"id\":\"%s\",\"eventId\":\"%s\",\"section\":\"%s\",\"row\":\"%s\",\"number\":%d,\"status\":\"%s\",\"type\":\"%s\",\"price\":%.2f}",
                    escapeJson(seat.getId()),
                    escapeJson(seat.getEventId()),
                    escapeJson(seat.getSection()),
                    escapeJson(seat.getRow()),
                    seat.getNumber(),
                    escapeJson(seat.getStatus()),
                    escapeJson(seat.getType()),
                    seat.getPrice()
            ));
        }
        json.append("]");
        return json.toString();
    }

    private String escapeJson(String input) {
        if (input == null) {
            return "";
        }
        return input.replace("\\", "\\\\")
                .replace("\"", "\\\"")
                .replace("\b", "\\b")
                .replace("\f", "\\f")
                .replace("\n", "\\n")
                .replace("\r", "\\r")
                .replace("\t", "\\t");
    }

    private void handleAddSeats(HttpServletRequest request, HttpServletResponse response, String eventId) throws IOException {
        String section = request.getParameter("section");
        String row = request.getParameter("row");
        String seatNumbersInput = request.getParameter("seatNumbers");
        String type = request.getParameter("type");
        double basePrice = Double.parseDouble(request.getParameter("basePrice"));

        List<Integer> seatNumbers = parseSeatNumbers(seatNumbersInput);
        if (seatNumbers.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid seat numbers");
            return;
        }

        seatDAO.addSeats(eventId, section, row, seatNumbers, type, basePrice);
        response.sendRedirect(request.getContextPath() + "/seat-management?eventId=" + eventId);
    }

    private void handleReserveSeats(HttpServletRequest request, HttpServletResponse response, String eventId) throws IOException {
        String[] seatIds = request.getParameterValues("seatIds");
        String userId = (String) request.getSession().getAttribute("userId");

        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        if (seatIds == null || seatIds.length == 0) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "No seats selected");
            return;
        }

        Reservation reservation = reservationDAO.createReservation(
                eventId,
                userId,
                Arrays.asList(seatIds)
        );

        if (reservation == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Failed to create reservation");
            return;
        }

        response.sendRedirect(request.getContextPath() + "/confirmation.jsp?reservationId=" + reservation.getId());
    }

    private void handleModifyReservation(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String reservationId = request.getParameter("reservationId");
        String modifyAction = request.getParameter("modifyAction");
        String[] newSeatIds = request.getParameterValues("newSeatIds");

        boolean success = false;
        switch (modifyAction) {
            case "cancel":
                success = reservationDAO.cancelReservation(reservationId);
                break;
            case "change":
                if (newSeatIds == null || newSeatIds.length == 0) {
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "No new seats selected");
                    return;
                }
                success = reservationDAO.modifyReservationSeats(reservationId, Arrays.asList(newSeatIds));
                break;
            case "upgrade":
                success = handleUpgradeReservation(reservationId, newSeatIds);
                break;
            default:
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid modification action");
                return;
        }

        if (success) {
            response.sendRedirect(request.getContextPath() + "/confirmation.jsp?reservationId=" + reservationId);
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Failed to modify reservation");
        }
    }

    private boolean handleUpgradeReservation(String reservationId, String[] newSeatIds) {
        // Implementation for upgrade would verify seats are VIP
        // For now, just treat as regular seat change
        return reservationDAO.modifyReservationSeats(reservationId, Arrays.asList(newSeatIds));
    }

    private List<Integer> parseSeatNumbers(String input) {
        if (input == null || input.trim().isEmpty()) {
            return Collections.emptyList();
        }

        List<Integer> numbers = new ArrayList<>();
        String[] parts = input.split(",");

        for (String part : parts) {
            part = part.trim();
            if (part.contains("-")) {
                String[] range = part.split("-");
                if (range.length == 2) {
                    try {
                        int start = Integer.parseInt(range[0].trim());
                        int end = Integer.parseInt(range[1].trim());
                        for (int i = Math.min(start, end); i <= Math.max(start, end); i++) {
                            numbers.add(i);
                        }
                    } catch (NumberFormatException e) {
                        // Skip invalid range
                    }
                }
            } else {
                try {
                    numbers.add(Integer.parseInt(part));
                } catch (NumberFormatException e) {
                    // Skip invalid number
                }
            }
        }

        return numbers;
    }
}