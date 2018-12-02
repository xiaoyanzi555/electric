package com.service;

import com.entity.ComsumeTask;
import com.utils.Page;
import org.junit.Before;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import static org.junit.Assert.*;

public class ComsumeTaskServiceImpTest {
    private ComsumeTaskService comsumeTaskService;
    @Before
    public void setUp() throws Exception {
        ApplicationContext ctx=new ClassPathXmlApplicationContext("spring-config.xml");
        comsumeTaskService=(ComsumeTaskService)ctx.getBean("comsumeTaskService");
    }

    @Test
    public void findAll() {
    }

    @Test
    public void find() {
        Page page=comsumeTaskService.findNoDis(new ComsumeTask(),1,10);
        System.out.println(1);
    }

    @Test
    public void findById() {
        ComsumeTask comsumeTask=new ComsumeTask();
        comsumeTask.setId(1);
        ComsumeTask cc=comsumeTaskService.findById(1);
        System.out.println(1);
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