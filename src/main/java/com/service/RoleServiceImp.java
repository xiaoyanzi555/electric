
package com.service;

import com.dao.*;
import com.entity.*;
import com.utils.EasyUIAdapter;
import com.utils.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.Map;

@Service("roleService")
@Transactional(readOnly = true)
public class RoleServiceImp implements RoleService {
    @Autowired
    private RoleDao roleDao;

    public List<Role> findAll() {
        return roleDao.findAll();
    }

    @Override
    public Page<Role> find(Role role, Integer page, Integer rows) {
        int total = roleDao.count(role);
        Page<Role> pageBean = new Page<>(total, page, rows);
        List<Role> list = roleDao.find(role, pageBean.getStart(), rows);
        pageBean.setList(list);
        return pageBean;
    }


    @Override
    public Role findById(Integer id) {
        return roleDao.findById(id);
    }

    @Override
    @Transactional(readOnly = false, propagation = Propagation.REQUIRED)
    public Role add(Role role) {
        //设置创建时间
        Date date=new Date();
        SimpleDateFormat df=new SimpleDateFormat("yyyy-MM-dd");
        String strDate=df.format(date);
        role.setModify_date(strDate);
        roleDao.add(role);
        return role;
    }

    @Override
    @Transactional(readOnly = false, propagation = Propagation.REQUIRED)
    public Role delete(Integer id) {
        Role role = roleDao.findById(id);
        if (role != null) {
            roleDao.delete(id);
        }
        return role;
    }

    @Override
    @Transactional(readOnly = false, propagation = Propagation.REQUIRED)
    public Role[] delete(Integer[] id) {
        if (id != null && id.length > 0) {
            for (int i = 0; i < id.length; i++) {
                roleDao.delete(id[i]);
            }
        }
        return null;
    }

    @Override
    @Transactional(readOnly = false, propagation = Propagation.REQUIRED)
    public Role update(Role role) {
        //设置编辑时间
        Date date=new Date();
        SimpleDateFormat df=new SimpleDateFormat("yyyy-MM-dd");
        String strDate=df.format(date);
        role.setModify_date(strDate);
        roleDao.update(role);
        return role;
    }

    @Override
    public Role findEntity(Role role) {
        return roleDao.findEntity(role);
    }
}
