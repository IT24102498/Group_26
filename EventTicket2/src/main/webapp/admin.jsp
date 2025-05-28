<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Admin Panel - Add Event</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
</head>
<body class="bg-no-repeat bg-center bg-cover bg-[url('${pageContext.request.contextPath}/images/background.jpg')]">
<div class="min-h-screen flex justify-center items-center">
  <div class="bg-white p-8 rounded-lg shadow-md container max-w-md">
    <h2 class="text-2xl font-semibold mb-4 text-center">Add New Event</h2>
    <form action="${pageContext.request.contextPath}/events" method="post" class="space-y-4">
      <div>
        <label for="name" class="block text-sm font-medium text-gray-700">Event Name</label>
        <input type="text" id="name" name="name" class="w-full border rounded-md p-2" required>
      </div>
      <div>
        <label for="date" class="block text-sm font-medium text-gray-700">Date (YYYY-MM-DD)</label>
        <input type="text" id="date" name="date" class="w-full border rounded-md p-2" required>
      </div>
      <div>
        <label for="time" class="block text-sm font-medium text-gray-700">Time (HH:MM)</label>
        <input type="text" id="time" name="time" class="w-full border rounded-md p-2" required>
      </div>
      <div>
        <label for="popularity" class="block text-sm font-medium text-gray-700">Popularity (1-100)</label>
        <input type="number" id="popularity" name="popularity" class="w-full border rounded-md p-2" required>
      </div>
      <div>
        <label for="picture" class="block text-sm font-medium text-gray-700">Picture URL</label>
        <input type="text" id="picture" name="picture" class="w-full border rounded-md p-2" required>
      </div>
      <button type="submit" class="w-full bg-blue-500 text-white p-2 rounded-md">Add Event</button>
    </form>
    <a href="${pageContext.request.contextPath}/events" class="block text-center text-blue-500 mt-4">Back to Events</a>
  </div>
</div>
</body>
</html>