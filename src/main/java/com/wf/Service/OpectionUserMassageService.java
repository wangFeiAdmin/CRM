package com.wf.Service;


import com.wf.Bean.User;

import java.util.Map;


public interface OpectionUserMassageService {
    /**
     * 用于登录信息验证，登录信息错误日志打印
     * @return
     */
    Map<String, Object> verifyLoginMassage(User user);

    /**
     * 用于对前用户的密码作出修改
     * @param olderPas
     * @param newPas
     * @return
     */
    boolean updateUserPassword(String olderPas,String newPas,User user);
}
