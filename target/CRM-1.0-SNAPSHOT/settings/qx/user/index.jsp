<%--
  Created by IntelliJ IDEA.
  User: wf
  Date: 2020/8/21
  Time: 8:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link href="${pageContext.request.contextPath}/jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet" />
    <script type="text/javascript" src="${pageContext.request.contextPath}/jquery/jquery-1.11.1-min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>
</head>
<script>
    //页面加载完后之后判断当前是否可以下一页 上一页……
    $(function () {






        //判断是否有上一页
        <c:if test="${sessionScope.Page.haspreviousPage}">
        <c:if test="${sessionScope.Page.hasNextPage==false}">

        $("#first").attr("class", "")
        $("#befo").attr("class", "")
        //让当前超链接无法点击
        $("#a3").attr("href", "#")
        $("#a4").attr("href", "#")
        </c:if>
        </c:if>

        //判断是否有下一页
        <c:if test="${sessionScope.Page.hasNextPage}">
        <c:if test="${sessionScope.Page.haspreviousPage==false}">

        $("#next").attr("class", "")
        $("#last").attr("class", "")
        //让当前超链接无法点击
        $("#a1").attr("href", "#")
        $("#a2").attr("href", "#")
        </c:if>
        </c:if>


        //即没有上一页，也没有下一页
        <c:if test="${sessionScope.Page.hasNextPage==false}">
        <c:if test="${sessionScope.Page.haspreviousPage==false}">

        //让当前超链接无法点击
        $("#a3").attr("href", "#")
        $("#a4").attr("href", "#")
        $("#a1").attr("href", "#")
        $("#a2").attr("href", "#")
        </c:if>
        </c:if>
        <c:if test="${sessionScope.Page.hasNextPage}">
        <c:if test="${sessionScope.Page.haspreviousPage}">

        //让当前超链接无法点击
        $("#first").attr("class", "")
        $("#befo").attr("class", "")
        $("#next").attr("class", "")
        $("#last").attr("class", "")
        </c:if>
        </c:if>


        //给全选按钮添加点击事件
        $("input[name='chekcItems']").click(function () {
            $("input[name='userids']").prop("checked", this.checked);//找到复选框添加属性checked并赋值
        });
        //找到每一个复选框并添加点击事件
        $("input[name='userids']").click(function () {
            if ($("input[name='userids']:checked").length == $("input[name='userids']").length) {//被选中复选框的个数等于复选框的总个数
                $("input[name='chekcItems']").prop("checked", true);//为全选/全不选复选框添加属性checked并赋值true
            } else {
                $("input[name='chekcItems']").prop("checked", false);//否则赋值false
            }
        });





});







    //发送验证获取所有的部门
    function funOne() {
        var htm="<option value='0' selected='selected'>请选择...</option>";//用于接收拼接的数据
        $.ajax({
            url:"${pageContext.request.contextPath}/selectDeptName",
            type:"get",
            dataType:"json",
            success:function (json) {
                //deptNo
                for(var i=0; i<json.length; i++){
                    var mass=json[i];
                    htm=htm.concat("<option value='"+mass.deptNo+"'>")
                    htm=htm.concat(mass.deptName);
                    htm=htm.concat("</option>")
                }
                $("#create-dept").html(htm);
            }
        })
    }

    //删除勾选部门的方法
    function deleteUsers() {
        var userids = [];
        $("input[name='userids']:checked").each(function (i) {
            userids.push($(this).val())
        })
        if (userids.length <1) {
            //让消息框显示
            $("#tanContent").html("<center>至少勾选一个~~</center>");
            $("#tan").show().delay(1500).hide(300);
        }else{
            $("#deleteLocation").attr("href","${pageContext.request.contextPath}/deleteUsers/"+userids);
        }
    }
</script>
<body>

<!-- 创建用户的模态窗口 -->
<div class="modal fade" id="createUserModal" role="dialog">
    <div class="modal-dialog" role="document" style="width: 90%;">
        <div class="modal-content">


            <form class="form-horizontal" id="addDeptFrom" role="form" method="post"
                  action="${pageContext.request.contextPath}/addUser">

            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">×</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">新增用户</h4>
            </div>
            <div class="modal-body">
                    <div class="form-group">
                        <label for="create-loginActNo" class="col-sm-2 control-label">登录帐号<span style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input required type="text" name="loginAct" class="form-control" id="create-loginActNo">
                        </div>
                        <label for="create-username"  class="col-sm-2 control-label">用户姓名</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input required type="text" name="name" class="form-control" id="create-username">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="create-loginPwd" class="col-sm-2 control-label">登录密码<span style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input required type="password" name="loginPwd" class="form-control" id="create-loginPwd">
                        </div>
                        <label for="create-confirmPwd" class="col-sm-2 control-label">确认密码<span style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input required type="password" class="form-control" id="create-confirmPwd">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="create-email" class="col-sm-2 control-label">邮箱</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input  required type="email" name="email" class="form-control" id="create-email">
                        </div>
                        <label for="create-expireTime" class="col-sm-2 control-label">失效时间</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="dateISO"  name="expireTime" class="form-control" id="create-expireTime">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="create-lockStatus" class="col-sm-2 control-label">锁定状态</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <select  class="form-control" name="lockState" id="create-lockStatus">
                                <option value="1"></option>
                                <option value="1">启用</option>
                                <option value="0">锁定</option>
                            </select>
                        </div>
                        <label for="create-org" class="col-sm-2 control-label">部门<span style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <select required  class="form-control" id="create-dept" onfocus="funOne()" name="deptno">
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="create-allowIps" class="col-sm-2 control-label">允许访问的IP</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" name="allowIps"  class="form-control" id="create-allowIps" style="width: 280%" placeholder="多个用逗号隔开">
                        </div>
                    </div>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="submit" class="btn btn-primary" >保存</button>
            </div>
            </form>
        </div>
    </div>
</div>


<div>
    <div style="position: relative; left: 30px; top: -10px;">
        <div class="page-header">
            <h3>用户列表</h3>
        </div>
    </div>
</div>

<div class="btn-toolbar" role="toolbar" style="position: relative; height: 80px; left: 30px; top: -10px;">
    <form class="form-inline" role="form" style="position: relative;top: 8%; left: 5px;">

        <div class="form-group">
            <div class="input-group">
                <div class="input-group-addon">用户姓名</div>
                <input class="form-control" type="text">
            </div>
        </div>
        &nbsp;&nbsp;&nbsp;&nbsp;
        <div class="form-group">
            <div class="input-group">
                <div class="input-group-addon">部门名称</div>
                <input class="form-control" type="text">
            </div>
        </div>
        &nbsp;&nbsp;&nbsp;&nbsp;
        <div class="form-group">
            <div class="input-group">
                <div class="input-group-addon">锁定状态</div>
                <select class="form-control">
                    <option></option>
                    <option>锁定</option>
                    <option>启用</option>
                </select>
            </div>
        </div>
        <br><br>

        <div class="form-group">
            <div class="input-group">
                <div class="input-group-addon">失效时间</div>
                <input class="form-control" type="text" id="startTime" />
            </div>
        </div>

        ~

        <div class="form-group">
            <div class="input-group">
                <input class="form-control" type="text" id="endTime" />
            </div>
        </div>

        <button type="submit" class="btn btn-default">查询</button>

    </form>
</div>


<div class="btn-toolbar" role="toolbar" style="background-color: #F7F7F7; height: 50px; position: relative;left: 30px; width: 110%; top: 20px;">
    <div class="btn-group" style="position: relative; top: 18%;">
        <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#createUserModal"><span class="glyphicon glyphicon-plus"></span> 创建</button>
        <a href="#" id="deleteLocation" onclick="deleteUsers()">  <button type="button" class="btn btn-danger"><span class="glyphicon glyphicon-minus"></span> 删除</button></a>
    </div>

</div>

<div style="position: relative; left: 30px; top: 40px; width: 110%">
    <table class="table table-hover">
        <thead>
        <tr style="color: #B3B3B3;">
            <td><input type="checkbox" name="chekcItems" id="select"/></td>
            <td>序号</td>
            <td>登录帐号</td>
            <td>用户姓名</td>
            <td>部门名称</td>
            <td>邮箱</td>
            <td>失效时间</td>
            <td>允许访问IP</td>
            <td>锁定状态</td>
            <td>创建者</td>
            <td>创建时间</td>
            <td>修改者</td>
            <td>修改时间</td>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${sessionScope.Page.list}" var="user" varStatus="status"  >
        <tr class="active">
            <td><input type="checkbox" name="userids" value="${user.id}"/></td>
            <td>${status.count}</td>
            <td><a href="detail.html">${user.loginAct}</a></td>
            <td>${user.name}</td>
            <td>${user.dept.deptName}</td>
            <td>${user.email}</td>
            <td>
                <c:if test="${user.expireTime==null}">
                    <c:out value="永久有效"/>
                </c:if>
                <c:if test="${user.expireTime!=null}">
                    <c:out value="${user.expireTime}"/>
                </c:if>
            </td>
            <td>
                <c:if test="${user.allowIps==null}">
                    <c:out value="无限"/>
                </c:if>
                <c:if test="${user.allowIps!=null}">
                    <c:out value="${user.allowIps}"/>
                </c:if>

            </td>
            <td>
                <c:if test="${user.lockState==1}">
                    <c:out value="启用"/>
                </c:if>
                <c:if test="${user.lockState==0}">
                    <c:out value="锁定"/>
                </c:if>
            </td>
            <td>${user.createBy}</td>
            <td>${user.createTime}</td>
            <td>${user.editBy}</td>
            <td>${user.editTime}</td>
        </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<div style="height: 50px; position: relative;top: 30px; left: 30px;">
    <div>
        <button type="button" class="btn btn-default" style="cursor: default;">共<b>${sessionScope.Page.total}</b>条记录</button>
    </div>
    <div class="btn-group" style="position: relative;top: -34px; left: 110px;">
        <button type="button" class="btn btn-default" style="cursor: default;">显示</button>
        <div class="btn-group">
            <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
                ${sessionScope.Page.pageSize}
                <span class="caret"></span>
            </button>
            <ul class="dropdown-menu" role="menu">
                <c:if test="${sessionScope.Page.pageSize!=10}">
                    <li><a href="${pageContext.request.contextPath}/limitSelect/10/1">
                        10
                    </a></li>
                </c:if>
                <li><a href="${pageContext.request.contextPath}/limitSelect/15/1">
                        15
                </a></li>
                <li><a href="${pageContext.request.contextPath}/limitSelect/20/1">
                        20
                </a></li>
            </ul>
        </div>
        <button type="button" class="btn btn-default" style="cursor: default;">条/页</button>
    </div>
    <div style="position: relative;top: -88px; left: 285px;">
        <nav>
            <ul class="pagination">
                <li class="disabled" id="first"><a id="a1"
                                                   href="${pageContext.request.contextPath}/limitSelect/${sessionScope.Page.pageSize}/1">首页</a>
                </li>
                <li class="disabled" id="befo"><a id="a2"
                                                  href="${pageContext.request.contextPath}/limitSelect/${sessionScope.Page.pageSize}/${sessionScope.Page.pageno-1}">上一页</a>
                </li>
                <li class="disabled" id="next"><a id="a3"
                                                  href="${pageContext.request.contextPath}/limitSelect/${sessionScope.Page.pageSize}/${sessionScope.Page.pageno+1}">下一页</a>
                </li>
                <li class="disabled" id="last"><a id="a4"
                                                  href="${pageContext.request.contextPath}/limitSelect/${sessionScope.Page.pageSize}/${sessionScope.Page.pages}">末页</a>
                </li>
            </ul>
        </nav>
    </div>
</div>
<!--显示一个弹框，用于告知用户创建失败-->
<div id="tan" style="display:none;
		       	border:3px solid #ccc;
				border-radius: 5px;
				background: #fff;
				font-size: 20px;
                 width: 230px;
                height: 70px;
                position: fixed;
                top:0%;left: 70%;
		 	">
           <span style="padding: 3px;font-size: 16px; color:darkgray;" id="tanContent">
           	<center>
           	创建失败，稍后尝试哦~~~
           	</center>
           </span>

</div>
</body>
</html>