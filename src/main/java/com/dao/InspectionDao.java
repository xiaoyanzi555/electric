package com.dao;

import com.entity.Inspection;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface InspectionDao extends BaseDao<Inspection,Integer>{
    int countExceptNoDis(@Param("example") Inspection inspection);

    List<Inspection> findExceptNoDis(@Param("example") Inspection example, @Param("page")Integer page, @Param("rows")Integer rows);


}
