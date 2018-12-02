package com.dao;

import com.entity.WorkTask;
import org.apache.ibatis.annotations.Param;
import org.springframework.web.bind.annotation.PathVariable;

import java.util.List;

public interface WorkTaskDao {
    void deleteByEntity(WorkTask workTask);
   /* List<WorkTask> find(@Param("example") WorkTask example, @Param("page")Integer page, @Param("rows")Integer rows);*/
    List<WorkTask> find(@Param("example") WorkTask example, @Param("page")Integer page, @Param("rows")Integer rows);
    int count(@Param("example") WorkTask example);
    void add(WorkTask entity);
}
