package com.service;

import com.entity.Resource;
import com.utils.Page;

import java.util.List;
import java.util.Map;

public interface ResourceService {
    Page<Resource> find(Resource example, int page, int rows);
    List<Resource> find(Resource example);
    List<Map<String,Object>> findSelectInfo(Resource example);
    Resource add(Resource resource);
    Resource update(Resource resource);
    void delete(Integer id);
    Resource findById(Integer id);
    List<Map<String,Object>> findResourcesWithTree(Integer id);
}
