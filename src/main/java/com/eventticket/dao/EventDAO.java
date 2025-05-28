package com.eventticket.dao;

import com.eventticket.model.Event;
import java.io.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class EventDAO {
    private static final String RESOURCE_PATH = "/events.txt";
    private static final DateTimeFormatter DATE_FORMATTER = DateTimeFormatter.ISO_LOCAL_DATE_TIME;
    private static final int MAX_EVENTS = 100;
    private Event[] events;
    private int eventCount;

    public EventDAO() {
        this.events = new Event[MAX_EVENTS];
        this.eventCount = 0;
        loadEventsFromResource();
    }

    private void loadEventsFromResource() {
        try (InputStream is = getClass().getResourceAsStream(RESOURCE_PATH);
             BufferedReader reader = new BufferedReader(new InputStreamReader(is))) {

            String line;
            while ((line = reader.readLine()) != null) {
                Event event = stringToEvent(line);
                if (event != null && event.getDateTime().isAfter(LocalDateTime.now())) {
                    addEventToArray(event);
                }
            }
            mergeSort(events, 0, eventCount - 1);
        } catch (IOException e) {
            System.err.println("Error loading events from resources: " + e.getMessage());
        }
    }

    public void addEvent(Event event) {
        if (eventCount < MAX_EVENTS) {
            addEventToArray(event);
            saveEventsToFile();
        } else {
            System.out.println("Cannot add event: Maximum event limit reached.");
        }
    }

    private void addEventToArray(Event event) {
        if (eventCount < MAX_EVENTS) {
            events[eventCount++] = event;
        }
    }

    public boolean removeEvent(String eventId) {
        boolean removed = false;
        for (int i = 0; i < eventCount; i++) {
            if (events[i].getId().equals(eventId)) {
                System.arraycopy(events, i + 1, events, i, eventCount - i - 1);
                events[--eventCount] = null;
                removed = true;
                break;
            }
        }
        if (removed) {
            saveEventsToFile();
        }
        return removed;
    }

    private void saveEventsToFile() {
        try {
            String path = getClass().getResource(RESOURCE_PATH).getPath();
            path = path.replace("%20", "src/main/resources/events.txt");
            File file = new File(path);

            try (PrintWriter writer = new PrintWriter(new FileWriter(file))) {
                for (int i = 0; i < eventCount; i++) {
                    writer.println(eventToString(events[i]));
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

    private void mergeSort(Event[] arr, int left, int right) {
        if (left < right) {
            int mid = (left + right) / 2;
            mergeSort(arr, left, mid);
            mergeSort(arr, mid + 1, right);
            merge(arr, left, mid, right);
        }
    }

    private void merge(Event[] arr, int left, int mid, int right) {
        Event[] temp = new Event[right - left + 1];
        int i = left, j = mid + 1, k = 0;

        while (i <= mid && j <= right) {
            if (arr[i].getDateTime().compareTo(arr[j].getDateTime()) <= 0) {
                temp[k++] = arr[i++];
            } else {
                temp[k++] = arr[j++];
            }
        }

        while (i <= mid) {
            temp[k++] = arr[i++];
        }

        while (j <= right) {
            temp[k++] = arr[j++];
        }

        for (i = left; i <= right; i++) {
            arr[i] = temp[i - left];
        }
    }

    public Event[] getAllEvents() {
        Event[] result = new Event[eventCount];
        System.arraycopy(events, 0, result, 0, eventCount);
        return result;
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
            System.err.println("Error: " + e.getMessage());
            return null;
        }
    }
}
