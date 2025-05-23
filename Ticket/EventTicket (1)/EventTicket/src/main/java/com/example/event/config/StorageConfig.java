package com.example.event.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;

import java.nio.file.Path;
import java.nio.file.Paths;

@Configuration
public class StorageConfig {
    @Value("${storage.file.path}")
    private String filePath;

    public String getFilePath() {
        return filePath;
    }

    public Path getEventTicketFile() {
        return Paths.get(filePath);
    }
}