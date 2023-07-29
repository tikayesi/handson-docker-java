package com.example.simpletodo.controller;

import com.example.simpletodo.entity.ToDo;
import com.example.simpletodo.service.ToDoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
public class ToDoController {
    ToDoService toDoService;

    @Autowired
    public ToDoController(ToDoService toDoService) {
        this.toDoService = toDoService;
    }

    @PostMapping("/todos")
    public ToDo save(@RequestBody ToDo toDo){
        return toDoService.createTodo(toDo);
    }

    @GetMapping("/todos")
    public List<ToDo> getList(){
        return toDoService.getTodolist();
    }

    @GetMapping("/todos/{id}")
    public ToDo getDetail(@PathVariable String id){
        return toDoService.getDetail(id);
    }

}
