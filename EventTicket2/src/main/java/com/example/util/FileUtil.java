package com.example.util;

import com.example.model.Event;
import com.example.model.Booking;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class FileUtil {
    private static final String EVENTS_FILE = "event.txt";
    private static final String BOOKINGS_FILE = "bookings.txt";

    public static List<Event> readEvents() throws IOException {
        List<Event> events = new ArrayList<>();
        File file = new File(EVENTS_FILE);
        if (!file.exists()) return events;

        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                try {
                    if (!line.trim().isEmpty()) { // Skip empty lines
                        events.add(Event.fromString(line));
                    }
                } catch (IllegalArgumentException e) {
                    System.err.println("Skipping invalid event line: " + e.getMessage());
                }
            }
        }
        return events;
    }

    public static void writeEvents(List<Event> events) throws IOException {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(EVENTS_FILE))) {
            for (Event event : events) {
                writer.write(event.toString());
                writer.newLine();
            }
        }
    }

    public static List<Booking> readBookings() throws IOException {
        List<Booking> bookings = new ArrayList<>();
        File file = new File(BOOKINGS_FILE);
        if (!file.exists()) return bookings;

        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                bookings.add(Booking.fromString(line));
            }
        }
        return bookings;
    }

    public static void writeBooking(Booking booking) throws IOException {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(BOOKINGS_FILE, true))) {
            writer.write(booking.toString());
            writer.newLine();
        }
    }
}