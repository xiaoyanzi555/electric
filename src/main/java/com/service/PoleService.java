package com.service;

import com.dao.BaseDao;
import com.entity.Pole;

import java.util.List;
import java.util.Map;

public interface PoleService extends BaseService<Pole,Integer>{
    void update(Integer[] id);//批量修改状态

    Map<String,String> findStartAndEnd(Integer id);

    List<Pole> findByEntity(Pole pole);
    List<Pole> findByEntity_hasDefect(Pole pole);
}
