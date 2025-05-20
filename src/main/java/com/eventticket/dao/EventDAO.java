package com.eventticket.dao;

import com.eventticket.model.Event;
import java.io.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;
import java.util.stream.Collectors;

public class EventDAO {
    private static final String FILE_PATH = "events.txt";
    private static final DateTimeFormatter DATE_FORMATTER = DateTimeFormatter.ISO_LOCAL_DATE_TIME;
    private Queue<Event> eventQueue;

    public EventDAO() {
        this.eventQueue = new PriorityQueue<>(
                Comparator.comparing(Event::getDateTime)
        );
        loadEventsFromFile();
        removePastEvents();
    }

    private void loadEventsFromFile() {
        File file = new File(FILE_PATH);
        if (!file.exists()) {
            return;
        }

        try (BufferedReader reader = new BufferedReader(new FileReader(FILE_PATH))) {
            String line;
            while ((line = reader.readLine()) != null) {
                Event event = stringToEvent(line);
                if (event != null) {
                    eventQueue.add(event);
                }
            }
        } catch (IOException e) {
            System.err.println("Error loading events: " + e.getMessage());
        }
    }

    private void saveEventsToFile() {
        try (PrintWriter out = new PrintWriter(new FileWriter(FILE_PATH))) {
            for (Event event : eventQueue) {
                out.println(eventToString(event));
            }
        } catch (IOException e) {
            System.err.println("Error saving events: " + e.getMessage());
        }
    }

    private void removePastEvents() {
        LocalDateTime now = LocalDateTime.now();
        eventQueue.removeIf(event -> event.getDateTime().isBefore(now));
        saveEventsToFile(); // Update the file after removal
    }

    public void saveEvent(Event event) {
        if (event.getDateTime().isAfter(LocalDateTime.now())) {
            eventQueue.add(event);
            saveEventsToFile();
        }
    }

    public List<Event> getAllEvents() {
        // Return a sorted list of future events
        return eventQueue.stream()
                .sorted(Comparator.comparing(Event::getDateTime))
                .collect(Collectors.toList());
    }

    public List<Event> searchEvents(String query) {
        String lowerQuery = query.toLowerCase();
        return eventQueue.stream()
                .filter(event ->
                        event.getName().toLowerCase().contains(lowerQuery) ||
                                event.getDescription().toLowerCase().contains(lowerQuery) ||
                                event.getVenue().toLowerCase().contains(lowerQuery) ||
                                event.getCategory().toLowerCase().contains(lowerQuery))
                .sorted(Comparator.comparing(Event::getDateTime))
                .collect(Collectors.toList());
    }

    private String eventToString(Event event) {
        return String.join(",",
                event.getId(),
                event.getName(),
                event.getDescription(),
                event.getDateTime().format(DATE_FORMATTER),
                event.getVenue(),
                String.valueOf(event.getPrice()),
                String.valueOf(event.getAvailableTickets()),
                event.getImagePath(),
                event.getCategory()
        );
    }

    private Event stringToEvent(String line) {
        try {
            String[] parts = line.split(",");
            if (parts.length < 9) {
                return null;
            }

            Event event = new Event();
            event.setId(parts[0]);
            event.setName(parts[1]);
            event.setDescription(parts[2]);
            event.setDateTime(LocalDateTime.parse(parts[3], DATE_FORMATTER));
            event.setVenue(parts[4]);
            event.setPrice(Double.parseDouble(parts[5]));
            event.setAvailableTickets(Integer.parseInt(parts[6]));
            event.setImagePath(parts[7]);
            event.setCategory(parts[8]);

            return event;
        } catch (Exception e) {
            System.err.println("Error parsing event: " + e.getMessage());
            return null;
        }
    }

    public Event findEventById(String id) {
        return eventQueue.stream()
                .filter(event -> event.getId().equals(id))
                .findFirst()
                .orElse(null);
    }

        }

