package com.wf.Exception;

/**
 * 登录信息非法异常
 */
public class LoginMassageIllicitException extends Exception{
    //错误信息状态码
    private Integer  StatusCode;
    //错误信息
    private String  ExceptionMassage;

    public  LoginMassageIllicitException (String exception,Integer statusCode){
        super(exception);
        this.ExceptionMassage=exception;
        this.StatusCode=statusCode;
    }

    public Integer getStatusCode() {
        return StatusCode;
    }

    public void setStatusCode(Integer statusCode) {
        StatusCode = statusCode;
    }

    public String getExceptionMassage() {
        return ExceptionMassage;
    }

    public void setExceptionMassage(String exceptionMassage) {
        ExceptionMassage = exceptionMassage;
    }


    public String toString() {
        return ExceptionMassage;
    }
}
