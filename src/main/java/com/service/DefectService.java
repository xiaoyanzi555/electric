package com.service;

import com.dao.BaseDao;
import com.entity.Defect;

import java.util.List;

public interface DefectService extends BaseService<Defect,Integer> {
    Defect finByEntity(Defect defect);

    List<Defect> findComsumeDefects(Integer id, Integer is_deal);
}
