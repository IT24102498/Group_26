package com.eventticket.model;

import java.io.Serializable;



    // Constructors
    public Seat() {}

    public Seat(String id, String eventId, String section, String row, int number,
                String status, String type, double price) {
        this.id = id;
        this.eventId = eventId;
        this.section = section;
        this.row = row;
        this.number = number;
        this.status = status;
        this.type = type;
        this.price = price;
    }

    // Getters and Setters
    public String getId() { return id; }
    public void setId(String id) { this.id = id; }

    public String getEventId() { return eventId; }
    public void setEventId(String eventId) { this.eventId = eventId; }

    public String getSection() { return section; }
    public void setSection(String section) { this.section = section; }

    public String getRow() { return row; }
    public void setRow(String row) { this.row = row; }

    public int getNumber() { return number; }
    public void setNumber(int number) { this.number = number; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getType() { return type; }
    public void setType(String type) { this.type = type; }

    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }

    @Override
    public String toString() {
        return "Seat{" +
                "id='" + id + '\'' +
                ", eventId='" + eventId + '\'' +
                ", section='" + section + '\'' +
                ", row='" + row + '\'' +
                ", number=" + number +
                ", status='" + status + '\'' +
                ", type='" + type + '\'' +
                ", price=" + price +
                '}';
    }
}