package com.dao;

import com.entity.User;
import com.entity.UserInsCon;
import org.springframework.web.bind.annotation.PathVariable;

import java.util.List;

public interface UserInsConDao {
    List<UserInsCon> find(UserInsCon userInsCon);
    void add(UserInsCon userInsCon);
    void deleteByEntity(UserInsCon userInsCon);
}
