package com.wf.Controller;

import com.wf.Bean.User;
import com.wf.Service.OpectionUserMassageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;

/**
 * 操作用户信息，包括用户登录信息的验证，用户信息的修改
 */
@SessionAttributes(value = {"map", "User"})
@Controller
public class OpectionUserMassage {

    @Autowired
    @Qualifier("opectionUserMassageServiceImpl")
    private OpectionUserMassageService oums; //service接口

    /**
     * 仅用于返回登录界面
     *
     * @return
     */
    @GetMapping("/login")
    public String returnWelcomePage() {
        return "workbench/login";
    }

    /**
     * 用于作为登录信息的验证
     *
     * @param user
     * @return
     */
    @PostMapping("/verifylogin")
    public String verifyMassage(User user, Model model, HttpServletRequest request) {
        //获取当前访问的IP地址
        String ip = request.getRemoteAddr();
        user.setAllowIps(ip);//设置ip
        Map<String, Object> result = oums.verifyLoginMassage(user);
        //将数据封装到sessiong中
        model.addAttribute("map", result);
        if (result.size() == 1) {//表示登录成功
            //将当前登录用户存入session中
            model.addAttribute("User", result.get("User"));
            return "workbench/index";
        }
        return "workbench/login";


    }

    @ResponseBody
    @RequestMapping("/update")
    @Transactional
    public Map<String,Object> updateUserPas(String olderPas, String affirmPas, HttpServletRequest request) {
        //获取登录对象
        User user=(User) request.getSession().getAttribute("User");
        //执行修改返回执行结果
        Boolean result = oums.updateUserPassword(olderPas, affirmPas, user);
        //将执行结果进行封装
        HashMap hashMap=new HashMap<>();
        hashMap.put("target",result);
        return hashMap;
    }


}
