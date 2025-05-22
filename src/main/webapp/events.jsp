<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:useBean id="eventDAO" class="com.eventticket.dao.EventDAO" scope="application"/>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Music Event Tickets</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)),
            url('https://i.postimg.cc/mkMcKm8z/IMG-9101.jpg');
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
            min-height: 100vh;
        }
        .event-card {
            transition: all 0.3s ease;
            background-color: rgba(255, 255, 255, 0.7); /* 70% transparent */
            backdrop-filter: blur(8px);
            border: 1px solid rgba(255, 255, 255, 0.3);
        }
        .event-card:hover {
            transform: translateY(-5px);
            background-color: rgba(255, 255, 255, 0.8); /* Slightly less transparent on hover */
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.2);
        }
        .nav-transparent {
            background-color: rgba(107, 70, 193, 0.8);
            backdrop-filter: blur(10px);
        }
        .hero-section {
            background: linear-gradient(to right, rgba(107, 70, 193, 0.7), rgba(128, 90, 213, 0.7));
            backdrop-filter: blur(5px);
        }
        .content-container {
            background-color: rgba(255, 255, 255, 0.65);
            backdrop-filter: blur(5px);
            border-radius: 0.5rem;
        }
        .text-content {
            text-shadow: 0 1px 2px rgba(0, 0, 0, 0.2); /* Improves readability */
        }
    </style>
</head>
<body>
<!-- Navigation Bar -->
<nav class="nav-transparent text-white p-4 shadow-lg sticky top-0 z-50">
    <div class="container mx-auto flex justify-between items-center">
        <a href="index.jsp" class="text-2xl font-bold">Tix.com</a>
        <div class="flex space-x-4">
            <a href="index.jsp" class="hover:text-purple-300">Home</a>
            <a href="events.jsp" class="hover:text-purple-300">Events</a>
            <a href="login.jsp" class="hover:text-purple-300">Login</a>
            <a href="register.jsp" class="hover:text-purple-300">Register</a>
        </div>
    </div>
</nav>

<!-- Hero Section -->
<header class="hero-section text-white py-16">
    <div class="container mx-auto text-center px-4">
        <h1 class="text-5xl font-bold mb-4">Find Your Next Experience</h1>
        <p class="text-xl mb-8">Discover and book tickets for amazing events</p>
    </div>
</header>

<!-- Main Content -->
<main class="container mx-auto px-4 py-8">
    <div class="content-container p-6 mb-8">
        <div class="flex justify-between items-center">
            <h2 class="text-3xl font-bold text-gray-800">All Events</h2>
            <div class="flex items-center">
                <span class="mr-2 px-2 py-1 bg-gray-200 rounded text-gray-700">Sort by:</span>
                <select id="sortSelect" class="px-3 py-1 border border-gray-300 rounded">
                    <option value="date">Date</option>
                    <option value="name">Name</option>
                    <option value="price-low">Price (Low to High)</option>
                    <option value="price-high">Price (High to Low)</option>
                </select>
            </div>
        </div>
    </div>

    <div id="eventsContainer" class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
        <c:forEach items="${eventDAO.allEvents}" var="event">
            <div class="event-card rounded-lg overflow-hidden">
                <img src="${event.imagePath}" alt="${event.name}" class="w-full h-48 object-cover">
                <div class="p-6">
                    <div class="flex justify-between items-start mb-2">
                        <h3 class="text-xl font-bold text-gray-800">${event.name}</h3>
                        <span class="bg-purple-100 text-purple-900 px-2 py-1 rounded text-sm">
                                ${event.category}
                        </span>
                    </div>
                    <p class="text-gray-600 mb-4">${event.venue} • ${event.dateTime.toLocalDate()}</p>
                    <p class="mb-4 text-gray-700">${event.description}</p>
                    <div class="flex justify-between items-center">
                        <span class="font-bold text-lg text-gray-800">$${event.price}</span>
                        <a href="Payment.jsp?eventId=${event.id}&eventName=${event.name}&price=${event.price}&date=${event.dateTime}&location=${event.venue}"
                           class="bg-purple-900 text-white px-4 py-2 rounded hover:bg-purple-800 transition">
                            Book Now
                        </a>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</main>

<!-- Footer -->
<footer class="bg-gray-800 text-white py-8">
    <div class="container mx-auto px-4">
        <div class="grid grid-cols-1 md:grid-cols-4 gap-8">
            <div>
                <h3 class="text-xl font-bold mb-4">Tix.com</h3>
                <p>Your one-stop destination for all music event tickets.</p>
            </div>
            <div>
                <h4 class="font-bold mb-4">Quick Links</h4>
                <ul class="space-y-2">
                    <li><a href="#" class="hover:text-purple-300 transition duration-300">Home</a></li>
                    <li><a href="#" class="hover:text-purple-300 transition duration-300">Events</a></li>
                    <li><a href="#" class="hover:text-purple-300 transition duration-300">About Us</a></li>
                    <li><a href="#" class="hover:text-purple-300 transition duration-300">Contact</a></li>
                </ul>
            </div>
            <div>
                <h4 class="font-bold mb-4">Support</h4>
                <ul class="space-y-2">
                    <li><a href="#" class="hover:text-purple-300 transition duration-300">FAQs</a></li>
                    <li><a href="#" class="hover:text-purple-300 transition duration-300">Terms & Conditions</a></li>
                    <li><a href="#" class="hover:text-purple-300 transition duration-300">Privacy Policy</a></li>
                </ul>
            </div>
            <div>
                <h4 class="font-bold mb-4">Contact Us</h4>
                <p>Email: Tixcom@gmail.com</p>
                <p>Phone: (123) 456-7890</p>
            </div>
        </div>
        <div class="border-t border-gray-700 mt-8 pt-8 text-center">
            <p>&copy; 2023 Tix.com All rights reserved.</p>
        </div>
    </div>
</footer>

<script>
    document.getElementById('sortSelect').addEventListener('change', function() {
        const sortValue = this.value;
        const container = document.getElementById('eventsContainer');
        const events = Array.from(container.children);

        events.sort((a, b) => {
            const aPrice = parseFloat(a.querySelector('.font-bold.text-lg').textContent.slice(1));
            const bPrice = parseFloat(b.querySelector('.font-bold.text-lg').textContent.slice(1));
            const aName = a.querySelector('h3').textContent.toLowerCase();
            const bName = b.querySelector('h3').textContent.toLowerCase();
            const aDate = new Date(a.querySelector('.text-gray-600').textContent.split('•')[1].trim());
            const bDate = new Date(b.querySelector('.text-gray-600').textContent.split('•')[1].trim());

            switch(sortValue) {
                case 'date': return aDate - bDate;
                case 'name': return aName.localeCompare(bName);
                case 'price-low': return aPrice - bPrice;
                case 'price-high': return bPrice - aPrice;
                default: return 0;
            }
        });

        container.innerHTML = '';
        events.forEach(event => container.appendChild(event));
    });
</script>
</body>
</html>