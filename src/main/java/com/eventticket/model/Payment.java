package com.eventticket.model;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

public class Payment {
    private String paymentId;
    private String eventId;
    private String eventName;
    private String userId;
    private double amount;
    private String cardNumber;
    private String cardHolderName;
    private String expiryDate;
    private String cvv;
    private Date paymentDate;
    private String status;
    private static final String FILE_NAME = "E:\\UNI\\eventticket\\PaymentDetails.txt";

    // Constructors
    public Payment() {
        this.paymentId = UUID.randomUUID().toString();
        this.paymentDate = new Date();
        this.status = "PENDING";
    }

    public Payment(String paymentId, String eventId, String eventName, String userId, double amount,
                   String cardNumber, String cardHolderName, String expiryDate, String cvv,
                   Date paymentDate, String status) throws IllegalArgumentException {
        this.paymentId = paymentId != null ? paymentId : UUID.randomUUID().toString();
        this.eventId = eventId;
        this.eventName = eventName;
        this.userId = userId;
        setAmount(amount);
        setCardNumber(cardNumber);
        setCardHolderName(cardHolderName);
        setExpiryDate(expiryDate);
        setCvv(cvv);
        this.paymentDate = paymentDate != null ? paymentDate : new Date();
        this.status = status != null ? status : "PENDING";
    }

    // Getters and Setters
    public String getPaymentId() { return paymentId; }
    public void setPaymentId(String paymentId) {
        this.paymentId = paymentId != null ? paymentId : UUID.randomUUID().toString();
    }

    public String getEventId() { return eventId; }
    public void setEventId(String eventId) { this.eventId = eventId; }

    public String getEventName() { return eventName; }
    public void setEventName(String eventName) { this.eventName = eventName; }

    public String getUserId() { return userId; }
    public void setUserId(String userId) { this.userId = userId; }

    public double getAmount() { return amount; }
    public void setAmount(double amount) {
        if (amount <= 0) {
            throw new IllegalArgumentException("Amount must be greater than zero");
        }
        this.amount = amount;
    }

    public String getCardNumber() { return cardNumber; }
    public void setCardNumber(String cardNumber) {
        if (cardNumber == null || !cardNumber.replaceAll("\\s", "").matches("\\d{16}")) {
            throw new IllegalArgumentException("Card number must be 16 digits");
        }
        this.cardNumber = cardNumber;
    }

    public String getCardHolderName() { return cardHolderName; }
    public void setCardHolderName(String cardHolderName) {
        if (cardHolderName == null || cardHolderName.trim().isEmpty()) {
            throw new IllegalArgumentException("Cardholder name cannot be empty");
        }
        this.cardHolderName = cardHolderName;
    }

    public String getExpiryDate() { return expiryDate; }
    public void setExpiryDate(String expiryDate) {
        if (expiryDate == null) {
            throw new IllegalArgumentException("Expiry date cannot be null");
        }
        try {
            String[] parts = expiryDate.split("/");
            if (parts.length != 2) {
                throw new IllegalArgumentException("Expiry date must be in MM/YY format");
            }
            int month = Integer.parseInt(parts[0]);
            if (month < 1 || month > 12) {
                throw new IllegalArgumentException("Month must be between 1 and 12");
            }
            this.expiryDate = expiryDate;
        } catch (NumberFormatException e) {
            throw new IllegalArgumentException("Invalid expiry date format: " + expiryDate);
        }
    }

    public String getCvv() { return cvv; }
    public void setCvv(String cvv) {
        if (cvv == null) {
            throw new IllegalArgumentException("CVV cannot be null");
        }
        if (cvv.length() != 3 || !cvv.matches("\\d{3}")) {
            throw new IllegalArgumentException("CVV must be exactly 3 digits");
        }
        this.cvv = cvv;
    }

    public Date getPaymentDate() { return paymentDate; }
    public void setPaymentDate(Date paymentDate) {
        this.paymentDate = paymentDate != null ? paymentDate : new Date();
    }

    public String getStatus() { return status; }
    public void setStatus(String status) {
        this.status = status != null ? status : "PENDING";
    }

    // CRUD Operation: Delete
    // Delete: Remove a payment by paymentId from the file
    public static void delete(String paymentId) throws IOException {
        if (paymentId == null) {
            throw new IllegalArgumentException("Payment ID cannot be null");
        }
        List<String> fileContent = new ArrayList<>();
        boolean found = false;
        try (BufferedReader br = new BufferedReader(new FileReader("D:\\New Text Document.txt"))) {
            String line;
            while ((line = br.readLine()) != null) {
                if (line.startsWith("Payment ID: " + paymentId)) {
                    found = true;
                    // Skip the entire payment record
                    for (int i = 0; i < 11 && br.readLine() != null; i++);
                } else {
                    fileContent.add(line);
                }
            }
        }
        if (!found) {
            throw new IOException("Payment with ID " + paymentId + " not found");
        }
        // Rewrite the file without the deleted record
        try (BufferedWriter bw = new BufferedWriter(new FileWriter(FILE_NAME))) {
            for (String line : fileContent) {
                bw.write(line + "\n");
            }
        }
    }
}