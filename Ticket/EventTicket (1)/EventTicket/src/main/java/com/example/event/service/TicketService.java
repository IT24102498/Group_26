package com.example.event.service;

import com.example.event.model.Ticket;
import com.example.event.repository.EventTicketFileRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.UUID;

@Service
public class TicketService {
    @Autowired
    private EventTicketFileRepository ticketRepository;

    public List<Ticket> getAllTickets() {
        return ticketRepository.findAll();
    }

    public Ticket getTicketById(String ticketId) {
        return ticketRepository.findAll().stream()
                .filter(ticket -> ticket.getTicketId().equals(ticketId))
                .findFirst()
                .orElse(null);
    }

    public void saveTicket(Ticket ticket) {
        if (ticket.getTicketId() == null || ticket.getTicketId().isEmpty()) {
            ticket.setTicketId("TKT-" + UUID.randomUUID().toString().substring(0, 6));
        }
        ticketRepository.save(ticket);
    }

    public void deleteTicket(String ticketId) {
        ticketRepository.delete(ticketId);
    }
}