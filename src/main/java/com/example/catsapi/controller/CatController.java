package com.example.catsapi.controller;

import com.example.catsapi.dto.CatDto;
import com.example.catsapi.entity.Cat;
import com.example.catsapi.service.CatService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/cats")
@RequiredArgsConstructor
public class CatController {

    private final CatService catService;

    @PostMapping
    public Cat save(@RequestBody CatDto cat){
        return catService.save(cat);
    }

    @GetMapping
    @PostMapping
    public Iterable<Cat> getAll(){
        return catService.getAll();
    }
}
