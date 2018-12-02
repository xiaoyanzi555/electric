package com.dao;

import com.entity.ComsumeTask;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ComsumeTaskDao extends BaseDao<ComsumeTask,Integer> {
    List<ComsumeTask> findNoDis(@Param("example") ComsumeTask consumeTask, @Param("page") Integer page, @Param("rows") int rows);

    int countNoDis(@Param("example") ComsumeTask consumeTask);
}
