package com.example.service;

import com.example.model.Booking;
import com.example.util.FileUtil;

import java.io.IOException;
import java.util.LinkedList;
import java.util.Queue;
import java.util.List;

public class BookingService {
    private Queue<Booking> bookingQueue = new LinkedList<>();

    public void addBookingToQueue(Booking booking) {
        bookingQueue.offer(booking);
    }

    public void processBookings() throws IOException {
        while (!bookingQueue.isEmpty()) {
            Booking booking = bookingQueue.poll();
            FileUtil.writeBooking(booking);
        }
    }

    public List<Booking> getBookings() throws IOException {
        return FileUtil.readBookings();
    }
}