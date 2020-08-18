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
}
