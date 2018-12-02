package com.service;

import com.alibaba.fastjson.JSON;
import com.entity.Resource;
import com.entity.User;
import com.utils.EasyUIAdapter;
import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import java.util.List;
import java.util.Map;

import static org.junit.Assert.*;

public class UserServiceImpTest {

    private UserService userService;
    @Before
    public void setUp() throws Exception {
        ApplicationContext ctx=new ClassPathXmlApplicationContext("spring-config.xml");
        userService=(UserService)ctx.getBean("userService");
    }

    @Test
    public void find() {
    }

    @Test
    public void findAll() {
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
    public void changePass() {
        String account="test";
        String pass="123456";
        Integer id=24;
        userService.changePass(account,pass,id);
    }

    @Test
    public void findByAccount() {
        User user=new User();
        user.setAccount("1");
        User u=userService.findByAccount(user);
        Assert.assertNotNull(u);
    }
    @Test
    public void findMenu(){

        List<Resource> list=userService.findMenu("admin");
        List<Map<String,Object>> l=EasyUIAdapter.treeMap(list);
        String s= JSON.toJSONString(l);
        System.out.println(11);
    }

}