package com.service;

import com.entity.ComsumeTask;
import com.utils.Page;

public interface ComsumeTaskService extends BaseService<ComsumeTask,Integer> {
    Page<ComsumeTask> findNoDis(ComsumeTask consumeTask, int page, int rows);
}
