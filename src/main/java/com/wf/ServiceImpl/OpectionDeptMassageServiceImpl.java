package com.wf.ServiceImpl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.wf.Bean.Dept;
import com.wf.Bean.Page;
import com.wf.Dao.OpectionDeptMassageDao;
import com.wf.Service.OpectionDeptMassageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class OpectionDeptMassageServiceImpl implements OpectionDeptMassageService {
    @Autowired
    @Qualifier("opectionDeptMassageDao")
    private OpectionDeptMassageDao odmd;


    /**
     * 分页查询dept表
     * @param page
     * @return
     */
    @Transactional
    public Page selectDeptAll(Page<Dept> page) {
        //配置分页当前页码，每页显示记录条数
        System.err.println("传入的page:....."+page);
        //执行查询
        PageHelper.startPage(page.getLimitIndex(),page.getPageSize());
        List<Dept> deptList=odmd.selectAll();
        //存储查询结果
        page.setList(deptList);
        //创建映射对象
        PageInfo<Dept> pageInfo=new PageInfo<>(deptList);
        page.setPages(pageInfo.getPages());//获取总页数  2
        page.setTotal(pageInfo.getTotal());//获取总记录数 16  每页 10
        System.err.println("总页数：：："+pageInfo.getPages());

        Integer pages=pageInfo.getPages();//获取总页数
        Integer pageno=page.getPageno();//获取当前页码
        //当前页码等于总页数
        if(pageno==1&&pageno==pages){
            //即没有上一页也没有下一页
            page.setHaspreviousPage(false);//没前一页
            page.setHasNextPage(false);//没有下一页
        }else if(pageno<pages){
            //应该有下一页和尾页
            page.setHaspreviousPage(false);//没前一页
            page.setHasNextPage(true);//有下一页
        }else if(pageno!=1&&pageno==pages){
            //应该有上一页和首页
            page.setHaspreviousPage(true);//没前一页
            page.setHasNextPage(false);//没有下一页
        }
        return page;
    }
}
