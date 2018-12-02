package com.entity;

import org.springframework.format.annotation.DateTimeFormat;

import java.util.List;

public class Role {
    private Integer id;
    private Integer createBy;
    private String createByName;
    private Integer use_state;
    private String role_code;
    private String role_name;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private String modify_date;
    private boolean checked=true;//判断是否选中,默认选中

    public String getCreateByName() {
        return createByName;
    }

    public void setCreateByName(String createByName) {
        this.createByName = createByName;
    }

    public boolean isChecked() {
        return checked;
    }

    public void setChecked(boolean checked) {
        this.checked = checked;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getCreateBy() {
        return createBy;
    }

    public void setCreateBy(Integer createBy) {
        this.createBy = createBy;
    }

    public Integer getUse_state() {
        return use_state;
    }

    public void setUse_state(Integer use_state) {
        this.use_state = use_state;
    }

    public String getRole_code() {
        return role_code;
    }

    public void setRole_code(String role_code) {
        this.role_code = role_code;
    }

    public String getRole_name() {
        return role_name;
    }

    public void setRole_name(String role_name) {
        this.role_name = role_name;
    }

    public String getModify_date() {
        return modify_date;
    }

    public void setModify_date(String modify_date) {
        this.modify_date = modify_date;
    }
}
