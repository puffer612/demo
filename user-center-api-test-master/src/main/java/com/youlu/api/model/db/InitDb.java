package com.youlu.api.model.db;

import lombok.Data;

import java.util.List;

@Data
public class InitDb {
    private String dbName;
    private List<InitTable> tables;
}

