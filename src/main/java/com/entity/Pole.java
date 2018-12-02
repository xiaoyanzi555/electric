package com.entity;

import com.service.DictionaryService;

/**
 * 杆塔表
 */
public class Pole {
    private Integer id;
    private String pole_code;//pole的编号
    private Integer line_id;//线路id
    private Integer task_id;//任务编号id
    private Integer use_state;
    private String line_name;
    private String line_code;//线路编号
    private Defect defect;//缺陷表

    public Defect getDefect() {
        return defect;
    }

    public void setDefect(Defect defect) {
        this.defect = defect;
    }

    public Integer getTask_id() {
        return task_id;
    }

    public void setTask_id(Integer task_id) {
        this.task_id = task_id;
    }

    public String getLine_code() {
        return line_code;
    }

    public void setLine_code(String line_code) {
        this.line_code = line_code;
    }

    public String getLine_name() {
        return line_name;
    }

    public void setLine_name(String line_name) {
        this.line_name = line_name;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getPole_code() {
        return pole_code;
    }

    public void setPole_code(String pole_code) {
        this.pole_code = pole_code;
    }

    public Integer getLine_id() {
        return line_id;
    }

    public void setLine_id(Integer line_id) {
        this.line_id = line_id;
    }

    public Integer getUse_state() {
        return use_state;
    }

    public void setUse_state(Integer use_state) {
        this.use_state = use_state;
    }
    public  String getUse_stateString(){
        return DictionaryService.load("use_state",this.use_state+"");
    }
}
