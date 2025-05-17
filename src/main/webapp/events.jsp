<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Music Events | MusicTix</title>
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
        img {
            opacity: 1 !important;
        }
        .price-container {
            min-height: 36px;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }
        .book-now-btn {
            height: 36px;
            display: flex;
            align-items: center;
            justify-content: center;
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

<!-- Main Content -->
<main class="container mx-auto py-12 px-4">
    <div>
        <!-- Title centered -->
        <h2 class="text-4xl font-bold text-gray-600 text-center mb-6">All Events</h2>

        <!-- Sort section right-aligned -->
        <div class="flex justify-end items-center mb-6">
            <span class="mr-2 px-2 py-1 bg-gray-200 rounded text-gray-700">Sort by:</span>
            <select id="sortSelect" class="px-3 py-1 border border-gray-300 rounded focus:outline-none focus:ring-2 focus:ring-purple-500">
                <option value="date">Date</option>
                <option value="name">Name</option>
                <option value="price-low">Price (Low to High)</option>
                <option value="price-high">Price (High to Low)</option>
            </select>
        </div>

        <div id="eventsContainer" class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
            <!-- Event 1 -->
            <div class="bg-white rounded-xl shadow-lg overflow-hidden hover:shadow-xl transition duration-300 event-card">
                <div class="relative">
                    <img src="https://travelfreak.com/wp-content/uploads/2018/04/summer-music-festivals-1.jpg"
                         alt="Summer Music Festival"
                         class="w-full h-48 object-cover"
                         style="opacity: 1;">
                </div>
                <div class="p-6">
                    <div class="flex justify-between items-start mb-2">
                        <h3 class="text-xl font-bold">Summer Music Festival</h3>
                        <span class="bg-purple-100 text-purple-900 px-2 py-1 rounded text-sm">Festival</span>
                    </div>
                    <p class="text-gray-600 mb-4">Central Park, New York</p>
                    <p class="mb-4">The biggest music festival of the summer featuring top artists from around the world.</p>
                    <div class="price-container">
                        <span class="font-bold text-lg">$99</span>
                        <a href="seatManagement.jsp?eventId=1&eventName=Summer+Music+Festival&price=99&date=June+15,+2025&location=Central+Park,+New+York"
                           class="book-now-btn bg-purple-900 text-white px-4 py-2 rounded hover:bg-purple-800 transition duration-300">Book Now</a>
                    </div>
                </div>
            </div>

            <!-- Event 2 -->
            <div class="bg-white rounded-xl shadow-lg overflow-hidden hover:shadow-xl transition duration-300 event-card">
                <div class="relative">
                    <img src="https://cloudinary-assets.dostuffmedia.com/res/dostuff-media/image/upload/event-9199789/1548711682.jpg"
                         alt="Jazz Night"
                         class="w-full h-48 object-cover"
                         style="opacity: 1;">
                </div>
                <div class="p-6">
                    <div class="flex justify-between items-start mb-2">
                        <h3 class="text-xl font-bold">Jazz Night</h3>
                        <span class="bg-purple-100 text-purple-900 px-2 py-1 rounded text-sm">Concert</span>
                    </div>
                    <p class="text-gray-600 mb-4">Blue Note Club, Chicago</p>
                    <p class="mb-4">An intimate evening with world-renowned jazz musicians in a classic club setting.</p>
                    <div class="price-container">
                        <span class="font-bold text-lg">$65</span>
                        <a href="Payment.jsp?eventId=2&eventName=Jazz+Night&price=65&date=July+8,+2025&location=Blue+Note+Club,+Chicago"
                           class="book-now-btn bg-purple-900 text-white px-4 py-2 rounded hover:bg-purple-800 transition duration-300">Book Now</a>
                    </div>
                </div>
            </div>

            <!-- Event 3 -->
            <div class="bg-white rounded-xl shadow-lg overflow-hidden hover:shadow-xl transition duration-300 event-card">
                <div class="relative">
                    <img src="https://www.indonesia.travel/content/dam/indtravelrevamp/en/trip-ideas/attend-dwp-2019-in-jakarta-make-sure-to-visit-these-places-around-the-event/image4.jpg"
                         alt="EDM Extravaganza"
                         class="w-full h-48 object-cover"
                         style="opacity: 1;">
                </div>
                <div class="p-6">
                    <div class="flex justify-between items-start mb-2">
                        <h3 class="text-xl font-bold">EDM Extravaganza</h3>
                        <span class="bg-purple-100 text-purple-900 px-2 py-1 rounded text-sm">Concert</span>
                    </div>
                    <p class="text-gray-600 mb-4">Stadium Arena, Los Angeles</p>
                    <p class="mb-4">The most electrifying EDM experience with stunning visuals and pyrotechnics.</p>
                    <div class="price-container">
                        <span class="font-bold text-lg">$120</span>
                        <a href="Payment.jsp?eventId=3&eventName=EDM+Extravaganza&price=120&date=August+22,+2025&location=Stadium+Arena,+Los+Angeles"
                           class="book-now-btn bg-purple-900 text-white px-4 py-2 rounded hover:bg-purple-800 transition duration-300">Book Now</a>
                    </div>
                </div>
            </div>

            <!-- Event 4 -->
            <div class="bg-white rounded-xl shadow-lg overflow-hidden hover:shadow-xl transition duration-300 event-card">
                <div class="relative">
                    <img src="https://rare-gallery.com/uploads/posts/563031-concerts-music.jpg"
                         alt="Classical Symphony"
                         class="w-full h-48 object-cover"
                         style="opacity: 1;">
                </div>
                <div class="p-6">
                    <div class="flex justify-between items-start mb-2">
                        <h3 class="text-xl font-bold">Classical Symphony</h3>
                        <span class="bg-purple-100 text-purple-900 px-2 py-1 rounded text-sm">Orchestra</span>
                    </div>
                    <p class="text-gray-600 mb-4">Carnegie Hall, New York</p>
                    <p class="mb-4">Experience the timeless beauty of classical masterpieces performed by world-class musicians.</p>
                    <div class="price-container">
                        <span class="font-bold text-lg">$85</span>
                        <a href="Payment.jsp?eventId=4&eventName=Classical+Symphony&price=85&date=September+5,+2025&location=Carnegie+Hall,+New+York"
                           class="book-now-btn bg-purple-900 text-white px-4 py-2 rounded hover:bg-purple-800 transition duration-300">Book Now</a>
                    </div>
                </div>
            </div>

            <!-- Event 5 -->
            <div class="bg-white rounded-xl shadow-lg overflow-hidden hover:shadow-xl transition duration-300 event-card">
                <div class="relative">
                    <img src="https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?ixlib=rb-1.2.1&auto=format&fit=crop&w=600&q=80"
                         alt="Indie Showcase"
                         class="w-full h-48 object-cover"
                         style="opacity: 1;">
                </div>
                <div class="p-6">
                    <div class="flex justify-between items-start mb-2">
                        <h3 class="text-xl font-bold">Indie Showcase</h3>
                        <span class="bg-purple-100 text-purple-900 px-2 py-1 rounded text-sm">Showcase</span>
                    </div>
                    <p class="text-gray-600 mb-4">The Bowery Ballroom, NYC</p>
                    <p class="mb-4">Discover the hottest up-and-coming indie artists before they hit the big time.Join for a dynamic blend of unique sounds.</p>
                    <div class="price-container">
                        <span class="font-bold text-lg">$45</span>
                        <a href="Payment.jsp?eventId=5&eventName=Indie+Showcase&price=45&date=July+29,+2025&location=The+Bowery+Ballroom,+NYC"
                           class="book-now-btn bg-purple-900 text-white px-4 py-2 rounded hover:bg-purple-800 transition duration-300">Book Now</a>
                    </div>
                </div>
            </div>

            <!-- Event 6 -->
            <div class="bg-white rounded-xl shadow-lg overflow-hidden hover:shadow-xl transition duration-300 event-card">
                <div class="relative">
                    <img src="https://d1e1dwdex1ps42.cloudfront.net/attachments/fg8hodpn3o4c3k8uypflubhb-country-roads-entertainers-group-shot.full.jpg"
                         alt="Country Roads Tour"
                         class="w-full h-48 object-cover"
                         style="opacity: 1;">
                </div>
                <div class="p-6">
                    <div class="flex justify-between items-start mb-2">
                        <h3 class="text-xl font-bold">Country Roads Tour</h3>
                        <span class="bg-purple-100 text-purple-900 px-2 py-1 rounded text-sm">Tour</span>
                    </div>
                    <p class="text-gray-600 mb-4">Grand Ole Opry, Nashville</p>
                    <p class="mb-4">Night of the hearts the biggest names in country music come together for this special tour event.</p>
                    <div class="price-container">
                        <span class="font-bold text-lg">$75</span>
                        <a href="Payment.jsp?eventId=6&eventName=Country+Roads+Tour&price=75&date=August+12,+2025&location=Grand+Ole+Opry,+Nashville"
                           class="book-now-btn bg-purple-900 text-white px-4 py-2 rounded hover:bg-purple-800 transition duration-300">Book Now</a>
                    </div>
                </div>
            </div>

            <!-- Event 7 -->
            <div class="bg-white rounded-xl shadow-lg overflow-hidden hover:shadow-xl transition duration-300 event-card">
                <div class="relative">
                    <img src="https://images.unsplash.com/photo-1496442226666-8d4d0e62e6e9?ixlib=rb-1.2.1&auto=format&fit=crop&w=600&q=80"
                         alt="Hip Hop Block Party"
                         class="w-full h-48 object-cover"
                         style="opacity: 1;">
                </div>
                <div class="p-6">
                    <div class="flex justify-between items-start mb-2">
                        <h3 class="text-xl font-bold">Hip Hop Block Party</h3>
                        <span class="bg-purple-100 text-purple-900 px-2 py-1 rounded text-sm">Festival</span>
                    </div>
                    <p class="text-gray-600 mb-4">Brooklyn Mirage, NYC</p>
                    <p class="mb-4">A celebration of hip hop culture with performances, DJ sets, and breakdancing battles.</p>
                    <div class="price-container">
                        <span class="font-bold text-lg">$60</span>
                        <a href="Payment.jsp?eventId=7&eventName=Hip+Hop+Block+Party&price=60&date=September+18,+2025&location=Brooklyn+Mirage,+NYC"
                           class="book-now-btn bg-purple-900 text-white px-4 py-2 rounded hover:bg-purple-800 transition duration-300">Book Now</a>
                    </div>
                </div>
            </div>

            <!-- Event 8 -->
            <div class="bg-white rounded-xl shadow-lg overflow-hidden hover:shadow-xl transition duration-300 event-card">
                <div class="relative">
                    <img src="https://images.unsplash.com/photo-1499364615650-ec38552f4f34?ixlib=rb-1.2.1&auto=format&fit=crop&w=600&q=80"
                         alt="Rock Legends Live"
                         class="w-full h-48 object-cover"
                         style="opacity: 1;">
                </div>
                <div class="p-6">
                    <div class="flex justify-between items-start mb-2">
                        <h3 class="text-xl font-bold">Rock Legends Live</h3>
                        <span class="bg-purple-100 text-purple-900 px-2 py-1 rounded text-sm">Concert</span>
                    </div>
                    <p class="text-gray-600 mb-4">Madison Square Garden, NYC</p>
                    <p class="mb-4">Feel the energy as these Iconic rock bands from the 70s and 80s reunite for one night only.</p>
                    <div class="price-container">
                        <span class="font-bold text-lg">$150</span>
                        <a href="Payment.jsp?eventId=8&eventName=Rock+Legends+Live&price=150&date=October+3,+2025&location=Madison+Square+Garden,+NYC"
                           class="book-now-btn bg-purple-900 text-white px-4 py-2 rounded hover:bg-purple-800 transition duration-300">Book Now</a>
                    </div>
                </div>
            </div>

            <!-- Event 9 -->
            <div class="bg-white rounded-xl shadow-lg overflow-hidden hover:shadow-xl transition duration-300 event-card">
                <div class="relative">
                    <img src="https://images.unsplash.com/photo-1470225620780-dba8ba36b745?ixlib=rb-1.2.1&auto=format&fit=crop&w=600&q=80"
                         alt="Electronic Beats"
                         class="w-full h-48 object-cover"
                         style="opacity: 1;">
                </div>
                <div class="p-6">
                    <div class="flex justify-between items-start mb-2">
                        <h3 class="text-xl font-bold">Electronic Beats</h3>
                        <span class="bg-purple-100 text-purple-900 px-2 py-1 rounded text-sm">Festival</span>
                    </div>
                    <p class="text-gray-600 mb-4">Warehouse District, Miami</p>
                    <p class="mb-4">A 12-hour electronic music marathon featuring underground and mainstream DJs.</p>
                    <div class="price-container">
                        <span class="font-bold text-lg">$80</span>
                        <a href="Payment.jsp?eventId=9&eventName=Electronic+Beats&price=80&date=November+11,+2025&location=Warehouse+District,+Miami"
                           class="book-now-btn bg-purple-900 text-white px-4 py-2 rounded hover:bg-purple-800 transition duration-300">Book Now</a>
                    </div>
                </div>
            </div>

            <!-- Event 10 -->
            <div class="bg-white rounded-xl shadow-lg overflow-hidden hover:shadow-xl transition duration-300 event-card">
                <div class="relative">
                    <img src="https://images.unsplash.com/photo-1508700115892-45ecd05ae2ad?ixlib=rb-1.2.1&auto=format&fit=crop&w=600&q=80"
                         alt="Acoustic Sessions"
                         class="w-full h-48 object-cover"
                         style="opacity: 1;">
                </div>
                <div class="p-6">
                    <div class="flex justify-between items-start mb-2">
                        <h3 class="text-xl font-bold">Acoustic Sessions</h3>
                        <span class="bg-purple-100 text-purple-900 px-2 py-1 rounded text-sm">Intimate</span>
                    </div>
                    <p class="text-gray-600 mb-4">The Listening Room, Austin</p>
                    <p class="mb-4">Stripped-down performances from your favorite artists in an intimate setting.</p>
                    <div class="price-container">
                        <span class="font-bold text-lg">$55</span>
                        <a href="Payment.jsp?eventId=10&eventName=Acoustic+Sessions&price=55&date=December+7,+2025&location=The+Listening+Room,+Austin"
                           class="book-now-btn bg-purple-900 text-white px-4 py-2 rounded hover:bg-purple-800 transition duration-300">Book Now</a>
                    </div>
                </div>
            </div>

            <!-- Event 11 -->
            <div class="bg-white rounded-xl shadow-lg overflow-hidden hover:shadow-xl transition duration-300 event-card">
                <div class="relative">
                    <img src="https://i.ytimg.com/vi/iGChYsYcsuI/maxresdefault.jpg"
                         alt="Pop Sensations Live"
                         class="w-full h-48 object-cover"
                         style="opacity: 1;">
                </div>
                <div class="p-6">
                    <div class="flex justify-between items-start mb-2">
                        <h3 class="text-xl font-bold">Pop Sensations Live</h3>
                        <span class="bg-purple-100 text-purple-900 px-2 py-1 rounded text-sm">Concert</span>
                    </div>
                    <p class="text-gray-600 mb-4">Staples Center, Los Angeles</p>
                    <p class="mb-4">The hottest pop stars of today performing their biggest hits in one spectacular show.</p>
                    <div class="price-container">
                        <span class="font-bold text-lg">$110</span>
                        <a href="Payment.jsp?eventId=11&eventName=Pop+Sensations+Live&price=110&date=October+15,+2025&location=Staples+Center,+Los+Angeles"
                           class="book-now-btn bg-purple-900 text-white px-4 py-2 rounded hover:bg-purple-800 transition duration-300">Book Now</a>
                    </div>
                </div>
            </div>

            <!-- Event 12 -->
            <div class="bg-white rounded-xl shadow-lg overflow-hidden hover:shadow-xl transition duration-300 event-card">
                <div class="relative">
                    <img src="https://th.bing.com/th/id/OIP.EvE5pGPYdTCVtdHCxCEIIwHaE6?rs=1&pid=ImgDetMain"
                         alt="Reggae Sunset"
                         class="w-full h-48 object-cover"
                         style="opacity: 1;">
                </div>
                <div class="p-6">
                    <div class="flex justify-between items-start mb-2">
                        <h3 class="text-xl font-bold">Reggae Sunset</h3>
                        <span class="bg-purple-100 text-purple-900 px-2 py-1 rounded text-sm">Festival</span>
                    </div>
                    <p class="text-gray-600 mb-4">Virginia Key Beach, Miami</p>
                    <p class="mb-4">Chill vibes and reggae rhythms as the sun sets over the ocean with legendary artists.</p>
                    <div class="price-container">
                        <span class="font-bold text-lg">$70</span>
                        <a href="Payment.jsp?eventId=12&eventName=Reggae+Sunset&price=70&date=September+30,+2025&location=Virginia+Key+Beach,+Miami"
                           class="book-now-btn bg-purple-900 text-white px-4 py-2 rounded hover:bg-purple-800 transition duration-300">Book Now</a>
                    </div>
                </div>
            </div>

            <!-- Event 13 -->
            <div class="bg-white rounded-xl shadow-lg overflow-hidden hover:shadow-xl transition duration-300 event-card">
                <div class="relative">
                    <img src="https://th.bing.com/th/id/R.076ffcd807335cbc7962589f7ce45d13?rik=lrEWE1XZgvWUDQ&pid=ImgRaw&r=0"
                         alt="Techno Warehouse"
                         class="w-full h-48 object-cover"
                         style="opacity: 1;">
                </div>
                <div class="p-6">
                    <div class="flex justify-between items-start mb-2">
                        <h3 class="text-xl font-bold">Techno Warehouse</h3>
                        <span class="bg-purple-100 text-purple-900 px-2 py-1 rounded text-sm">Rave</span>
                    </div>
                    <p class="text-gray-600 mb-4">Industrial District, Detroit</p>
                    <p class="mb-4">An all-night techno experience in an authentic warehouse setting with international DJs.</p>
                    <div class="price-container">
                        <span class="font-bold text-lg">$50</span>
                        <a href="Payment.jsp?eventId=13&eventName=Techno+Warehouse&price=50&date=November+25,+2025&location=Industrial+District,+Detroit"
                           class="book-now-btn bg-purple-900 text-white px-4 py-2 rounded hover:bg-purple-800 transition duration-300">Book Now</a>
                    </div>
                </div>
            </div>

            <!-- Event 14 -->
            <div class="bg-white rounded-xl shadow-lg overflow-hidden hover:shadow-xl transition duration-300 event-card">
                <div class="relative">
                    <img src="https://images.unsplash.com/photo-1501612780327-45045538702b?ixlib=rb-1.2.1&auto=format&fit=crop&w=600&q=80"
                         alt="Soul & Blues Festival"
                         class="w-full h-48 object-cover"
                         style="opacity: 1;">
                </div>
                <div class="p-6">
                    <div class="flex justify-between items-start mb-2">
                        <h3 class="text-xl font-bold">Soul & Blues Festival</h3>
                        <span class="bg-purple-100 text-purple-900 px-2 py-1 rounded text-sm">Festival</span>
                    </div>
                    <p class="text-gray-600 mb-4">Memphis Riverfront, Tennessee</p>
                    <p class="mb-4">Celebrate the roots of American music with soulful performances and authentic blues.</p>
                    <div class="price-container">
                        <span class="font-bold text-lg">$65</span>
                        <a href="Payment.jsp?eventId=14&eventName=Soul+%26+Blues+Festival&price=65&date=October+28,+2025&location=Memphis+Riverfront,+Tennessee"
                           class="book-now-btn bg-purple-900 text-white px-4 py-2 rounded hover:bg-purple-800 transition duration-300">Book Now</a>
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
    document.addEventListener('DOMContentLoaded', function() {
        const sortSelect = document.getElementById('sortSelect');
        const eventsContainer = document.getElementById('eventsContainer');

        // Store event data as data attributes on the elements
        const eventElements = Array.from(eventsContainer.children);
        eventElements.forEach(eventEl => {
            const dateText = eventEl.querySelector('a').href.match(/date=([^&]+)/)[1];
            const priceText = eventEl.querySelector('.font-bold.text-lg').textContent.replace('$', '');

            eventEl.dataset.date = new Date(dateText).getTime();
            eventEl.dataset.name = eventEl.querySelector('h3').textContent.trim().toLowerCase();
            eventEl.dataset.price = parseFloat(priceText);
        });

        sortSelect.addEventListener('change', function() {
            const sortValue = this.value;
            const events = Array.from(eventsContainer.children);

            events.sort((a, b) => {
                switch(sortValue) {
                    case 'date':
                        return a.dataset.date - b.dataset.date;

                    case 'name':
                        return a.dataset.name.localeCompare(b.dataset.name);

                    case 'price-low':
                        return a.dataset.price - b.dataset.price;

                    case 'price-high':
                        return b.dataset.price - a.dataset.price;

                    default:
                        return 0;
                }
            });

            // Clear and re-append sorted events
            eventsContainer.innerHTML = '';
            events.forEach(event => {
                eventsContainer.appendChild(event);
            });
        });

        // Image loading handler
        const images = document.querySelectorAll('img');
        images.forEach(img => {
            if (img.complete) {
                img.classList.add('loaded');
            } else {
                img.addEventListener('load', function() {
                    this.classList.add('loaded');
                });
                img.addEventListener('error', function() {
                    console.error('Image failed to load:', this.src);
                });
            }
        });
    });
</script>
</body>
</html>