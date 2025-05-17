package com.eventticket.utils;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.HashMap;
import java.util.Map;

public class UserStore {
    // Map to store users (username: hashed password)
    public static Map<String, String> users = new HashMap<>();

    // Map to store customers (customer ID: Customer object)
    public static Map<String, Customer> customers = new HashMap<>();

    static {
        // Preload with a sample user (username: admin, password: admin)
        users.put("admin", hashPassword("admin"));
        users.put("user", hashPassword("user123")); // Another example user
    }

    // Utility method to hash passwords using SHA-256
    private static String hashPassword(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hashBytes = md.digest(password.getBytes());
            StringBuilder sb = new StringBuilder();
            for (byte b : hashBytes) {
                sb.append(String.format("%02x", b));
            }
            return sb.toString();
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("SHA-256 algorithm not found.", e);
        }
    }

    // Method to add a new customer
    public static void addCustomer(Customer customer) {
        customers.put(customer.getId(), customer);
    }

    // Method to retrieve a customer
    public static Customer getCustomer(String id) {
        return customers.get(id);
    }

    // Method to update customer details
    public static void updateCustomer(Customer customer) {
        customers.put(customer.getId(), customer);
    }

    // Method to delete a customer
    public static void deleteCustomer(String id) {
        customers.remove(id);
    }
}
