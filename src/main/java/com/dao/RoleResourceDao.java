package com.dao;

import com.entity.RoleResource;

import java.util.List;

public interface RoleResourceDao extends BaseDao<RoleResource,Integer> {
    List<Integer> findByRoleId(int roleid);
}
