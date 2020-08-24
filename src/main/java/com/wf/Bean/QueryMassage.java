package com.wf.Bean;

/**
 * 封装条件查询时的条件
 */
public class QueryMassage<T> {
   private Page<T> userPage;
   private String  userName;
   private String  deptName;
   private String  lockState;
   private String  startTime;
   private String  endTime;

    public QueryMassage() {
    }

    public Page<T> getUserPage() {
        return userPage;
    }

    public void setUserPage(Page<T> userPage) {
        this.userPage = userPage;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getDeptName() {
        return deptName;
    }

    public void setDeptName(String deptName) {
        this.deptName = deptName;
    }

    public String getLockState() {
        return lockState;
    }

    public void setLockState(String lockState) {
        this.lockState = lockState;
    }

    public String getStartTime() {
        return startTime;
    }

    public void setStartTime(String startTime) {
        this.startTime = startTime;
    }

    public String getEndTime() {
        return endTime;
    }

    public void setEndTime(String endTime) {
        this.endTime = endTime;
    }


    @Override
    public String toString() {
        return "QueryMassage{" +
                "userPage=" + userPage +
                ", userName='" + userName + '\'' +
                ", deptName='" + deptName + '\'' +
                ", lockState='" + lockState + '\'' +
                ", startTime='" + startTime + '\'' +
                ", endTime='" + endTime + '\'' +
                '}';
    }
}
