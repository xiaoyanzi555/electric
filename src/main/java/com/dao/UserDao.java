package com.dao;

import com.entity.Resource;
import com.entity.User;

import java.util.List;
import java.util.Set;

public interface UserDao extends BaseDao<User,Integer> {
    User findByAccount(User user);

    List<User> findUsersByRoleId(Integer role_id);

    Set<String> findAllRoles(String account);

    Set<String> findAllPermissions(String account);

    List<Resource> findMenu(String account);
}
