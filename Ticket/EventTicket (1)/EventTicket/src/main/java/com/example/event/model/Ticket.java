package com.example.event.model;

import java.time.LocalDateTime;

public class Ticket {
    private String ticketId;
    private String attendeeName;
    private String eventName;
    private String ticketType;
    private String seatNumber;
    private LocalDateTime eventDateTime;
    private double ticketPrice;

    // Constructor
    public Ticket() {}

    public Ticket(String ticketId, String attendeeName, String eventName, String ticketType,
                  String seatNumber, LocalDateTime eventDateTime, double ticketPrice) {
        this.ticketId = ticketId;
        this.attendeeName = attendeeName;
        this.eventName = eventName;
        this.ticketType = ticketType;
        this.seatNumber = seatNumber;
        this.eventDateTime = eventDateTime;
        this.ticketPrice = ticketPrice;
    }

    // Getters and Setters
    public String getTicketId() { return ticketId; }
    public void setTicketId(String ticketId) { this.ticketId = ticketId; }
    public String getAttendeeName() { return attendeeName; }
    public void setAttendeeName(String attendeeName) { this.attendeeName = attendeeName; }
    public String getEventName() { return eventName; }
    public void setEventName(String eventName) { this.eventName = eventName; }
    public String getTicketType() { return ticketType; }
    public void setTicketType(String ticketType) { this.ticketType = ticketType; }
    public String getSeatNumber() { return seatNumber; }
    public void setSeatNumber(String seatNumber) { this.seatNumber = seatNumber; }
    public LocalDateTime getEventDateTime() { return eventDateTime; }
    public void setEventDateTime(LocalDateTime eventDateTime) { this.eventDateTime = eventDateTime; }
    public double getTicketPrice() { return ticketPrice; }
    public void setTicketPrice(double ticketPrice) { this.ticketPrice = ticketPrice; }
}