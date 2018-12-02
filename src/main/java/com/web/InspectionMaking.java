package com.web;

import com.alibaba.fastjson.JSON;
import com.entity.Inspection;
import com.entity.User;
import com.entity.UserInsCon;
import com.service.InspectionService;
import com.utils.EasyUIAdapter;
import com.utils.Page;
import com.utils.WebResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

@Controller
public class InspectionMaking {
    @Autowired
    private InspectionService inspectionService;
    @ResponseBody
    @RequestMapping(value = "/inspection",method = RequestMethod.GET,produces = "application/json;charset=utf-8")
    public String find(Inspection inspection,int page,int rows,HttpServletRequest request){
        //只能查询自己当前的巡查任务
        User user= (User) request.getSession().getAttribute("user");
        inspection.setDistribute_id(user.getId());
        Page<Inspection> pageBean=inspectionService.find(inspection,page,rows);
        Map<String,Object> data=EasyUIAdapter.datagridMap(pageBean);
        WebResult webResult=new WebResult(data);
        return JSON.toJSONString(webResult);
    }
    //查询单个
    @ResponseBody
    @RequestMapping(value = "/inspection/{id}",method = RequestMethod.GET,produces = "application/json;charset=utf-8")
    public String findById(@PathVariable("id") Integer id){
        Inspection inspection=inspectionService.findById(id);
        WebResult webResult=new WebResult(inspection);
        return JSON.toJSONString(webResult);
    }
    //查询
    @ResponseBody
    @RequestMapping(value = "/inspection",method = RequestMethod.GET,
            headers = "select=findAll",produces = "application/json;charset=utf-8")
    public String findAll(){
        List<Inspection> list=inspectionService.findAll();
        List data=EasyUIAdapter.datagridMap_Ins(list);
        WebResult webResult=new WebResult(data);
        return JSON.toJSONString(webResult);
    }

    //修改
    @ResponseBody
    @RequestMapping(value = "/inspection",method = RequestMethod.PUT,produces = "application/json;charset=utf-8")
    public String edit(Inspection inspection){
        inspectionService.update(inspection);
        WebResult webResult=new WebResult();
        return JSON.toJSONString(webResult);
    }
    //添加
    @ResponseBody
    @RequestMapping(value = "/inspection",method = RequestMethod.POST,produces = "application/json;charset=utf-8")
    public String add(Inspection inspection){
        inspection=inspectionService.add(inspection);
        WebResult webResult=new WebResult(inspection);
        return JSON.toJSONString(webResult);
    }

}
