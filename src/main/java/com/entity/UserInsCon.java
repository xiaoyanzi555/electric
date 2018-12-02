package com.entity;

public class UserInsCon {
    private Integer id;
    private Integer staff_id;
    private Integer task_id;
    private Integer pos_type;
    //巡检和消缺的中间表

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getStaff_id() {
        return staff_id;
    }

    public void setStaff_id(Integer staff_id) {
        this.staff_id = staff_id;
    }

    public Integer getTask_id() {
        return task_id;
    }

    public void setTask_id(Integer task_id) {
        this.task_id = task_id;
    }

    public Integer getPos_type() {
        return pos_type;
    }

    public void setPos_type(Integer pos_type) {
        this.pos_type = pos_type;
    }
}
