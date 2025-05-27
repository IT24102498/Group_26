<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:useBean id="eventDAO" class="com.eventticket.dao.EventDAO" scope="application"/>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Panel</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <style>
        .form-input {
            transition: all 0.3s ease;
        }
        .form-input:focus {
            border-color: #6b46c1;
            box-shadow: 0 0 0 3px rgba(107, 70, 193, 0.2);
        }
    </style>
</head>
<body class="bg-gray-100">
<!-- Navigation -->
<nav class="bg-purple-900 text-white p-4 shadow-lg">
    <div class="container mx-auto flex justify-between items-center">
        <a href="index.jsp" class="text-2xl font-bold">Tix.com Admin</a>
        <div class="flex space-x-4">
            <a href="index.jsp" class="hover:text-purple-300">Back to Site</a>
            <a href="events.jsp" class="hover:text-purple-300">View Events</a>
        </div>
    </div>
</nav>

<div class="container mx-auto px-4 py-8">
    <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">
        <!-- Add Event Form -->
        <div class="lg:col-span-1 bg-white p-6 rounded-lg shadow">
            <h2 class="text-2xl font-bold mb-6 text-purple-900">Add New Event</h2>
            <form id="addEventForm" action="adminAction.jsp" method="post">
                <input type="hidden" name="action" value="add">

                <div class="mb-4">
                    <label class="block text-gray-700 mb-2">Event ID</label>
                    <input type="text" name="id" required
                           class="form-input w-full px-4 py-2 border rounded-lg">
                </div>

                <div class="mb-4">
                    <label class="block text-gray-700 mb-2">Event Name</label>
                    <input type="text" name="name" required
                           class="form-input w-full px-4 py-2 border rounded-lg">
                </div>

                <div class="mb-4">
                    <label class="block text-gray-700 mb-2">Description</label>
                    <textarea name="description" required
                              class="form-input w-full px-4 py-2 border rounded-lg"></textarea>
                </div>

                <div class="mb-4">
                    <label class="block text-gray-700 mb-2">Date & Time</label>
                    <input type="datetime-local" name="dateTime" required
                           class="form-input w-full px-4 py-2 border rounded-lg">
                </div>

                <div class="mb-4">
                    <label class="block text-gray-700 mb-2">Venue</label>
                    <input type="text" name="venue" required
                           class="form-input w-full px-4 py-2 border rounded-lg">
                </div>

                <div class="mb-4">
                    <label class="block text-gray-700 mb-2">Price</label>
                    <input type="number" step="0.01" name="price" required
                           class="form-input w-full px-4 py-2 border rounded-lg">
                </div>

                <div class="mb-4">
                    <label class="block text-gray-700 mb-2">Available Tickets</label>
                    <input type="number" name="availableTickets" required
                           class="form-input w-full px-4 py-2 border rounded-lg">
                </div>

                <div class="mb-4">
                    <label class="block text-gray-700 mb-2">Image URL</label>
                    <input type="text" name="imagePath" required
                           class="form-input w-full px-4 py-2 border rounded-lg">
                </div>

                <div class="mb-4">
                    <label class="block text-gray-700 mb-2">Category</label>
                    <select name="category" required
                            class="form-input w-full px-4 py-2 border rounded-lg">
                        <option value="Concert">Concert</option>
                        <option value="Theater">Theater</option>
                        <option value="Family">Family</option>
                        <option value="Sports">Sports</option>
                        <option value="Other">Other</option>
                    </select>
                </div>

                <button type="submit"
                        class="w-full bg-purple-900 text-white py-2 px-4 rounded-lg hover:bg-purple-800 transition">
                    Add Event
                </button>
            </form>
        </div>

        <!-- Event List -->
        <div class="lg:col-span-2">
            <h2 class="text-2xl font-bold mb-6 text-purple-900">Manage Events</h2>
            <div class="bg-white p-6 rounded-lg shadow">
                <div class="overflow-x-auto">
                    <table class="min-w-full bg-white">
                        <thead>
                        <tr>
                            <th class="py-2 px-4 border-b">Name</th>
                            <th class="py-2 px-4 border-b">Date</th>
                            <th class="py-2 px-4 border-b">Price</th>
                            <th class="py-2 px-4 border-b">Tickets</th>
                            <th class="py-2 px-4 border-b">Actions</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${eventDAO.allEvents}" var="event">
                            <tr>
                                <td class="py-2 px-4 border-b">${event.name}</td>
                                <td class="py-2 px-4 border-b">${event.dateTime}</td>
                                <td class="py-2 px-4 border-b">$${event.price}</td>
                                <td class="py-2 px-4 border-b">${event.availableTickets}</td>
                                <td class="py-2 px-4 border-b">
                                    <form action="adminAction.jsp" method="post" class="inline">
                                        <input type="hidden" name="action" value="delete">
                                        <input type="hidden" name="id" value="${event.id}">
                                        <button type="submit"
                                                class="text-red-600 hover:text-red-800">
                                            Delete
                                        </button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>