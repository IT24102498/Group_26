package com.eventticket.model;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.List;

public class Reservation implements Serializable {
    private String id;
    private String eventId;
    private String userId;
    private LocalDateTime reservationDate;
    private double totalAmount;
    private String status; // confirmed, cancelled
    private List<Seat> seats;

    // Constructors
    public Reservation() {}

    public Reservation(String id, String eventId, String userId, LocalDateTime reservationDate,
                       double totalAmount, String status, List<Seat> seats) {
        this.id = id;
        this.eventId = eventId;
        this.userId = userId;
        this.reservationDate = reservationDate;
        this.totalAmount = totalAmount;
        this.status = status;
        this.seats = seats;
    }

    // Getters and Setters
    public String getId() { return id; }
    public void setId(String id) { this.id = id; }

    public String getEventId() { return eventId; }
    public void setEventId(String eventId) { this.eventId = eventId; }

    public String getUserId() { return userId; }
    public void setUserId(String userId) { this.userId = userId; }

    public LocalDateTime getReservationDate() { return reservationDate; }
    public void setReservationDate(LocalDateTime reservationDate) { this.reservationDate = reservationDate; }

    public double getTotalAmount() { return totalAmount; }
    public void setTotalAmount(double totalAmount) { this.totalAmount = totalAmount; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public List<Seat> getSeats() { return seats; }
    public void setSeats(List<Seat> seats) { this.seats = seats; }

    @Override
    public String toString() {
        return "Reservation{" +
                "id='" + id + '\'' +
                ", eventId='" + eventId + '\'' +
                ", userId='" + userId + '\'' +
                ", reservationDate=" + reservationDate +
                ", totalAmount=" + totalAmount +
                ", status='" + status + '\'' +
                ", seats=" + seats +
                '}';
    }
}