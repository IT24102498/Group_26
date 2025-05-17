<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.eventticket.utils.UserStore" %>
<%@ page import="com.eventticket.utils.Customer" %>
<%@ page import="java.util.Map" %>
<%@ page import="javax.servlet.http.HttpServletRequest" %>
<%@ page import="javax.servlet.http.HttpServletResponse" %>
<%@ page import="java.io.IOException" %>
<%@ page import="javax.servlet.ServletException" %>

<%
    // Handle adding a new customer
    String customerId = request.getParameter("customerId");
    String customerName = request.getParameter("customerName");
    String customerEmail = request.getParameter("customerEmail");

    if (customerId != null && customerName != null && customerEmail != null) {
        Customer newCustomer = new Customer(customerId, customerName, customerEmail);
        UserStore.addCustomer(newCustomer);
        response.sendRedirect("adminpanel.jsp");
        return;
    }

    // Handle deleting a customer
    String deleteId = request.getParameter("deleteId");
    if (deleteId != null) {
        UserStore.deleteCustomer(deleteId);
        response.sendRedirect("adminpanel.jsp");
        return;
    }

    // Handle editing existing customer
    String editId = request.getParameter("editId");
    String editName = request.getParameter("editName");
    String editEmail = request.getParameter("editEmail");
    if (editId != null && editName != null && editEmail != null) {
        Customer updatedCustomer = new Customer(editId, editName, editEmail);
        UserStore.updateCustomer(updatedCustomer);
        response.sendRedirect("adminpanel.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Admin Panel - Customer & User Management</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet" />
    <style>
        .edit-form {
            display: none;
        }
    </style>
    <script>
        let originalValues = {};

        function toggleEditForm(id) {
            const formRow = document.getElementById('edit-form-' + id);
            if (!formRow) return;

            document.querySelectorAll('.edit-form').forEach(row => {
                if (row.id !== 'edit-form-' + id) {
                    row.style.display = 'none';
                    resetForm(row.dataset.customerId);
                }
            });

            if (formRow.style.display === 'table-row') {
                formRow.style.display = 'none';
                resetForm(id);
            } else {
                const nameInput = formRow.querySelector('input[name="editName"]');
                const emailInput = formRow.querySelector('input[name="editEmail"]');
                originalValues[id] = {
                    name: nameInput.value,
                    email: emailInput.value
                };

                formRow.style.display = 'table-row';
                nameInput.focus();
            }
        }

        function resetForm(id) {
            if (!originalValues[id]) return;
            const formRow = document.getElementById('edit-form-' + id);
            if (!formRow) return;
            formRow.querySelector('input[name="editName"]').value = originalValues[id].name;
            formRow.querySelector('input[name="editEmail"]').value = originalValues[id].email;
        }
    </script>
</head>
<body class="bg-gray-100 min-h-screen flex flex-col">

<nav class="bg-purple-900 text-white p-4 shadow-md">
    <div class="container mx-auto max-w-6xl">
        <h1 class="text-3xl font-bold">Admin Panel</h1>
    </div>
</nav>

<main class="container mx-auto max-w-6xl px-4 py-6 flex-grow space-y-12">

    <!-- Customer Management Section -->
    <section>
        <h2 class="text-3xl font-bold mb-6 text-center">Manage Customers</h2>

        <!-- Form to add new customer -->
        <form id="customerForm" class="mb-8 bg-white p-6 rounded shadow max-w-4xl mx-auto" method="post" autocomplete="off">
            <div class="flex flex-col sm:flex-row sm:space-x-4 space-y-4 sm:space-y-0">
                <input type="text" name="customerId" placeholder="Customer ID"
                       class="border border-gray-300 p-3 rounded flex-1 focus:outline-none focus:ring-2 focus:ring-purple-600" required />
                <input type="text" name="customerName" placeholder="Customer Name"
                       class="border border-gray-300 p-3 rounded flex-1 focus:outline-none focus:ring-2 focus:ring-purple-600" required />
                <input type="email" name="customerEmail" placeholder="Customer Email"
                       class="border border-gray-300 p-3 rounded flex-1 focus:outline-none focus:ring-2 focus:ring-purple-600" required />
            </div>
            <div class="mt-4 text-center">
                <button type="submit"
                        class="bg-purple-900 hover:bg-purple-800 text-white px-6 py-3 rounded font-semibold transition duration-200">
                    Add Customer
                </button>
            </div>
        </form>

        <!-- Customer List Table -->
        <div class="bg-white rounded shadow overflow-x-auto">
            <h3 class="text-2xl font-semibold p-6 border-b border-gray-200">Customer List</h3>
            <table class="min-w-full table-auto">
                <thead class="bg-purple-900 text-white">
                <tr>
                    <th class="px-6 py-3 text-left w-1/6">ID</th>
                    <th class="px-6 py-3 text-left w-1/4">Name</th>
                    <th class="px-6 py-3 text-left w-1/3">Email</th>
                    <th class="px-6 py-3 text-center w-1/4">Actions</th>
                </tr>
                </thead>
                <tbody>
                <%
                    Map<String, Customer> customers = UserStore.customers;
                    for (Customer customer : customers.values()) {
                %>
                <tr class="border-b border-gray-200 hover:bg-gray-50 align-middle">
                    <td class="px-6 py-4 align-middle"><%= customer.getId() %></td>
                    <td class="px-6 py-4 align-middle"><%= customer.getName() %></td>
                    <td class="px-6 py-4 align-middle"><%= customer.getEmail() %></td>
                    <td class="px-6 py-4 text-center align-middle space-x-2">
                        <button type="button" onclick="toggleEditForm('<%= customer.getId() %>')"
                                aria-label="Edit Customer <%= customer.getName() %>"
                                class="bg-yellow-500 hover:bg-yellow-600 text-white px-3 py-1 rounded transition duration-150 focus:outline-none focus:ring-2 focus:ring-yellow-400">
                            Edit
                        </button>
                        <form method="post" class="inline" onsubmit="return confirm('Are you sure you want to delete this customer?');">
                            <input type="hidden" name="deleteId" value="<%= customer.getId() %>" />
                            <button type="submit"
                                    class="bg-red-500 hover:bg-red-600 text-white px-3 py-1 rounded transition duration-150 focus:outline-none focus:ring-2 focus:ring-red-400">
                                Delete
                            </button>
                        </form>
                    </td>
                </tr>
                <tr id="edit-form-<%= customer.getId() %>" class="edit-form border-b border-gray-200 bg-gray-50" style="display:none;" data-customer-id="<%= customer.getId() %>">
                    <td colspan="4" class="px-6 py-4">
                        <form method="post" class="flex flex-col sm:flex-row sm:items-center sm:space-x-4 space-y-3 sm:space-y-0" autocomplete="off">
                            <input type="hidden" name="editId" value="<%= customer.getId() %>" />

                            <!-- Show ID as readonly input for user reference -->
                            <input type="text" value="<%= customer.getId() %>" readonly
                                   class="border border-gray-300 p-2 rounded flex-0 w-32 bg-gray-100 cursor-not-allowed mr-4" />

                            <input type="text" name="editName" value="<%= customer.getName() %>" placeholder="New Name"
                                   class="border border-gray-300 p-2 rounded flex-1 focus:outline-none focus:ring-2 focus:ring-green-500" required />

                            <input type="email" name="editEmail" value="<%= customer.getEmail() %>" placeholder="New Email"
                                   class="border border-gray-300 p-2 rounded flex-1 focus:outline-none focus:ring-2 focus:ring-green-500" required />

                            <div class="flex space-x-2">
                                <button type="submit"
                                        class="bg-green-500 hover:bg-green-600 text-white px-4 py-2 rounded font-semibold transition duration-150 focus:outline-none focus:ring-2 focus:ring-green-400">
                                    Save
                                </button>
                                <button type="button" onclick="toggleEditForm('<%= customer.getId() %>')"
                                        class="bg-gray-300 hover:bg-gray-400 text-black px-4 py-2 rounded transition duration-150 focus:outline-none focus:ring-2 focus:ring-gray-400">
                                    Cancel
                                </button>
                            </div>
                        </form>
                    </td>
                </tr>
                <% } %>
                </tbody>
            </table>
        </div>
    </section>

    <!-- Registered Users Section -->
    <section>
        <h2 class="text-3xl font-bold mb-6 text-center">Registered Users</h2>

        <div class="bg-white rounded shadow max-w-2xl mx-auto overflow-x-auto">
            <table class="min-w-full table-auto">
                <thead class="bg-purple-900 text-white">
                <tr>
                    <th class="px-6 py-3 text-left w-full">Username</th>
                </tr>
                </thead>
                <tbody>
                <%
                    Map<String, String> users = UserStore.users;
                    for (String username : users.keySet()) {
                %>
                <tr class="border-b border-gray-200 hover:bg-gray-50">
                    <td class="px-6 py-4"><%= username %></td>
                </tr>
                <% } %>
                </tbody>
            </table>
        </div>
    </section>

</main>

<footer class="bg-purple-900 text-white p-4 text-center">
    &copy; <%= java.time.Year.now() %> Event Ticketing System - Admin Panel
</footer>

</body>
</html>