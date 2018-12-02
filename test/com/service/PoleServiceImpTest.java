package com.service;

import com.entity.Pole;
import com.utils.Page;
import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import java.util.List;
import java.util.Map;

import static org.junit.Assert.*;

public class PoleServiceImpTest {
    private PoleService poleService;
    @Before
    public void setUp() throws Exception {
        ApplicationContext ctx=new ClassPathXmlApplicationContext("spring-config.xml");
        poleService=(PoleService)ctx.getBean("poleService");
    }

    @Test
    public void findAll() {
       Pole pole=new Pole();
       pole.setLine_id(11);
       List list=poleService.findByEntity(pole);
        System.out.println(11);
    }

    @Test
    public void find() {
        Pole pole=new Pole();
        pole.setLine_id(6);
        Page page=poleService.find(pole,1,10);
        Assert.assertNotNull(page);
    }

    @Test
    public void count() {
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