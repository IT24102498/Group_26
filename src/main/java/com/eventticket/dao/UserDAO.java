package com.eventticket.dao;

import com.eventticket.model.User;
import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {
    private static final String FILE_PATH = "users.txt";

    // Save a user to file
    public void saveUser(User user) throws IOException {
        try (PrintWriter out = new PrintWriter(new FileWriter(FILE_PATH, true))) {
            out.println(userToString(user));
        }
    }

    // Find user by username
    public User findUserByUsername(String username) throws IOException {
        File file = new File(FILE_PATH);
        if (!file.exists()) {
            return null;
        }

        try (BufferedReader reader = new BufferedReader(new FileReader(FILE_PATH))) {
            String line;
            while ((line = reader.readLine()) != null) {
                User user = stringToUser(line);
                if (user != null && user.getUsername().equals(username)) {
                    return user;
                }
            }
        }
        return null;
    }

    // Get all users
    public List<User> getAllUsers() throws IOException {
        List<User> users = new ArrayList<>();
        File file = new File(FILE_PATH);

        if (!file.exists()) {
            return users;
        }

        try (BufferedReader reader = new BufferedReader(new FileReader(FILE_PATH))) {
            String line;
            while ((line = reader.readLine()) != null) {
                User user = stringToUser(line);
                if (user != null) {
                    users.add(user);
                }
            }
        }
        return users;
    }

    // Update user information
    public void updateUser(User updatedUser) throws IOException {
        List<User> users = getAllUsers();
        for (int i = 0; i < users.size(); i++) {
            if (users.get(i).getId().equals(updatedUser.getId())) {
                users.set(i, updatedUser);
                break;
            }
        }

        // Rewrite all users to file
        try (PrintWriter out = new PrintWriter(new FileWriter(FILE_PATH))) {
            for (User user : users) {
                out.println(userToString(user));
            }
        }
    }

    // Convert User object to string
    private String userToString(User user) {
        return String.join(",",
                user.getId(),
                user.getUsername(),
                user.getPassword(),
                user.getEmail(),
                user.getFullName(),
                user.getRole()
        );
    }

    // Convert string to User object
    private User stringToUser(String line) {
        try {
            String[] parts = line.split(",");
            if (parts.length < 6) {
                return null;
            }
            return new User(parts[0], parts[1], parts[2], parts[3], parts[4], parts[5]);
        } catch (Exception e) {
            System.err.println("Error parsing user: " + e.getMessage());
            return null;
        }
    }
}