package com.example.todobackend.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import lombok.Data;

@Entity // Bu sınıf veritabanı tablosu olacak
@Data   // Lombok: Otomatik getter/setter/toString
public class Todo {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY) // Otomatik ID
    private Long id;
    private String title;      // Görev başlığı
    private String description; // Açıklama
    private boolean completed; // Tamamlanmış mı?
}