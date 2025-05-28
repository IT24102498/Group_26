<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Booking History</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
</head>
<body class="bg-no-repeat bg-center bg-cover bg-[url('${pageContext.request.contextPath}/images/background.jpg')]">
<div class="min-h-screen flex justify-center items-center">
    <div class="bg-white p-8 rounded-lg shadow-md container max-w-3xl">
        <h2 class="text-2xl font-semibold mb-4 text-center">Booking History</h2>
        <table class="w-full border">
            <thead>
            <tr class="bg-gray-200">
                <th class="border p-2">Ticket ID</th>
                <th class="border p-2">Event Name</th>
                <th class="border p-2">User Name</th>
                <th class="border p-2">Seat</th>
            </tr>
            </thead>
            <tbody>
            <% java.util.Map<String, String> eventNames = (java.util.Map<String, String>) request.getAttribute("eventNames"); %>
            <% for (com.example.model.Booking booking : (java.util.List<com.example.model.Booking>) request.getAttribute("bookings")) { %>
            <tr>
                <td class="border p-2"><%= booking.getTicketId() %></td>
                <td class="border p-2"><%= eventNames.get(booking.getEventId()) != null ? eventNames.get(booking.getEventId()) : "Unknown Event" %></td>
                <td class="border p-2"><%= booking.getUserName() %></td>
                <td class="border p-2"><%= booking.getSeat() %></td>
            </tr>
            <% } %>
            </tbody>
        </table>
        <a href="${pageContext.request.contextPath}/events" class="block text-center text-blue-500 mt-4">Back to Events</a>
    </div>
</div>
</body>
</html>