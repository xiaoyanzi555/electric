package com.entity;

import com.service.DictionaryService;
import org.springframework.format.annotation.DateTimeFormat;

public class User {
    private Integer id;
    private Integer sex;
    private Integer role_id;
    private Integer account_state;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private String birthday;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private String hiredate_time;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private String recent_login;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private String dimission_time;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private String register_time;
    private String account;
    private String uname;
    private String password;
    private String phone;
    private String email;
    private String roleName;//查询角色名称
    private String salt;

    public String getSalt() {
        return salt;
    }

    public void setSalt(String salt) {
        this.salt = salt;
    }

    public String getRoleName() {
        return roleName;
    }

    public void setRoleName(String roleName) {
        this.roleName = roleName;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getSex() {
        return sex;
    }

    public void setSex(Integer sex) {
        this.sex = sex;
    }

    public Integer getRole_id() {
        return role_id;
    }

    public void setRole_id(Integer role_id) {
        this.role_id = role_id;
    }

    public Integer getAccount_state() {
        return account_state;
    }

    public void setAccount_state(Integer account_state) {
        this.account_state = account_state;
    }

    public String getBirthday() {
        return birthday;
    }

    public void setBirthday(String birthday) {
        this.birthday = birthday;
    }

    public String getHiredate_time() {
        return hiredate_time;
    }

    public void setHiredate_time(String hiredate_time) {
        this.hiredate_time = hiredate_time;
    }

    public String getRecent_login() {
        return recent_login;
    }

    public void setRecent_login(String recent_login) {
        this.recent_login = recent_login;
    }

    public String getDimission_time() {
        return dimission_time;
    }

    public void setDimission_time(String dimission_time) {
        this.dimission_time = dimission_time;
    }

    public String getRegister_time() {
        return register_time;
    }

    public void setRegister_time(String register_time) {
        this.register_time = register_time;
    }

    public String getAccount() {
        return account;
    }

    public void setAccount(String account) {
        this.account = account;
    }

    public String getUname() {
        return uname;
    }

    public void setUname(String uname) {
        this.uname = uname;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getAccount_stateString(){
        return DictionaryService.load("account_state",this.account_state+"");
    }


}
