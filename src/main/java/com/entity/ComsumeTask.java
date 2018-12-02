package com.entity;

import com.service.DictionaryService;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.List;

public class ComsumeTask {
    private Integer id;
    private String consume_task_code;
    private Integer task_state;
    private Integer task_cancel;
    private Integer pass;
    private Integer find_id;
    private Integer defect_grade;
    private Integer work_documents;
    private Integer task_user_id;
    private String task_user_name;//任务负责人
    private String distribution_id;
    private String task_name;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private String distribute_time;
    private String task_description;
    private String remark;
    private String responsible_idea;
    private String execution_description;
    private String distribution_idea;
    private String overtime_record;
    private String end_record;
    private String rate;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private String find_time;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private String task_complete_time;
    private String distribution_name;
    private List<Integer> consomers;//消缺人员
    private List<Integer> defects;//缺陷编号

    public String getTask_user_name() {
        return task_user_name;
    }

    public void setTask_user_name(String task_user_name) {
        this.task_user_name = task_user_name;
    }

    public String getDistribution_name() {
        return distribution_name;
    }

    public void setDistribution_name(String distribution_name) {
        this.distribution_name = distribution_name;
    }

    public String getDistribute_time() {
        return distribute_time;
    }

    public void setDistribute_time(String distribute_time) {
        this.distribute_time = distribute_time;
    }

    public String getTask_name() {
        return task_name;
    }

    public void setTask_name(String task_name) {
        this.task_name = task_name;
    }

    public List<Integer> getDefects() {
        return defects;
    }

    public void setDefects(List<Integer> defects) {
        this.defects = defects;
    }

    public String getTask_complete_time() {
        return task_complete_time;
    }

    public void setTask_complete_time(String task_complete_time) {
        this.task_complete_time = task_complete_time;
    }

    public String getConsume_task_code() {
        return consume_task_code;
    }

    public void setConsume_task_code(String consume_task_code) {
        this.consume_task_code = consume_task_code;
    }

    public List<Integer> getConsomers() {
        return consomers;
    }

    public void setConsomers(List<Integer> consomers) {
        this.consomers = consomers;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }


    public Integer getTask_state() {
        return task_state;
    }

    public void setTask_state(Integer task_state) {
        this.task_state = task_state;
    }

    public Integer getTask_cancel() {
        return task_cancel;
    }

    public void setTask_cancel(Integer task_cancel) {
        this.task_cancel = task_cancel;
    }

    public Integer getPass() {
        return pass;
    }

    public void setPass(Integer pass) {
        this.pass = pass;
    }

    public Integer getFind_id() {
        return find_id;
    }

    public void setFind_id(Integer find_id) {
        this.find_id = find_id;
    }

    public Integer getDefect_grade() {
        return defect_grade;
    }

    public void setDefect_grade(Integer defect_grade) {
        this.defect_grade = defect_grade;
    }

    public Integer getWork_documents() {
        return work_documents;
    }

    public void setWork_documents(Integer work_documents) {
        this.work_documents = work_documents;
    }

    public Integer getTask_user_id() {
        return task_user_id;
    }

    public void setTask_user_id(Integer task_user_id) {
        this.task_user_id = task_user_id;
    }

    public String getDistribution_id() {
        return distribution_id;
    }

    public void setDistribution_id(String distribution_id) {
        this.distribution_id = distribution_id;
    }


    public String getTask_description() {
        return task_description;
    }

    public void setTask_description(String task_description) {
        this.task_description = task_description;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public String getResponsible_idea() {
        return responsible_idea;
    }

    public void setResponsible_idea(String responsible_idea) {
        this.responsible_idea = responsible_idea;
    }

    public String getExecution_description() {
        return execution_description;
    }

    public void setExecution_description(String execution_description) {
        this.execution_description = execution_description;
    }

    public String getDistribution_idea() {
        return distribution_idea;
    }

    public void setDistribution_idea(String distribution_idea) {
        this.distribution_idea = distribution_idea;
    }

    public String getOvertime_record() {
        return overtime_record;
    }

    public void setOvertime_record(String overtime_record) {
        this.overtime_record = overtime_record;
    }

    public String getEnd_record() {
        return end_record;
    }

    public void setEnd_record(String end_record) {
        this.end_record = end_record;
    }

    public String getRate() {
        return rate;
    }

    public void setRate(String rate) {
        this.rate = rate;
    }

    public String getFind_time() {
        return find_time;
    }

    public void setFind_time(String find_time) {
        this.find_time = find_time;
    }
    public String getWork_documents_String(){
        return DictionaryService.load("work_documents",this.work_documents+"");
    }
    public String getTask_State_String(){
        return DictionaryService.load("task_state",this.task_state+"");
    }
    public String getTask_Cancel_String(){
        return DictionaryService.load("task_cancel",this.task_cancel+"");
    }
}
