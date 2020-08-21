package com.wf.Dao;

import com.wf.Bean.Dept;
import com.wf.Bean.Page;

import java.util.List;

/**
 * 对部门表做CRUD操作
 */
public interface OpectionDeptMassageDao {
    /**
     * 用于分页查询部门表下的所有数据
     *
     * @return
     */
    List<Dept> selectAll();

    /**
     * 查询部门表当中是否包含此部门编号
     * @param dept
     * @return
     */
    Dept selectCode(Dept dept);

    /**
     * 用于添加一个部门
     * @param dept
     * @return
     */
    int addDept(Dept dept);

    /**
     * 查询指定部门
     * @param dept
     * @return
     */
    Dept selectDept(Dept dept);

    /**
     * 修改部门表中的信息
     * @param dept
     * @return
     */
    int updateDept(Dept dept);

    /**
     * 用于删除部门表中的数据
     * @param ids
     * @return
     */
    int deleteDept(String [] ids);
}
