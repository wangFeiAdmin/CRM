package com.wf.Bean;


import org.springframework.stereotype.Component;

import java.util.HashMap;
import java.util.Map;

@Component
public class User {
    private String id;//主键
    private String loginAct;//登录账号
    private String name;//用户名
    private String loginPwd;//密码
    private String email;//邮箱
    private String expireTime;//失效时间
    private String lockState;//锁定状态
    private Dept   dept;//部门编号
    private String allowIps;//允许访问的ip
    private String createTime;//创建时间
    private String createBy;//创建人
    private String editTime;//修改时间
    private String editBy;//修改人
    private String deptno;//部门编号
    private String recordSize;// user表记录的总条数
    private String olderPas;//旧密码
    private String olderPasTwo;//旧密码

    public String getOlderPasTwo() {
        return olderPasTwo;
    }

    public void setOlderPasTwo(String olderPasTwo) {
        this.olderPasTwo = olderPasTwo;
    }

    public String getOlderPas() {
        return olderPas;
    }

    public void setOlderPas(String olderPas) {
        this.olderPas = olderPas;
    }

    public String getRecordSize() {
        return recordSize;
    }

    public void setRecordSize(String recordSize) {
        this.recordSize = recordSize;
    }

    private Map<String, String> massage=new HashMap<>();

    public Map<String, String> getMassage() {
        return massage;
    }

    public void setMassage(Map<String, String> massage) {
        this.massage = massage;
    }

    public User(){}

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getLoginAct() {
        return loginAct;
    }

    public void setLoginAct(String loginAct) {
        this.loginAct = loginAct;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getLoginPwd() {
        return loginPwd;
    }

    public void setLoginPwd(String loginPwd) {
        this.loginPwd = loginPwd;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getExpireTime() {
        return expireTime;
    }

    public void setExpireTime(String expireTime) {
        this.expireTime = expireTime;
    }

    public String getLockState() {
        return lockState;
    }

    public void setLockState(String lockState) {
        this.lockState = lockState;
    }

    public Dept getDept() {
        return dept;
    }

    public void setDept(Dept dept) {
        this.dept = dept;
    }

    public String getAllowIps() {
        return allowIps;
    }

    public void setAllowIps(String allowIps) {
        this.allowIps = allowIps;
    }

    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime;
    }

    public String getCreateBy() {
        return createBy;
    }

    public void setCreateBy(String createBy) {
        this.createBy = createBy;
    }

    public String getEditTime() {
        return editTime;
    }

    public void setEditTime(String editTime) {
        this.editTime = editTime;
    }

    public String getEditBy() {
        return editBy;
    }

    public void setEditBy(String editBy) {
        this.editBy = editBy;
    }

    public String getDeptno() {
        return deptno;
    }

    public void setDeptno(String deptno) {
        this.deptno = deptno;
    }

    @Override
    public String toString() {
        return "User{" +
                "id='" + id + '\'' +
                ", loginAct='" + loginAct + '\'' +
                ", name='" + name + '\'' +
                ", loginPwd='" + loginPwd + '\'' +
                ", email='" + email + '\'' +
                ", expireTime='" + expireTime + '\'' +
                ", lockState='" + lockState + '\'' +
                ", dept=" + dept +
                ", allowIps='" + allowIps + '\'' +
                ", createTime='" + createTime + '\'' +
                ", createBy='" + createBy + '\'' +
                ", editTime='" + editTime + '\'' +
                ", editBy='" + editBy + '\'' +
                ", deptno='" + deptno + '\'' +
                ", recordSize='" + recordSize + '\'' +
                ", olderPas='" + olderPas + '\'' +
                ", olderPasTwo='" + olderPasTwo + '\'' +
                ", massage=" + massage +
                '}';
    }
}
