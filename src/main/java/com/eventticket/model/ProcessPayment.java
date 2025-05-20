package com.eventticket.model;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.FileWriter;
import java.io.IOException;
import java.util.Date;

@WebServlet(name = "ProcessPayment", urlPatterns = {"/ProcessPayment"})
public class ProcessPayment extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            // Retrieve form parameters
            String eventId = req.getParameter("eventId");
            String eventName = req.getParameter("eventName");
            String price = req.getParameter("price");
            String username = req.getParameter("username");
            String email = req.getParameter("email");
            String cardNumber = req.getParameter("cardNumber");
            String expiryDate = req.getParameter("expiryDate");
            String cvv = req.getParameter("cvv");
            String cardHolderName = req.getParameter("cardName");

            // Validate required fields
            if (eventId == null || eventName == null || price == null || username == null ||
                    cardNumber == null || expiryDate == null || cvv == null || cardHolderName == null) {
                req.setAttribute("generalError", "All fields are required");
                req.getRequestDispatcher("payment.jsp").forward(req, resp);
                return;
            }

            // Parse price
            double amount;
            try {
                amount = Double.parseDouble(price);
            } catch (NumberFormatException e) {
                req.setAttribute("generalError", "Invalid price format");
                req.getRequestDispatcher("payment.jsp").forward(req, resp);
                return;
            }

            // Create and populate Payment object
            Payment payment = new Payment();
            payment.setEventId(eventId);
            payment.setEventName(eventName);
            payment.setUserId(username);
            payment.setAmount(amount);
            payment.setCardNumber(cardNumber);
            payment.setCardHolderName(cardHolderName);
            payment.setExpiryDate(expiryDate);
            payment.setCvv(cvv);
            payment.setPaymentDate(new Date());
            payment.setStatus("SUCCESS"); // Assume payment is successful for demo

            // WARNING: Storing payment details in a plain text file is insecure and not PCI DSS compliant.
            // In a production environment, use a secure database or payment gateway integration.
            String fileName = "E:\\UNI\\eventticket\\PaymentDetails.txt";
            try (FileWriter fw = new FileWriter(fileName, true)) { // Append mode to avoid overwriting
                fw.write("Payment ID: " + payment.getPaymentId() + "\n");
                fw.write("Event ID: " + payment.getEventId() + "\n");
                fw.write("Event Name: " + payment.getEventName() + "\n");
                fw.write("User ID: " + payment.getUserId() + "\n");
                fw.write("Amount: " + payment.getAmount() + "\n");
                fw.write("Card Number: " + payment.getCardNumber() + "\n");
                fw.write("Expiry Date: " + payment.getExpiryDate() + "\n");
                fw.write("CVV: " + payment.getCvv() + "\n");
                fw.write("Card Holder Name: " + payment.getCardHolderName() + "\n");
                fw.write("Payment Date: " + payment.getPaymentDate() + "\n");
                fw.write("Status: " + payment.getStatus() + "\n");
                fw.write("------------------------\n");
            } catch (IOException e) {
                req.setAttribute("generalError", "Error saving payment details: " + e.getMessage());
                req.getRequestDispatcher("payment.jsp").forward(req, resp);
                return;
            }

            // Redirect to confirmation page with paymentId
            resp.sendRedirect("confirmation.jsp?paymentId=" + payment.getPaymentId());

        } catch (IllegalArgumentException e) {
            // Handle validation errors from Payment class
            String message = e.getMessage();
            if (message.contains("expiry date")) {
                req.setAttribute("expiryDateError", message);
            } else if (message.contains("CVV")) {
                req.setAttribute("cvvError", message);
            } else {
                req.setAttribute("generalError", message);
            }
            req.getRequestDispatcher("payment.jsp").forward(req, resp);
        } catch (Exception e) {
            req.setAttribute("generalError", "An unexpected error occurred: " + e.getMessage());
            req.getRequestDispatcher("payment.jsp").forward(req, resp);
        }
    }
}