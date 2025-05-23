package com.example.event.repository;

import com.example.event.config.StorageConfig;
import com.example.event.model.Ticket;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.io.*;
import java.nio.file.Path;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

@Repository
public class EventTicketFileRepository {
    private final Path filePath;
    private static final DateTimeFormatter formatter = DateTimeFormatter.ISO_LOCAL_DATE_TIME;

    @Autowired
    public EventTicketFileRepository(StorageConfig storageConfig) {
        this.filePath = storageConfig.getEventTicketFile();
    }

    public List<Ticket> findAll() {
        List<Ticket> tickets = new ArrayList<>();
        File file = filePath.toFile();
        if (!file.exists()) {
            return tickets;
        }

        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",");
                if (parts.length == 7) {
                    Ticket ticket = new Ticket(
                            parts[0], // ticketId
                            parts[1], // attendeeName
                            parts[2], // eventName
                            parts[3], // ticketType
                            parts[4], // seatNumber
                            LocalDateTime.parse(parts[5], formatter), // eventDateTime
                            Double.parseDouble(parts[6]) // ticketPrice
                    );
                    tickets.add(ticket);
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return tickets;
    }

    public void save(Ticket ticket) {
        List<Ticket> tickets = findAll();
        // Remove existing ticket with the same ticketId, if it exists
        tickets.removeIf(t -> t.getTicketId().equals(ticket.getTicketId()));
        // Add the new or updated ticket
        tickets.add(ticket);

        // Rewrite the entire file
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(filePath.toFile()))) {
            for (Ticket t : tickets) {
                writer.write(String.format("%s,%s,%s,%s,%s,%s,%.2f\n",
                        t.getTicketId(),
                        t.getAttendeeName(),
                        t.getEventName(),
                        t.getTicketType(),
                        t.getSeatNumber(),
                        t.getEventDateTime().format(formatter),
                        t.getTicketPrice()));
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public void delete(String ticketId) {
        List<Ticket> tickets = findAll();
        tickets.removeIf(ticket -> ticket.getTicketId().equals(ticketId));
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(filePath.toFile()))) {
            for (Ticket ticket : tickets) {
                writer.write(String.format("%s,%s,%s,%s,%s,%s,%.2f\n",
                        ticket.getTicketId(),
                        ticket.getAttendeeName(),
                        ticket.getEventName(),
                        ticket.getTicketType(),
                        ticket.getSeatNumber(),
                        ticket.getEventDateTime().format(formatter),
                        ticket.getTicketPrice()));
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}