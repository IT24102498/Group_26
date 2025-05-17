<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Get parameters from URL
    String eventId = request.getParameter("eventId");
    String eventName = request.getParameter("eventName");
    String price = request.getParameter("price");
    String date = request.getParameter("date");
    String location = request.getParameter("location");

    // Get user details from session
    String username = (String) session.getAttribute("username");
    String email = (String) session.getAttribute("email");

    // Set default values if parameters are null
    if (eventName == null) eventName = "Music Event";
    if (price == null) price = "0";
    if (date == null) date = "Coming Soon";
    if (location == null) location = "Venue TBD";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment | MusicTix</title>
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

<!-- Payment Section -->
<main class="container mx-auto py-12 px-4">
    <div class="max-w-4xl mx-auto">
        <!-- Progress Steps -->
        <div class="flex justify-between mb-12">
            <div class="step flex flex-col items-center">
                <div class="w-10 h-10 rounded-full bg-purple-900 text-white flex items-center justify-center mb-2">1</div>
                <span class="text-sm font-medium">Event Details</span>
            </div>
            <div class="step flex flex-col items-center">
                <div class="w-10 h-10 rounded-full bg-purple-900 text-white flex items-center justify-center mb-2">2</div>
                <span class="text-sm font-medium">Ticket Selection</span>
            </div>
            <div class="step flex flex-col items-center">
                <div class="w-10 h-10 rounded-full bg-purple-200 text-purple-900 border-2 border-purple-900 flex items-center justify-center mb-2">3</div>
                <span class="text-sm font-medium text-purple-900 font-bold">Payment</span>
            </div>
            <div class="step flex flex-col items-center">
                <div class="w-10 h-10 rounded-full bg-gray-200 text-gray-500 flex items-center justify-center mb-2">4</div>
                <span class="text-sm font-medium">Confirmation</span>
            </div>
        </div>

        <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">
            <!-- Payment Form -->
            <div class="lg:col-span-2">
                <div class="bg-white rounded-xl shadow-lg p-8">
                    <h2 class="text-2xl font-bold mb-6">Payment Information</h2>

                    <form id="payment-form" action="ProcessPayment" method="POST">
                        <!-- Hidden Fields -->
                        <input type="hidden" name="eventId" value="<%= eventId %>">
                        <input type="hidden" name="eventName" value="<%= eventName %>">
                        <input type="hidden" name="price" value="<%= price %>">
                        <input type="hidden" name="username" value="<%= username %>">
                        <input type="hidden" name="email" value="<%= email %>">

                        <!-- Card Details -->
                        <div class="mb-6">
                            <label for="card-number" class="block text-gray-700 font-medium mb-2">Card Number</label>
                            <div class="relative">
                                <input type="text" id="card-number" name="cardNumber" placeholder="1234 5678 9012 3456"
                                       class="w-full px-4 py-2 border border-gray-300 rounded focus:outline-none focus:ring-2 focus:ring-purple-500"
                                       required pattern="[\d ]{16,19}">
                                <div class="absolute right-3 top-2">
                                    <img src="https://via.placeholder.com/40x25" alt="Card Type" class="h-6">
                                </div>
                            </div>
                        </div>

                        <div class="grid grid-cols-2 gap-4 mb-6">
                            <div>
                                <label for="expiry-date" class="block text-gray-700 font-medium mb-2">Expiry Date</label>
                                <input type="text" id="expiry-date" name="expiryDate" placeholder="MM/YY"
                                       class="w-full px-4 py-2 border border-gray-300 rounded focus:outline-none focus:ring-2 focus:ring-purple-500"
                                       required pattern="\d{2}/\d{2}">
                            </div>
                            <div>
                                <label for="cvv" class="block text-gray-700 font-medium mb-2">CVV</label>
                                <input type="text" id="cvv" name="cvv" placeholder="123"
                                       class="w-full px-4 py-2 border border-gray-300 rounded focus:outline-none focus:ring-2 focus:ring-purple-500"
                                       required pattern="\d{3,4}">
                            </div>
                        </div>

                        <!-- Cardholder Name -->
                        <div class="mb-6">
                            <label for="card-name" class="block text-gray-700 font-medium mb-2">Cardholder Name</label>
                            <input type="text" id="card-name" name="cardName" placeholder="John Doe"
                                   class="w-full px-4 py-2 border border-gray-300 rounded focus:outline-none focus:ring-2 focus:ring-purple-500" required>
                        </div>

                        <!-- Submit Button -->
                        <button type="submit" class="w-full bg-purple-900 text-white py-3 px-4 rounded-lg hover:bg-purple-800 transition duration-300 font-bold text-lg">
                            Complete Payment - $<span id="total-amount"><%= price %></span>
                        </button>
                    </form>
                </div>
            </div>

            <!-- Order Summary -->
            <div class="lg:col-span-1">
                <div class="bg-white rounded-xl shadow-lg p-6 sticky top-4">
                    <h2 class="text-xl font-bold mb-4">Order Summary</h2>

                    <!-- Event Info -->
                    <div class="flex mb-6 pb-4 border-b border-gray-200">
                        <img src="https://via.placeholder.com/80x80" alt="<%= eventName %>" class="w-16 h-16 object-cover rounded">
                        <div class="ml-4">
                            <h3 class="font-semibold"><%= eventName %></h3>
                            <p class="text-sm text-gray-600"><%= date %></p>
                            <p class="text-sm text-gray-600"><%= location %></p>
                        </div>
                    </div>

                    <!-- Ticket Details -->
                    <div class="mb-4">
                        <h3 class="font-semibold mb-2">Ticket Details</h3>
                        <div class="flex justify-between mb-2">
                            <span>General Admission (x1)</span>
                            <span>$<%= Integer.parseInt(price) - 20 %></span>
                        </div>
                        <div class="flex justify-between mb-2">
                            <span>Service Fee</span>
                            <span>$10.00</span>
                        </div>
                        <div class="flex justify-between mb-2">
                            <span>Tax</span>
                            <span>$10.00</span>
                        </div>
                    </div>

                    <!-- Total -->
                    <div class="border-t border-gray-200 pt-4 mb-4">
                        <div class="flex justify-between font-bold text-lg">
                            <span>Total</span>
                            <span>$<%= price %></span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
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

<script>
    // Simple form validation
    document.getElementById('payment-form').addEventListener('submit', function(e) {
        const cardNumber = document.getElementById('card-number').value;
        const expiryDate = document.getElementById('expiry-date').value;
        const cvv = document.getElementById('cvv').value;
        const cardName = document.getElementById('card-name').value;

        if (!cardNumber || !expiryDate || !cvv || !cardName) {
            e.preventDefault();
            alert('Please fill in all payment details');
            return false;
        }

        return true;
    });
</script>
</body>
</html>
