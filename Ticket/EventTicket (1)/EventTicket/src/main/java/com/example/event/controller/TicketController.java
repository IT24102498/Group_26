package com.example.event.controller;

import com.example.event.model.Ticket;
import com.example.event.service.TicketService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/tickets")
public class TicketController {
    @Autowired
    private TicketService ticketService;

    @GetMapping
    public String listTickets(Model model) {
        model.addAttribute("tickets", ticketService.getAllTickets());
        return "ticket-list";
    }

    @GetMapping("/add")
    public String showAddForm(Model model) {
        model.addAttribute("ticket", new Ticket());
        return "add-ticket";
    }

    @PostMapping("/add")
    public String addTicket(@ModelAttribute("ticket") Ticket ticket, Model model) {
        ticketService.saveTicket(ticket);
        model.addAttribute("ticket", ticket);
        return "tickets"; // Redirect to tickets.html to show confirmation
    }

    @GetMapping("/edit/{ticketId}")
    public String showEditForm(@PathVariable String ticketId, Model model) {
        Ticket ticket = ticketService.getTicketById(ticketId);
        if (ticket == null) {
            return "redirect:/tickets";
        }
        model.addAttribute("ticket", ticket);
        return "edit-ticket";
    }

    @PostMapping("/edit/{ticketId}")
    public String editTicket(@PathVariable String ticketId, @ModelAttribute("ticket") Ticket ticket, Model model) {
        ticket.setTicketId(ticketId);
        ticketService.saveTicket(ticket);
        model.addAttribute("ticket", ticket);
        return "tickets"; // Redirect to tickets.html to show updated ticket
    }

    @GetMapping("/delete/{ticketId}")
    public String deleteTicket(@PathVariable String ticketId) {
        ticketService.deleteTicket(ticketId);
        return "redirect:/tickets";
    }

    @GetMapping("/ticket/{ticketId}")
    public String viewTicket(@PathVariable String ticketId, Model model) {
        Ticket ticket = ticketService.getTicketById(ticketId);
        model.addAttribute("ticket", ticket);
        return "tickets";
    }
}