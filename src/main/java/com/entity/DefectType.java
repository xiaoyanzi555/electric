package com.entity;

public class DefectType {
    private Integer id;
    private String defect_type;
    private Integer use_state;
    private boolean checked=true;//判断是否选中,默认选中

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

    public String getDefect_type() {
        return defect_type;
    }

    public void setDefect_type(String defect_type) {
        this.defect_type = defect_type;
    }

    public Integer getUse_state() {
        return use_state;
    }

    public void setUse_state(Integer use_state) {
        this.use_state = use_state;
    }
}
