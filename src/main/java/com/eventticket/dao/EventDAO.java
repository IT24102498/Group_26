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
            //sort by date using merge sort
            events = mergeSort(events, Comparator.comparing(Event::getDateTime));
        } catch (IOException e) {
            System.err.println("Error loading events from resources: " + e.getMessage());
        }
    }

    //merge sort for sorting
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