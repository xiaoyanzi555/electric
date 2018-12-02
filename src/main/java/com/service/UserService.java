package com.service;


import com.entity.Resource;
import com.entity.User;
import com.entity.UserInsCon;

import java.util.List;
import java.util.Map;
import java.util.Set;

public interface UserService extends BaseService<User,Integer>{
    User[] update(Integer[] id);

    User findByAccount(User user);

    List<User> findUsersByRoleId(Integer id);
//根据传入的信息查询已有信息,中间表
    List<User> findByUIC(UserInsCon userInsCon);

    boolean checkPass(String pass, String salt, String dbPass);

    User findByAccount(String account);

    String generateSaltString(String account, String salt);

    Set<String> findAllRoles(String account);

    Set<String> findAllPermissions(String account);
    User login(String account, String pass);
    void changePass(String account, String pass,Integer id);
    List<Resource> findMenu(String account);
}
