package com.wf.Dao;

import com.wf.Bean.User;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 操作用户信息，对用户信息进行的一系列CRUD
 */
public interface OpectionUserMassageDao {
    /**
     * 查询指定指定用户
     * @param user
     * @return
     */
    User selectUser(User user);

    /**
     * 修改用户的密码
     * @param user
     * @return
     */
    int  updatePas(User user);

    /**
     * 查询用户表中的所有用户
     * @return
     */
    List<User> selectAll();

    /**
     * 查询所有部门名称
     * @return
     */
   List<Map<String,String>> selectDeptName();

    /**
     * 添加用户
     * @param user
     * @return
     */
    int addUser(User user);

    /**
     * 用于删除用户
     * @param userids
     * @return
     */
   int deleteUser(String[] userids);
}
