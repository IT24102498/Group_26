<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Event Booking System</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
</head>
<body class="bg-no-repeat bg-center bg-cover bg-[url('${pageContext.request.contextPath}/images/background.jpg')]">
<div class="min-h-screen flex justify-center items-center">
    <div class="bg-white p-8 rounded-lg shadow-md container max-w-2xl">
        <h2 class="text-2xl font-semibold mb-4 text-center">Event Booking System</h2>
        <div class="flex justify-between items-center mb-4">
            <a href="${pageContext.request.contextPath}/admin.jsp" class="text-blue-500">Admin Panel</a>
            <div>
                <label for="sortBy" class="block text-sm font-medium text-gray-700">Sort By</label>
                <select id="sortBy" onchange="window.location.href='${pageContext.request.contextPath}/events?sortBy='+this.value" class="w-full border rounded-md p-2">
                    <option value="date">Date</option>
                    <option value="popularity">Popularity</option>
                </select>
            </div>
        </div>
        <h3 class="text-xl font-semibold mb-2">Events</h3>
        <div class="space-y-2">
            <%
                java.util.List<com.example.model.Event> events = (java.util.List<com.example.model.Event>) request.getAttribute("events");
                if (events == null || events.isEmpty()) {
            %>
            <p class="text-center text-gray-500">No events available. Please add an event via the Admin Panel.</p>
            <% } else { %>
            <% for (com.example.model.Event event : events) { %>
            <div class="border p-4 rounded-md flex items-center">
                <img src="<%= event.getPicture() %>" alt="<%= event.getName() %>" class="w-24 h-24 object-cover mr-4 rounded-md" onerror="this.style.display='none';">
                <div>
                    <h4 class="text-lg font-medium"><%= event.getName() %></h4>
                    <p>Date: <%= event.getDate() %></p>
                    <p>Time: <%= event.getTime() %></p>
                    <p>Popularity: <%= event.getPopularity() %></p>
                    <a href="${pageContext.request.contextPath}/booking.jsp?eventId=<%= event.getId() %>" class="text-blue-500">Book Now</a>
                </div>
            </div>
            <% } %>
            <% } %>
        </div>
        <a href="${pageContext.request.contextPath}/history" class="block text-center text-blue-500 mt-4">View Booking History</a>
    </div>
</div>
<script src="${pageContext.request.contextPath}/js/script.js"></script>
</body>
</html>