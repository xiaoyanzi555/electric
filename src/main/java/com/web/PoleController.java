package com.web;

import com.alibaba.fastjson.JSON;
import com.entity.Pole;
import com.service.PoleService;
import com.utils.EasyUIAdapter;
import com.utils.Page;
import com.utils.WebResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class PoleController {
    @Autowired
    private PoleService poleService;
    //查询
    @ResponseBody
    @RequestMapping(value = "/poles",method = RequestMethod.GET,produces = {"application/json;charset=utf-8"})
    public String find(Pole pole,int page,int rows){
        Page<Pole> pageBean=poleService.find(pole,page,rows);
        Map<String,Object> data=EasyUIAdapter.datagridMap(pageBean);
        WebResult webResult=new WebResult(data);
        return JSON.toJSONString(webResult);
    }
    //查询单个杆塔
    @ResponseBody
    @RequestMapping(value = "/poles/{id}",method = RequestMethod.GET,produces = {"application/json;charset=utf-8"})
    public String findById(@PathVariable("id") Integer id){
        Pole pole=poleService.findById(id);
        WebResult webResult=new WebResult(pole);
        return JSON.toJSONString(webResult);
    }
    //通过线路查取出该线路下的所有杆塔
    @ResponseBody
    @RequestMapping(value = "/poles",method = RequestMethod.GET,
            headers = "select=lines_all_poles",produces = {"application/json;charset=utf-8"})
    public String findByLineId(Pole pole,Integer task_id){
        List<Pole> poles=poleService.findByEntity(pole);
        //为每一根杆塔指定任务编号
        if (poles!=null && poles.size()>0){
           for(Pole dbpole:poles){
               dbpole.setTask_id(task_id);
           }
        }
        WebResult webResult=new WebResult(poles);
        return JSON.toJSONString(webResult);
    }
    //查询起始和结束的杆塔
    @ResponseBody
    @RequestMapping(value = "/poles/{id}/poles",method = RequestMethod.GET,produces = {"application/json;charset=utf-8"})
    public String findStartAndEnd(@PathVariable("id") Integer id){
        Map<String,String> list=poleService.findStartAndEnd(id);
        WebResult webResult=new WebResult(list);
        return JSON.toJSONString(webResult);
    }
    //添加
    @ResponseBody
    @RequestMapping(value = "/poles",method = RequestMethod.POST,produces = {"application/json;charset=utf-8"})
    public String add(Pole pole){
        pole=poleService.add(pole);
        WebResult webResult=new WebResult(pole);
        return JSON.toJSONString(webResult);
    }
    //修改
    @ResponseBody
    @RequestMapping(value = "/poles",method = RequestMethod.PUT,produces = {"application/json;charset=utf-8"})
    public String edit(Pole pole){
        pole=poleService.update(pole);
        WebResult webResult=new WebResult(pole);
        return JSON.toJSONString(webResult);
    }
    //批量修改
    @ResponseBody
    @RequestMapping(value = "/poles/{id}",method = RequestMethod.PUT,produces = {"application/json;charset=utf-8"})
    public String edit_more(@PathVariable("id") Integer[] id){
        poleService.update(id);
        WebResult webResult=new WebResult();
        return JSON.toJSONString(webResult);
    }
    //删除
    @ResponseBody
    @RequestMapping(value = "/poles/{id}",method = RequestMethod.DELETE,produces = {"application/json;charset=utf-8"})
    public String delete(@PathVariable("id") Integer[] id){
        Pole[] pole=poleService.delete(id);
        WebResult webResult=new WebResult(pole);
        return JSON.toJSONString(webResult);
    }
}
