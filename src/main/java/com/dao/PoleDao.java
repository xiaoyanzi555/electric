package com.dao;

import com.entity.Pole;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface PoleDao extends BaseDao<Pole,Integer> {
    void deleteByEntity(Pole pole);

    void updateByEntity(@Param("example") Pole pole);
    Map<String,String> findStartAndEnd(Integer id);

    List<Pole> findByEntity(@Param("example") Pole pole);
    List<Pole> findByEntity_hasDefect(@Param("example") Pole pole);
}
