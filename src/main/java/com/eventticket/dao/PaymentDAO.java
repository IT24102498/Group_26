package com.eventticket.dao;

import com.eventticket.model.Payment;
import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

public class PaymentDAO {
    private static final String LOG_FILE_PATH = "payment_logs.txt"; // Path to your log file

    public boolean processPayment(Payment payment) {
        String paymentId = "PAY-" + UUID.randomUUID().toString().substring(0, 8);
        Date paymentDate = new Date(); // Get current real-time date

        try {
            // Log payment to text file
            logPaymentToFile(paymentId, payment, paymentDate);
            return true;
        } catch (IOException e) {
            System.err.println("Error writing to payment log file: " + e.getMessage());
            return false;
        }
    }

    private void logPaymentToFile(String paymentId, Payment payment, Date paymentDate) throws IOException {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(LOG_FILE_PATH, true))) {
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

            writer.write("=== Payment Receipt ===\n");
            writer.write("Payment ID: " + paymentId + "\n");
            writer.write("Date: " + dateFormat.format(paymentDate) + "\n");
            writer.write("Event ID: " + payment.getEventId() + "\n");
            writer.write("Event Name: " + payment.getEventName() + "\n");
            writer.write("User ID: " + payment.getUserId() + "\n");
            writer.write("Amount: $" + payment.getAmount() + "\n");
            writer.write("Card Holder: " + payment.getCardHolderName() + "\n");
            writer.write("Card Number: " + maskCardNumber(payment.getCardNumber()) + "\n");
            writer.write("Expiry Date: " + payment.getExpiryDate() + "\n");
            writer.write("Status: COMPLETED\n");
            writer.write("======================\n\n");
        }
    }

    private String maskCardNumber(String cardNumber) {
        if (cardNumber == null || cardNumber.length() < 4) {
            return "****";
        }
        return "****-****-****-" + cardNumber.substring(cardNumber.length() - 4);
    }
}
