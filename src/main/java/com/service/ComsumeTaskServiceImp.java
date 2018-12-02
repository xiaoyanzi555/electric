package com.service;

import com.dao.ComsumeDefectDao;
import com.dao.ComsumeTaskDao;
import com.dao.UserInsConDao;
import com.entity.*;
import com.utils.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
@Service("comsumeTaskService")
@Transactional(readOnly = true)
public class ComsumeTaskServiceImp implements ComsumeTaskService {
    @Autowired
    private ComsumeTaskDao comsumeTaskDao;
    @Autowired
    private ComsumeDefectDao comsumeDefectDao;
    @Autowired
    private UserInsConDao userInsConDao;
    @Autowired
    private WorkTaskService workTaskService;
    @Autowired
    private DefectService defectService;
    @Override
    public List<ComsumeTask> findAll() {
        return null;
    }

    @Override
    public Page<ComsumeTask> find(ComsumeTask comsumeTask, Integer page, Integer rows) {
        int total=comsumeTaskDao.count(comsumeTask);
        Page<ComsumeTask> pageBean=new Page<>(total,page,rows);
        List<ComsumeTask> list=comsumeTaskDao.find(comsumeTask,pageBean.getStart(),rows);
        pageBean.setList(list);
        return pageBean;
    }

    @Override
    public ComsumeTask findById(Integer id) {
        return comsumeTaskDao.findById(id);
    }

    @Override
    @Transactional(readOnly = false,propagation = Propagation.REQUIRED)
    public ComsumeTask add(ComsumeTask comsumeTask) {
        //任务状态默认为待分配
        comsumeTask.setTask_state(1);//待分配
        comsumeTask.setTask_cancel(2);//任务默认不取消
        //设置组长
        if(comsumeTask.getConsomers()!=null && comsumeTask.getConsomers().size()>0){
            comsumeTask.setTask_user_id(comsumeTask.getConsomers().get(0));
        }
        //添加自己的同时添加中间表
        comsumeTaskDao.add(comsumeTask);
        if (comsumeTask.getDefects()!=null && comsumeTask.getDefects().size()>0){
            //循环添加缺陷到中间表之中
            for (int i = 0; i <comsumeTask.getDefects().size() ; i++) {
                ComsumeDefect comsumeDefect=new ComsumeDefect();
                comsumeDefect.setComsume_id(comsumeTask.getId());
                comsumeDefect.setIs_deal(1);//默认未处理状态
                comsumeDefect.setDefect_id(comsumeTask.getDefects().get(i));
                comsumeDefectDao.add(comsumeDefect);

                //在添加完成消缺的任务之后，让该任务的消缺状态处于已消缺状态，让再次选择是查不到
                Defect defect=new Defect();
                defect.setIsComsume(2);
                defect.setId(comsumeTask.getDefects().get(i));
                defectService.update(defect);
            }
        }
        //添加消缺人员到中间表中
        if(comsumeTask.getConsomers()!=null && comsumeTask.getConsomers().size()>0){
            for (int i = 0; i <comsumeTask.getConsomers().size() ; i++) {
                UserInsCon userInsCon=new UserInsCon();
                userInsCon.setStaff_id(comsumeTask.getConsomers().get(i));
                userInsCon.setTask_id(comsumeTask.getId());
                userInsCon.setPos_type(2);//表示消缺
                userInsConDao.add(userInsCon);
            }
        }
        return comsumeTask;
    }

    @Override
    public ComsumeTask delete(Integer id) {
        return null;
    }

    @Override
    public ComsumeTask[] delete(Integer[] id) {
        return new ComsumeTask[0];
    }

    @Override
    @Transactional(readOnly = false,propagation = Propagation.REQUIRED)
    public ComsumeTask update(ComsumeTask comsumeTask) {

        //修改中间表，消缺人员的更改
        //重新添加消缺人员
        if (comsumeTask.getConsomers()!=null && comsumeTask.getConsomers().size()>0){
            //删除之前所有该消缺任务下的人员
            UserInsCon userInsCon=new UserInsCon();
            userInsCon.setTask_id(comsumeTask.getId());
            userInsCon.setPos_type(2);//表示消缺
            userInsConDao.deleteByEntity(userInsCon);
            for (int i = 0; i <comsumeTask.getConsomers().size() ; i++) {
                UserInsCon u=new UserInsCon();
                u.setStaff_id(comsumeTask.getConsomers().get(i));
                u.setTask_id(comsumeTask.getId());
                u.setPos_type(2);
                userInsConDao.add(u);
            }
            comsumeTask.setTask_user_id(comsumeTask.getConsomers().get(0));
        }
        //重新在添加
        if (comsumeTask.getDefects()!=null && comsumeTask.getDefects().size()>0){
            //删除缺陷和消缺的中间表，并重新添加
            ComsumeDefect comsumeDefect=new ComsumeDefect();
            comsumeDefect.setComsume_id(comsumeTask.getId());
            comsumeDefect.setIs_deal(1);//未处理
            comsumeDefectDao.deleteByEntity(comsumeDefect);
            for (int i = 0; i <comsumeTask.getDefects().size() ; i++) {
                ComsumeDefect cd=new ComsumeDefect();
                cd.setComsume_id(comsumeTask.getId());
                cd.setDefect_id(comsumeTask.getDefects().get(i));
                cd.setIs_deal(1);//未处理
                comsumeDefectDao.add(cd);
            }
        }
        //如果是已分配状态才对任务进行添加
        if (comsumeTask.getTask_state()!=null && comsumeTask.getTask_state()==2){
          //添加任务表
            WorkTask workTask=new WorkTask();
            workTask.setOwner_id(comsumeTask.getConsomers().get(0));
            workTask.setWait_task_type(2);
            workTask.setWait_task_id(comsumeTask.getId());
            workTask.setIs_deal(1);
            workTaskService.add(workTask);
        }
        //如果字段为不通过，则修改状态为驳回
        if (comsumeTask.getPass()!=null && comsumeTask.getPass()==2){
            comsumeTask.setTask_state(5);
            if (comsumeTask.getDefects()!=null && comsumeTask.getDefects().size()>0){
                for (int i = 0; i <comsumeTask.getDefects().size() ; i++) {
                    //并且将该缺陷更改为未处理状态
                    Defect defect=new Defect();
                    defect.setIsComsume(1);
                    defect.setId(comsumeTask.getDefects().get(i));
                    defectService.update(defect);
                }
            }
        }
        //修改自己的一些字段和属性
        comsumeTaskDao.update(comsumeTask);
        return null;
    }

    @Override
    public Page<ComsumeTask> findNoDis(ComsumeTask consumeTask, int page, int rows) {
        int total=comsumeTaskDao.countNoDis(consumeTask);
        Page<ComsumeTask> pageBean=new Page<>(total,page,rows);
        List<ComsumeTask> list=comsumeTaskDao.findNoDis(consumeTask,pageBean.getStart(),rows);
        pageBean.setList(list);
        return pageBean;
    }
}
