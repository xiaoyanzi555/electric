package com.service;

import com.entity.Line;
import com.utils.Page;
import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import static org.junit.Assert.*;

public class LineServiceImpTest {
    private LineService lineService;
    @Before
    public void setUp() throws Exception {
        ApplicationContext ctx=new ClassPathXmlApplicationContext("spring-config.xml");
        lineService=(LineService)ctx.getBean("lineService");
    }

    @Test
    public void findAll() {

    }

    @Test
    public void find() {
        Page page=lineService.find(null,1,10);
        Assert.assertNotNull(page);
    }

    @Test
    public void findById() {
    }

    @Test
    public void add() {
        Line line=new Line();
        line.setStart_pole("mc0010");
        line.setEnd_pole("mc0020");
        line.setLine_code("mc5b");
        lineService.add(line);
    }

    @Test
    public void delete() {
    }

    @Test
    public void delete1() {
    }

    @Test
    public void update() {
        Line line=new Line();
        line.setLine_name("111");
        line.setLine_code("XW001121112");
        line.setId(7);
        lineService.update(line);
    }
}