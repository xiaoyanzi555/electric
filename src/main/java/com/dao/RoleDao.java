package com.dao;

import com.entity.Role;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface RoleDao extends BaseDao<Role,Integer> {
    Role findEntity(@Param("example") Role role);
}
