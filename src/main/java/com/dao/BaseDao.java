package com.dao;

import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface BaseDao<T,I> {
    List<T> findAll();
    List<T> find(@Param("example") T example, @Param("page")I page, @Param("rows")I rows);
    int count(@Param("example") T example);
    T findById(I id);
    void add(T entity);
    void delete(I id);
    void update(@Param("example")T entity);
}
