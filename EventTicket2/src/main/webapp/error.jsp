<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Error</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
</head>
<body class="bg-no-repeat bg-center bg-cover bg-[url('${pageContext.request.contextPath}/images/background.jpg')]">
<div class="min-h-screen flex justify-center items-center">
    <div class="bg-white p-8 rounded-lg shadow-md container max-w-md">
        <h2 class="text-2xl font-semibold mb-4 text-center text-red-500">Error</h2>
        <p class="text-center mb-4"><%= request.getAttribute("error") != null ? request.getAttribute("error") : "An unexpected error occurred." %></p>
        <a href="${pageContext.request.contextPath}/events" class="block text-center text-blue-500">Back to Events</a>
    </div>
</div>
</body>
</html>