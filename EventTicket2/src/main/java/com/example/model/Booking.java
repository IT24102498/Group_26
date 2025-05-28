package com.example.model;

public class Booking {
    private String ticketId;
    private String eventId;
    private String userName;
    private String seat;

    public Booking(String ticketId, String eventId, String userName, String seat) {
        this.ticketId = ticketId;
        this.eventId = eventId;
        this.userName = userName;
        this.seat = seat;
    }

    public String getTicketId() { return ticketId; }
    public void setTicketId(String ticketId) { this.ticketId = ticketId; }
    public String getEventId() { return eventId; }
    public void setEventId(String eventId) { this.eventId = eventId; }
    public String getUserName() { return userName; }
    public void setUserName(String userName) { this.userName = userName; }
    public String getSeat() { return seat; }
    public void setSeat(String seat) { this.seat = seat; }

    @Override
    public String toString() {
        return ticketId + "," + eventId + "," + userName + "," + seat;
    }

    public static Booking fromString(String line) {
        String[] parts = line.split(",");
        return new Booking(parts[0], parts[1], parts[2], parts[3]);
    }
}