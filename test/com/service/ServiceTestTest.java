package com.service;

import com.entity.UserInsCon;
import org.junit.Before;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import java.util.List;

import static org.junit.Assert.*;

public class ServiceTestTest {
    private ServiceTest serviceTest;
    @Before
    public void setUp() throws Exception {
        ApplicationContext ctx=new ClassPathXmlApplicationContext("spring-config.xml");
        serviceTest=(ServiceTest)ctx.getBean("serviceTest");
    }

    @Test
    public void find() {
        UserInsCon userInsCon=new UserInsCon();
        userInsCon.setPos_type(1);
        userInsCon.setTask_id(12);
        serviceTest.deleteByEntity(userInsCon);
        System.out.println(1);
    }
}