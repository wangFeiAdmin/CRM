package com.wf.Bean;

import java.util.List;

/**
 * 用于显示分页信息
 */
public class Page<T> {
    private Integer pageSize=10;//页面默显示显示记录条数
    private Integer pageno=1;//当前页码
    private Integer limitIndex;//分页查询起始页码
    private Long total=0L;//总记录数
    private Integer pages=0;//总页数
    private List<T> list;//装载信息
    private Boolean  haspreviousPage;//是否有前一页
    private Boolean hasNextPage;//是否有下一页
    public Page() {
    }

    public Boolean getHaspreviousPage() {
        return haspreviousPage;
    }

    public void setHaspreviousPage(Boolean haspreviousPage) {
        this.haspreviousPage = haspreviousPage;
    }

    public Boolean getHasNextPage() {
        return hasNextPage;
    }

    public void setHasNextPage(Boolean hasNextPage) {
        this.hasNextPage = hasNextPage;
    }

    public Integer getPageSize() {
        return pageSize;
    }

    public void setPageSize(Integer pageSize) {
        //设置分页查询起始下标
        this.limitIndex=(pageno-1)*pageSize;
        this.pageSize = pageSize;
    }

    public Integer getPageno() {
        return pageno;
    }

    public void setPageno(Integer pageno) {
        //设置分页查询起始下标
        this.limitIndex=(pageno-1)*pageSize;
        this.pageno = pageno;
    }

    public Integer getLimitIndex() {
        return limitIndex;
    }



    public Long getTotal() {
        return total;
    }

    public void setTotal(Long total) {
        this.total = total;
    }

    public Integer getPages() {
        return pages;
    }

    public void setPages(Integer pages) {
        this.pages = pages;
    }

    public List<T> getList() {
        return list;
    }

    public void setList(List<T> list) {
        this.list = list;
    }

    @Override
    public String toString() {
        return "Page{" +
                "pageSize=" + pageSize +
                ", pageno=" + pageno +
                ", limitIndex=" + limitIndex +
                ", total=" + total +
                ", pages=" + pages +
                ", list=" + list +
                ", haspreviousPage=" + haspreviousPage +
                ", hasNextPage=" + hasNextPage +
                '}';
    }
}
