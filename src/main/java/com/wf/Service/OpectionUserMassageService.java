package com.wf.Service;


import com.wf.Bean.User;

import java.util.Map;


public interface OpectionUserMassageService {
    /**
     * 用于登录信息验证，登录信息错误日志打印
     * @return
     */
    Map<String, Object> verifyLoginMassage(User user);
}
