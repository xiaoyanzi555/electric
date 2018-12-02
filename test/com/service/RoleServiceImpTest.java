package com.service;

import com.entity.Role;
import org.junit.Before;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import static org.junit.Assert.*;

public class RoleServiceImpTest {
    private RoleService roleService;
    @Before
    public void setUp() throws Exception {
        ApplicationContext ctx=new ClassPathXmlApplicationContext("spring-config.xml");
        roleService=(RoleService)ctx.getBean("roleService");
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
    }

    @Test
    public void update() {
    }

    @Test
    public void findEntity() {
        Role role=new Role();
        role.setRole_name("巡检员");
        Role r=roleService.findEntity(role);
        System.out.println(1);
    }
}