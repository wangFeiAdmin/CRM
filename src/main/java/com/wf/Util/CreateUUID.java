package com.wf.Util;



import java.util.UUID;

public class CreateUUID {

    private CreateUUID(){}


    /**
     * 用于生成一个32位的UUID
     * @return
     */
    public static String  getUUID(){
        return  UUID.randomUUID().toString().replace("-","");
    }
}
