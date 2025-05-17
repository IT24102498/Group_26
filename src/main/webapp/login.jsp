<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - MusicTix</title>
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
            <a href="login.jsp" class="hover:text-purple-300 font-semibold">Login</a>
            <a href="register.jsp" class="hover:text-purple-300">Register</a>
        </div>
    </div>
</nav>

<!-- Login Section -->
<main class="container mx-auto py-12 px-4">
    <div class="max-w-md mx-auto bg-white p-8 rounded-lg shadow-lg">
        <h1 class="text-3xl font-bold text-center text-purple-900 mb-6">Login to Your Account</h1>

        <%-- Display error message if login fails --%>
        <% if (request.getParameter("error") != null) { %>
        <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded mb-4">
            Invalid username or password. Please try again.
        </div>
        <% } %>

        <%-- Display success message if registration was successful --%>
        <% if (request.getParameter("regsuccess") != null) { %>
        <div class="bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded mb-4">
            <%= request.getParameter("regsuccess") %>
        </div>
        <% } %>

        <form action="LoginServlet" method="post" class="space-y-6">
            <div>
                <label for="username" class="block text-gray-700 font-medium mb-2">Username</label>
                <input type="text" id="username" name="username" required
                       class="w-full px-4 py-2 border border-gray-300 rounded focus:outline-none focus:ring-2 focus:ring-purple-600">
            </div>

            <div>
                <label for="password" class="block text-gray-700 font-medium mb-2">Password</label>
                <input type="password" id="password" name="password" required
                       class="w-full px-4 py-2 border border-gray-300 rounded focus:outline-none focus:ring-2 focus:ring-purple-600">
            </div>

            <div class="flex items-center justify-between">
                <div class="flex items-center">
                    <input type="checkbox" id="remember" name="remember"
                           class="h-4 w-4 text-purple-600 focus:ring-purple-500 border-gray-300 rounded">
                    <label for="remember" class="ml-2 block text-gray-700">Remember me</label>
                </div>
                <a href="forgot-password.jsp" class="text-purple-600 hover:text-purple-800 text-sm">Forgot password?</a>
            </div>

            <button type="submit"
                    class="w-full bg-purple-900 text-white py-3 px-4 rounded hover:bg-purple-800 transition duration-300 font-bold">
                Login
            </button>
        </form>

        <div class="mt-6 text-center">
            <p class="text-gray-600">Don't have an account?
                <a href="register.jsp" class="text-purple-600 hover:text-purple-800 font-medium">Register here</a>
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