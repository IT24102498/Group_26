package com.example.model;

public class Event implements Comparable<Event> {
    private String id;
    private String name;
    private String date;
    private String time;
    private int popularity;
    private String picture;

    public Event(String id, String name, String date, String time, int popularity, String picture) {
        this.id = id;
        this.name = name;
        this.date = date;
        this.time = time;
        this.popularity = popularity;
        this.picture = picture;
    }

    public String getId() { return id; }
    public void setId(String id) { this.id = id; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getDate() { return date; }
    public void setDate(String date) { this.date = date; }
    public String getTime() { return time; }
    public void setTime(String time) { this.time = time; }
    public int getPopularity() { return popularity; }
    public void setPopularity(int popularity) { this.popularity = popularity; }
    public String getPicture() { return picture; }
    public void setPicture(String picture) { this.picture = picture; }

    @Override
    public int compareTo(Event other) {
        return this.date.compareTo(other.date);
    }

    public int compareByPopularity(Event other) {
        return Integer.compare(this.popularity, other.popularity);
    }

    @Override
    public String toString() {
        return id + "," + name + "," + date + "," + time + "," + popularity + "," + picture;
    }

    public static Event fromString(String line) throws IllegalArgumentException {
        if (line == null || line.trim().isEmpty()) {
            throw new IllegalArgumentException("Event line cannot be null or empty");
        }
        String[] parts = line.split(",");
        if (parts.length != 6) {
            throw new IllegalArgumentException("Invalid event format: " + line + ". Expected format: id,name,date,time,popularity,picture");
        }
        try {
            return new Event(parts[0], parts[1], parts[2], parts[3], Integer.parseInt(parts[4]), parts[5]);
        } catch (NumberFormatException e) {
            throw new IllegalArgumentException("Invalid popularity value in event: " + line, e);
        }
    }
}