package com.wf.Bean;

import java.util.List;

/**
 * 用于显示分页信息
 */
public class Page<T> {
    private Integer pageSize=10;//页面默显示显示记录条数
    private Integer pageno=1;//当前页码
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

        this.pageSize = pageSize;
    }

    public Integer getPageno() {
        return pageno;
    }

    public void setPageno(Integer pageno) {
        //设置分页查询起始下标

        this.pageno = pageno;
    }


    public  void setHaspreviousPageAndHasNextPage(){
        Integer pages = this.pages;//获取总页数
        Integer pageno = this.pageno;//获取当前页码 2
        //当前页码等于总页数
        if (pageno == 1 && pageno == pages) {
            //即没有上一页也没有下一页
           this.haspreviousPage=false;//没前一页
            this.hasNextPage=false;//没有下一页
        }else if (pageno==1&&pageno < pages) {
            //应该有下一页和尾页
            this.haspreviousPage=false;//没前一页
            this.hasNextPage=true;//有下一页
        } else if (pageno < pages) {
            //应该有下一页和尾页
            this.haspreviousPage=true;//没前一页
            this.hasNextPage=true;//有下一页
        } else if (pageno != 1 && pageno == pages) {
            //应该有上一页和首页
            this.haspreviousPage=true;//没前一页
            this.hasNextPage=false;//没有下一页
        }
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
                ", total=" + total +
                ", pages=" + pages +
                ", list=" + list +
                ", haspreviousPage=" + haspreviousPage +
                ", hasNextPage=" + hasNextPage +
                '}';
    }
}
