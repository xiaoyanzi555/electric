package com.utils;

import java.util.ArrayList;
import java.util.List;

/*分页工具类*/
public class Page<T> {
    private Integer totals=0;//总记录数
    private Integer totalPages=0;//总页码数
    private Integer start=0;//当前页起始的数据id位置
    private Integer rows=3;//一页记录数
    private Integer page=1;//当前页

    private Integer prev=0;//上一页
    private Integer next=2;//下一页
    private Integer startPage=1;//起始页码数
    private Integer endPage;//截止页码数
    private Integer  pages=10;//显示一屏页码数
    private List<T> list=new ArrayList<>();//一页记录数

    public Page(int totals, int page, int rows){
        this.totals=totals;
        this.page=page;
        this.rows=rows;
        //计算分页相关参数
        this.totalPages=totals%rows==0?totals/rows:totals/rows+1;
        this.prev=page-1;
        this.next=page+1;
        if (this.next>this.totalPages){
            this.next=this.totalPages;
        }
        if (this.page>6){
            this.startPage=this.page-5;
        }
        this.endPage=this.startPage+pages-1;
        if (this.endPage>this.totalPages){
            this.endPage=this.totalPages;
        }
        this.start=(this.page-1)*this.rows;//确定起始位置
    }
    public Integer getTotalPages() {
        return totalPages;
    }

    public void setTotalPages(Integer totalPages) {
        this.totalPages = totalPages;
    }

    public Integer getPrev() {
        return prev;
    }

    public void setPrev(Integer prev) {
        this.prev = prev;
    }

    public Integer getNext() {
        return next;
    }

    public void setNext(Integer next) {
        this.next = next;
    }

    public Integer getStartPage() {
        return startPage;
    }

    public void setStartPage(Integer startPage) {
        this.startPage = startPage;
    }

    public Integer getEndPage() {
        return endPage;
    }

    public void setEndPage(Integer endPage) {
        this.endPage = endPage;
    }



    public Integer getTotals() {
        return totals;
    }

    public void setTotals(Integer totals) {
        this.totals = totals;
    }

    public Integer getPages() {
        return pages;
    }

    public void setPages(Integer pages) {
        this.pages = pages;
    }

    public Integer getStart() {
        return start;
    }

    public void setStart(Integer start) {
        this.start = start;
    }

    public Integer getRows() {
        return rows;
    }

    public void setRows(Integer rows) {
        this.rows = rows;
    }

    public List<T> getList() {
        return list;
    }

    public void setList(List<T> list) {
        this.list = list;
    }

    public Integer getPage() {
        return page;
    }

    public void setPage(Integer page) {
        this.page = page;
    }
}
