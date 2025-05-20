package com.eventticket.model;

import java.util.Date;

public class Payment {
    private String paymentId;
    private String eventId;
    private String eventName;
    private String userId;
    private double amount;
    private String cardNumber;


    // Constructors
    public Payment() {}

    public Payment(String paymentId, String eventId, String eventName, String userId, double amount,
                   String cardNumber, String cardHolderName, String expiryDate, String cvv,
                   Date paymentDate, String status) {
        this.paymentId = paymentId;
        this.eventId = eventId;
        this.eventName = eventName;
        this.userId = userId;
        this.amount = amount;
        this.cardNumber = cardNumber;

    }

    // Getters and Setters
    public String getPaymentId() { return paymentId; }
    public void setPaymentId(String paymentId) { this.paymentId = paymentId; }

    public String getEventId() { return eventId; }
    public void setEventId(String eventId) { this.eventId = eventId; }

    public String getEventName() { return eventName; }
    public void setEventName(String eventName) { this.eventName = eventName; }

    public String getUserId() { return userId; }
    public void setUserId(String userId) { this.userId = userId; }

    public double getAmount() { return amount; }
    public void setAmount(double amount) { this.amount = amount; }

    public String getCardNumber() { return cardNumber; }
    public void setCardNumber(String cardNumber) { this.cardNumber = cardNumber; }


}
