package com.entity;

import com.service.DictionaryService;
import org.springframework.format.annotation.DateTimeFormat;

import java.io.Serializable;
import java.util.Date;

public class Resource implements Serializable {
    private Integer id;
    private String url;
    private String menu_class;
    private String menu_name;
    private Integer parent_id;
    private String parent_name;
    private Integer sequence;
    private String menu_type;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date create_time;
    private String permissions;
    private String parent_ids;
    private String icon;

    public Integer getValue(){return this.id;}


    public String getParent_name() {
        return parent_name;
    }

    public void setParent_name(String parent_name) {
        this.parent_name = parent_name;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public String getMenu_class() {
        return menu_class;
    }

    public void setMenu_class(String menu_class) {
        this.menu_class = menu_class;
    }

    public String getMenu_name() {
        return menu_name;
    }

    public void setMenu_name(String menu_name) {
        this.menu_name = menu_name;
    }

    public Integer getParent_id() {
        return parent_id;
    }

    public void setParent_id(Integer parent_id) {
        this.parent_id = parent_id;
    }

    public Integer getSequence() {
        return sequence;
    }

    public void setSequence(Integer sequence) {
        this.sequence = sequence;
    }

    public String getMenu_type() {
        return menu_type;
    }

    public void setMenu_type(String menu_type) {
        this.menu_type = menu_type;
    }

    public Date getCreate_time() {
        return create_time;
    }

    public void setCreate_time(Date create_time) {
        this.create_time = create_time;
    }

    public String getPermissions() {
        return permissions;
    }

    public void setPermissions(String permissions) {
        this.permissions = permissions;
    }

    public String getParent_ids() {
        return parent_ids;
    }

    public String getIcon() {
        return icon;
    }

    public void setIcon(String icon) {
        this.icon = icon;
    }

    public void setParent_ids(String parent_ids) {
        this.parent_ids = parent_ids;
    }
}
