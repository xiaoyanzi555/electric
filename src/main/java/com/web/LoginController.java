package com.web;

import com.alibaba.fastjson.JSON;
import com.entity.User;
import com.service.UserService;
import com.utils.WebResult;
import org.apache.shiro.web.session.HttpServletSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;
import java.net.URI;


@Controller
public class LoginController {
    @Autowired
    private UserService userService;
    @ResponseBody
    @RequestMapping(value = "/login",method = RequestMethod.GET,produces = {"application/json;charset=utf-8"})
    public String login(User user,HttpServletRequest request){
        //查找出所有的用户
        User dbuser=userService.findByAccount(user);
        //判断用户输入密码和数据库密码
        if (dbuser.getPassword().equals(user.getPassword())){
            //放在session里面
            request.getSession().setAttribute("user", dbuser);
            WebResult webResult=new WebResult();
            return JSON.toJSONString(webResult);
        }else {
            WebResult webResult=new WebResult(404,"密码错误");
            return JSON.toJSONString(webResult);
        }
    }
}
