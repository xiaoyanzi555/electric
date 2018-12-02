package com.web;

import com.alibaba.fastjson.JSON;
import com.entity.DefectType;
import com.service.DefectTypeService;
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
public class DefectTypeController {
    @Autowired
    private DefectTypeService defectTypeService;
    @ResponseBody
    @RequestMapping(value = "/defects_type",method = RequestMethod.GET,produces = {"application/json;charset=utf-8"})
    public String find(DefectType defectType,int page,int rows){
        Page<DefectType> pageBean=defectTypeService.find(defectType,page,rows);
        Map<String,Object> data=EasyUIAdapter.datagridMapChecked_DefectType(pageBean);
        WebResult webResult=new WebResult(data);
        return JSON.toJSONString(webResult);
    }
    //查询缺陷列表在下拉框中
    @ResponseBody
    @RequestMapping(value = "/defects_type",
            headers = "select=find_all",method = RequestMethod.GET,produces = {"application/json;charset=utf-8"})
    public String find_Conbox_DefType(){
        List<DefectType> list=defectTypeService.findAll();
        List<Map<String,Object>> listMap=EasyUIAdapter.combobox_DefectType(list,null);
        WebResult webResult=new WebResult(listMap);
        return JSON.toJSONString(webResult);
    }
    //查询单个用户
    @ResponseBody
    @RequestMapping(value = "/defects_type/{id}",method = RequestMethod.GET,produces = {"application/json;charset=utf-8"})
    public String findById(@PathVariable("id") Integer id){
        DefectType defectType=defectTypeService.findById(id);
        WebResult webResult=new WebResult(defectType);
        return JSON.toJSONString(webResult);
    }
    //添加
    @ResponseBody
    @RequestMapping(value = "/defects_type",method = RequestMethod.POST,produces = {"application/json;charset=utf-8"})
    public String add(DefectType defectType){
        defectType=defectTypeService.add(defectType);
        WebResult webResult=new WebResult();
        return JSON.toJSONString(webResult);
    }
    //删除
    @ResponseBody
    @RequestMapping(value = "/defects_type/{id}",method = RequestMethod.DELETE,produces = {"application/json;charset=utf-8"})
    public String delete(@PathVariable("id") Integer[] id){
        defectTypeService.delete(id);
        WebResult webResult=new WebResult();
        return JSON.toJSONString(webResult);
    }
    //修改
    @ResponseBody
    @RequestMapping(value = "/defects_type",method = RequestMethod.PUT,produces = {"application/json;charset=utf-8"})
    public String update(DefectType defectType){
        defectTypeService.update(defectType);
        WebResult webResult=new WebResult();
        return JSON.toJSONString(webResult);
    }
}
