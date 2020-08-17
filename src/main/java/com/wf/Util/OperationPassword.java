package com.wf.Util;


import sun.misc.BASE64Encoder;
import java.security.MessageDigest;


public class OperationPassword {

    private OperationPassword(){}

    /**
     * 用于对当前密码进行加密
     * @param pas
     * @return
     * @throws Exception
     */
    public static String  getEncryptPassword(String  pas) throws Exception {
        MessageDigest md5 = MessageDigest.getInstance("MD5");
        BASE64Encoder base64en = new BASE64Encoder();
        //加密后的字符串
        return base64en.encode(md5.digest(pas.getBytes("utf-8")));
    }

    /**
     * 用于验证当前加密后的密码，和之前的密码是否一致
     * @param oldpas
     * @param newPas
     * @return
     * @throws Exception
     */
    public static boolean verifyPassword(String oldpas,String newPas) throws Exception{
        return  oldpas.equals(getEncryptPassword(newPas));
    }



}
