<%--
  Created by IntelliJ IDEA.
  User: wf
  Date: 2020/8/22
  Time: 19:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <base href="${pageContext.request.contextPath}/">
    <link href="jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet" />
    <script type="text/javascript" src="jquery/jquery-1.11.1-min.js"></script>
    <script type="text/javascript" src="jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>
    <script type="text/javascript">

        //页面加载完毕
        $(function(){

            //导航中所有文本颜色为黑色
            $(".liClass > a").css("color" , "black");

            //默认选中导航菜单中的第一个菜单项
            $(".liClass:first").addClass("active");

            //第一个菜单项的文字变成白色
            $(".liClass:first > a").css("color" , "white");

            //给所有的菜单项注册鼠标单击事件
            $(".liClass").click(function(){
                //移除所有菜单项的激活状态
                $(".liClass").removeClass("active");
                //导航中所有文本颜色为黑色
                $(".liClass > a").css("color" , "black");
                //当前项目被选中
                $(this).addClass("active");
                //当前项目颜色变成白色
                $(this).children("a").css("color","white");
            });




        });

    </script>

    <script>

        function  updatePas (olderPas,newPas,affirmPas){

            if(olderPas==''||newPas==''||affirmPas==''){
                $(".err").html("密码不能为空");
            }else{
                //判断两次密码输入的是否一致
                if(newPas==affirmPas){
                    $.ajax({
                        url:"${pageContext.request.contextPath}/update",
                        data:{
                            "id":${sessionScope.User.id},
                            "olderPasTwo":olderPas,
                            "loginPwd":affirmPas
                        },
                        type:"post",
                        success:function (json) {
                            if(json.target){
                                //打开主页重新登录
                                window.open("workbench/login.jsp");
                            }else{
                                $(".err").html("原密码错误");
                            }
                        }
                    })
                }else{
                    $(".err").html("两次密码不一致");
                }


            }

        }

    </script>
</head>
<body>

<!-- 我的资料 -->
<div class="modal fade" id="myInformation" role="dialog">
    <div class="modal-dialog" role="document" style="width: 30%;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">×</span>
                </button>
                <h4 class="modal-title">我的资料</h4>
            </div>
            <div class="modal-body">
                <div style="position: relative; left: 40px;">
                    姓名：<b>${sessionScope.User.name}</b><br><br>
                    登录帐号：<b>${sessionScope.User.loginAct}</b><br><br>
                    组织机构：<b>${sessionScope.User.dept.deptName}</b><br><br>
                    邮箱：<b>${sessionScope.User.email}</b><br><br>
                    失效时间：<b>
                    <c:if test="${sessionScope.User.expireTime==null}">
                        <c:out value="永久有效"/>
                    </c:if>
                    <c:if test="${sessionScope.User.expireTime.equals('null')}">
                        <c:out value="永久有效"/>
                    </c:if>
                    <c:if test="${sessionScope.User.expireTime!=null}">
                        <c:if test="${sessionScope.User.expireTime.equals('null')==false}">
                            <c:out value="${sessionScope.User.expireTime}"/>
                        </c:if>
                    </c:if>
                </b><br><br>
                    允许访问IP：<b>
                    <c:if test="${sessionScope.User.allowIps==null}">
                        <c:out value="无限"/>
                    </c:if>
                    <c:if test="${sessionScope.User.allowIps.equals('null')}">
                        <c:out value="无限"/>
                    </c:if>
                    <c:if test="${sessionScope.User.allowIps!=null}">
                        <c:if test="${sessionScope.User.allowIps.equals('null')==false}">
                            <c:out value="${sessionScope.User.allowIps}"/>
                        </c:if>
                    </c:if>
                </b>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            </div>
        </div>
    </div>
</div>

<!-- 修改密码的模态窗口 -->
<div class="modal fade" id="editPwdModal" role="dialog"  id="xian">
    <div class="modal-dialog" role="document" style="width: 70%;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">×</span>
                </button>
                <h4 class="modal-title">修改密码</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" role="form">
                    <div class="form-group">
                        <label for="oldPwd"  class="col-sm-2 control-label">原密码</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" id="oldP" class="form-control" id="oldPwd" style="width: 200%;">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="newPwd" class="col-sm-2 control-label">新密码</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" id="newP" class="form-control" id="newPwd" style="width: 200%;">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="confirmPwd" class="col-sm-2 control-label">确认密码</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" id="trueP" class="form-control" id="confirmPwd" style="width: 200%;">
                        </div>
                    </div>
                    <div>
                        <div style="position: absolute; left: 220px; bottom: 3px">
                             <span class="err" style="color: red">

                             </span>
                        </div>

                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <%--           更新按钮上的     --%>
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary"  id="logButt" data-dismiss="" onclick="updatePas($('#oldP').val(),$('#newP').val(),$('#trueP').val())">更新</button>
            </div>
        </div>
    </div>
</div>

<!-- 退出系统的模态窗口 -->
<div class="modal fade" id="exitModal" role="dialog">
    <div class="modal-dialog" role="document" style="width: 30%;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">×</span>
                </button>
                <h4 class="modal-title">离开</h4>
            </div>
            <div class="modal-body">
                <p>您确定要退出系统吗？</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary" data-dismiss="modal" onclick="window.location.href='../../login.html';">确定</button>
            </div>
        </div>
    </div>
</div>

<!-- 顶部 -->
<div id="top" style="height: 50px; background-color: #3C3C3C; width: 100%;">
    <div style="position: absolute; top: 5px; left: 0px; font-size: 30px; font-weight: 400; color: white; font-family: 'times new roman'">CRM &nbsp;<span style="font-size: 12px;">&copy;2017&nbsp;动力节点</span></div>
    <div style="position: absolute; top: 15px; right: 15px;">
        <ul>
            <li class="dropdown user-dropdown">
                <a href="javascript:void(0)" style="text-decoration: none; color: white;" class="dropdown-toggle" data-toggle="dropdown">
                    <span class="glyphicon glyphicon-user"></span>${sessionScope.User.loginAct}<span class="caret"></span>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                </a>
                <ul class="dropdown-menu">
                    <li><a href="${pageContext.request.contextPath}/settings/index.jsp"><span class="glyphicon glyphicon-wrench"></span> 系统设置</a></li>
                    <li><a href="javascript:void(0)" data-toggle="modal" data-target="#myInformation"><span class="glyphicon glyphicon-file"></span> 我的资料</a></li>
                    <li><a href="javascript:void(0)" data-toggle="modal" data-target="#editPwdModal"><span class="glyphicon glyphicon-edit"></span> 修改密码</a></li>
                    <li><a href="javascript:void(0);" data-toggle="modal" data-target="#exitModal"><span class="glyphicon glyphicon-off"></span> 退出</a></li>
                </ul>
            </li>
        </ul>
    </div>
</div>


</body>
</html>
