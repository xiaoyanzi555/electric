package com.service;

import com.entity.Line;

public interface LineService extends BaseService<Line,Integer> {
    void update(Integer[] id);//批量修改状态
}
