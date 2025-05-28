<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book Ticket</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
</head>
<body class="bg-no-repeat bg-center bg-cover bg-[url('${pageContext.request.contextPath}/images/background.jpg')]">
<div class="min-h-screen flex justify-center items-center">
    <div class="bg-white p-8 rounded-lg shadow-md container max-w-md">
        <h2 class="text-2xl font-semibold mb-4 text-center">Book Your Ticket</h2>
        <form action="${pageContext.request.contextPath}/book" method="post" class="space-y-4" id="bookingForm">
            <input type="hidden" name="eventId" id="eventId">
            <div>
                <label for="userName" class="block text-sm font-medium text-gray-700">Your Name</label>
                <input type="text" id="userName" name="userName" class="w-full border rounded-md p-2" required>
            </div>
            <div>
                <label for="seat" class="block text-sm font-medium text-gray-700">Seat Number</label>
                <input type="text" id="seat" name="seat" class="w-full border rounded-md p-2" required>
            </div>
            <button type="submit" class="w-full bg-blue-500 text-white p-2 rounded-md">Book Ticket</button>
        </form>
        <a href="${pageContext.request.contextPath}/events" class="block text-center text-blue-500 mt-4">Back to Events</a>
    </div>
</div>
<script src="${pageContext.request.contextPath}/js/script.js"></script>
</body>
</html>