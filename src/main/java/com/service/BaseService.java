package com.service;

import com.utils.Page;

import java.util.List;

public interface BaseService<T,I> {
    List<T> findAll();
    Page<T> find(T example, I page, I rows);
    T findById(I id);
    T add(T entity);
    T delete(I id);
    T[] delete(Integer[] id);
    T update(T entity);
}
