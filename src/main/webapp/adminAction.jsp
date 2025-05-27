<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.eventticket.model.Event" %>
<%@ page import="com.eventticket.dao.EventDAO" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.time.format.DateTimeFormatter" %>

<jsp:useBean id="eventDAO" class="com.eventticket.dao.EventDAO" scope="application"/>

<%
    String action = request.getParameter("action");

    if ("add".equals(action)) {
        // Create new event
        Event event = new Event(
                request.getParameter("id"),
                request.getParameter("name"),
                request.getParameter("description"),
                LocalDateTime.parse(request.getParameter("dateTime").replace("T", " "),
                        DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm")),
                request.getParameter("venue"),
                Double.parseDouble(request.getParameter("price")),
                Integer.parseInt(request.getParameter("availableTickets")),
                request.getParameter("imagePath"),
                request.getParameter("category")
        );

        eventDAO.addEvent(event);
    }
    else if ("delete".equals(action)) {
        String eventId = request.getParameter("id");
        eventDAO.removeEvent(eventId);
    }

    response.sendRedirect("admin.jsp");
%>