package com.wf.ServiceImpl;

import com.wf.Bean.User;
import com.wf.Dao.OpectionUserMassageDao;
import com.wf.Exception.LoginMassageIllicitException;
import com.wf.Service.OpectionUserMassageService;
import com.wf.Util.MassageVerify;
import com.wf.Util.OperationPassword;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import java.util.HashMap;
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
            } catch (LoginMassageIllicitException e) {
                result.put("Exception",e);
                return result;
            }
            try {
                //判断当前账号状态是否被锁定
                MassageVerify.verifyLockState(u);
            } catch (LoginMassageIllicitException e) {
                result.put("Exception",e);
                return result;
            }

            try {
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
}
