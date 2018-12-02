package com.entity;

import com.service.DictionaryService;
import org.springframework.format.annotation.DateTimeFormat;

public class Defect {
    private Integer id;
    private Integer work_documents;
    private Integer task_state;
    private Integer defect_type;
    private Integer task_id;
    private Integer pole_id;
    private Integer line_id;
    private String rate;
    private String defect_description;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private String find_time;
    private String defect_type_string;
    private Integer find_user_id;
    private String find_user_name;//缺陷发现人
    private String distribute_user;//下发人
    private String distribute_time;//下时间
    private String task_code;//任务编号
    private String line_code;//线路编号
    private String pole_code;//杆塔编号
    private Integer defect_grade;
    private Integer isComsume;

    public Integer getWork_documents() {
        return work_documents;
    }

    public void setWork_documents(Integer work_documents) {
        this.work_documents = work_documents;
    }

    public Integer getTask_state() {
        return task_state;
    }

    public void setTask_state(Integer task_state) {
        this.task_state = task_state;
    }

    public Integer getIsComsume() {
        return isComsume;
    }

    public void setIsComsume(Integer isComsume) {
        this.isComsume = isComsume;
    }

    public String getDistribute_user() {
        return distribute_user;
    }

    public void setDistribute_user(String distribute_user) {
        this.distribute_user = distribute_user;
    }

    public String getDistribute_time() {
        return distribute_time;
    }

    public void setDistribute_time(String distribute_time) {
        this.distribute_time = distribute_time;
    }

    public String getTask_code() {
        return task_code;
    }

    public void setTask_code(String task_code) {
        this.task_code = task_code;
    }

    public String getLine_code() {
        return line_code;
    }

    public void setLine_code(String line_code) {
        this.line_code = line_code;
    }

    public String getPole_code() {
        return pole_code;
    }

    public void setPole_code(String pole_code) {
        this.pole_code = pole_code;
    }

    public String getFind_user_name() {
        return find_user_name;
    }

    public void setFind_user_name(String find_user_name) {
        this.find_user_name = find_user_name;
    }

    public String getDefect_type_string() {
        return defect_type_string;
    }

    public void setDefect_type_string(String defect_type_string) {
        this.defect_type_string = defect_type_string;
    }

    public Integer getLine_id() {
        return line_id;
    }

    public void setLine_id(Integer line_id) {
        this.line_id = line_id;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getDefect_type() {
        return defect_type;
    }

    public void setDefect_type(Integer defect_type) {
        this.defect_type = defect_type;
    }

    public Integer getTask_id() {
        return task_id;
    }

    public void setTask_id(Integer task_id) {
        this.task_id = task_id;
    }

    public Integer getPole_id() {
        return pole_id;
    }

    public void setPole_id(Integer pole_id) {
        this.pole_id = pole_id;
    }

    public String getRate() {
        return rate;
    }

    public void setRate(String rate) {
        this.rate = rate;
    }

    public String getDefect_description() {
        return defect_description;
    }

    public void setDefect_description(String defect_description) {
        this.defect_description = defect_description;
    }

    public String getFind_time() {
        return find_time;
    }

    public void setFind_time(String find_time) {
        this.find_time = find_time;
    }

    public Integer getFind_user_id() {
        return find_user_id;
    }

    public void setFind_user_id(Integer find_user_id) {
        this.find_user_id = find_user_id;
    }

    public Integer getDefect_grade() {
        return defect_grade;
    }

    public void setDefect_grade(Integer defect_grade) {
        this.defect_grade = defect_grade;
    }

    public String getDefect_gradeString(){
        return DictionaryService.load("defect_grade",this.getDefect_grade()+"");
    }
    public String getTask_stateString(){
        return DictionaryService.load("task_state",this.getTask_state()+"");
    }
    public String getWork_documentsString(){
        return DictionaryService.load("work_documents",this.getWork_documents()+"");
    }
}
