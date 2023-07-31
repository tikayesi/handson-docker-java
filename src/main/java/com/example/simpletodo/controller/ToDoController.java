package com.example.simpletodo.controller;

import org.springframework.web.bind.annotation.*;


@RestController
public class ToDoController {

    @GetMapping("/todos")
    public String getDetail(){
        return "Hello world!";
    }

}
