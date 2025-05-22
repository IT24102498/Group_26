<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Get parameters from URL
    String eventId = request.getParameter("eventId");
    String eventName = request.getParameter("eventName");
    String amount = request.getParameter("amount");

    // Generate a random transaction ID
    String transactionId = "TXN-" + System.currentTimeMillis();

    // Set default values if parameters are null
    if (eventName == null) eventName = "Music Event";
    if (amount == null) amount = "0" ;
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Booking Confirmation | MusicTix</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/style.css">
</head>
<body class="bg-gray-100">
<!-- Navigation Bar -->
<nav class="bg-purple-900 text-white p-4 shadow-lg">
    <div class="container mx-auto flex justify-between items-center">
        <a href="index.jsp" class="text-2xl font-bold">MusicTix</a>
        <div class="flex space-x-4">
            <a href="index.jsp" class="hover:text-purple-300">Home</a>
            <a href="events.jsp" class="hover:text-purple-300">Events</a>
            <a href="login.jsp" class="hover:text-purple-300">Login</a>
            <a href="register.jsp" class="hover:text-purple-300">Register</a>
        </div>
    </div>
</nav>

<!-- Confirmation Section -->
<main class="container mx-auto py-12 px-4">
    <div class="max-w-3xl mx-auto bg-white rounded-xl shadow-lg overflow-hidden">
        <!-- Confirmation Header -->
        <div class="bg-gradient-to-r from-purple-800 to-indigo-900 text-white p-8 text-center">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-16 w-16 mx-auto mb-4" fill="none" viewBox="0 0 24 24"
                 stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"/>
            </svg>
            <h1 class="text-3xl font-bold mb-2">Payment Successful!</h1>
            <p class="text-lg">Thank you for your purchase. Your tickets are confirmed.</p>
        </div>

        <!-- Transaction Details -->
        <div class="p-8 border-b border-gray-200">
            <h2 class="text-xl font-bold mb-4">Transaction Details</h2>
            <div class="grid grid-cols-2 gap-4">
                <div>
                    <p class="text-gray-600">Transaction ID</p>
                    <p class="font-medium"><%= transactionId %>
                    </p>
                </div>
                <div>
                    <p class="text-gray-600">Date</p>
                    <p class="font-medium"><%= new java.util.Date() %>
                    </p>
                </div>
                <div>
                    <p class="text-gray-600">Payment Method</p>
                    <p class="font-medium">Credit Card</p>
                </div>
                <div>
                    <p class="text-gray-600">Status</p>
                    <p class="font-medium text-green-600">Completed</p>
                </div>
            </div>
        </div>

        <!-- Event Details -->
        <div class="p-8 border-b border-gray-200">
            <h2 class="text-xl font-bold mb-4">Event Details</h2>
            <div class="flex items-start">
                <img src="https://via.placeholder.com/120x120" alt="<%= eventName %>"
                     class="w-24 h-24 object-cover rounded-lg mr-6">
                <div>
                    <h3 class="text-xl font-bold"><%= eventName %>
                    </h3>
                    <p class="text-gray-600 mt-2">Date: July 8, 2023</p>
                    <p class="text-gray-600">Time: 8:00 PM</p>
                    <p class="text-gray-600">Venue: Blue Note Club, Chicago</p>
                    <p class="text-gray-600">Seats: GA-12, GA-13, GA-14</p>
                </div>
            </div>
        </div>

        <!-- Payment Summary -->
        <div class="p-8">
            <h2 class="text-xl font-bold mb-4">Payment Summary</h2>
            <div class="space-y-3">
                <div class="flex justify-between">
                    <span class="text-gray-600">Tickets (3x)</span>
                    <span>$<%= Integer.parseInt(amount) - 20 %></span>
                </div>
                <div class="flex justify-between">
                    <span class="text-gray-600">Service Fee</span>
                    <span>$10.00</span>
                </div>
                <div class="flex justify-between">
                    <span class="text-gray-600">Tax</span>
                    <span>$10.00</span>
                </div>
                <div class="flex justify-between pt-4 border-t border-gray-200 font-bold text-lg">
                    <span>Total</span>
                    <span>$<%= request.getParameter("price") %></span>
                </div>
            </div>
        </div>

        <!-- Download/Print Buttons -->
        <div class="bg-gray-50 p-6 flex justify-center space-x-4">
            <form action="ProcessPayment" method="post">
                <input type="hidden" name="action" value="delete">
                <input type="hidden" name="paymentId" value="<%= request.getParameter("paymentId") != null ? request.getParameter("paymentId") : "" %>">
                <button type="submit" class="bg-purple-900 text-white px-6 py-2 rounded-lg hover:bg-purple-800 transition duration-300">
                    <a href="index.jsp" >
                        Refund Payment
                    </a>
                </button>
            </form>
            <button class="bg-white text-purple-900 border border-purple-900 px-6 py-2 rounded-lg hover:bg-purple-50 transition duration-300">
                Print Confirmation
            </button>
        </div>

        <!-- Additional Actions -->
        <div class="max-w-3xl mx-auto mt-8 flex justify-between">
            <a href="events.jsp" class="text-purple-900 font-medium hover:text-purple-700">
                ← Back to Events
            </a>
            <a href="index.jsp" class="text-purple-900 font-medium hover:text-purple-700">
                Go to Home →
            </a>

        </div>
</main>

<!-- Footer -->
<footer class="bg-gray-800 text-white py-8">
    <div class="container mx-auto px-4">
        <div class="grid grid-cols-1 md:grid-cols-4 gap-8">
            <div>
                <h3 class="text-xl font-bold mb-4">MusicTix</h3>
                <p>Your one-stop destination for all music event tickets.</p>
            </div>
            <div>
                <h4 class="font-bold mb-4">Quick Links</h4>
                <ul class="space-y-2">
                    <li><a href="index.jsp" class="hover:text-purple-300">Home</a></li>
                    <li><a href="events.jsp" class="hover:text-purple-300">Events</a></li>
                    <li><a href="#" class="hover:text-purple-300">About Us</a></li>
                    <li><a href="#" class="hover:text-purple-300">Contact</a></li>
                </ul>
            </div>
            <div>
                <h4 class="font-bold mb-4">Support</h4>
                <ul class="space-y-2">
                    <li><a href="#" class="hover:text-purple-300">FAQs</a></li>
                    <li><a href="#" class="hover:text-purple-300">Terms & Conditions</a></li>
                    <li><a href="#" class="hover:text-purple-300">Privacy Policy</a></li>
                </ul>
            </div>
            <div>
                <h4 class="font-bold mb-4">Contact Us</h4>
                <p>Email: info@musictix.com</p>
                <p>Phone: (123) 456-7890</p>
            </div>
        </div>
        <div class="border-t border-gray-700 mt-8 pt-8 text-center">
            <p>&copy; 2023 MusicTix. All rights reserved.</p>
        </div>
    </div>
</footer>
</body>
</html>