package com.wf.Service;


import com.wf.Bean.Dept;
import com.wf.Bean.Page;

public interface OpectionDeptMassageService {
    /**
     * 查询部门表中的所有部门
     * @return
     */
    Page selectDeptAll(Page<Dept> page);

    /**
     * 查询部门表当中是否包含此部门编号
     * @param dept
     * @return
     */
    boolean selectCode(Dept dept);

    /**
     * 添加一个新的部门
     * @param dept
     * @return
     */
   boolean createDept(Dept dept);

    /**
     * 查询指定部门
     * @param dept
     * @return
     */
   Dept selectDept(Dept dept);

    /**
     * 修改部门表中的数据
      * @param dept
     * @return
     */
   boolean  updateDeptMassage(Dept dept);

    /**
     * 删除部门表中的部分部门
     * @param ids
     * @return
     */
    boolean deleteDepts(String [] ids);
}
