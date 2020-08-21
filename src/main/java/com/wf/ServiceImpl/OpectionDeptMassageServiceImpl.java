package com.wf.ServiceImpl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.wf.Bean.Dept;
import com.wf.Bean.Page;
import com.wf.Dao.OpectionDeptMassageDao;
import com.wf.Service.OpectionDeptMassageService;
import com.wf.Util.CreateUUID;
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
     *
     * @param page
     * @return
     */
    @Transactional
    public Page selectDeptAll(Page<Dept> page) {
        //配置分页当前页码，每页显示记录条数
        PageHelper.startPage(page.getPageno(), page.getPageSize());
        //执行查询
        List<Dept> deptList  = odmd.selectAll();
        //存储查询结果
        page.setList(deptList);
        //创建映射对象
        PageInfo<Dept> pageInfo = new PageInfo<>(deptList);
        page.setPages(pageInfo.getPages());//获取总页数  3
        page.setTotal(pageInfo.getTotal());//获取总记录数 16  每页 10
        page.setPages(pageInfo.getPages());//设置总页数
        //对是否有上一页和下一页进行填充
        page.setHaspreviousPageAndHasNextPage();
        return page;
    }

    /**
     * 校验当前部门编号是否重复
     * @param dept
     * @return
     */
    @Override
    public boolean selectCode(Dept dept) {
        //执行查询，判断是否存在当前编号
        Dept dept1 = odmd.selectCode(dept);
        //判断当前部门编号是否存在
        if(dept1!=null){
            return  true;
        }
        return false;
    }

    /**
     * 添加一个部门,若添加成功则将添加的这个dept返回
     * 若不成功则返回null
     * @param dept
     * @return
     */
    @Transactional
    public boolean createDept(Dept dept){
        //获取一个uuid，将UUID设置为主键
        dept.setId(CreateUUID.getUUID());
        //执行查询
        return  odmd.addDept(dept)>0;
    }

    /**
     * 查询指定部门
     * @param dept
     * @return
     */
    @Override
    public Dept selectDept(Dept dept) {
        return odmd.selectDept(dept);
    }

    /**
     * 修改部门表中的数据
     * @param dept
     * @return
     */
    @Transactional
    public boolean  updateDeptMassage(Dept dept){
        return odmd.updateDept(dept)>0;
    }


    /**
     * 删除部门表中的部分部门
     * @param ids
     * @return
     */
    @Transactional
    public boolean deleteDepts(String [] ids){
        return  odmd.deleteDept(ids)>0;
    }
}
