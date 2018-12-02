package com.service;

import com.utils.Page;
import org.junit.Before;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import static org.junit.Assert.*;

public class DefectTypeServiceImpTest {
    private DefectTypeService defectTypeService;
    @Before
    public void setUp() throws Exception {
        ApplicationContext ctx=new ClassPathXmlApplicationContext("spring-config.xml");
        defectTypeService=(DefectTypeService)ctx.getBean("defectTypeService");
    }

    @Test
    public void findAll() {
    }

    @Test
    public void find() {
        Page page=defectTypeService.find(null,1,10);
    }

    @Test
    public void findById() {
    }

    @Test
    public void add() {
    }

    @Test
    public void delete() {
    }

    @Test
    public void delete1() {
    }

    @Test
    public void update() {
    }
}