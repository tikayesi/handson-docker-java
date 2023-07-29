package com.example.simpletodo.service;

import com.example.simpletodo.entity.ToDo;
import com.example.simpletodo.repository.ToDoRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ToDoServiceImpl implements ToDoService{

    ToDoRepository toDoRepository;

    @Autowired
    public ToDoServiceImpl(ToDoRepository toDoRepository) {
        this.toDoRepository = toDoRepository;
    }

    @Override
    public ToDo createTodo(ToDo toDo) {
        return toDoRepository.save(toDo);
    }

    @Override
    public List<ToDo> getTodolist() {
        return toDoRepository.findAll();
    }

    @Override
    public ToDo getDetail(String id) {
        return toDoRepository.findById(id).get();
    }
}
