<%--
  Created by IntelliJ IDEA.
  User: wf
  Date: 2020/8/17
  Time: 9:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">

    <link href="${pageContext.request.contextPath}/jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet"/>
    <script type="text/javascript" src="${pageContext.request.contextPath}/jquery/jquery-1.11.1-min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>
</head>

<script>
    $(function () {
        //页面初始化结束，登录框自动获得焦点
        $("#Act").focus();

        //当用户名框获得焦点以后清除错误信息
        $("#Act").on('blur',function(){
            $("#msg").html("");
        })
    })




    //表示按下了回车键，也需要进行登录的操作
    $(window).keydown(function (event) {
        if (event.keyCode == 13) { // 回车键是13
            verify($('#Act').val(),$('#Pwd').val());
        }
    });

    //用于发送请求对当前用户信息做验证
    function verify(userName, userPas) {
        if(userName==''||userPas==''){
            $("#msg").html("用户名或密码不能为空");
        }else{
            $("#fromOne").attr("action","${pageContext.request.contextPath}/verifylogin");
              $("#fromOne").submit();
        }

    }


</script>


<body>
<div style="position: absolute; top: 0px; left: 0px; width: 60%;">
    <img src="${pageContext.request.contextPath}/image/IMG_7114.JPG" style="width: 100%; height: 90%; position: relative; top: 50px;">
</div>
<div id="top" style="height: 50px; background-color: #3C3C3C; width: 100%;">
    <div style="position: absolute; top: 5px; left: 0px; font-size: 30px; font-weight: 400; color: white; font-family: 'times new roman'">
        CRM &nbsp;<span style="font-size: 12px;">&copy;2017&nbsp;动力节点</span></div>
</div>

<div style="position: absolute; top: 120px; right: 100px;width:450px;height:400px;border:1px solid #D5D5D5">
    <div style="position: absolute; top: 0px; right: 60px;">
        <div class="page-header">
            <h1>登录</h1>
        </div>
        <form action="/verifylogin" id="fromOne" class="form-horizontal" role="form" method="post">
            <div class="form-group form-group-lg">
                <div style="width: 350px;">
                    <input class="form-control" id="Act" name="loginAct" type="text" placeholder="用户名">
                </div>
                <div style="width: 350px; position: relative;top: 20px;">
                    <input class="form-control" id="Pwd" name="loginPwd" type="password" placeholder="密码">
                </div>
                <div class="checkbox" style="position: relative;top: 30px; left: 10px;">
                    <span id="msg" style="color: red">
                        <c:if test="${sessionScope.map.Exception!=null}">
                          ${sessionScope.map.Exception}
                        </c:if>
                    </span>
                </div>
                <button type="button" class="btn btn-primary btn-lg btn-block"
                        onclick="verify($('#loginAct').val(),$('#loginPwd').val())"
                        style="width: 350px; position: relative;top: 45px;">登录
                </button>
            </div>
        </form>
    </div>
</div>
</body>
</html>