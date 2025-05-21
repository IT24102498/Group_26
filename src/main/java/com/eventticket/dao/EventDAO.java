package com.eventticket.dao;

import com.eventticket.model.Event;
import java.io.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;
import java.util.stream.Collectors;

public class EventDAO {
    private static final String RESOURCE_PATH = "/events.txt";
    private static final DateTimeFormatter DATE_FORMATTER = DateTimeFormatter.ISO_LOCAL_DATE_TIME;
    private List<Event> events;

    public EventDAO() {
        this.events = new ArrayList<>();
        loadEventsFromResource();
    }

    private void loadEventsFromResource() {
        try (InputStream is = getClass().getResourceAsStream(RESOURCE_PATH);
             BufferedReader reader = new BufferedReader(new InputStreamReader(is))) {

            String line;
            while ((line = reader.readLine()) != null) {
                Event event = stringToEvent(line);
                if (event != null && event.getDateTime().isAfter(LocalDateTime.now())) {
                    events.add(event);
                }
            }
            // Sort by date by default
            events.sort(Comparator.comparing(Event::getDateTime));
        } catch (IOException e) {
            System.err.println("Error loading events from resources: " + e.getMessage());
        }
    }

    public List<Event> getAllEvents() {
        return new ArrayList<>(events);
    }

    public List<Event> searchEvents(String query) {
        String lowerQuery = query.toLowerCase();
        return events.stream()
                .filter(event -> event.getName().toLowerCase().contains(lowerQuery) ||
                        event.getDescription().toLowerCase().contains(lowerQuery) ||
                        event.getVenue().toLowerCase().contains(lowerQuery) ||
                        event.getCategory().toLowerCase().contains(lowerQuery))
                .collect(Collectors.toList());
    }

    private Event stringToEvent(String line) {
        try {
            String[] parts = line.split(",");
            if (parts.length < 9) return null;

            return new Event(
                    parts[0], parts[1], parts[2],
                    LocalDateTime.parse(parts[3], DATE_FORMATTER),
                    parts[4], Double.parseDouble(parts[5]),
                    Integer.parseInt(parts[6]), parts[7], parts[8]
            );
        } catch (Exception e) {
            System.err.println("Error parsing event: " + e.getMessage());
            return null;
        }
    }

    public Event findEventById(String id) {
        return events.stream()
                .filter(event -> event.getId().equals(id))
                .findFirst()
                .orElse(null);
    }
}