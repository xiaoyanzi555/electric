package com.service;

import com.dao.UserInsConDao;
import com.entity.User;
import com.entity.UserInsCon;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("serviceTest")
public class ServiceTest {
    @Autowired
    private UserInsConDao userInsConDao;
    public void deleteByEntity(UserInsCon userInsCon){
        userInsConDao.deleteByEntity(userInsCon);
    }
}
