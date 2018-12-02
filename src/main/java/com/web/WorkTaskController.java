package com.web;

import com.alibaba.fastjson.JSON;
import com.entity.User;
import com.entity.WorkTask;
import com.service.WorkTaskService;
import com.utils.EasyUIAdapter;
import com.utils.Page;
import com.utils.WebResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;

@Controller
public class WorkTaskController {
    @Autowired
    private WorkTaskService workTaskService;
    @ResponseBody
    @RequestMapping(value = "/workTask",method = RequestMethod.GET,produces = {"application/json;charset=utf-8"})
    public String find(WorkTask workTask, int page, int rows, HttpServletRequest request){
       //查询当前登录用户的
        User user= (User) request.getSession().getAttribute("user");
        workTask.setOwner_id(user.getId());
        //查询未处理的任务1--未处理，2---已处理
        workTask.setIs_deal(1);
        workTask.setRoleid(user.getRole_id());
        Page<WorkTask> pageBean=workTaskService.find(workTask,page,rows);
        Map<String,Object> data= EasyUIAdapter.datagridMap(pageBean);
        WebResult webResult=new WebResult(data);
        return JSON.toJSONString(webResult);
    }
}
