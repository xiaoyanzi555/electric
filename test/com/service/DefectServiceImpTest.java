package com.service;

import com.entity.Defect;
import com.utils.Page;
import org.junit.Before;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import java.util.List;

import static org.junit.Assert.*;

public class DefectServiceImpTest {
    private DefectService defectService;
    @Before
    public void setUp() throws Exception {
        ApplicationContext ctx=new ClassPathXmlApplicationContext("spring-config.xml");
        defectService=(DefectService)ctx.getBean("defectService");
    }

    @Test
    public void findAll() {
        List list=defectService.findAll();
        System.out.println(11);
    }

    @Test
    public void find() {
        Defect defect=new Defect();
        defect.setTask_code("XW001");
        Page page=defectService.find(null,1,10);
        System.out.println(1);
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

    @Test
    public void finByEntity() {
        Defect defect=new Defect();
        defect.setTask_id(18);
        Defect dd=defectService.finByEntity(defect);
        System.out.println(11);
    }
}