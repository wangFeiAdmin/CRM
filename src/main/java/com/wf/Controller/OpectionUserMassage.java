package com.wf.Controller;

import com.wf.Bean.Dept;
import com.wf.Bean.Page;
import com.wf.Bean.QueryMassage;
import com.wf.Bean.User;
import com.wf.Service.OpectionUserMassageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 操作用户信息，包括用户登录信息的验证，用户信息的修改
 *
 *
 */
@SessionAttributes(value = {"map", "User"})
@Controller
public class OpectionUserMassage {

    @Autowired
    @Qualifier("opectionUserMassageServiceImpl")
    private OpectionUserMassageService oums;

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

    /**
     * 修改账户密码
     *
     *
     *
     * @return
     */

    @ResponseBody
    @RequestMapping("/update")
    @Transactional
    public Map<String, Object> updateUserPas(User newUser) {
        //获取登录对象

        //传入一个旧密码 一个新密码  旧密码是旧密码 新密码是登录密码

        //执行修改返回执行结果
        Boolean result = oums.updateUserPassword(newUser);
        //将执行结果进行封装
        HashMap hashMap = new HashMap<>();
        hashMap.put("target", result);
        hashMap.put("updateUaser",newUser);
        return hashMap;
    }






    /**
     * 用于查询所有部门的名称
     * 可模糊查询可不模糊
     *
     * @return
     */
    @RequestMapping("/selectDeptName")
    @ResponseBody
    public List<Map<String, String>> selectDeptNameAll(Dept dept) {
        return oums.selectDeptNameAll(dept);
    }


    /**
     * 用于新增用户
     *
     * @param user
     * @return
     */
    @RequestMapping("/addUser")
    @Transactional
    public String createUser(User user, ModelMap modelMap) {
        //获取登录用户
        User loginUser = (User) modelMap.get("User");
        String loginName = loginUser.getName();
        //给创建人和修改人名称赋值，
        user.setCreateBy(loginName);
        user.setEditBy(loginName);
        //执行添加，接收添加的部门对象
        boolean target = oums.createUser(user);
        return "settings/qx/index";
    }

    /**
     * 用于删除用户表中的用户
     *
     * @param userids
     * @return
     */
    @RequestMapping("/deleteUsers/{userids}")
    @Transactional
    public String deleteDepts(@PathVariable String[] userids) {
        //执行修改返回修改结果
        boolean target = oums.deleteUsers(userids);
        return "settings/qx/index";
    }


    /**
     * 条件查询用户
     *
     * @param massage
     * @param model
     * @param modelMap
     * @return
     */
    @RequestMapping("/conditionQuery")
    @ResponseBody
    public QueryMassage<User>  conditionLimitQuery(QueryMassage<User> massage, Model model, ModelMap modelMap) {
        QueryMassage<User> queryMassage = oums.conditionQuery(massage);
        return queryMassage;
    }


    /**
     * 用于填充页面信息，返回修改用户信息的页面
     * @param userStr
     * @return
     */
    @RequestMapping("/detail")
    public  String  returnUpdateUserMassagePage(User userStr,Model model){
        //将需要修改的用户信息存储在request中
        model.addAttribute("updateUser",userStr);
        return "settings/qx/user/detail";
    }

}
