package com.eventticket.utils;

import com.eventticket.model.Customer;

import javax.servlet.ServletContext;
import java.io.*;
import java.util.HashMap;
import java.util.Map;

public class UserStore {
    // Map to store customers (customer ID: Customer object)
    public static Map<String, Customer> customers = new HashMap<>();
    private static final String USERS_FILE = "/WEB-INF/data/users.txt";
    public static Map<String, String> users;

    // Load users from users.txt file
    public static synchronized Map<String, String[]> loadUsers(ServletContext context) {
        Map<String, String[]> users = new HashMap<>();
        String filePath = context.getRealPath(USERS_FILE);

        if (filePath == null) {
            System.err.println("ServletContext returned null for path: " + USERS_FILE);
            throw new RuntimeException("Unable to resolve path for users.txt in project directory.");
        }

        System.out.println("Attempting to load users from: " + filePath);
        File file = new File(filePath);

        // Validate that the file path is within the project directory
        String contextPath = context.getRealPath("/");
        if (!file.getAbsolutePath().startsWith(contextPath)) {
            System.err.println("File path " + file.getAbsolutePath() + " is outside project directory: " + contextPath);
            throw new RuntimeException("File path is not within the project directory.");
        }

        // Ensure the parent directory exists
        if (!file.getParentFile().exists()) {
            System.out.println("Creating directory: " + file.getParentFile().getAbsolutePath());
            if (!file.getParentFile().mkdirs()) {
                System.err.println("Failed to create directory: " + file.getParentFile().getAbsolutePath());
                throw new RuntimeException("Failed to create directory for users.txt.");
            }
        }

        // Create the file with sample users if it doesn't exist
        if (!file.exists()) {
            System.out.println("users.txt does not exist, creating with sample users");
            try (BufferedWriter writer = new BufferedWriter(new FileWriter(file))) {
                writer.write("admin:admin:admin@example.com\n");
                writer.write("user:user123:user@example.com\n");
                System.out.println("Created users.txt with sample users at: " + file.getAbsolutePath());
            } catch (IOException e) {
                System.err.println("Failed to create users.txt: " + e.getMessage());
                e.printStackTrace();
                throw new RuntimeException("Failed to create users.txt file.", e);
            }
        }

        // Read the file
        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                if (!line.trim().isEmpty()) {
                    String[] parts = line.split(":", 3);
                    if (parts.length == 3) {
                        users.put(parts[0], new String[]{parts[1], parts[2]});
                    }
                }
            }
            System.out.println("Loaded " + users.size() + " users from users.txt at: " + file.getAbsolutePath());
        } catch (IOException e) {
            System.err.println("Failed to read users.txt: " + e.getMessage());
            e.printStackTrace();
            throw new RuntimeException("Failed to read users.txt file.", e);
        }
        return users;
    }

    // Save users to users.txt file
    public static synchronized void saveUsers(Map<String, String[]> users, ServletContext context) {
        String filePath = context.getRealPath(USERS_FILE);

        if (filePath == null) {
            System.err.println("ServletContext returned null for path: " + USERS_FILE);
            throw new RuntimeException("Unable to resolve path for users.txt in project directory.");
        }

        System.out.println("Saving users to: " + filePath);
        File file = new File(filePath);

        // Validate that the file path is within the project directory
        String contextPath = context.getRealPath("/");
        if (!file.getAbsolutePath().startsWith(contextPath)) {
            System.err.println("File path " + file.getAbsolutePath() + " is outside project directory: " + contextPath);
            throw new RuntimeException("File path is not within the project directory.");
        }

        // Ensure the parent directory exists
        if (!file.getParentFile().exists()) {
            System.out.println("Creating directory: " + file.getParentFile().getAbsolutePath());
            if (!file.getParentFile().mkdirs()) {
                System.err.println("Failed to create directory: " + file.getParentFile().getAbsolutePath());
                throw new RuntimeException("Failed to create directory for users.txt.");
            }
        }

        // Write to the file
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(file))) {
            for (Map.Entry<String, String[]> entry : users.entrySet()) {
                writer.write(entry.getKey() + ":" + entry.getValue()[0] + ":" + entry.getValue()[1] + "\n");
            }
            System.out.println("Users saved successfully to: " + file.getAbsolutePath());
        } catch (IOException e) {
            System.err.println("Failed to write to users.txt: " + e.getMessage());
            e.printStackTrace();
            throw new RuntimeException("Failed to write to users.txt file.", e);
        }
    }

    // Add a new user
    public static synchronized void addUser(String username, String password, String email, ServletContext context) {
        System.out.println("Adding user: " + username);
        Map<String, String[]> users = loadUsers(context);
        users.put(username, new String[]{password, email});
        saveUsers(users, context);
        System.out.println("User saved: " + username);
    }

    // Check if a user exists
    public static synchronized boolean userExists(String username, ServletContext context) {
        boolean exists = loadUsers(context).containsKey(username);
        System.out.println("Checking user existence: " + username + " -> " + exists);
        return exists;
    }

    // Validate user credentials
    public static synchronized boolean validateUser(String username, String password, ServletContext context) {
        Map<String, String[]> users = loadUsers(context);
        if (!users.containsKey(username)) {
            return false;
        }
        boolean valid = password.equals(users.get(username)[0]);
        System.out.println("Validating user: " + username + " -> " + valid);
        return valid;
    }

    // Get user email
    public static synchronized String getUserEmail(String username, ServletContext context) {
        Map<String, String[]> users = loadUsers(context);
        if (!users.containsKey(username)) {
            return null;
        }
        return users.get(username)[1];
    }

    // Methods for customer management (unchanged)
    public static void addCustomer(Customer customer) {
        customers.put(customer.getId(), customer);
    }

    public static Customer getCustomer(String id) {
        return customers.get(id);
    }

    public static void updateCustomer(Customer customer) {
        customers.put(customer.getId(), customer);
    }

    public static void deleteCustomer(String id) {
        customers.remove(id);
    }
}