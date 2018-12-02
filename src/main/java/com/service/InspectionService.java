package com.service;

import com.entity.Inspection;
import com.utils.Page;

import java.util.Map;

public interface InspectionService extends BaseService<Inspection,Integer>{
    Page<Inspection> findExceptNoDis(Inspection inspection, int page, int rows);

}
