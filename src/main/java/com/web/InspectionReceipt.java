package com.web;

import com.alibaba.fastjson.JSON;

import com.entity.*;
import com.service.*;
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
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class InspectionReceipt {
    @Autowired
    private InspectionService inspectionService;
    @Autowired
    private UserInsConService userInsConService;
    @Autowired
    private UserService userService;
    @Autowired
    private PoleService poleService;
    @Autowired
    DefectService defectService;
    @ResponseBody
    @RequestMapping(value = "/inspectionReceipt",method = RequestMethod.GET,produces = "application/json;charset=utf-8")
    public String find(Inspection inspection, int page, int rows, HttpServletRequest request){
        //查询当前用户的巡检信息
        User user= (User) request.getSession().getAttribute("user");
        //只能查看自己的任务
        inspection.setLeader_id(user.getId());
        //除开待分配的任务
        Page<Inspection> pageBean=inspectionService.findExceptNoDis(inspection,page,rows);
        Map<String,Object> data= EasyUIAdapter.datagridMap(pageBean);
        WebResult webResult=new WebResult(data);
        return JSON.toJSONString(webResult);
    }

    //查询单个所有的信息
    @ResponseBody
    @RequestMapping(value = "/inspectionReceipt",
            headers = "select=all_detail",method = RequestMethod.GET,produces = "application/json;charset=utf-8")
    public String findAllDetailById(Inspection inspection){
       //通过taskid查取出里面的所有task信息
        Inspection dbInspection=inspectionService.findById(inspection.getId());
        //通过任务id查取出中间表巡检员的信息
        UserInsCon userInsCon=new UserInsCon();
        userInsCon.setTask_id(inspection.getId());
        userInsCon.setPos_type(1);//巡检任务
        List<UserInsCon> uic_list=userInsConService.find(userInsCon);
        //得到user的id在查取出user的集合
        //构建user集合
        List<User> user_list=new ArrayList<>();
        if (uic_list!=null && uic_list.size()>0){
            for(UserInsCon uic:uic_list){
                User user=userService.findById(uic.getStaff_id());
                user_list.add(user);
            }
        }
        //通过线路的id查取出所有杆塔的信息
        Pole pole=new Pole();
        pole.setLine_id(inspection.getLine_id());
        List<Pole> pole_list=poleService.findByEntity_hasDefect(pole);
        //将所有的信息存储在一个map集合里面
        Map<String,Object> data=new HashMap<>();
        data.put("dbInspection",dbInspection);
        data.put("pole_list",pole_list);
        data.put("user_list",user_list);
        WebResult webResult=new WebResult(data);
        return JSON.toJSONString(webResult);
    }
}
