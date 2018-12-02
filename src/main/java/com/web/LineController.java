package com.web;

import com.alibaba.fastjson.JSON;
import com.dao.LineDao;
import com.entity.Line;
import com.entity.Pole;
import com.service.LineService;
import com.utils.EasyUIAdapter;
import com.utils.Page;
import com.utils.WebResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;
import java.util.Map;

@Controller
public class LineController {
    @Autowired
    private LineService lineService;
    //查询
    @ResponseBody
    @RequestMapping(value = "/lines",method = RequestMethod.GET,produces = {"application/json;charset=utf-8"})
    public String find(Line line, int page, int rows){
        Page<Line> pageBean=lineService.find(line,page,rows);
        Map<String,Object> data= EasyUIAdapter.datagridMap(pageBean);
        WebResult webResult=new WebResult(data);
        return JSON.toJSONString(webResult);
    }
    //查询所有线路
    @ResponseBody
    @RequestMapping(value = "/lines",method = RequestMethod.GET,
            headers="data=all",produces = {"application/json;charset=utf-8"})
    public String findAll(){
        List<Line> list=lineService.findAll();
        WebResult webResult=new WebResult(list);
        return JSON.toJSONString(webResult);
    }
    //查询所有在下拉框展示
    @ResponseBody
    @RequestMapping(value = "/lines",method = RequestMethod.GET,
            headers="data=select",produces = {"application/json;charset=utf-8"})
    public String find(){
        List<Line> list=lineService.findAll();
        List data=EasyUIAdapter.comboboxLine(list,null);
        WebResult webResult=new WebResult(data);
        return JSON.toJSONString(webResult);
    }
    //查询所有在下拉框选中
    @ResponseBody
    @RequestMapping(value = "/lines/{line_id}",method = RequestMethod.GET,
            headers="data=check",produces = {"application/json;charset=utf-8"})
    public String findByCheck(@PathVariable("line_id") Integer line_id){
        List<Line> list=lineService.findAll();
        Line line=lineService.findById(line_id);
        List data=EasyUIAdapter.comboboxLine(list,line);
        WebResult webResult=new WebResult(data);
        return JSON.toJSONString(webResult);
    }
    //查询单个
    @ResponseBody
    @RequestMapping(value = "/lines/{id}",method = RequestMethod.GET,produces = {"application/json;charset=utf-8"})
    public String findById(@PathVariable("id") Integer id){
        Line line=lineService.findById(id);
        WebResult webResult=new WebResult(line);
        return JSON.toJSONString(webResult);
    }
    //添加
    @ResponseBody
    @RequestMapping(value = "/lines",method = RequestMethod.POST,produces = {"application/json;charset=utf-8"})
    public String add(Line line){
        line=lineService.add(line);
        WebResult webResult=new WebResult(line);
        return JSON.toJSONString(webResult);
    }
    //修改
    @ResponseBody
    @RequestMapping(value = "/lines",method = RequestMethod.PUT,produces = {"application/json;charset=utf-8"})
    public String edit(Line line){
        line=lineService.update(line);
        WebResult webResult=new WebResult(line);
        return JSON.toJSONString(webResult);
    }
    //批量修改
    @ResponseBody
    @RequestMapping(value = "/lines/{id}",method = RequestMethod.PUT,produces = {"application/json;charset=utf-8"})
    public String edit_more(@PathVariable("id") Integer[] id){
        lineService.update(id);
        WebResult webResult=new WebResult();
        return JSON.toJSONString(webResult);
    }
    //删除
    @ResponseBody
    @RequestMapping(value = "/lines/{id}",method = RequestMethod.DELETE,produces = {"application/json;charset=utf-8"})
    public String delete(@PathVariable("id") Integer[] id){
        lineService.delete(id);
        WebResult webResult=new WebResult();
        return JSON.toJSONString(webResult);
    }
}
