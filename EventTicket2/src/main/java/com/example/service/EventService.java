package com.example.service;

import com.example.model.Event;
import com.example.util.FileUtil;
import com.example.util.MergeSortUtil;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

public class EventService {
    public List<Event> getEvents(String sortBy) throws IOException {
        List<Event> events = FileUtil.readEvents();
        if (sortBy != null && sortBy.equals("popularity")) {
            MergeSortUtil.mergeSortByPopularity(events, 0, events.size() - 1);
        } else {
            MergeSortUtil.mergeSortByDate(events, 0, events.size() - 1);
        }
        return events;
    }

    public void addEvent(Event event) throws IOException {
        List<Event> events = FileUtil.readEvents();
        events.add(event);
        FileUtil.writeEvents(events);
    }

    public Event getEventById(String id) throws IOException {
        List<Event> events = FileUtil.readEvents();
        return events.stream().filter(e -> e.getId().equals(id)).findFirst().orElse(null);
    }
}