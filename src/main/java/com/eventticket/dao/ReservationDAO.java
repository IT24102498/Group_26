package com.eventticket.dao;

import com.eventticket.model.Reservation;
import com.eventticket.model.Seat;
import java.io.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;
import java.util.stream.Collectors;

public class ReservationDAO {
    private static final String FILE_PATH = "reservations.txt";
    private static final DateTimeFormatter DATE_FORMATTER = DateTimeFormatter.ISO_LOCAL_DATE_TIME;
    private Map<String, Reservation> reservations;
    private SeatDAO seatDAO;

    public ReservationDAO(SeatDAO seatDAO) {
        this.reservations = new HashMap<>();
        this.seatDAO = seatDAO;
        loadReservationsFromFile();
    }

    private void loadReservationsFromFile() {
        File file = new File(FILE_PATH);
        if (!file.exists()) {
            return;
        }

        try (BufferedReader reader = new BufferedReader(new FileReader(FILE_PATH))) {
            String line;
            while ((line = reader.readLine()) != null) {
                Reservation reservation = stringToReservation(line);
                if (reservation != null) {
                    reservations.put(reservation.getId(), reservation);
                }
            }
        } catch (IOException e) {
            System.err.println("Error loading reservations: " + e.getMessage());
        }
    }

    private void saveReservationsToFile() {
        try (PrintWriter out = new PrintWriter(new FileWriter(FILE_PATH))) {
            for (Reservation reservation : reservations.values()) {
                out.println(reservationToString(reservation));
            }
        } catch (IOException e) {
            System.err.println("Error saving reservations: " + e.getMessage());
        }
    }

    public Reservation createReservation(String eventId, String userId, List<String> seatIds) {
        List<Seat> seats = seatIds.stream()
                .map(seatId -> seatDAO.findSeatById(eventId, seatId))
                .filter(Objects::nonNull)
                .collect(Collectors.toList());

        if (seats.isEmpty()) {
            return null;
        }

        double totalAmount = seats.stream()
                .mapToDouble(Seat::getPrice)
                .sum();

        String reservationId = "RES-" + System.currentTimeMillis();
        Reservation reservation = new Reservation(
                reservationId,
                eventId,
                userId,
                LocalDateTime.now(),
                totalAmount,
                "confirmed",
                seats
        );

        reservations.put(reservationId, reservation);
        saveReservationsToFile();
        return reservation;
    }

    public Reservation getReservation(String reservationId) {
        return reservations.get(reservationId);
    }

    public boolean cancelReservation(String reservationId) {
        Reservation reservation = reservations.get(reservationId);
        if (reservation == null) {
            return false;
        }

        reservation.setStatus("cancelled");
        reservation.getSeats().forEach(seat -> seat.setStatus("available"));
        saveReservationsToFile();
        seatDAO.saveSeatsToFile(); // Update seat statuses
        return true;
    }

    public boolean modifyReservationSeats(String reservationId, List<String> newSeatIds) {
        Reservation reservation = reservations.get(reservationId);
        if (reservation == null) {
            return false;
        }

        // Release old seats
        reservation.getSeats().forEach(seat -> seat.setStatus("available"));

        // Reserve new seats
        List<Seat> newSeats = newSeatIds.stream()
                .map(seatId -> seatDAO.findSeatById(reservation.getEventId(), seatId))
                .filter(Objects::nonNull)
                .filter(seat -> "available".equals(seat.getStatus()))
                .peek(seat -> seat.setStatus("reserved"))
                .collect(Collectors.toList());

        if (newSeats.size() != newSeatIds.size()) {
            return false; // Not all new seats are available
        }

        // Update reservation
        reservation.setSeats(newSeats);
        reservation.setTotalAmount(newSeats.stream().mapToDouble(Seat::getPrice).sum());

        saveReservationsToFile();
        seatDAO.saveSeatsToFile();
        return true;
    }

    private String reservationToString(Reservation reservation) {
        String seatIds = reservation.getSeats().stream()
                .map(Seat::getId)
                .collect(Collectors.joining(";"));

        return String.join(",",
                reservation.getId(),
                reservation.getEventId(),
                reservation.getUserId(),
                reservation.getReservationDate().format(DATE_FORMATTER),
                String.valueOf(reservation.getTotalAmount()),
                reservation.getStatus(),
                seatIds
        );
    }

    private Reservation stringToReservation(String line) {
        try {
            String[] parts = line.split(",");
            if (parts.length < 7) {
                return null;
            }

            Reservation reservation = new Reservation();
            reservation.setId(parts[0]);
            reservation.setEventId(parts[1]);
            reservation.setUserId(parts[2]);
            reservation.setReservationDate(LocalDateTime.parse(parts[3], DATE_FORMATTER));
            reservation.setTotalAmount(Double.parseDouble(parts[4]));
            reservation.setStatus(parts[5]);

            // Load seats from seat DAO
            String[] seatIds = parts[6].split(";");
            List<Seat> seats = Arrays.stream(seatIds)
                    .map(seatId -> seatDAO.findSeatById(reservation.getEventId(), seatId))
                    .filter(Objects::nonNull)
                    .collect(Collectors.toList());

            reservation.setSeats(seats);
            return reservation;
        } catch (Exception e) {
            System.err.println("Error parsing reservation: " + e.getMessage());
            return null;
        }
    }
}