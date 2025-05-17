package com.eventticket.model;

import java.io.Serializable;
import java.time.LocalDateTime;

public class Ticket implements Serializable {
    private String id;
    private String eventId;
    private String userId;
    private LocalDateTime purchaseDate;
    private int quantity;
    private double totalPrice;
    private String status; // "CONFIRMED", "CANCELLED"

    // Constructors, getters, and setters
    // ...
}