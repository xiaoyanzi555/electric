package com.entity;

import com.service.DictionaryService;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.List;

public class Inspection {
    private Integer id;
    private Integer line_id;
    private Integer distribute_id;
    private Integer task_state;
    private Integer task_cancel;
    private Integer leader_id;//组长id
    private String task_code;
    private String task_name;
    private String start_pole_code;
    private String end_pole_code;
    private String remark;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private String distribute_time;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private String task_end_time;

    public Integer getLeader_id() {
        return leader_id;
    }

    public void setLeader_id(Integer leader_id) {
        this.leader_id = leader_id;
    }

    private List<Integer> staff_ids;//所有被选中的巡检员id
    private String line_name_String;//巡检线路名称
    private String distribute_name;//下发人

    public String getDistribute_name() {
        return distribute_name;
    }

    public void setDistribute_name(String distribute_name) {
        this.distribute_name = distribute_name;
    }

    public String getLine_name_String() {
        return line_name_String;
    }

    public void setLine_name_String(String line_name_String) {
        this.line_name_String = line_name_String;
    }

    public List<Integer> getStaff_ids() {
        return staff_ids;
    }

    public void setStaff_ids(List<Integer> staff_ids) {
        this.staff_ids = staff_ids;
    }

    public String getStart_pole_code() {
        return start_pole_code;
    }

    public void setStart_pole_code(String start_pole_code) {
        this.start_pole_code = start_pole_code;
    }

    public String getEnd_pole_code() {
        return end_pole_code;
    }

    public void setEnd_pole_code(String end_pole_code) {
        this.end_pole_code = end_pole_code;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getLine_id() {
        return line_id;
    }

    public void setLine_id(Integer line_id) {
        this.line_id = line_id;
    }

    public Integer getDistribute_id() {
        return distribute_id;
    }

    public void setDistribute_id(Integer distribute_id) {
        this.distribute_id = distribute_id;
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

    public String getTask_code() {
        return task_code;
    }

    public void setTask_code(String task_code) {
        this.task_code = task_code;
    }

    public String getTask_name() {
        return task_name;
    }

    public void setTask_name(String task_name) {
        this.task_name = task_name;
    }


    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public String getDistribute_time() {
        return distribute_time;
    }

    public void setDistribute_time(String distribute_time) {
        this.distribute_time = distribute_time;
    }

    public String getTask_end_time() {
        return task_end_time;
    }

    public void setTask_end_time(String task_end_time) {
        this.task_end_time = task_end_time;
    }
    public String getTask_State_String(){
        return DictionaryService.load("task_state",this.getTask_state()+"");
    }
    public String getTask_Cancel_String(){
        return DictionaryService.load("task_cancel",this.getTask_cancel()+"");
    }
}
