package com.service;

import com.dao.WorkTaskDao;
import com.entity.WorkTask;
import com.utils.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service("workTaskService")
@Transactional(readOnly = true)
public class WorkTaskServiceImp implements WorkTaskService  {
    @Autowired
    private WorkTaskDao workTaskDao;


    @Override
    public Page<WorkTask> find(WorkTask workTask, Integer page, Integer rows) {
        int total=workTaskDao.count(workTask);
        Page<WorkTask> pageBean=new Page<>(total,page,rows);
        List<WorkTask> list=workTaskDao.find(workTask,pageBean.getStart(),rows);
        pageBean.setList(list);
        return pageBean;
    }




    @Override
    @Transactional(readOnly = false,propagation = Propagation.REQUIRED)
    public WorkTask add(WorkTask workTask) {
        workTaskDao.add(workTask);
        return workTask;
    }



    @Override
    @Transactional(readOnly = false,propagation = Propagation.REQUIRED)
    public void deleteByEntity(WorkTask workTask) {
        workTaskDao.deleteByEntity(workTask);
    }
}
