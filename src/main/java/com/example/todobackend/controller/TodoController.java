package com.example.todobackend.controller;

import com.example.todobackend.entity.Todo;
import com.example.todobackend.service.TodoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController // REST API için
@RequestMapping("/api/todos") // Base URL
@CrossOrigin(origins = "*") // Frontend CORS için (React localhost)
public class TodoController {
    @Autowired
    private TodoService todoService;

    @GetMapping // Tüm todos'u getir
    public List<Todo> getAllTodos() {
        return todoService.getAllTodos();
    }

    @PostMapping // Yeni todo ekle
    public Todo createTodo(@RequestBody Todo todo) {
        return todoService.createTodo(todo);
    }

    @GetMapping("/{id}") // ID'ye göre getir
    public ResponseEntity<Todo> getTodoById(@PathVariable Long id) {
        return todoService.getTodoById(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @PutMapping("/{id}") // Güncelle
    public ResponseEntity<Todo> updateTodo(@PathVariable Long id, @RequestBody Todo todoDetails) {
        return ResponseEntity.ok(todoService.updateTodo(id, todoDetails));
    }

    @DeleteMapping("/{id}") // Sil
    public ResponseEntity<Void> deleteTodo(@PathVariable Long id) {
        todoService.deleteTodo(id);
        return ResponseEntity.noContent().build();
    }
}