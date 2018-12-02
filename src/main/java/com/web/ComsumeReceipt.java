package com.web;

import com.alibaba.fastjson.JSON;
import com.entity.ComsumeTask;
import com.service.ComsumeTaskService;
import com.utils.EasyUIAdapter;
import com.utils.Page;
import com.utils.WebResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Map;

@Controller
public class ComsumeReceipt {
    @Autowired
    private ComsumeTaskService comsumeTaskService;
    @ResponseBody
    @RequestMapping(value = "/consumeReceipt",method = RequestMethod.GET,produces = {"application/json;charset=utf-8"})
    public String find(ComsumeTask consumeTask, int page, int rows){
        Page<ComsumeTask> pageBean=comsumeTaskService.findNoDis(consumeTask,page,rows);
        Map<String,Object> data= EasyUIAdapter.datagridMap(pageBean);
        WebResult webResult=new WebResult(data);
        return JSON.toJSONString(webResult);
    }
}
