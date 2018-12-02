package com.web;

import com.alibaba.fastjson.JSON;
import com.entity.Resource;
import com.entity.Role;
import com.entity.User;
import com.entity.UserInsCon;
import com.service.RoleService;
import com.service.UserService;
import com.utils.Constants;
import com.utils.EasyUIAdapter;
import com.utils.Page;
import com.utils.WebResult;
import org.apache.shiro.SecurityUtils;
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
public class UserController {
    @Autowired
    private UserService userService;
    @Autowired
    private RoleService roleService;
//菜单
    @ResponseBody
    @RequestMapping(value = "/menu", method = RequestMethod.GET,produces = {"application/json;charset=utf-8"})
    public String menu(HttpServletRequest request){
        User user= (User) request.getSession().getAttribute(Constants.CURRENT_USER);
        List<Resource> list=userService.findMenu(user.getAccount());
        List<Map<String,Object>> data=EasyUIAdapter.treeMap(list);
        WebResult result=new WebResult(data);
        return JSON.toJSONString(result);
    }
    //注销
    @RequestMapping(value = "/logout", method = RequestMethod.GET)
    public void logout(HttpServletRequest request){
        //注销
        SecurityUtils.getSecurityManager().logout(SecurityUtils.getSubject());
        ((HttpServletRequest)request).getSession().removeAttribute(Constants.CURRENT_USER);
        //session中删除当前用户
    }
    @ResponseBody
    @RequestMapping(value ="/users",method = RequestMethod.GET,produces = {"application/json;charset=utf-8"})
    public String find(User user, Integer page, Integer rows){
        Page pageBean=userService.find(user,page,rows);
        Map<String,Object> map=EasyUIAdapter.datagridMap(pageBean);
        WebResult webResult=new WebResult(map);
        return JSON.toJSONString(webResult);
    }
    //查询中间表用户
    @ResponseBody
    @RequestMapping(value ="/users",method = RequestMethod.GET,
            headers = "select=uic",produces = {"application/json;charset=utf-8"})
    public String findUIC(UserInsCon userInsCon){
        List list=userService.findByUIC(userInsCon);
        WebResult webResult=new WebResult(list);
        return JSON.toJSONString(webResult);
    }

    //查询单个用户
    @ResponseBody
    @RequestMapping(value = "/users/{id}", method = RequestMethod.GET,produces = {"application/json;charset=utf-8"})
    public String findById(@PathVariable("id")Integer id){
        User user=userService.findById(id);
        WebResult webResult=new WebResult(user);
        return JSON.toJSONString(webResult);
    }
    //根据传入的数据查取出对应的用户
    @ResponseBody
    @RequestMapping(value = "/users", method = RequestMethod.GET,
            headers = "data=all",produces = {"application/json;charset=utf-8"})
    public String findAll(){
        List<User> list=userService.findAll();
        List data=EasyUIAdapter.combobox_User(list,null);
        WebResult webResult=new WebResult(data);
        return JSON.toJSONString(webResult);
    }
    //查取所有用户在下拉框进行显示
    //添加
    @ResponseBody
    @RequestMapping(value = "/users", method = RequestMethod.POST,produces = {"application/json;charset=utf-8"})
    public String add(User user){
        user=userService.add(user);
        WebResult webResult=new WebResult(user);
        return JSON.toJSONString(webResult);
    }
    //修改
    @ResponseBody
    @RequestMapping(value = "/users", method = RequestMethod.PUT,produces = {"application/json;charset=utf-8"})
    public String edit(User user, HttpServletRequest request){
        user=userService.update(user);
        //将修改的数据再次覆盖session中的数据
        request.getSession().setAttribute("user",user);
        WebResult webResult=new WebResult(user);
        return JSON.toJSONString(webResult);
    }
    //批量修改
    @ResponseBody
    @RequestMapping(value = "/users/{id}", method = RequestMethod.PUT,produces = {"application/json;charset=utf-8"})
    public String edit_more(@PathVariable("id") Integer[] id){
        userService.update(id);
        WebResult webResult=new WebResult();
        return JSON.toJSONString(webResult);
    }
    //删除
    @ResponseBody
    @RequestMapping(value = "/users/{id}", method = RequestMethod.DELETE,produces = {"application/json;charset=utf-8"})
    public String delete(@PathVariable("id") Integer[] id){
        User[] users=userService.delete(id);
        WebResult webResult=new WebResult(users);
        return JSON.toJSONString(webResult);
    }

}
