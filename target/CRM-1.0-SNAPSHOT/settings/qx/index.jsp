<%--
  Created by IntelliJ IDEA.
  User: wf
  Date: 2020/8/21
  Time: 7:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="/head.jsp"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <script type="text/javascript">

        //页面加载完毕
        $(function(){
            //展示市场活动页面
            window.open("${pageContext.request.contextPath}/settings/qx/user/index.jsp","workareaFrame");
        });

    </script>

</head>
<body>
<!-- 中间 -->
<div id="center" style="position: absolute;top: 50px; bottom: 30px; left: 0px; right: 0px;">

    <!-- 导航 -->
    <div id="navigation" style="left: 0px; width: 18%; position: relative; height: 100%; overflow:auto;">

        <ul id="no1" class="nav nav-pills nav-stacked">
            <li class="liClass"><a href="user/index.html" target="workareaFrame"><span class="glyphicon glyphicon-user"></span> 用户维护</a></li>
            <li class="liClass"><a href="#" target="workareaFrame"><span class="glyphicon glyphicon-user"></span> 角色维护</a></li>
            <li class="liClass"><a href="#" target="workareaFrame"><span class="glyphicon glyphicon-user"></span> 许可维护</a></li>
        </ul>

        <!-- 分割线 -->
        <div id="divider1" style="position: absolute; top : 0px; right: 0px; width: 1px; height: 100% ; background-color: #B3B3B3;"></div>
    </div>

    <!-- 工作区 -->
    <div id="workarea" style="position: absolute; top : 0px; left: 18%; width: 82%; height: 100%;">
        <iframe style="border-width: 0px; width: 100%; height: 100%;" name="workareaFrame"></iframe>
    </div>

</div>

<div id="divider2" style="height: 1px; width: 100%; position: absolute;bottom: 30px; background-color: #B3B3B3;"></div>

<!-- 底部 -->
<div id="down" style="height: 30px; width: 100%; position: absolute;bottom: 0px;"></div>

</body>
</html>