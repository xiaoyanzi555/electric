package com.utils;

public class WebResult<T> {
   private String msg;
   private Integer code;
   private T data;

    public WebResult() {
        this(200);
    }
    public WebResult(Integer code){
        this(code,"操作成功");
    }
    public WebResult(Integer code,String msg){
        this(code,msg,null);
    }
    public WebResult(Integer code,String msg, T data) {
        this.msg = msg;
        this.code = code;
        this.data = data;
    }
    public WebResult(T data){
        this(200,"操作成功",data);
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Integer getCode() {
        return code;
    }

    public void setCode(Integer code) {
        this.code = code;
    }

    public T getData() {
        return data;
    }

    public void setData(T data) {
        this.data = data;
    }
}
