package com.wf.Controller;

import com.wf.Bean.Dept;
import com.wf.Bean.Page;
import com.wf.Service.OpectionDeptMassageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

/**
 * 对部门表的信息做操作
 */
@Controller
@RequestMapping("/dept")
@SessionAttributes(value = {"Page"})
public class OpectionDeptMassage {
    @Autowired
    @Qualifier("opectionDeptMassageServiceImpl")
    private OpectionDeptMassageService odms;

    /**
     * 查询所有部门
     * @param model
     * @return
     */
    @RequestMapping("/selectAll")
    public String selectDeptAll(Model model){
        //创建一个页面用于装载信息
        Page<Dept> page=new Page<>();
        //执行查询
        Page<Dept> resultPage = odms.selectDeptAll(page);
        //将查询结果保存至session中
        model.addAttribute("Page",resultPage);
        return "settings/dept/index";
    }

    /**
     * 分页查询部门
     * @param model
     * @return
     */
    @RequestMapping("/limitSelect/{pageSize}/{pageNO}")
    public String LimitselectDept(@PathVariable String pageSize, @PathVariable String pageNO, Model model, ModelMap request){
        //创建一个页面用于装载信息
        Page<Dept> page=(Page<Dept>)request.get("Page");
        Integer pagesize=Integer.parseInt(pageSize);//获取每页显示记录数
        Integer pageno=Integer.parseInt(pageNO);//获取当前页码
        page.setPageSize(pagesize);//设置每页显示条数
        page.setPageno(pageno);//设置当前页码
        //执行查询
        Page<Dept> resultPage = odms.selectDeptAll(page);
        //将查询结果保存至session中
        model.addAttribute("Page",resultPage);
        return "settings/dept/index";
    }

    /**
     * 用于对部门进行添加
     * @param dept
     * @return
     */
    @RequestMapping("/add")
    @Transactional
    public String createDept(Dept dept,Model model){
        //执行添加，接收添加的部门对象
        boolean target = odms.createDept(dept);
        //存储一下当前的执行结果
        HashMap<String,Object> result=new HashMap<>();
        result.put("target",target);
        if(target){
            result.put("title","添加成功~~");
            model.addAttribute("Ststus",result);
            //转发到用于查询的controller
            return "forward:/dept/selectAll";
        }
        result.put("title","添加失败~~");
        model.addAttribute("Ststus",result);
        return "/settings/dept/index";
    }

    /**
     * 根据部门编号查询当前部门编号是否重复
     * @param dept
     * @return
     */
    @RequestMapping("/verifyDeptCode")
    @ResponseBody
    public Map<String,Boolean> verifyDeptCode(Dept dept){
        //执行查询判断当前部门编号是否重复
        boolean b = odms.selectCode(dept);
        //装载查询结果
        HashMap<String,Boolean> result=new HashMap<>();
        result.put("target",b);
        return  result;
    }

    /**
     * 用于根据id查询指定部门
     * @param dept
     * @return
     */
    @RequestMapping("/selectSingle")
    @ResponseBody
    public Dept selectDept(Dept dept){
        return odms.selectDept(dept);
    }

    /**
     * 用于修改部门的信息
     * @param dept
     * @return
     */
    @RequestMapping("/update")
    @Transactional
    public  String  updateDept(Dept  dept,Model model){
        //执行修改返回修改结果
        boolean target = odms.updateDeptMassage(dept);
        //存储一下当前的执行结果
        HashMap<String,Object> result=new HashMap<>();
        result.put("target",target);
        if(target){
            result.put("title","修改成功~~");
            model.addAttribute("Ststus",result);
            //转发到用于查询的controller
            return "forward:/dept/selectAll";
        }
        result.put("title","修改失败~~");
        model.addAttribute("Ststus",result);
        //直接返回界面
        return "/settings/dept/index";
    }

    /**
     * 用于删除部门表中的数据
     * @param deptids
     * @param model
     * @return
     */
    @RequestMapping("/deleteDepts/{deptids}")
    @Transactional
    public String deleteDepts(@PathVariable String [] deptids,Model model){
        //执行修改返回修改结果
        boolean target = odms.deleteDepts(deptids);
        //存储一下当前的执行结果
        HashMap<String,Object> result=new HashMap<>();
        result.put("target",target);
        if(target){
            result.put("title","删除成功~~");
            model.addAttribute("Ststus",result);
            //转发到用于查询的controller
            return "forward:/dept/selectAll";
        }
        result.put("title","删除失败~~");
        model.addAttribute("Ststus",result);
        //直接返回界面
        return "/settings/dept/index";
    }


}
