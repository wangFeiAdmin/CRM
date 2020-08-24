package com.wf.Service;


import com.wf.Bean.Dept;
import com.wf.Bean.Page;
import com.wf.Bean.QueryMassage;
import com.wf.Bean.User;

import java.util.List;
import java.util.Map;


public interface OpectionUserMassageService {
    /**
     * 用于登录信息验证，登录信息错误日志打印
     * @return
     */
    Map<String, Object> verifyLoginMassage(User user);

    /**
     * 用于对前用户的密码作出修改
     *
     *
     * @return
     */
    boolean updateUserPassword(User user);



    /**
     * 查询所有部门名称
     * @return
     */
    List<Map<String,String>> selectDeptNameAll(Dept dept);

    /**
     * 添加一个新的用户
     * @param user
     * @return
     */
    boolean createUser(User user);

    /**
     * 删除用户
     * @param userids
     * @return
     */
    boolean deleteUsers(String[] userids);


    /**
     * 条件查询用户
     * @param massage
     * @param massage
     * @return
     */
    QueryMassage<User> conditionQuery(QueryMassage<User> massage);
}
