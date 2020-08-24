package com.wf.ServiceImpl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.wf.Bean.Dept;
import com.wf.Bean.Page;
import com.wf.Bean.QueryMassage;
import com.wf.Bean.User;
import com.wf.Dao.OpectionUserMassageDao;
import com.wf.Exception.LoginMassageIllicitException;
import com.wf.Service.OpectionUserMassageService;
import com.wf.Util.CreateUUID;
import com.wf.Util.MassageVerify;
import com.wf.Util.OperationPassword;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class OpectionUserMassageServiceImpl implements OpectionUserMassageService{

    @Autowired
    @Qualifier("opectionUserMassageDao")
    private OpectionUserMassageDao oumd; //Dao接口

    /**
     * 登录信息的验证
     * @return
     */
    @Override
    public Map<String, Object> verifyLoginMassage(User user) {
        //获取当前访问的ip
        String ip=user.getAllowIps();
        //用于接收执行结果
        Map<String, Object> result=new HashMap<String, Object>();
        //将用户输入的密码进行加密
        try {
            user.setLoginPwd(OperationPassword.getEncryptPassword(user.getLoginPwd()));
        } catch (Exception e) {
            e.printStackTrace();
        }
        //执行查询返回查询信息
        User u=oumd.selectUser(user);
        //判断当前用户是否被查询到
        if(u!=null){
            //验证时间是否过期
            result.put("User",u);
            try {
                //判断当前账号是否超出时间
                MassageVerify.verifyExpireTime(u);
                //判断当前账号状态是否被锁定
                MassageVerify.verifyLockState(u);
                //判断当前账号登录的ip设备是否符合规范
                MassageVerify.verifyAllowIps(u,ip);
            } catch (LoginMassageIllicitException e) {
                result.put("Exception",e);
                return result;
            }
            return  result;
        }else{
            //表示账户密码用户名错误
           result.put("Exception",new LoginMassageIllicitException("用户名或密码不正确",7004));
           result.put("User",null);
        }
        return result;
    }

    /**
     * 对当前用户的密码作出修改
     *
     *
     * @return
     */
    @Override
    @Transactional
    public boolean updateUserPassword(User user) {
        System.err.println(user);
        //获取新密码
        String newPas=user.getLoginPwd();
        try {
            //判断当前用户输入的源密码是否正确
            if(!user.getOlderPas().equals(user.getOlderPasTwo())){
                if(!OperationPassword.verifyPassword(user.getOlderPas(),user.getOlderPasTwo())){
                    return false;
                }
            }

            //加密新密码
            newPas=OperationPassword.getEncryptPassword(newPas);
            //设置新的密码
            user.setLoginPwd(newPas);
            //更改密码

        } catch (Exception e) {
            e.printStackTrace();
        }

        //返回修改结果
        return oumd.updatePas(user)>0;
    }




    /**
     * 查询所有部门名称
     * @return
     */
    @Override
    public List<Map<String,String>> selectDeptNameAll(Dept dept) {

        return oumd.selectDeptName(dept);
    }

    /**
     * 添加用户
     * @param user
     * @return
     */
    @Override
    @Transactional
    public boolean createUser(User user) {
        //获取当前时间
        String nowTime = MassageVerify.getNowTime();
        user.setCreateTime(nowTime);
        user.setEditTime(nowTime);
        user.setId(CreateUUID.getUUID());
        //设置id为空
        if("".equals(user.getAllowIps())||"".equals(user.getExpireTime())){
            user.setAllowIps(null);
            user.setExpireTime(null);
            user.setLockState("1");
        }
        try {
            user.setLoginPwd(OperationPassword.getEncryptPassword(user.getLoginPwd()));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return  oumd.addUser(user)>0;
    }

    /**
     * 批量删除用户
     * @param userids
     * @return
     */
    @Override
    @Transactional
    public boolean deleteUsers(String[] userids) {
        return  oumd.deleteUser(userids)>0;
    }

    /**
     * 条件查询用户
     * @param massage
     * @param massage
     * @return
     */
    public QueryMassage<User>  conditionQuery(QueryMassage<User> massage){
        //获取一个page
        Page<User> page=massage.getUserPage();
        //配置分页当前页码，每页显示记录条数
        PageHelper.startPage(page.getPageno(), page.getPageSize());
        //执行查询
        List<User> userList = oumd.conditionQuery(massage);
        //存储查询结果
        page.setList(userList);
        //创建映射对象
        PageInfo<User> pageInfo = new PageInfo<>(userList);
        page.setPages(pageInfo.getPages());//获取总页数  3
        page.setTotal(pageInfo.getTotal());//获取总记录数 16  每页 10
        page.setPages(pageInfo.getPages());//设置总页数
        //对是否有上一页和下一页进行填充
        page.setHaspreviousPageAndHasNextPage();
        massage.setUserPage(page);
        return massage;
    }

}
