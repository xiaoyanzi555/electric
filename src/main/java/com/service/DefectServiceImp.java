package com.service;

import com.dao.ComsumeDefectDao;
import com.dao.DefectDao;
import com.dao.InspectionDao;
import com.entity.ComsumeDefect;
import com.entity.Defect;
import com.entity.Inspection;
import com.utils.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Service("defectService")
@Transactional(readOnly = true)
public class DefectServiceImp implements DefectService{
    @Autowired
    private DefectDao defectDao;
    @Autowired
    private InspectionDao inspectionDao;
    @Autowired
    private ComsumeDefectDao comsumeDefectDao;
    @Override
    public List<Defect> findAll() {
        return defectDao.findAll() ;
    }

    @Override
    public Page<Defect> find(Defect defect, Integer page, Integer rows) {
        int total=defectDao.count(defect);
        Page<Defect> pageBean=new Page<>(total,page,rows);
        List<Defect> list=defectDao.find(defect,pageBean.getStart(),rows);
        pageBean.setList(list);
        return pageBean;
    }

    @Override
    public Defect findById(Integer id) {
        return defectDao.findById(id);
    }

    @Override
    @Transactional(readOnly = false,propagation = Propagation.REQUIRED)
    public Defect add(Defect defect) {
        //默认defect的任务为还没有开始巡检
        defect.setIsComsume(1);
        //如果用户什么信息都没有填写那么则不进行缺陷表的插入
        if (!(defect.getRate()==null && defect.getDefect_description()==null)){
            //都为空表示用户没有添加任何数据
            defectDao.add(defect);
        }
        //修改任务表的状态为已完成
        Inspection inspection=new Inspection();
        inspection.setId(defect.getTask_id());
        inspection.setTask_state(4);
        //修改任务完成时间
        inspection.setTask_end_time(defect.getFind_time());
        inspectionDao.update(inspection);
        return defect;
    }

    @Override
    public Defect delete(Integer id) {
        return null;
    }

    @Override
    public Defect[] delete(Integer[] id) {
        return new Defect[0];
    }

    @Override
    public Defect update(Defect defect) {
        defectDao.update(defect);
        return null;
    }

    @Override
    public Defect finByEntity(Defect defect) {
        return defectDao.finByEntity(defect);
    }

    @Override
    public List<Defect> findComsumeDefects(Integer comsumeid, Integer is_deal) {
        ComsumeDefect comsumeDefect=new ComsumeDefect();
        comsumeDefect.setIs_deal(is_deal);
        comsumeDefect.setComsume_id(comsumeid);//该消缺任务编号下的所有缺陷
        List<ComsumeDefect> list=comsumeDefectDao.findByEntity(comsumeDefect);
        List<Defect> defects=new ArrayList<>();
        //循环查找所有的缺陷
        if (list!=null && list.size()>0){
            for (int i = 0; i <list.size() ; i++) {
                ComsumeDefect item=list.get(i);
                Defect defect=defectDao.findById(item.getDefect_id());
                defects.add(defect);
            }
        }
        return defects;
    }
}
