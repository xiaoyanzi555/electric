package com.service;

import com.dao.DefectTypeDao;
import com.entity.Defect;
import com.entity.DefectType;
import com.utils.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
@Service("defectTypeService")
@Transactional(readOnly = true)
public class DefectTypeServiceImp implements DefectTypeService {
    @Autowired
    private DefectTypeDao defectTypeDao;
    @Override
    public List<DefectType> findAll() {
        return defectTypeDao.findAll();
    }

    @Override
    public Page<DefectType> find(DefectType defectType, Integer page, Integer rows) {
        int total=defectTypeDao.count(defectType);
        Page<DefectType> pageBean=new Page<>(total,page,rows);
        List<DefectType> list=defectTypeDao.find(defectType,pageBean.getStart(),rows);
        pageBean.setList(list);
        return pageBean;
    }

    @Override
    public DefectType findById(Integer id) {
        return defectTypeDao.findById(id);
    }

    @Override
    @Transactional(readOnly = false,propagation = Propagation.REQUIRED)
    public DefectType add(DefectType defectType) {
        defectTypeDao.add(defectType);
        return defectType;
    }

    @Override
    @Transactional(readOnly = false,propagation = Propagation.REQUIRED)
    public DefectType delete(Integer id) {
        DefectType defectType=defectTypeDao.findById(id);
        if (defectType!=null){
            defectTypeDao.delete(id);
        }
        return defectType;
    }

    @Override
    @Transactional(readOnly = false,propagation = Propagation.REQUIRED)
    public DefectType[] delete(Integer[] id) {
        DefectType[] defectTypes=new DefectType[id.length];
        if (id!=null && id.length>0){
            for (int i = 0; i <id.length ; i++) {
                DefectType defectType=defectTypeDao.findById(id[i]);
                if (defectType!=null){
                    defectTypeDao.delete(id[i]);
                    defectTypes[i]=defectType;
                }
            }

        }
        return defectTypes;
    }

    @Override
    @Transactional(readOnly = false,propagation = Propagation.REQUIRED)
    public DefectType update(DefectType defectType) {
        defectTypeDao.update(defectType);
        DefectType dbDefectType=defectTypeDao.findById(defectType.getId());
        return dbDefectType;
    }


}
