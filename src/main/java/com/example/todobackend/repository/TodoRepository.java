package com.example.todobackend.repository;

import com.example.todobackend.entity.Todo;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface TodoRepository extends JpaRepository<Todo, Long> {
    // Ekstra method gerekmez, CRUD hazır
}