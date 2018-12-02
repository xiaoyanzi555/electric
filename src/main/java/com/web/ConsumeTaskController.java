package com.web;

import com.alibaba.fastjson.JSON;
import com.entity.ComsumeTask;
import com.entity.Defect;
import com.entity.User;
import com.entity.UserInsCon;
import com.service.ComsumeTaskService;
import com.service.DefectService;
import com.service.UserInsConService;
import com.service.UserService;
import com.utils.EasyUIAdapter;
import com.utils.Page;
import com.utils.WebResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class ConsumeTaskController {
    @Autowired
   private ComsumeTaskService consumeTaskService;
    @Autowired
    private DefectService defectService;
    @Autowired
    private UserInsConService userInsConService;
    @Autowired
    private UserService userService;
    @ResponseBody
    @RequestMapping(value = "/consumeTask",method = RequestMethod.GET,produces = {"application/json;charset=utf-8"})
    public String find(ComsumeTask consumeTask, int page, int rows){
        Page<ComsumeTask> pageBean=consumeTaskService.find(consumeTask,page,rows);
        Map<String,Object> data=EasyUIAdapter.datagridMap(pageBean);
        WebResult webResult=new WebResult(data);
        return JSON.toJSONString(webResult);
    }

    @ResponseBody
    @RequestMapping(value = "/consumeTask/{id}",method = RequestMethod.GET,produces = {"application/json;charset=utf-8"})
    public String findById(@PathVariable("id") Integer id){
        ComsumeTask comsumeTask=consumeTaskService.findById(id);
        WebResult webResult=new WebResult(comsumeTask);
        return JSON.toJSONString(webResult);
    }

    //查询详细信息
    @ResponseBody
    @RequestMapping(value = "/consumeTask/{id}",method = RequestMethod.GET,
            headers="select=detail",produces = {"application/json;charset=utf-8"})
    public String findByDetail(@PathVariable("id") Integer id){
        //将所有数据进行整合
        Map<String,Object> data=new HashMap<>();
        ComsumeTask comsumeTask=consumeTaskService.findById(id);
        data.put("comsumeTask",comsumeTask);
        //查询该线路下的所有缺陷
        //通过中间表查取出缺陷id，在通过缺陷id返回一个缺陷对象
        List<Defect> lists=defectService.findComsumeDefects(id,null);
        data.put("defects",lists);
        //通过中间表查询消缺人员的人员信息
        UserInsCon userInsCon=new UserInsCon();
        userInsCon.setPos_type(2);
        userInsCon.setTask_id(id);
        List<UserInsCon> usersId=userInsConService.find(userInsCon);
        List<User> users=new ArrayList<>();
        if (usersId!=null && usersId.size()>0){
            //通过id查取用户
            for (int i = 0; i <usersId.size() ; i++) {
                UserInsCon uis=usersId.get(i);
                User user=new User();
                User dbuser=userService.findById(uis.getStaff_id());
                users.add(dbuser);
            }
        }
        data.put("users",users);
        WebResult webResult=new WebResult(data);
        return JSON.toJSONString(webResult);
    }
    //修改
    @ResponseBody
    @RequestMapping(value = "/consumeTask",method = RequestMethod.PUT,produces = {"application/json;charset=utf-8"})
    public String edit(ComsumeTask task){
        consumeTaskService.update(task);
        WebResult webResult=new WebResult();
        return JSON.toJSONString(webResult);
    }
    //添加
    @ResponseBody
    @RequestMapping(value = "/consumeTask",method = RequestMethod.POST,produces = {"application/json;charset=utf-8"})
    public String add(ComsumeTask consumeTask){
        consumeTaskService.add(consumeTask);
        WebResult webResult=new WebResult();
        return JSON.toJSONString(webResult);
    }
}
