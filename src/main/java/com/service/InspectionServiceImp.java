package com.service;

import com.dao.InspectionDao;
import com.dao.UserInsConDao;
import com.dao.WorkTaskDao;
import com.entity.Inspection;
import com.entity.UserInsCon;
import com.entity.WorkTask;
import com.utils.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

@Service("inspectionService")
@Transactional(readOnly = true)
public class InspectionServiceImp implements InspectionService {
    @Autowired
    private InspectionDao inspectionDao;
    @Autowired
    private UserInsConDao userInsConDao;
    @Autowired
    private WorkTaskDao workTaskDao;
    @Override
    public List<Inspection> findAll() {
        return inspectionDao.findAll();
    }

    @Override
    public Page<Inspection> find(Inspection inspection, Integer page, Integer rows) {
        int total=inspectionDao.count(inspection);
        Page<Inspection> pageBean=new Page<>(total,page,rows);
        List<Inspection> list=inspectionDao.find(inspection,pageBean.getStart(),rows);
        pageBean.setList(list);
        return pageBean;
    }

    @Override
    public Inspection findById(Integer id) {

        return inspectionDao.findById(id);
    }

    @Override
    @Transactional(readOnly = false,propagation = Propagation.REQUIRED)
    public Inspection add(Inspection inspection) {
        //任务默认待分配
        inspection.setTask_state(1);
        //任务默认不取消
        inspection.setTask_cancel(2);
        if (inspection.getStaff_ids()!=null && inspection.getStaff_ids().size()>0){
            inspection.setLeader_id(inspection.getStaff_ids().get(0));
        }
        inspectionDao.add(inspection);
        //在中间表添加任务和人员的信息
        if (inspection.getStaff_ids()!=null && inspection.getStaff_ids().size()>0){
            for (int i = 0; i <inspection.getStaff_ids().size() ; i++) {
                UserInsCon userInsCon=new UserInsCon();
                userInsCon.setPos_type(1);//巡检
                userInsCon.setTask_id(inspection.getId());
                userInsCon.setStaff_id(inspection.getStaff_ids().get(i));
                //调用dao层添加
                userInsConDao.add(userInsCon);
            }
        }

        return inspection;
    }

    @Override
    @Transactional(readOnly = false,propagation = Propagation.REQUIRED)
    public Inspection delete(Integer id) {
        return null;
    }

    @Override
    @Transactional(readOnly = false,propagation = Propagation.REQUIRED)
    public Inspection[] delete(Integer[] id) {
        return new Inspection[0];
    }

    @Override
    @Transactional(readOnly = false,propagation = Propagation.REQUIRED)
    public Inspection update(Inspection inspection) {
        //添加新数据
        if (inspection.getStaff_ids()!=null && inspection.getStaff_ids().size()>0){
            //还需要修改中间表
            //修改中间表，将属于这个taskid的任务的人员进行删除在添加
            UserInsCon userInsCon=new UserInsCon();
            userInsCon.setTask_id(inspection.getId());
            userInsCon.setPos_type(1);
            userInsConDao.deleteByEntity(userInsCon);

            for (int i = 0; i <inspection.getStaff_ids().size() ; i++) {
                UserInsCon uic=new UserInsCon();
                uic.setPos_type(1);//巡检
                uic.setTask_id(inspection.getId());
                uic.setStaff_id(inspection.getStaff_ids().get(i));
                //调用dao层添加
                userInsConDao.add(uic);
            }
            inspection.setLeader_id(inspection.getStaff_ids().get(0));

        }
        //如果是已经分配状态，那么需要在任务表里面添加数据，而且判断第一个选中的人是组长
            if (inspection.getTask_state()!=null && inspection.getTask_state()==2){
                //在任务表添加数数据
                //1:缺陷管理，2：消缺任务
                WorkTask workTask=new WorkTask();
                workTask.setWait_task_type(1);
                workTask.setIs_deal(1);//默认为未处理状态
                workTask.setWait_task_id(inspection.getId());
                workTask.setOwner_id(inspection.getStaff_ids().get(0));
                workTaskDao.add(workTask);
            }

            //如果任务处于取消状态那么应该在任务表将其进行删除
        if (inspection.getTask_cancel()!=null && inspection.getTask_cancel()==1){
            WorkTask workTask=new WorkTask();
            workTask.setWait_task_id(inspection.getId());
            workTaskDao.deleteByEntity(workTask);//任务只有一个组长
        }
        inspectionDao.update(inspection);

        inspection=inspectionDao.findById(inspection.getId());
        return inspection;
    }

    //查询除开未分配的任务
    @Override
    public Page<Inspection> findExceptNoDis(Inspection inspection, int page, int rows) {
        int total=inspectionDao.countExceptNoDis(inspection);
        Page<Inspection> pageBean=new Page<>(total,page,rows);
        List<Inspection> list=inspectionDao.findExceptNoDis(inspection,pageBean.getStart(),rows);
        pageBean.setList(list);
        return pageBean;
    }

}
