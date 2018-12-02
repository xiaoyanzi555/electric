package com.entity;
//消缺和缺陷的中间表
public class ComsumeDefect {
    private Integer id;
    private Integer comsume_id;
    private Integer defect_id;
    private Integer is_deal;

    public Integer getIs_deal() {
        return is_deal;
    }

    public void setIs_deal(Integer is_deal) {
        this.is_deal = is_deal;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getComsume_id() {
        return comsume_id;
    }

    public void setComsume_id(Integer comsume_id) {
        this.comsume_id = comsume_id;
    }

    public Integer getDefect_id() {
        return defect_id;
    }

    public void setDefect_id(Integer defect_id) {
        this.defect_id = defect_id;
    }
}
