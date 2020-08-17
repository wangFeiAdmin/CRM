package com.wf.Util;

import com.wf.Bean.User;
import com.wf.Exception.LoginMassageIllicitException;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * 信息验证
 */
public class MassageVerify {

    private MassageVerify() {}


    //存放账号状态
    private static final Map<Object, String> map = new HashMap<Object, String>();

    static {
        map.put(null, "null");
        map.put("0", "0");
        map.put("1", "1");
    }

    /**
     * 判定当前允许访问的ip中是否包含当前ip
     * 若包含则表示，当前访问的ip是被允许的，可在该设备上登录此账号，
     * 返回结果为true
     * 若为空则表示ip不收限制，返回结果为true，可在该设备上登录此账号，
     * 反之，表示是不被允许的，不能再当前设备上登录此账号，
     * @param user
     * @param nowIp
     * @return
     * @throws LoginMassageIllicitException
     */
    public static void verifyAllowIps(User user,String nowIp) throws LoginMassageIllicitException{
        //表示当前账号不受限制，可在任意设备上登录
        if(user.getAllowIps()==null){
            return;
        }
        //通过循环遍历查看当前访问的ip是否在指定的ip行列之中
        String[] ip=user.getAllowIps().split(",");
        for (String i : ip) {
            if(nowIp.equals(i)){
                return;
            }
        }
        throw  new LoginMassageIllicitException("当前设备不可登录该账号",702);
    }

    /**
     * 用于返回单前账号状态是否可用，
     * 返回结果若是true表示当前账号可用
     * 返回结果若是false表示当前账号不可用
     * @param user
     * @return
     * @throws LoginMassageIllicitException
     */
    public static void verifyLockState(User user) throws LoginMassageIllicitException{
        //获取集合中指定状态
        Object value = map.get(user.getLockState());
        //为空表示没有获取状态，即超出3个状态，若获取到了，并且结果还不是1，那么就表示不可用
        if (!(value != null && "1".equals(value))) {
            throw  new LoginMassageIllicitException("当期账户被锁定",701);
        }
    }


    /**
     * 用于验证当前时间是否大于查询时间
     * 结果若是true，则表示当前时间大于查询时间，表示已经超时
     * 反之，则表示没有超时
     * @param user
     * @return
     * @throws LoginMassageIllicitException
     */
    public static  void verifyExpireTime(User user) throws LoginMassageIllicitException {
        //当前时间设定为null表示用不过时
        if (user.getEditTime() == null) {
            return;
        }
        //验证当前时间是否大于规定时间
        if(compareSize(getNowTime(),user.getExpireTime())){
            throw  new LoginMassageIllicitException("当期账户已超时失效",700);
        }

    }


    /**
     * 用于获取当前时间
     *
     * @return
     */
    public static String getNowTime() {
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        return simpleDateFormat.format(new Date());
    }

    /**
     * 将两个字符串格式的日期获取到，并判断大小
     * 返回的结果为true，表示当前时间已经超时
     * @param timeOne
     * @param timeTwo
     * @return
     */
        public  static  boolean  compareSize(String timeOne,String timeTwo){
        DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Date d1=null;
        Date d2=null;
         try {
             d1=df.parse(timeOne);
             d2=df.parse(timeTwo);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return d1.getTime()>d2.getTime();

    }


}
