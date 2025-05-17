package com.eventticket.dao;

import com.eventticket.model.Seat;
import java.io.*;
import java.time.format.DateTimeFormatter;
import java.util.*;
import java.util.stream.Collectors;

public class SeatDAO {
    private static final String FILE_PATH = "seats.txt";
    private static final DateTimeFormatter DATE_FORMATTER = DateTimeFormatter.ISO_LOCAL_DATE_TIME;
    private Map<String, List<Seat>> seatsByEvent;

    public SeatDAO() {
        this.seatsByEvent = new HashMap<>();
        loadSeatsFromFile();
    }

    private void loadSeatsFromFile() {
        File file = new File(FILE_PATH);
        if (!file.exists()) {
            return;
        }

        try (BufferedReader reader = new BufferedReader(new FileReader(FILE_PATH))) {
            String line;
            while ((line = reader.readLine()) != null) {
                Seat seat = stringToSeat(line);
                if (seat != null) {
                    seatsByEvent.computeIfAbsent(seat.getEventId(), k -> new ArrayList<>()).add(seat);
                }
            }
        } catch (IOException e) {
            System.err.println("Error loading seats: " + e.getMessage());
        }
    }

    public void saveSeatsToFile() {
        try (PrintWriter out = new PrintWriter(new FileWriter(FILE_PATH))) {
            for (List<Seat> seats : seatsByEvent.values()) {
                for (Seat seat : seats) {
                    out.println(seatToString(seat));
                }
            }
        } catch (IOException e) {
            System.err.println("Error saving seats: " + e.getMessage());
        }
    }

    public List<Seat> getSeatsByEvent(String eventId) {
        return seatsByEvent.getOrDefault(eventId, new ArrayList<>());
    }

    public Seat findSeatById(String eventId, String seatId) {
        return getSeatsByEvent(eventId).stream()
                .filter(seat -> seat.getId().equals(seatId))
                .findFirst()
                .orElse(null);
    }

    public void addSeats(String eventId, String section, String row, List<Integer> seatNumbers, String type, double basePrice) {
        List<Seat> eventSeats = seatsByEvent.computeIfAbsent(eventId, k -> new ArrayList<>());

        for (int number : seatNumbers) {
            String seatId = section.charAt(0) + "-" + row + "-" + number;
            double price = "vip".equalsIgnoreCase(type) ? basePrice * 1.5 : basePrice;

            // Check if seat already exists
            boolean exists = eventSeats.stream()
                    .anyMatch(s -> s.getSection().equals(section) &&
                            s.getRow().equals(row) &&
                            s.getNumber() == number);

            if (!exists) {
                Seat newSeat = new Seat(seatId, eventId, section, row, number, "available", type, price);
                eventSeats.add(newSeat);
            }
        }

        saveSeatsToFile();
    }

    public boolean reserveSeats(String eventId, List<String> seatIds, String userId) {
        List<Seat> seatsToReserve = getSeatsByEvent(eventId).stream()
                .filter(seat -> seatIds.contains(seat.getId()) && "available".equals(seat.getStatus()))
                .collect(Collectors.toList());

        if (seatsToReserve.size() != seatIds.size()) {
            return false; // Not all seats are available
        }

        seatsToReserve.forEach(seat -> seat.setStatus("reserved"));
        saveSeatsToFile();
        return true;
    }

    public boolean modifyReservation(String reservationId, String action, List<String> newSeatIds) {
        // In a real implementation, you would update the reservation and seats
        // This is a simplified version
        return true;
    }

    private String seatToString(Seat seat) {
        return String.join(",",
                seat.getId(),
                seat.getEventId(),
                seat.getSection(),
                seat.getRow(),
                String.valueOf(seat.getNumber()),
                seat.getStatus(),
                seat.getType(),
                String.valueOf(seat.getPrice())
        );
    }

    private Seat stringToSeat(String line) {
        try {
            String[] parts = line.split(",");
            if (parts.length < 8) {
                return null;
            }

            Seat seat = new Seat();
            seat.setId(parts[0]);
            seat.setEventId(parts[1]);
            seat.setSection(parts[2]);
            seat.setRow(parts[3]);
            seat.setNumber(Integer.parseInt(parts[4]));
            seat.setStatus(parts[5]);
            seat.setType(parts[6]);
            seat.setPrice(Double.parseDouble(parts[7]));

            return seat;
        } catch (Exception e) {
            System.err.println("Error parsing seat: " + e.getMessage());
            return null;
        }
    }
}