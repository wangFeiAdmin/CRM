<%--
  Created by IntelliJ IDEA.
  User: wf
  Date: 2020/8/21
  Time: 8:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link href="${pageContext.request.contextPath}/jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css"
          rel="stylesheet"/>
    <script type="text/javascript" src="${pageContext.request.contextPath}/jquery/jquery-1.11.1-min.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>
</head>
<script>
    var pageNo = 1;//当前页码
    var pageSize = 10;//每页显示记录数
    var pages = 1;//可以分几页

    $(function () {
        //调用发送ajax的方法发送数据
        getMassage();

        //给全选按钮添加点击事件
        $("input[name='chekcItems']").click(function () {
            //找到复选框添加属性checked并赋值
            $("input[name='userids']").prop("checked", this.checked);
        });
        //找到每一个复选框并添加点击事件
        $("input[name='userids']").click(function () {
            //被选中复选框的个数等于复选框的总个数
            if ($("input[name='userids']:checked").length == $("input[name='userids']").length) {
                //为全选/全不选复选框添加属性checked并赋值true
                $("input[name='chekcItems']").prop("checked", true);
            } else {
                //否则赋值false
                $("input[name='chekcItems']").prop("checked", false);
            }
        });
    });


    /**
     * 用于发送请求，获取需要查询的数据
     */
    function getMassage() {
        //获取条件from中的数据
        var userName = $('#userName').val();
        var deptName = $('#deptName').val();
        var lockState = $('#lockState').val();
        var startTime = $('#startTime').val();
        var endTime = $('#endTime').val();
       
        var htm = '';//接收返回的数据
        $.ajax({
            url: "${pageContext.request.contextPath}/conditionQuery",
            type: "get",
            data: {
                //page对象的属性
                "userPage.pageSize": pageSize,
                "userPage.pageno": pageNo,
                "userName": userName,
                "deptName": deptName,
                "lockState": lockState,
                "startTime": startTime,
                "endTime": endTime
            },
            dataType: "json",
            success: function (json) {
                //设置条件框中的数据
                $('#userName').val(json.userName);
                $('#deptName').val(json.deptName);
                $('#lockState').val(json.lockState);
                $('#startTime').val(json.startTime);
                $('#endTime').val(json.endTime);
                var userPage = json.userPage;//获取分页对象
                //设置当前总记录数
                pageSize = userPage.pageSize;
                $("#showPageSize").html(pageSize);
                //设置当前页码
                pageNo = userPage.pageno;
                //设置总共有多少页
                pages = userPage.pages;
                //设置总记录条数
                $("#record").html(userPage.total);
                //判断是否有上一页
                if (userPage.haspreviousPage == true && userPage.hasNextPage == false) {
                    //让当前按钮无法点击
                    //设置可用
                    $("#a1").attr("disabled", false);
                    $("#a2").attr("disabled", false);

                    //设置不可用
                    $("#a3").attr("disabled", true);
                    $("#a4").attr("disabled", true);

                }

                //判断是否有下一页
                if (userPage.haspreviousPage == false && userPage.hasNextPage == true) {
                    //设置不可用
                    $("#a1").attr("disabled", true);
                    $("#a2").attr("disabled", true);
                    //设置可用
                    $("#a3").attr("disabled", false);
                    $("#a4").attr("disabled", false);

                }
                //即没有上一页，也没有下一页
                if (userPage.haspreviousPage == false && userPage.hasNextPage == false) {
                    //设置不可用
                    $("#a1").attr("disabled", true);
                    $("#a2").attr("disabled", true);
                    //设置不可用
                    $("#a3").attr("disabled", true);
                    $("#a4").attr("disabled", true);
                }

                // //让当前超链接无法点击
                if (userPage.haspreviousPage == true && userPage.hasNextPage == true) {
                    //设置可用
                    $("#a1").attr("disabled", false);
                    $("#a2").attr("disabled", false);
                    //设置可用
                    $("#a3").attr("disabled", false);
                    $("#a4").attr("disabled", false);
                }
                for (var i = 0; i < userPage.list.length; i++) {
                    //获取user对象
                    var mass = userPage.list[i];

                  var url="?id=".concat(mass.id).concat("&loginAct=").concat(
                      mass.loginAct).concat("&name=").concat(mass.name).concat(
                          "&email=").concat(mass.email).concat("&expireTime=").concat(
                      mass.expireTime).concat("&lockState=").concat(mass.lockState).concat(
                            "&allowIps=").concat(mass.allowIps).concat("&dept.deptName=").concat(mass.dept.deptName).concat(
                                "&loginPwd=").concat(mass.loginPwd)


                    htm = htm.concat(' <tr class="active">');
                    htm = htm.concat('<td><input type="checkbox" name="userids" value="' + mass.id + '"/></td>')
                    htm = htm.concat('<td>' + (i + 1) + '</td>');
                    htm = htm.concat('<td><a id="update" href="${pageContext.request.contextPath}/detail/'+url+'">' + mass.loginAct + '</a></td>');
                    htm = htm.concat('<td>' + mass.name + '</td>');
                    htm = htm.concat('<td>' + mass.dept.deptName + '</td>');
                    htm = htm.concat('<td>' + mass.email + '</td>');
                    if (mass.expireTime == null) {
                        htm = htm.concat('<td>永久有效</td>');
                    } else {
                        htm = htm.concat('<td>' + mass.expireTime + '</td>');
                    }
                    if (mass.allowIps == null) {
                        htm = htm.concat('<td>无限</td>');
                    } else {
                        htm = htm.concat('<td>' + mass.allowIps + '</td>');
                    }
                    if (mass.lockState == 1) {
                        htm = htm.concat('<td>启用</td>');
                    } else {
                        htm = htm.concat('<td>禁用</td>');
                    }
                    htm = htm.concat('<td>' + mass.createBy + '</td>');
                    htm = htm.concat('<td>' + mass.createTime + '</td>');
                    htm = htm.concat('<td>' + mass.editBy + '</td>');
                    htm = htm.concat('<td>' + mass.editTime + '</td>');
                }
                //展示数据
                $("#tbody").html(htm);
            }
        });
    }


    //发送验证获取所有的部门
    function funOne() {
        var htm = "<option value='0' selected='selected'>请选择...</option>";//用于接收拼接的数据
        $.ajax({
            url: "${pageContext.request.contextPath}/selectDeptName",
            type: "post",
            data:{
                "deptName":null
            },
            dataType: "json",
            success: function (json) {
                //deptNo
                for (var i = 0; i < json.length; i++) {
                    var mass = json[i];
                    htm = htm.concat("<option value='" + mass.deptNo + "'>")
                    htm = htm.concat(mass.deptName);
                    htm = htm.concat("</option>")
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
        if (userids.length < 1) {
            //让消息框显示
            $("#tanContent").html("<center>至少勾选一个~~</center>");
            $("#tan").show().delay(1500).hide(300);
        } else {
            $("#deleteLocation").attr("href", "${pageContext.request.contextPath}/deleteUsers/" + userids);
        }
    }

    //验证当前查询的状态，是否为条件查询
    function verifyStatus(pagesize) {
        //设置每页显示记录数
        pageSize = pagesize;
        getMassage();
    }

    //用于设置当前页码
    function setPageNo(status) {
        //表示点击的是首页
        if (status == 1) {
            pageNo = 1;
            //表示点击的是上一页
        } else if (status == 2) {
            pageNo = (pageNo - 1);
        } else if (status == 3) {
            pageNo = (pageNo + 1);
        } else if (status == 4) {
            pageNo = pages;
        }
        //调用发送ajax的方法
        getMassage();
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
                        <label for="create-loginActNo" class="col-sm-2 control-label">登录帐号<span
                                style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input required type="text" name="loginAct" class="form-control" id="create-loginActNo">
                        </div>
                        <label for="create-username" class="col-sm-2 control-label">用户姓名</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input required type="text" name="name" class="form-control" id="create-username">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="create-loginPwd" class="col-sm-2 control-label">登录密码<span
                                style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input required type="password" name="loginPwd" class="form-control" id="create-loginPwd">
                        </div>
                        <label for="create-confirmPwd" class="col-sm-2 control-label">确认密码<span
                                style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input required type="password"  class="form-control" id="create-confirmPwd">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="create-email" class="col-sm-2 control-label">邮箱</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input required type="email" name="email" class="form-control" id="create-email">
                        </div>
                        <label for="create-expireTime" class="col-sm-2 control-label">失效时间</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="dateISO" name="expireTime" class="form-control" id="create-expireTime">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="create-lockStatus" class="col-sm-2 control-label">锁定状态</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <select class="form-control" name="lockState" id="create-lockStatus">
                                <option  value="1"></option>
                                <option value="1">启用</option>
                                <option value="0">锁定</option>
                            </select>
                        </div>
                        <label for="create-org" class="col-sm-2 control-label">部门<span
                                style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <select required class="form-control" id="create-dept" onfocus="funOne()" name="deptno">
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="create-allowIps" class="col-sm-2 control-label">允许访问的IP</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" name="allowIps" class="form-control" id="create-allowIps"
                                   style="width: 280%" placeholder="多个用逗号隔开">
                        </div>
                    </div>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="submit" class="btn btn-primary">保存</button>
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
    <form class="form-inline" id="conditionQueryFrom" role="form" style="position: relative;top: 8%; left: 5px;">

        <div class="form-group">
            <div class="input-group">
                <div class="input-group-addon">用户姓名</div>
                <input class="form-control" id="userName" type="text">
            </div>
        </div>
        &nbsp;&nbsp;&nbsp;&nbsp;
        <div class="form-group">
            <div class="input-group">
                <div class="input-group-addon">部门名称</div>
                <input class="form-control" id="deptName" type="text">
            </div>
        </div>
        &nbsp;&nbsp;&nbsp;&nbsp;
        <div class="form-group">
            <div class="input-group">
                <div class="input-group-addon">锁定状态</div>
                <select class="form-control" id="lockState">
                    <option></option>
                    <option value="0">锁定</option>
                    <option value="1">启用</option>
                </select>
            </div>
        </div>
        <br><br>

        <div class="form-group">
            <div class="input-group">
                <div class="input-group-addon">失效时间</div>
                <input class="form-control" id="startTime" type="text" id="startTime"/>
            </div>
        </div>

        ~

        <div class="form-group">
            <div class="input-group">
                <input class="form-control" id="endTime" type="text" id="endTime"/>
            </div>
        </div>

        <button type="button" onclick="getMassage()" class="btn btn-default">查询</button>

    </form>
</div>


<div class="btn-toolbar" role="toolbar"
     style="background-color: #F7F7F7; height: 50px; position: relative;left: 30px; width: 110%; top: 20px;">
    <div class="btn-group" style="position: relative; top: 18%;">
        <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#createUserModal"><span
                class="glyphicon glyphicon-plus"></span> 创建
        </button>
        <a href="#" id="deleteLocation" onclick="deleteUsers()">
            <button type="button" class="btn btn-danger"><span class="glyphicon glyphicon-minus"></span> 删除</button>
        </a>
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
        <tbody id="tbody"></tbody>
    </table>
</div>

<div style="height: 50px; position: relative;top: 30px; left: 30px;">
    <div>
        <button type="button" class="btn btn-default" style="cursor: default;">共<b><span id="record"></span></b>条记录
        </button>
    </div>
    <div class="btn-group" style="position: relative;top: -34px; left: 110px;">
        <button type="button" class="btn btn-default" style="cursor: default;">显示</button>
        <div class="btn-group">
            <button type="button" id="showPageSize" class="btn btn-default dropdown-toggle" data-toggle="dropdown">

                <span class="caret">

                </span>
            </button>
            <ul class="dropdown-menu" role="menu">
                <li><a id="showTen" onclick="verifyStatus(10)" href="#">
                    10
                </a>
                </li>
                <li><a id="show15" onclick="verifyStatus(15)" href="#">
                    15
                </a></li>
                <li><a id="show20" onclick="verifyStatus(20)" href="#">
                    20
                </a></li>
            </ul>
        </div>
        <button type="button" class="btn btn-default" style="cursor: default;">条/页</button>
    </div>
    <div style="position: relative;top: -88px; left: 285px;">
        <nav>
            <ul class="pagination">
                <li class="disabled" id="first">
                    <button id="a1"
                            disabled="disabled"
                            type="button" class="btn btn-default" style="cursor: default;"
                            onclick="setPageNo(1)"
                    >首页
                    </button>
                </li>
                <li class="disabled" id="befo">
                    <button id="a2"
                            disabled="disabled"
                            type="button" class="btn btn-default" style="cursor: default;"
                            onclick="setPageNo(2)"
                    >上一页
                    </button>
                </li>
                <li class="disabled" id="next">
                    <button id="a3"
                            disabled="disabled"
                            type="button" class="btn btn-default" style="cursor: default;"
                            onclick="setPageNo(3)"
                    >下一页
                    </button>
                </li>
                <li class="disabled" id="last">
                    <button id="a4"
                            disabled="disabled"
                            type="button" class="btn btn-default" style="cursor: default;"
                            onclick="setPageNo(4)"
                    >末页
                    </button>
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