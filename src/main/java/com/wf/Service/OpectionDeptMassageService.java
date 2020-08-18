package com.wf.Service;


import com.wf.Bean.Dept;
import com.wf.Bean.Page;

public interface OpectionDeptMassageService {
    /**
     * 查询部门表中的所有部门
     * @return
     */
    Page selectDeptAll(Page<Dept> page);
}
