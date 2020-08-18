package com.wf.Controller;

import com.wf.Bean.Dept;
import com.wf.Bean.Page;
import com.wf.Service.OpectionDeptMassageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;

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
        page.setPageSize(10);//设置每页显示条数
        page.setPageno(1);
        //执行查询
        Page<Dept> resultPage = odms.selectDeptAll(page);
        System.err.println(resultPage);
        //将查询结果保存至session中
        model.addAttribute("Page",resultPage);
        return "redirect:/settings/dept/index.jsp";
    }

    /**
     * 分页查询部门
     * @param model
     * @return
     */
    @RequestMapping("/limitSelect/{pageSize}/{pageNO}")
    public String LimitselectDept(@PathVariable String pageSize, @PathVariable String pageNO, Model model, HttpServletRequest request){
        //创建一个页面用于装载信息
        Page<Dept> page=(Page<Dept>)request.getSession().getAttribute("Page");
        Integer pagesize=Integer.parseInt(pageSize);//获取每页显示记录数
        Integer pageno=Integer.parseInt(pageNO);//获取当前页码
        page.setPageSize(pagesize);//设置每页显示条数
        page.setPageno(pageno);//设置当前页码
        //执行查询
        Page<Dept> resultPage = odms.selectDeptAll(page);
        //将查询结果保存至session中
        model.addAttribute("Page",resultPage);
        return "redirect:/settings/dept/index.jsp";
    }


}
