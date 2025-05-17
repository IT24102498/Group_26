<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Seat Management | Tix.com</title>
  <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
  <style>
    /* Custom Font */
    @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap');

    /* Base Styles with Background Image */
    body {
      font-family: 'Poppins', sans-serif;
      line-height: 1.6;
      background-image: url('https://media.istockphoto.com/id/1247853982/photo/cheering-crowd-with-hands-in-air-at-music-festival.jpg?s=2048x2048&w=is&k=20&c=DbYnuPLZ3ga9QyEMxgc5Mn9wP3AYH8ofiytno2o7HPw=');
      background-size: cover;
      background-position: center;
      background-attachment: fixed;
      background-repeat: no-repeat;
      min-height: 100vh;
      margin: 0;
      color: #333;
    }

    /* Navigation Bar with Glass Effect */
    nav {
      background-color: rgba(76, 29, 149, 0.85) !important;
      backdrop-filter: blur(8px);
      -webkit-backdrop-filter: blur(8px);
      box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
      border-bottom: 1px solid rgba(255, 255, 255, 0.1);
    }

    /* Main Content with Glass Effect */
    .bg-white {
      background-color: rgba(255, 255, 255, 0.9) !important;
      backdrop-filter: blur(6px);
      -webkit-backdrop-filter: blur(6px);
      border: 1px solid rgba(255, 255, 255, 0.2);
      transition: all 0.3s ease;
    }

    /* Buttons with Glass Effect */
    .bg-purple-900 {
      background-color: rgba(76, 29, 149, 0.9) !important;
      backdrop-filter: blur(2px);
      -webkit-backdrop-filter: blur(2px);
      transition: all 0.3s ease;
      border: 1px solid rgba(255, 255, 255, 0.2);
    }

    .bg-purple-900:hover {
      background-color: rgba(91, 33, 182, 0.95) !important;
      backdrop-filter: blur(4px);
    }

    /* Form Input */
    input:focus {
      outline: none;
      box-shadow: 0 0 0 3px rgba(128, 90, 213, 0.3);
      background-color: rgba(255, 255, 255, 0.95);
    }

    /* Footer with Glass Effect */
    .bg-gray-800 {
      background-color: rgba(31, 41, 55, 0.9) !important;
      backdrop-filter: blur(4px);
      -webkit-backdrop-filter: blur(4px);
      border-top: 1px solid rgba(255, 255, 255, 0.1);
    }

    /* Seat Styles */
    .seat {
      width: 40px;
      height: 40px;
      margin: 5px;
      display: inline-flex;
      align-items: center;
      justify-content: center;
      cursor: pointer;
      border-radius: 5px;
      font-weight: bold;
      transition: transform 0.2s ease;
    }

    .seat:hover {
      transform: scale(1.1);
    }

    .available {
      background-color: rgba(76, 175, 80, 0.9);
      color: white;
    }
    .reserved {
      background-color: rgba(244, 67, 54, 0.9);
      color: white;
    }
    .selected {
      background-color: rgba(33, 150, 243, 0.9);
      color: white;
    }
    .vip {
      background-color: rgba(255, 215, 0, 0.9);
      color: black;
    }
    .disabled {
      background-color: rgba(204, 204, 204, 0.7);
      cursor: not-allowed;
    }
    .stage {
      background-color: rgba(51, 51, 51, 0.9);
      color: white;
      height: 60px;
      display: flex;
      align-items: center;
      justify-content: center;
      margin-bottom: 20px;
      border-radius: 5px;
      backdrop-filter: blur(2px);
      -webkit-backdrop-filter: blur(2px);
      border: 1px solid rgba(255, 255, 255, 0.2);
    }

    /* Glass panels */
    .bg-gray-50 {
      background-color: rgba(249, 250, 251, 0.85) !important;
      backdrop-filter: blur(4px);
      -webkit-backdrop-filter: blur(4px);
      border: 1px solid rgba(255, 255, 255, 0.2);
    }

    /* Text Contrast Enhancement */
    .text-white {
      text-shadow: 0 1px 3px rgba(0, 0, 0, 0.3);
    }

    /* Footer Links */
    footer a {
      transition: all 0.2s ease;
      color: #d1d5db !important;
    }

    footer a:hover {
      color: #e5e7eb !important;
      text-decoration: underline;
    }

    /* Responsive Adjustments */
    @media (max-width: 768px) {
      .text-3xl {
        font-size: 1.8rem;
      }

      .text-xl {
        font-size: 1.1rem;
      }

      #addSeatsForm {
        grid-template-columns: 1fr !important;
      }

      .seat {
        width: 30px;
        height: 30px;
        font-size: 0.8rem;
      }
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
<main class="container mx-auto py-8 px-4">
  <div class="bg-white rounded-xl shadow-lg p-6">
    <!-- Event Info -->
    <div class="mb-8 border-b pb-4">
      <h2 class="text-3xl font-bold mb-2">${param.eventName}</h2>
      <p class="text-gray-600 mb-1">Date: ${param.date}</p>
      <p class="text-gray-600 mb-1">Location: ${param.location}</p>
      <p class="text-gray-600">Price: $${param.price}</p>
    </div>

    <!-- Seat Management Section -->
    <div class="mb-8">
      <h3 class="text-2xl font-bold mb-4">Seat Management</h3>

      <!-- Seat Legend -->
      <div class="flex flex-wrap gap-4 mb-6">
        <div class="flex items-center">
          <div class="seat available mr-2"></div>
          <span>Available</span>
        </div>
        <div class="flex items-center">
          <div class="seat reserved mr-2"></div>
          <span>Reserved</span>
        </div>
        <div class="flex items-center">
          <div class="seat selected mr-2"></div>
          <span>Selected</span>
        </div>
        <div class="flex items-center">
          <div class="seat vip mr-2"></div>
          <span>VIP</span>
        </div>
        <div class="flex items-center">
          <div class="seat disabled mr-2"></div>
          <span>Disabled</span>
        </div>
      </div>

      <!-- Seat Map -->
      <div class="mb-8">
        <h4 class="text-xl font-semibold mb-3">Seat Map</h4>
        <div class="stage mb-6">STAGE</div>

        <!-- Floor Section -->
        <div class="mb-8">
          <h5 class="font-bold mb-3">Floor Section</h5>
          <div id="floorSection" class="flex flex-wrap justify-center">
            <!-- Seats will be generated here by JavaScript -->
          </div>
        </div>

        <!-- Balcony Section -->
        <div class="mb-8">
          <h5 class="font-bold mb-3">Balcony Section</h5>
          <div id="balconySection" class="flex flex-wrap justify-center">
            <!-- Seats will be generated here by JavaScript -->
          </div>
        </div>

        <!-- VIP Section -->
        <div class="mb-8">
          <h5 class="font-bold mb-3">VIP Section</h5>
          <div id="vipSection" class="flex flex-wrap justify-center">
            <!-- Seats will be generated here by JavaScript -->
          </div>
        </div>
      </div>
    </div>

    <!-- Selected Seats Summary -->
    <div class="bg-gray-50 p-4 rounded-lg mb-6">
      <h4 class="text-xl font-semibold mb-3">Your Selection</h4>
      <div id="selectedSeats" class="mb-3">
        <p>No seats selected yet.</p>
      </div>
      <div class="flex justify-between items-center">
        <div>
          <span class="font-bold">Total: $</span>
          <span id="totalPrice">0</span>
        </div>
        <div>
          <button onclick="clearSelection()" class="bg-gray-500 text-white px-4 py-2 rounded hover:bg-gray-600 transition duration-300 mr-2">Clear</button>
          <button onclick="prepareReservation()" class="bg-purple-900 text-white px-4 py-2 rounded hover:bg-purple-800 transition duration-300">Reserve Selected Seats</button>
          <form id="reservationForm" action="Payment.jsp" method="post" style="display: none;">
            <input type="hidden" name="selectedSeatsData" id="selectedSeatsData">
            <input type="hidden" name="totalPrice" id="formTotalPrice">
            <input type="hidden" name="eventName" value="${param.eventName}">
            <input type="hidden" name="date" value="${param.date}">
            <input type="hidden" name="location" value="${param.location}">
            <input type="hidden" name="basePrice" value="${param.price}">
          </form>
        </div>
      </div>
    </div>

    <!-- Modify Reservation Section -->
    <div class="bg-gray-50 p-4 rounded-lg">
      <h4 class="text-xl font-semibold mb-3">Modify Reservation</h4>
      <form id="modifyReservationForm" class="grid grid-cols-1 md:grid-cols-3 gap-4 mb-4">
        <div>
          <label class="block text-sm font-medium text-gray-700 mb-1">Reservation ID</label>
          <input type="text" name="reservationId" class="w-full px-3 py-2 border rounded-md" placeholder="Enter reservation ID">
        </div>
        <div>
          <label class="block text-sm font-medium text-gray-700 mb-1">Action</label>
          <select name="action" class="w-full px-3 py-2 border rounded-md">
            <option value="cancel">Cancel Reservation</option>
            <option value="change">Change Seats</option>
            <option value="upgrade">Upgrade to VIP</option>
          </select>
        </div>
        <div class="flex items-end">
          <button type="button" onclick="modifyReservation()" class="bg-purple-900 text-white px-4 py-2 rounded hover:bg-purple-800 transition duration-300 h-10">Modify</button>
        </div>
      </form>
      <div id="modifyResult" class="text-sm"></div>
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
  // Sample seat data - in a real application, this would come from the server
  const seatData = {
    floor: [
      { id: 'F-A-1', row: 'A', number: 1, status: 'available', type: 'regular' },
      { id: 'F-A-2', row: 'A', number: 2, status: 'available', type: 'regular' },
      { id: 'F-A-3', row: 'A', number: 3, status: 'reserved', type: 'regular' },
      { id: 'F-A-4', row: 'A', number: 4, status: 'available', type: 'regular' },
      { id: 'F-B-1', row: 'B', number: 1, status: 'available', type: 'regular' },
      { id: 'F-B-2', row: 'B', number: 2, status: 'available', type: 'regular' },
      { id: 'F-B-3', row: 'B', number: 3, status: 'available', type: 'regular' },
      { id: 'F-B-4', row: 'B', number: 4, status: 'available', type: 'regular' },
      { id: 'F-C-1', row: 'C', number: 1, status: 'disabled', type: 'regular' },
      { id: 'F-C-2', row: 'C', number: 2, status: 'available', type: 'regular' },
      { id: 'F-C-3', row: 'C', number: 3, status: 'available', type: 'regular' },
      { id: 'F-C-4', row: 'C', number: 4, status: 'disabled', type: 'regular' }
    ],
    balcony: [
      { id: 'B-A-1', row: 'A', number: 1, status: 'available', type: 'regular' },
      { id: 'B-A-2', row: 'A', number: 2, status: 'available', type: 'regular' },
      { id: 'B-A-3', row: 'A', number: 3, status: 'available', type: 'regular' },
      { id: 'B-A-4', row: 'A', number: 4, status: 'available', type: 'regular' },
      { id: 'B-B-1', row: 'B', number: 1, status: 'available', type: 'regular' },
      { id: 'B-B-2', row: 'B', number: 2, status: 'available', type: 'regular' },
      { id: 'B-B-3', row: 'B', number: 3, status: 'available', type: 'regular' },
      { id: 'B-B-4', row: 'B', number: 4, status: 'available', type: 'regular' }
    ],
    vip: [
      { id: 'V-A-1', row: 'A', number: 1, status: 'available', type: 'vip' },
      { id: 'V-A-2', row: 'A', number: 2, status: 'available', type: 'vip' },
      { id: 'V-A-3', row: 'A', number: 3, status: 'reserved', type: 'vip' },
      { id: 'V-A-4', row: 'A', number: 4, status: 'available', type: 'vip' }
    ]
  };

  // Selected seats array
  let selectedSeats = [];
  const pricePerSeat = parseFloat('${param.price}') || 99; // Default to 99 if not provided
  const vipPriceMultiplier = 1.5;

  // Initialize the seat map when the page loads
  document.addEventListener('DOMContentLoaded', function() {
    generateSeatMap();
  });

  // Generate the seat map based on seatData
  function generateSeatMap() {
    generateSectionSeats('floor', seatData.floor);
    generateSectionSeats('balcony', seatData.balcony);
    generateSectionSeats('vip', seatData.vip);
  }

  // Generate seats for a specific section
  function generateSectionSeats(sectionId, seats) {
    const sectionElement = document.getElementById(sectionId + 'Section');
    sectionElement.innerHTML = '';

    // Group seats by row
    const rows = {};
    seats.forEach(seat => {
      if (!rows[seat.row]) {
        rows[seat.row] = [];
      }
      rows[seat.row].push(seat);
    });

    // Create seat elements for each row
    for (const row in rows) {
      const rowDiv = document.createElement('div');
      rowDiv.className = 'mb-2';
      rowDiv.innerHTML = `<span class="inline-block w-8">Row ${row}:</span>`;

      rows[row].forEach(seat => {
        const seatElement = document.createElement('div');
        seatElement.className = `seat ${seat.status} ${seat.type == 'vip' ? 'vip' : ''}`;
        seatElement.textContent = seat.number;
        seatElement.dataset.id = seat.id;
        seatElement.dataset.row = seat.row;
        seatElement.dataset.number = seat.number;
        seatElement.dataset.status = seat.status;
        seatElement.dataset.type = seat.type;
        seatElement.dataset.section = sectionId;

        if (seat.status === 'disabled') {
          seatElement.classList.add('disabled');
        } else {
          seatElement.addEventListener('click', function() {
            toggleSeatSelection(this);
          });
        }

        rowDiv.appendChild(seatElement);
      });

      sectionElement.appendChild(rowDiv);
    }
  }

  // Toggle seat selection
  function toggleSeatSelection(seatElement) {
    const seatId = seatElement.dataset.id;
    const seatStatus = seatElement.dataset.status;

    if (seatStatus === 'reserved') {
      alert('This seat is already reserved. Please select another seat.');
      return;
    }

    if (seatElement.classList.contains('selected')) {
      // Deselect the seat
      seatElement.classList.remove('selected');
      selectedSeats = selectedSeats.filter(seat => seat.id !== seatId);
    } else {
      // Select the seat
      seatElement.classList.add('selected');
      selectedSeats.push({
        id: seatId,
        row: seatElement.dataset.row,
        number: seatElement.dataset.number,
        section: seatElement.dataset.section,
        type: seatElement.dataset.type
      });
    }

    updateSelectedSeatsDisplay();
  }

  // Update the selected seats display
  function updateSelectedSeatsDisplay() {
    const selectedSeatsElement = document.getElementById('selectedSeats');
    const totalPriceElement = document.getElementById('totalPrice');

    if (selectedSeats.length === 0) {
      selectedSeatsElement.innerHTML = '<p>No seats selected yet.</p>';
      totalPriceElement.textContent = '0';
      return;
    }

    let html = '<ul class="list-disc pl-5">';
    let totalPrice = 0;

    selectedSeats.forEach(seat => {
      const seatPrice = seat.type === 'vip' ? pricePerSeat * vipPriceMultiplier : pricePerSeat;
      totalPrice += seatPrice;

      html += `<li>${seat.section.toUpperCase()} Section, Row ${seat.row}, Seat ${seat.number} (${seat.type.toUpperCase()}) - $${seatPrice.toFixed(2)}</li>`;
    });

    html += '</ul>';
    selectedSeatsElement.innerHTML = html;
    totalPriceElement.textContent = totalPrice.toFixed(2);
  }

  // Clear all selected seats
  function clearSelection() {
    document.querySelectorAll('.seat.selected').forEach(seat => {
      seat.classList.remove('selected');
    });
    selectedSeats = [];
    updateSelectedSeatsDisplay();
  }

  // Prepare reservation data and submit form to Payment.jsp
  function prepareReservation() {
    if (selectedSeats.length === 0) {
      alert('Please select at least one seat to reserve');
      return;
    }

    // Calculate total price
    let totalPrice = 0;
    const seatsData = selectedSeats.map(seat => {
      const seatPrice = seat.type === 'vip' ? pricePerSeat * vipPriceMultiplier : pricePerSeat;
      totalPrice += seatPrice;

      return {
        id: seat.id,
        row: seat.row,
        number: seat.number,
        section: seat.section,
        type: seat.type,
        price: seatPrice
      };
    });

    // Set form data
    document.getElementById('selectedSeatsData').value = JSON.stringify(seatsData);
    document.getElementById('formTotalPrice').value = totalPrice.toFixed(2);

    // Submit the form to Payment.jsp
    document.getElementById('reservationForm').submit();
  }

  // Modify reservation
  function modifyReservation() {
    const form = document.getElementById('modifyReservationForm');
    const reservationId = form.elements['reservationId'].value.trim();
    const action = form.elements['action'].value;

    if (!reservationId) {
      alert('Please enter a reservation ID');
      return;
    }

    // In a real application, this would send a request to the server
    // For demo purposes, we'll just show a message
    const resultElement = document.getElementById('modifyResult');

    switch (action) {
      case 'cancel':
        resultElement.innerHTML = `<p class="text-green-600">Reservation ${reservationId} has been canceled successfully.</p>`;
        break;
      case 'change':
        resultElement.innerHTML = `<p class="text-green-600">You can now select new seats for reservation ${reservationId}.</p>`;
        break;
      case 'upgrade':
        resultElement.innerHTML = `<p class="text-green-600">Reservation ${reservationId} has been upgraded to VIP.</p>`;
        break;
    }

    // In a real application, you would update the seatData and UI accordingly
  }
</script>
</body>
</html>