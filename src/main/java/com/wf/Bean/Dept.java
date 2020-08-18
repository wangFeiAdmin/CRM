package com.wf.Bean;

import org.springframework.stereotype.Component;

@Component
public class Dept {
    private String id;//主键
    private String deptNo;//部门编号
    private String deptName;//部门名称
    private String deptfunctionary;//部门负责人
    private String deptphone;//部门电话
    private String deptremark;//部门描述

    public Dept() {
    }

    public Dept(String id, String deptNo, String deptName, String deptfunctionary, String deptphone, String deptremark) {
        this.id = id;
        this.deptNo = deptNo;
        this.deptName = deptName;
        this.deptfunctionary = deptfunctionary;
        this.deptphone = deptphone;
        this.deptremark = deptremark;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getDeptNo() {
        return deptNo;
    }

    public void setDeptNo(String deptNo) {
        this.deptNo = deptNo;
    }

    public String getDeptName() {
        return deptName;
    }

    public void setDeptName(String deptName) {
        this.deptName = deptName;
    }

    public String getDeptfunctionary() {
        return deptfunctionary;
    }

    public void setDeptfunctionary(String deptfunctionary) {
        this.deptfunctionary = deptfunctionary;
    }

    public String getDeptphone() {
        return deptphone;
    }

    public void setDeptphone(String deptphone) {
        this.deptphone = deptphone;
    }

    public String getDeptremark() {
        return deptremark;
    }

    public void setDeptremark(String deptremark) {
        this.deptremark = deptremark;
    }

    @Override
    public String toString() {
        return "Dept{" +
                "id='" + id + '\'' +
                ", deptNo='" + deptNo + '\'' +
                ", deptName='" + deptName + '\'' +
                ", deptfunctionary='" + deptfunctionary + '\'' +
                ", deptphone='" + deptphone + '\'' +
                ", deptremark='" + deptremark + '\'' +
                '}';
    }
}
