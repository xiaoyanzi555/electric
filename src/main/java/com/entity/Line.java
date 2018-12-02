package com.entity;

import com.service.DictionaryService;
import org.springframework.format.annotation.DateTimeFormat;

/**
 * 线路表
 */
public class Line {
    private Integer id;
    private Integer elec_grade;
    private String line_name;
    private String line_code;
    private String line_len;
    private String loop_len;
    private Integer tower_base;
    private String start_pole;
    private String end_pole;
    private String remake;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private String deliver_time;

    private Integer use_state;
    private Integer run_state;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getElec_grade() {
        return elec_grade;
    }

    public void setElec_grade(Integer elec_grade) {
        this.elec_grade = elec_grade;
    }

    public String getLine_name() {
        return line_name;
    }

    public void setLine_name(String line_name) {
        this.line_name = line_name;
    }

    public String getLine_code() {
        return line_code;
    }

    public void setLine_code(String line_code) {
        this.line_code = line_code;
    }

    public String getLine_len() {
        return line_len;
    }

    public void setLine_len(String line_len) {
        this.line_len = line_len;
    }

    public String getLoop_len() {
        return loop_len;
    }

    public void setLoop_len(String loop_len) {
        this.loop_len = loop_len;
    }

    public Integer getTower_base() {
        return tower_base;
    }

    public void setTower_base(Integer tower_base) {
        this.tower_base = tower_base;
    }

    public String getStart_pole() {
        return start_pole;
    }

    public void setStart_pole(String start_pole) {
        this.start_pole = start_pole;
    }

    public String getEnd_pole() {
        return end_pole;
    }

    public void setEnd_pole(String end_pole) {
        this.end_pole = end_pole;
    }

    public String getRemake() {
        return remake;
    }

    public void setRemake(String remake) {
        this.remake = remake;
    }

    public String getDeliver_time() {
        return deliver_time;
    }

    public void setDeliver_time(String deliver_time) {
        this.deliver_time = deliver_time;
    }

    public Integer getUse_state() {
        return use_state;
    }

    public void setUse_state(Integer use_state) {
        this.use_state = use_state;
    }

    public Integer getRun_state() {
        return run_state;
    }

    public void setRun_state(Integer run_state) {
        this.run_state = run_state;
    }

    public  String getUse_stateString(){
        return DictionaryService.load("use_state",this.use_state+"");
    }
    public  String getRun_stateString(){
        return DictionaryService.load("run_state",this.run_state+"");
    }
}
