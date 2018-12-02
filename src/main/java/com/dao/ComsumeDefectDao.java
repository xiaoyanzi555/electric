package com.dao;

import com.entity.ComsumeDefect;

import java.util.List;

public interface ComsumeDefectDao extends BaseDao<ComsumeDefect,Integer>{
    //查取数据
    List<ComsumeDefect> findByEntity(ComsumeDefect comsumeDefect);

    void deleteByEntity(ComsumeDefect comsumeDefect);
}
