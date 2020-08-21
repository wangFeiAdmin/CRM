package com.wf.Controller;

import com.wf.Bean.Dept;
import com.wf.Bean.Page;
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
 */
@SessionAttributes(value = {"map", "User","Page"})
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
     * @param olderPas
     * @param affirmPas
     * @param request
     * @return
     */

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

    /**
     * 查询所有的用户
     * @param model
     * @return
     */
    @RequestMapping("/selectAll")
    public String seleceUserAll(Model model){
        //创建一个页面用于装载信息
        Page<User> page=new Page<>();
        //执行查询
        Page<User> resultPage = oums.selectUsertAll(page);
        //将查询结果保存至session中
        model.addAttribute("Page",resultPage);
        return "settings/qx/index";
    }


    /**
     * 分页查询用户
     * @param model
     * @return
     */
    @RequestMapping("/limitSelect/{pageSize}/{pageNO}")
    public String LimitselectDept(@PathVariable String pageSize, @PathVariable String pageNO, Model model, ModelMap request){
        //创建一个页面用于装载信息
        Page<User> page=(Page<User>)request.get("Page");
        Integer pagesize=Integer.parseInt(pageSize);//获取每页显示记录数
        Integer pageno=Integer.parseInt(pageNO);//获取当前页码
        page.setPageSize(pagesize);//设置每页显示条数
        page.setPageno(pageno);//设置当前页码
        //执行查询
        Page<User> resultPage = oums.selectUsertAll(page);
        //将查询结果保存至session中
        model.addAttribute("Page",resultPage);
        return "settings/qx/index";
    }

    /**
     * 查询所有部门的名称
     * @return
     */
    @RequestMapping("/selectDeptName")
    @ResponseBody
    public List<Map<String,String>> selectDeptNameAll(){
        return oums.selectDeptNameAll();
    }


    /**
     * 用于新增用户
     * @param user
     * @return
     */
    @RequestMapping("/addUser")
    @Transactional
    public String createUser(User user,ModelMap modelMap){
        //获取登录用户
        User loginUser= (User) modelMap.get("User");
        String loginName=loginUser.getName();
        //给创建人和修改人名称赋值，
        user.setCreateBy(loginName);
        user.setEditBy(loginName);
        //执行添加，接收添加的部门对象
        boolean target = oums.createUser(user);
        if(target){
            return "forward:/selectAll";
        }
        return "settings/qx/index";
    }

    /**
     * 用于删除用户表中的用户
     * @param userids
     * @return
     */
    @RequestMapping("/deleteUsers/{userids}")
    @Transactional
    public String deleteDepts(@PathVariable String [] userids){
        //执行修改返回修改结果
        boolean target = oums.deleteUsers(userids);
        if(target){
            return "forward:/selectAll";
        }
        return "settings/qx/index";
    }



}
