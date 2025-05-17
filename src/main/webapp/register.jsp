<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - MusicTix</title>
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
            <a href="register.jsp" class="hover:text-purple-300 font-semibold">Register</a>
        </div>
    </div>
</nav>

<!-- Registration Section -->
<main class="container mx-auto py-12 px-4">
    <div class="max-w-md mx-auto bg-white p-8 rounded-lg shadow-lg">
        <h1 class="text-3xl font-bold text-center text-purple-900 mb-6">Create an Account</h1>

        <%-- Display error or success message --%>
        <% if (request.getParameter("error") != null) { %>
        <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded mb-4">
            <%= request.getParameter("error") %>
        </div>
        <% } else if (request.getParameter("regsuccess") != null) { %>
        <div class="bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded mb-4">
            Registration successful! You can now <a href="login.jsp" class="text-purple-600">login</a>.
        </div>
        <% } %>

        <form action="RegisterServlet" method="post" class="space-y-6">
            <div>
                <label for="username" class="block text-gray-700 font-medium mb-2">Username</label>
                <input type="text" id="username" name="username" required
                       class="w-full px-4 py-2 border border-gray-300 rounded focus:outline-none focus:ring-2 focus:ring-purple-600">
            </div>

            <div>
                <label for="email" class="block text-gray-700 font-medium mb-2">Email</label>
                <input type="email" id="email" name="email" required
                       class="w-full px-4 py-2 border border-gray-300 rounded focus:outline-none focus:ring-2 focus:ring-purple-600">
            </div>

            <div>
                <label for="password" class="block text-gray-700 font-medium mb-2">Password</label>
                <input type="password" id="password" name="password" required
                       class="w-full px-4 py-2 border border-gray-300 rounded focus:outline-none focus:ring-2 focus:ring-purple-600">
            </div>

            <button type="submit"
                    class="w-full bg-purple-900 text-white py-3 px-4 rounded hover:bg-purple-800 transition duration-300 font-bold">
                Register
            </button>
        </form>

        <div class="mt-6 text-center">
            <p class="text-gray-600">Already have an account?
                <a href="login.jsp" class="text-purple-600 hover:text-purple-800 font-medium">Login here</a>
            </p>
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

<script src="js/script.js"></script>
</body>
</html>