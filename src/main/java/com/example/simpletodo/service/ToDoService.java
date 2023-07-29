package com.example.simpletodo.service;

import com.example.simpletodo.entity.ToDo;

import java.util.List;

public interface ToDoService {
    public ToDo createTodo(ToDo toDo);
    List<ToDo> getTodolist();
    ToDo getDetail(String id);
}
