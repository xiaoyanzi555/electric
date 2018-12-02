package com.dao;

import com.entity.Resource;

import java.util.List;
import java.util.Map;

public interface ResourceDao extends BaseDao<Resource,Integer> {
    List<Resource> findByExampleWithPage(Resource example, Integer start, Integer rows);

    List<Resource> findByExample(Resource example);

    List<Map<String,Object>> findSelctInfoByExample(Resource example);
}