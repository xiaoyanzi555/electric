package com.service;

import com.dao.UserInsConDao;
import com.entity.UserInsCon;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
@Service("userInsConService")
@Transactional(readOnly = true)
public class UserInsConServiceImp implements UserInsConService {
   @Autowired
   private UserInsConDao userInsConDao;
    @Override
    public List<UserInsCon> find(UserInsCon userInsCon) {
        return userInsConDao.find(userInsCon);
    }
}
