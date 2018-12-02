package com.service;

import com.entity.WorkTask;
import com.utils.Page;

import java.util.List;

public interface WorkTaskService {
    void deleteByEntity(WorkTask workTask);
    /* List<WorkTask> find(@Param("example") WorkTask example, @Param("page")Integer page, @Param("rows")Integer rows);*/
    Page<WorkTask> find(WorkTask example, Integer page, Integer rows);
    WorkTask add(WorkTask entity);
}
