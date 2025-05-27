package com.eventticket.dao;

import com.eventticket.model.Event;
import java.io.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;

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
            //sort by date using merge sort
            events = mergeSort(events, Comparator.comparing(Event::getDateTime));
        } catch (IOException e) {
            System.err.println("Error loading events from resources: " + e.getMessage());
        }
    }

    public void addEvent(Event event) {
        events.add(event);
        saveEventsToFile();
    }

    public boolean removeEvent(String eventId) {
        boolean removed = events.removeIf(event -> event.getId().equals(eventId));
        if (removed) {
            saveEventsToFile();
        }
        return removed;
    }

    private void saveEventsToFile() {
        try {
            String path = getClass().getResource(RESOURCE_PATH).getPath();
            path = path.replace("%20", " ");
            File file = new File(path);

            try (PrintWriter writer = new PrintWriter(new FileWriter(file))) {
                for (Event event : events) {
                    writer.println(eventToString(event));
                }
            }
        } catch (IOException e) {
            System.err.println("Error saving events to file: " + e.getMessage());
        }
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

    //merge sort
    private List<Event> mergeSort(List<Event> events, Comparator<Event> comparator) {
        if (events.size() <= 1) {
            return new ArrayList<>(events);
        }

        int mid = events.size() / 2;
        List<Event> left = mergeSort(events.subList(0, mid), comparator);
        List<Event> right = mergeSort(events.subList(mid, events.size()), comparator);

        return merge(left, right, comparator);
    }

    private List<Event> merge(List<Event> left, List<Event> right, Comparator<Event> comparator) {
        List<Event> merged = new ArrayList<>();
        int i = 0, j = 0;

        while (i < left.size() && j < right.size()) {
            if (comparator.compare(left.get(i), right.get(j)) <= 0) {
                merged.add(left.get(i++));
            } else {
                merged.add(right.get(j++));
            }
        }

        merged.addAll(left.subList(i, left.size()));
        merged.addAll(right.subList(j, right.size()));

        return merged;
    }

    public List<Event> getAllEvents() {
        return new ArrayList<>(events);
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
        }
        catch (Exception e) {
            System.err.println("Error " + e.getMessage());
            return null;
        }
    }
}