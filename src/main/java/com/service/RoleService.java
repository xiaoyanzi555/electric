package com.service;

import com.entity.Role;

import java.util.List;
import java.util.Map;

public interface RoleService extends BaseService<Role,Integer>{
    Role findEntity(Role roleName);
}
