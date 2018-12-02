package com.dao;

import com.entity.Defect;

public interface DefectDao extends BaseDao<Defect,Integer>{
    Defect finByEntity(Defect defect);
}
