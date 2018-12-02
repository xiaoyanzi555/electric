package com.service;

import com.entity.Inspection;
import com.utils.Page;
import org.junit.Before;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import java.util.List;

import static org.junit.Assert.*;

public class InspectionServiceImpTest {
    private InspectionService inspectionService;
    @Before
    public void setUp() throws Exception {
        ApplicationContext ctx=new ClassPathXmlApplicationContext("spring-config.xml");
        inspectionService=(InspectionService)ctx.getBean("inspectionService");
    }

    @Test
    public void findAll() {
    }

    @Test
    public void find() {
        Inspection inspection=new Inspection();
        inspection.setLeader_id(13);
        Page list=inspectionService.findExceptNoDis(inspection,1,10);
        System.out.println(list);

    }

    @Test
    public void findById() {
        Inspection inspection=inspectionService.findById(17);
        System.out.println(11);
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
        Inspection inspection=new Inspection();
        inspection.setId(21);
        inspectionService.update(inspection);
    }
}