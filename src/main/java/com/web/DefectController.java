package com.web;

import com.alibaba.fastjson.JSON;
import com.dao.ComsumeDefectDao;
import com.entity.ComsumeDefect;
import com.entity.ComsumeTask;
import com.entity.Defect;
import com.service.DefectService;
import com.utils.EasyUIAdapter;
import com.utils.Page;
import com.utils.WebResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Controller
public class DefectController {
    @Autowired
    private DefectService defectService;
    //查询
    @ResponseBody
    @RequestMapping(value = "/defects",method = RequestMethod.GET,produces = {"application/json;charset=utf-8"})
    public String find(Defect defect,int page,int rows){
        Page<Defect> pageBean=defectService.find(defect,page,rows);
        Map<String,Object> data=EasyUIAdapter.datagridMap(pageBean);
        WebResult webResult=new WebResult(data);
        return JSON.toJSONString(webResult);
    }
    //查询
    @ResponseBody
    @RequestMapping(value = "/defects",method = RequestMethod.GET,
            headers="comsume=defects",produces = {"application/json;charset=utf-8"})
    public String findByEntity(Integer id,Integer is_deal){
        List<Defect> defects=defectService.findComsumeDefects(id,is_deal);
        WebResult webResult=new WebResult(defects);
        return JSON.toJSONString(webResult);
    }
    //添加
    @ResponseBody
    @RequestMapping(value = "/defects",method = RequestMethod.PUT,produces = {"application/json;charset=utf-8"})
    public String add(Defect defect){

        //如果级别不是-1，就往数据库里面添加数据
        if (defect!=null && defect.getDefect_grade()==-1){
            //默认级别为一般
            defect.setDefect_grade(1);
        }
        //如果类型没有选择那么就默认为1
        if (defect.getDefect_type()==null || "".equals(defect.getDefect_type())){
            //默认级别为一般
            defect.setDefect_type(1);
        }
        defectService.add(defect);
        WebResult webResult=new WebResult();
        return JSON.toJSONString(webResult);
    }

}
