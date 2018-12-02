package com.web;

import com.alibaba.fastjson.JSON;
import com.entity.Role;
import com.entity.User;
import com.service.RoleService;
import com.service.UserService;
import com.utils.EasyUIAdapter;
import com.utils.Page;
import com.utils.WebResult;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.authz.annotation.RequiresRoles;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;
import java.util.Map;

@Controller
public class RoleController {
    @Autowired
    private RoleService roleService;
    @Autowired UserService userService;
    @ResponseBody
    //@RequiresRoles("admin")//粗粒度,试用网站
    @RequiresPermissions("roles:list")
    @RequestMapping(value ="/roles",method = RequestMethod.GET,produces = {"application/json;charset=utf-8"})
    public String find(Role role, Integer page, Integer rows){
        Page pageBean=roleService.find(role,page,rows);
        Map<String,Object> map=EasyUIAdapter.datagridMapChecked_Role(pageBean);
        WebResult webResult=new WebResult(map);
        return JSON.toJSONString(webResult);
    }
    //通过用户角色名称查取id值
    @ResponseBody
    @RequestMapping(value ="/roles",method = RequestMethod.GET,
            headers = "select=ins",produces = {"application/json;charset=utf-8"})
    public String find_roleid_by_roleName(Role roleName){
        Role role=roleService.findEntity(roleName);
        WebResult webResult=new WebResult(role);
        return JSON.toJSONString(webResult);
    }
    //查找所有roles以role_name为value，role_name为文本
    @ResponseBody
    @RequestMapping(value ="/roles",method = RequestMethod.GET,
            headers = "select=role_name",produces = {"application/json;charset=utf-8"})
    public String find(){
        List<Role> list=roleService.findAll();
        List data=EasyUIAdapter.datagridMap_Role(list);
        WebResult webResult=new WebResult(data);
        return JSON.toJSONString(webResult);
    }
    //查找所有//查找所有roles以role_id为value，role_name为文本
    @ResponseBody
    @RequestMapping(value ="/roles/{id}",method = RequestMethod.GET,
            headers = "select=role_name_id",produces = {"application/json;charset=utf-8"})
    public String findAll(@PathVariable("id") Integer id){
        User user=userService.findById(id);
        List<Role> list=roleService.findAll();
        List data=EasyUIAdapter.datagridMap_Role_id(list,user);
        WebResult webResult=new WebResult(data);
        return JSON.toJSONString(webResult);
    }
    //查询指定角色下的用户
    @ResponseBody
    @RequestMapping(value = "/roles/{id}/users", method = RequestMethod.GET,produces = {"application/json;charset=utf-8"})
    public String findUsersByRoleId(@PathVariable("id")Integer id){
        List<User> users=userService.findUsersByRoleId(id);
        List list=EasyUIAdapter.combobox_User(users,null);
        WebResult webResult=new WebResult(list);
        return JSON.toJSONString(webResult);
    }
    @ResponseBody
    @RequestMapping(value ="/roles/{id}",method = RequestMethod.GET,produces = {"application/json;charset=utf-8"})
    public String findById(@PathVariable("id")Integer id){
        Role role=roleService.findById(id);
        WebResult webResult=new WebResult(role);
        return JSON.toJSONString(webResult);
    }

    //添加
    @ResponseBody
    @RequestMapping(value ="/roles",method = RequestMethod.POST,produces = {"application/json;charset=utf-8"})
    public String add(Role role){
        role=roleService.add(role);
        WebResult webResult=new WebResult();
        return JSON.toJSONString(webResult);
    }
    //修改
    @ResponseBody
    @RequestMapping(value ="/roles",method = RequestMethod.PUT,produces = {"application/json;charset=utf-8"})
    public String edit(Role role){
        role=roleService.update(role);
        WebResult webResult=new WebResult(role);
        return JSON.toJSONString(webResult);
    }
    //删除
    @ResponseBody
    @RequestMapping(value ="/roles/{id}",method = RequestMethod.DELETE,produces = {"application/json;charset=utf-8"})
    public String delete(@PathVariable("id") Integer[] id){
        Role[] roles=roleService.delete(id);
        WebResult webResult=new WebResult(roles);
        return JSON.toJSONString(webResult);
    }
}
