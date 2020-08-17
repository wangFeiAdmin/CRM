package com.wf.Dao;

import com.wf.Bean.User;

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

}
