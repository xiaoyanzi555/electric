package com.entity;

import com.service.DictionaryService;
import org.springframework.format.annotation.DateTimeFormat;

public class WorkTask {
    private Integer id;
    private Integer owner_id;
    private Integer wait_task_type;
    private Integer wait_task_id;
    private String wait_task_name;
    private Integer is_deal;
    private Integer roleid;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private String arrive_time;

    public Integer getRoleid() {
        return roleid;
    }

    public void setRoleid(Integer roleid) {
        this.roleid = roleid;
    }

    public String getWait_task_name() {
        return wait_task_name;
    }

    public Integer getIs_deal() {
        return is_deal;
    }

    public void setIs_deal(Integer is_deal) {
        this.is_deal = is_deal;
    }

    public void setWait_task_name(String wait_task_name) {
        this.wait_task_name = wait_task_name;
    }

    public String getArrive_time() {
        return arrive_time;
    }

    public void setArrive_time(String arrive_time) {
        this.arrive_time = arrive_time;
    }

    public Integer getOwner_id() {
        return owner_id;
    }

    public void setOwner_id(Integer owner_id) {
        this.owner_id = owner_id;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getWait_task_type() {
        return wait_task_type;
    }

    public void setWait_task_type(Integer wait_task_type) {
        this.wait_task_type = wait_task_type;
    }

    public Integer getWait_task_id() {
        return wait_task_id;
    }

    public void setWait_task_id(Integer wait_task_id) {
        this.wait_task_id = wait_task_id;
    }

    public String getWait_task_type_String(){
        return DictionaryService.load("wait_task_type",this.wait_task_type+"");
    }
}
