package com.eventticket.model;

import java.io.Serializable;
import java.time.LocalDateTime;

public class Event implements Serializable {
    private String id;
    private String name;
    private String description;
    private LocalDateTime dateTime;
    private String venue;
    private double price;
    private int availableTickets;
    private String imagePath;
    private String category;

    // Constructors
    public Event() {}

    public Event(String id, String name, String description, LocalDateTime dateTime,
                 String venue, double price, int availableTickets, String imagePath, String category) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.dateTime = dateTime;
        this.venue = venue;
        this.price = price;
        this.availableTickets = availableTickets;
        this.imagePath = imagePath;
        this.category = category;
    }

    // Getters and Setters
    public String getId() { return id; }
    public void setId(String id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public LocalDateTime getDateTime() { return dateTime; }
    public void setDateTime(LocalDateTime dateTime) { this.dateTime = dateTime; }

    public String getVenue() { return venue; }
    public void setVenue(String venue) { this.venue = venue; }

    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }

    public int getAvailableTickets() { return availableTickets; }
    public void setAvailableTickets(int availableTickets) { this.availableTickets = availableTickets; }

    public String getImagePath() { return imagePath; }
    public void setImagePath(String imagePath) { this.imagePath = imagePath; }

    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }

    @Override
    public String toString() {
        return "Event{" +
                "id='" + id + '\'' +
                ", name='" + name + '\'' +
                ", description='" + description + '\'' +
                ", dateTime=" + dateTime +
                ", venue='" + venue + '\'' +
                ", price=" + price +
                ", availableTickets=" + availableTickets +
                ", imagePath='" + imagePath + '\'' +
                ", category='" + category + '\'' +
                '}';
    }
}