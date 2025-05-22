<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Music Event Tickets</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/style.css">
    <style>
        .event-card {
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        .event-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
        }
    </style>
</head>
<body class="bg-gray-100">
<!-- Navigation Bar - Fixed to top -->
<nav class="bg-purple-900 text-white p-4 shadow-lg sticky top-0 z-50">
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

<!-- Hero Section - Reduced height and bottom margin -->
<header class="bg-gradient-to-r from-purple-800 to-indigo-900 text-white py-16 mt-0 mb-4">
    <div class="container mx-auto text-center px-4">
        <h1 class="text-5xl font-bold mb-4">Find and Book Your Next Great Experience</h1>
        <p class="text-xl mb-8">From Festivals to Front Rows – We've Got Your Ticket</p>
    </div>
</header>

<!-- Main Content Container -->
<div class="container mx-auto px-4">
    <section class="py-4">
        <h2 class="text-4xl font-bold mb-6 text-center text-gray-700">Latest Events</h2>

        <!-- Concerts Section -->
        <div class="mb-16">
            <h3 class="text-3xl font-bold mb-6 text-center text-gray-500">Concerts</h3>
            <div class="grid grid-cols-1 md:grid-cols-3 gap-8 mb-12">
                <!-- Event Cards -->
                <!-- Summer Music Festival -->
                <div class="bg-white rounded-lg shadow-lg overflow-hidden event-card">
                    <img src="https://travelfreak.com/wp-content/uploads/2018/04/summer-music-festivals-1.jpg" alt="Summer Festival" class="w-full h-48 object-cover">
                    <div class="p-6">
                        <h3 class="text-xl font-bold mb-2">Summer Music Festival</h3>
                        <p class="text-gray-600 mb-4">June 15, 2025 • Central Park</p>
                        <p class="mb-4">Join us for the biggest music festival of the summer featuring top artists from around the world.</p>
                        <div class="flex justify-between items-center">
                            <span class="font-bold text-lg">$99</span>
                            <a href="events.jsp" class="bg-purple-900 text-white px-4 py-2 rounded hover:bg-purple-800 transition duration-300">Book Now</a>
                        </div>
                    </div>
                </div>

                <!-- Jazz Night -->
                <div class="bg-white rounded-lg shadow-lg overflow-hidden event-card">
                    <img src="https://cloudinary-assets.dostuffmedia.com/res/dostuff-media/image/upload/event-9199789/1548711682.jpg" alt="Jazz Night" class="w-full h-48 object-cover">
                    <div class="p-6">
                        <h3 class="text-xl font-bold mb-2">Jazz Night</h3>
                        <p class="text-gray-600 mb-4">July 8, 2025 • Blue Note Club</p>
                        <p class="mb-4">An intimate evening with world-renowned jazz musicians in a classic club setting.</p>
                        <div class="flex justify-between items-center">
                            <span class="font-bold text-lg">$65</span>
                            <a href="events.jsp" class="bg-purple-900 text-white px-4 py-2 rounded hover:bg-purple-800 transition duration-300">Book Now</a>
                        </div>
                    </div>
                </div>

                <!-- EDM Extravaganza -->
                <div class="bg-white rounded-lg shadow-lg overflow-hidden event-card">
                    <img src="https://www.indonesia.travel/content/dam/indtravelrevamp/en/trip-ideas/attend-dwp-2019-in-jakarta-make-sure-to-visit-these-places-around-the-event/image4.jpg" alt="EDM Event" class="w-full h-48 object-cover">
                    <div class="p-6">
                        <h3 class="text-xl font-bold mb-2">EDM Extravaganza</h3>
                        <p class="text-gray-600 mb-4">August 22, 2025 • Stadium Arena</p>
                        <p class="mb-4">Lose yourself in the most electrifying EDM experience with stunning visuals and pyrotechnics.</p>
                        <div class="flex justify-between items-center">
                            <span class="font-bold text-lg">$120</span>
                            <a href="events.jsp" class="bg-purple-900 text-white px-4 py-2 rounded hover:bg-purple-800 transition duration-300">Book Now</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Theatre and Family Section -->
        <div class="mb-16">
            <h3 class="text-3xl font-bold mb-6 text-center text-gray-500">Theatre and Family</h3>
            <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
                <!-- Broadway Nights -->
                <div class="bg-white rounded-lg shadow-lg overflow-hidden event-card">
                    <img src="https://dtla-weekly.com/wp-content/uploads/2018/01/nob22.jpg" alt="Broadway" class="w-full h-48 object-cover">
                    <div class="p-6">
                        <h3 class="text-xl font-bold mb-2">Broadway Nights</h3>
                        <p class="text-gray-600 mb-4">September 5, 2025 • Majestic Theatre</p>
                        <p class="mb-4">Experience the magic of Broadway with this special limited engagement performance.</p>
                        <div class="flex justify-between items-center">
                            <span class="font-bold text-lg">$85</span>
                            <a href="events.jsp" class="bg-purple-900 text-white px-4 py-2 rounded hover:bg-purple-800 transition duration-300">Book Now</a>
                        </div>
                    </div>
                </div>

                <!-- Family Fun Day -->
                <div class="bg-white rounded-lg shadow-lg overflow-hidden event-card">
                    <img src="https://www.dynamicevents.ie/static/9adf25db13f7ebab649212e11e5eb8dd/9a51e/family_fun_day2.jpg" alt="Family Event" class="w-full h-48 object-cover">
                    <div class="p-6">
                        <h3 class="text-xl font-bold mb-2">Family Fun Day</h3>
                        <p class="text-gray-600 mb-4">October 12, 2025 • City Park</p>
                        <p class="mb-4">Bring the whole family out to a day of fun activities, performances, and entertainment for the whole family.</p>
                        <div class="flex justify-between items-center">
                            <span class="font-bold text-lg">$35</span>
                            <a href="events.jsp" class="bg-purple-900 text-white px-4 py-2 rounded hover:bg-purple-800 transition duration-300">Book Now</a>
                        </div>
                    </div>
                </div>

                <!-- Puppet Show -->
                <div class="bg-white rounded-lg shadow-lg overflow-hidden event-card">
                    <img src="https://i.ytimg.com/vi/JYV39U7Vblw/maxresdefault.jpg" alt="Puppet Show" class="w-full h-48 object-cover">
                    <div class="p-6">
                        <h3 class="text-xl font-bold mb-2">Puppet Show Spectacular</h3>
                        <p class="text-gray-600 mb-4">November 3, 2025 • Community Center</p>
                        <p class="mb-4">Step into a world of magical puppet performances that will delight children and adults alike.</p>
                        <div class="flex justify-between items-center">
                            <span class="font-bold text-lg">$25</span>
                            <a href="events.jsp" class="bg-purple-900 text-white px-4 py-2 rounded hover:bg-purple-800 transition duration-300">Book Now</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Browse Events Button -->
        <div class="text-center mt-8">
            <a href="events.jsp" class="inline-block bg-purple-900 text-white px-8 py-4 rounded-full font-bold hover:bg-purple-800 transition duration-300 text-lg">
                Browse All Events
            </a>
        </div>
    </section>
</div>

<!-- Newsletter -->
<section class="bg-purple-100 py-12">
    <div class="container mx-auto text-center px-4">
        <h2 class="text-3xl font-bold mb-4">Stay Updated</h2>
        <p class="mb-6 max-w-2xl mx-auto">Subscribe to our newsletter to get the latest updates on upcoming events and exclusive offers.</p>
        <form class="max-w-md mx-auto flex">
            <input type="email" placeholder="Your email" class="flex-grow px-4 py-2 rounded-l focus:outline-none">
            <button type="submit" class="bg-purple-900 text-white px-6 py-2 rounded-r hover:bg-purple-800 transition duration-300">Subscribe</button>
        </form>
    </div>
</section>

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
    document.addEventListener('DOMContentLoaded', function () {
        const images = document.querySelectorAll('img');
        images.forEach(img => {
            if (img.complete) {
                img.classList.add('loaded');
            } else {
                img.addEventListener('load', function () {
                    this.classList.add('loaded');
                });
                img.addEventListener('error', function () {
                    console.error('Image failed to load:', this.src);
                });
            }
        });
    });
</script>
</body>
</html>
