package com.service;

import com.entity.WorkTask;
import com.utils.Page;
import org.junit.Before;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import static org.junit.Assert.*;

public class WorkTaskServiceImpTest {
    private WorkTaskService workTaskService;
    @Before
    public void setUp() throws Exception {
        ApplicationContext ctx=new ClassPathXmlApplicationContext("spring-config.xml");
        workTaskService=(WorkTaskService)ctx.getBean("workTaskService");
    }

    @Test
    public void findAll() {
    }

    @Test
    public void find() {

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
        WorkTask workTask=new WorkTask();
        workTask.setWait_task_id(11);
        workTaskService.deleteByEntity(workTask);
    }

    @Test
    public void update() {
    }
}