package com.wf.Interceptor;

import com.wf.Bean.User;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class IllegalInterceptor implements HandlerInterceptor {
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        //获取当前登录用户
        User user=(User) request.getSession().getAttribute("User");
        //表示已经进行了登录操作
        if(user!=null){
            return true;
        }
        //获取当前访问的uri
        String requestURI = request.getRequestURI();
        //表示进行的是登录相关的操作
        if(requestURI.contains("login")||requestURI.contains("verifylogin")||requestURI.contains("jquery")||requestURI.contains("image")){
            return true;
        }
        response.sendRedirect("/CRM/workbench/login.jsp");
        return false;
    }
}
