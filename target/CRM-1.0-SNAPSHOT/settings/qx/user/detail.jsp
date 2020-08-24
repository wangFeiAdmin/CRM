<%--
  Created by IntelliJ IDEA.
  User: wf
  Date: 2020/8/23
  Time: 7:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link href="${pageContext.request.contextPath}/jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css"
          rel="stylesheet"/>
    <link href="${pageContext.request.contextPath}/jquery/zTree_v3-master/css/zTreeStyle/zTreeStyle.css" type="text/css"
          rel="stylesheet"/>

    <script type="text/javascript" src="${pageContext.request.contextPath}/jquery/jquery-1.11.1-min.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/jquery/zTree_v3-master/js/jquery.ztree.all.min.js"></script>

    <SCRIPT type="text/javascript">
        var setting = {
            data: {
                simpleData: {
                    enable: true
                }
            }
        };


        $(document).ready(function () {
           // $.fn.zTree.init($("#treeDemo"), setting, zNodes);
        });


    </SCRIPT>
    <script>
        var deptno='';
        /**
         * 用于发送请求，修改用户的信息
         */
        function updateUserMassage() {
            console.log("部门编号："+deptno)
            var uid='${updateUser.id}';
            var editBy='${sessionScope.User.name}';
            var olderPasTwo='${updateUser.loginPwd}';
            var et= $("#expireTime").val().trim();//有效时间
            var ai=$("#allowIps").val().trim();//允许
            if("永久有效"===et){
                et='';
            }
            if("无限"==ai){
                ai='';
            }
            $.ajax({
                url: "${pageContext.request.contextPath}/update",
                type: "post",
                dataType: "json",
                data: {
                    "id":uid,//主键
                    "loginAct":$("#loginAct").val().trim(),
                    "name":$("#name").val().trim(),//用户名
                    "loginPwd": $("#loginPwd").val().trim(),//密码
                    "olderPas":olderPasTwo,
                    "olderPasTwo":$("#loginPas").val(),
                    "email": $("#email").val().trim(),//邮箱
                    "expireTime":et,
                    "lockState": $("#lockState").val().trim(),//锁
                    "allowIps": ai,
                    "editTime": $("#editTime").val(),//修改
                    "deptno":deptno,//部门编号
                    "editBy":editBy.trim()//修改人
                },
                success: function (json) {
                    if(json.target){
                    var user=json.updateUaser;
                    $("#loginAct").val(user.loginAct);
                        $("#name").val(user.name);
                    $("#loginPwd").val(user.loginPwd);
                       $("#email").val(user.email);
                  $("#expireTime").val(user.expireTime);
                   $("#lockState").val(user.lockState);
                    $("#allowIps").val(user.allowIps);
                    $("#editTime").val(user.editTime);

                        $("#loginAct2").html(user.loginAct);
                        $("#name2").html(user.name);
                        $("#loginPwd2").html(user.loginPwd);
                        $("#email2").html(user.email);
                        $("#expireTime2").html(user.expireTime);
                        $("#lockState2").html(user.lockState);
                        $("#allowIps2").html(user.allowIps);
                        $("#editTime2").html(user.editTime);
                }
                }
            })
        }

        $(function () {
            $("#deptName").on("keyup",function () {
                funOne($("#deptName").val())

            })

        })
        //鼠标移动到内容上
        function changeBackColor_over(div){
            $(div).css("background-color","#CCCCCC");
        }
        //鼠标离开内容
        function changeBackColor_out(div){
            $(div).css("background-color","");

        }
        //将点击的内容放到搜索框
        function setSearch_onclick(div){
            var str =div.innerHTML;
            //获取部门编号
            str=str.substring(str.lastIndexOf("=")+2,str.length-2);
            deptno=str

            $("#deptName").val(div.innerText);
            $("#tips").css("display","none");
        }
        //发送验证获取所有的部门，自动补全部门名称
        function funOne(name) {
            if(name==null||name==''){
                $("#tips").css("display","none");
                return;
            }

            $.ajax({
                url: "${pageContext.request.contextPath}/selectDeptName",
                type: "post",
                data:{
                    "deptName":name
                },
                dataType: "json",
                success: function (json) {
                    //deptNo
                    var htm='';


                    for (var i = 0; i < json.length; i++) {
                        var mass = json[i];
                        htm+="<div id='content'  onclick='setSearch_onclick(this)' onmouseout='changeBackColor_out(this)' onmouseover='changeBackColor_over(this)'>"+
                            mass.deptName+"" +"<input type='hidden' value='"+mass.deptNo+"'>"+
                            "</div>";
                    }
                    $("#tips").html(htm);
                    $("#tips").css("display","block");

                }
            })
        }
    </script>
</head>
<body>

<!-- 分配许可的模态窗口 -->
<div class="modal fade" id="assignRoleForUserModal" role="dialog">
    <div class="modal-dialog" role="document" style="width: 80%;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">×</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">为<b>张三</b>分配角色</h4>
            </div>
            <div class="modal-body">
                <table width="90%" border="0" cellspacing="0" cellpadding="0" align="center">
                    <tr>
                        <td width="42%">
                            <div class="list_tit" style="border: solid 1px #D5D5D5; background-color: #F4F4B5;">
                                张三，未分配角色列表
                            </div>
                        </td>
                        <td width="15%">
                            &nbsp;
                        </td>
                        <td width="43%">
                            <div class="list_tit" style="border: solid 1px #D5D5D5; background-color: #F4F4B5;">
                                张三，已分配角色列表
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <select size="15" name="srcList" id="srcList"
                                    style="width: 100%" multiple="multiple">
                                <option>
                                    总裁
                                </option>
                                <option>
                                    市场部普通职员
                                </option>
                                <option>
                                    市场总监
                                </option>
                                <option>
                                    销售部销售员
                                </option>
                                <option>
                                    销售总监
                                </option>
                            </select>
                        </td>
                        <td>
                            <p align="center">
                                <a href="javascript:void(0);" title="分配角色"><span
                                        class="glyphicon glyphicon-chevron-right" style="font-size: 20px;"></span></a>
                            </p>
                            <br><br>
                            <p align="center">
                                <a href="javascript:void(0);" title="撤销角色"><span
                                        class="glyphicon glyphicon-chevron-left" style="font-size: 20px;"></span></a>
                            </p>
                        </td>
                        <td>
                            <select name="destList" size="15" multiple="multiple"
                                    id="destList" style="width: 100%">
                                <option>
                                    副总裁
                                </option>
                            </select>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            </div>
        </div>
    </div>
</div>

<!-- 编辑用户的模态窗口 -->
<div class="modal fade" id="editUserModal" role="dialog">
    <div class="modal-dialog" role="document" style="width: 90%;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">×</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">修改用户</h4>
            </div>

            <div class="modal-body">

                <form class="form-horizontal" role="form">
                    <div class="form-group">

                        <label for="edit-loginActNo" class="col-sm-2 control-label">登录帐号<span
                                style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" required class="form-control" id="loginAct" id="edit-loginActNo"
                                   value="${updateUser.loginAct}">
                        </div>
                        <label for="edit-username" class="col-sm-2 control-label">用户姓名</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" required id="name" class="form-control" id="edit-username"
                                   value="${updateUser.name}">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="edit-loginPwd" class="col-sm-2 control-label">登录密码<span
                                style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="password" required id="loginPas" class="form-control" id="edit-loginPwd"
                                   value="${updateUser.loginPwd}">
                        </div>
                        <label for="edit-confirmPwd" class="col-sm-2 control-label">确认密码<span
                                style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input required type="password"  id="loginPwd" class="form-control" id="edit-confirmPwd"
                                   value="${updateUser.loginPwd}">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="edit-email" class="col-sm-2 control-label">邮箱</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="email" class="form-control" id="email" id="edit-email"
                                   value="${updateUser.email}">
                        </div>
                        <label for="edit-expireTime" class="col-sm-2 control-label">失效时间</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="expireTime" id="edit-expireTime"
                                   value="<c:if test="${updateUser.expireTime==null}">
                            <c:out value="永久有效"/> </c:if><c:if test="${updateUser.expireTime.equals('null')}"><c:out value="永久有效"/> </c:if>
                        <c:if test="${updateUser.expireTime!=null}"><c:if test="${updateUser.expireTime.equals('null')==false}"><c:out value="${updateUser.expireTime}"/>
                            </c:if>
                        </c:if>
                        ">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="edit-lockStatus" class="col-sm-2 control-label">锁定状态</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <select class="form-control" id="lockState" id="edit-lockStatus">
                                <option value="1"></option>
                                <c:if test="${updateUser.lockState==1}">
                                    <option selected value="1">启用</option>
                                    <option value="0">锁定</option>
                                </c:if>
                                <c:if test="${updateUser.lockState!=1}">
                                    <option value="1">启用</option>
                                    <option selected value="0">锁定</option>
                                </c:if>


                            </select>
                        </div>
                        <label for="create-org" class="col-sm-2 control-label">部门名称<span
                                style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input required type="text"   id="deptName"  class="form-control" id="create-org"
                                   value="${updateUser.dept.deptNo}"
                                  >
                            <div id="tips" style="display: none; background-color:white; width:90%;  border: 1px solid pink";>
                        </div>


                        </div>
                    </div>
                    <div class="form-group"  >
                        <label for="edit-allowIps" class="col-sm-2 control-label">允许访问的IP</label>
                        <div class="col-sm-10" style="width: 300px;"  >
                            <input type="text" class="form-control" id="allowIps" id="edit-allowIps" style="width: 280%"
                                   placeholder="多个用逗号隔开" value="
                                 <c:if test="${updateUser.allowIps==null}">
                            <c:out value="无限"/>
                        </c:if>
                        <c:if test="${updateUser.allowIps.equals('null')}">
                            <c:out value="无限"/>
                        </c:if>
                        <c:if test="${updateUser.allowIps!=null}">
                            <c:if test="${updateUser.allowIps.equals('null')==false}">
                                <c:out value="${updateUser.allowIps}"/>
                            </c:if>
                        </c:if>
                                ">
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="gengxin" data-dismiss="modal" onclick="updateUserMassage()">更新</button>
            </div>
        </div>
    </div>
</div>

<div>
    <div style="position: relative; left: 30px; top: -10px;">
        <div class="page-header">
            <h3>用户明细 <small>${updateUser.name}</small></h3>
        </div>
        <div style="position: relative; height: 50px; width: 250px;  top: -72px; left: 80%;">
            <a href="${pageContext.request.contextPath}/settings/qx/index.jsp">
            <button type="button" class="btn btn-default"><span
                    class="glyphicon glyphicon-arrow-left"></span> 返回
            </button>
            </a>
        </div>
    </div>
</div>

<div style="position: relative; left: 60px; top: -50px;">

    <div id="myTabContent" class="tab-content">
        <div class="tab-pane fade in active" id="role-info">
            <div style="position: relative; top: 20px; left: -30px;">
                <div style="position: relative; left: 40px; height: 30px; top: 20px;">
                    <div style="width: 300px; color: gray;">登录帐号</div>
                    <div style="width: 500px;position: relative; left: 200px; top: -20px;"><b>
                        <span id="loginAct2">
                            ${updateUser.loginAct}
                        </span>
                    </b>
                    </div>
                    <div style="height: 1px; width: 600px; background: #D5D5D5; position: relative; top: -20px;"></div>
                </div>
                <div style="position: relative; left: 40px; height: 30px; top: 40px;">
                    <div style="width: 300px; color: gray;">用户姓名</div>
                    <div style="width: 500px;position: relative; left: 200px; top: -20px;"><b>
                        <span id="name2">
                            ${updateUser.name}
                        </span>
                    </b>
                    </div>
                    <div style="height: 1px; width: 600px; background: #D5D5D5; position: relative; top: -20px;"></div>
                </div>
                <div style="position: relative; left: 40px; height: 30px; top: 60px;">
                    <div style="width: 300px; color: gray;">邮箱</div>
                    <div style="width: 500px;position: relative; left: 200px; top: -20px;">
                        <span id="email2">
                            ${updateUser.email}
                        </span>
                        </b>
                    </div>
                    <div style="height: 1px; width: 600px; background: #D5D5D5; position: relative; top: -20px;"></div>
                </div>
                <div style="position: relative; left: 40px; height: 30px; top: 80px;">
                    <div style="width: 300px; color: gray;">失效时间</div>
                    <div style="width: 500px;position: relative; left: 200px; top: -20px;"><b>
                        <span id="expireTime2">
                        <c:if test="${updateUser.expireTime==null}">
                            <c:out value="永久有效"/>
                        </c:if>
                        <c:if test="${updateUser.expireTime.equals('null')}">
                            <c:out value="永久有效"/>
                        </c:if>
                        <c:if test="${updateUser.expireTime!=null}">
                            <c:if test="${updateUser.expireTime.equals('null')==false}">
                                <c:out value="${updateUser.expireTime}"/>
                            </c:if>
                        </c:if>
                        </span></b></div>
                    <div style="height: 1px; width: 600px; background: #D5D5D5; position: relative; top: -20px;"></div>
                </div>
                <div style="position: relative; left: 40px; height: 30px; top: 100px;">
                    <div style="width: 300px; color: gray;">允许访问IP</div>
                    <div style="width: 500px;position: relative; left: 200px; top: -20px;"><b>
                        <span id="allowIps2">
                        <c:if test="${updateUser.allowIps==null}">
                            <c:out value="无限"/>
                        </c:if>
                        <c:if test="${updateUser.allowIps.equals('null')}">
                            <c:out value="无限"/>
                        </c:if>
                        <c:if test="${updateUser.allowIps!=null}">
                            <c:if test="${updateUser.allowIps.equals('null')==false}">
                                <c:out value="${updateUser.allowIps}"/>
                            </c:if>
                        </c:if>
                            </span>
                    </b></div>
                    <div style="height: 1px; width: 600px; background: #D5D5D5; position: relative; top: -20px;"></div>
                </div>
                <div style="position: relative; left: 40px; height: 30px; top: 120px;">
                    <div style="width: 300px; color: gray;">锁定状态</div>
                    <div style="width: 500px;position: relative; left: 200px; top: -20px;"><b>
                        <span id="lockState2">
                        <c:if test="${updateUser.lockState==1}">
                            <c:out value="启用"/>
                        </c:if>
                        <c:if test="${updateUser.lockState!=1}">
                            <c:out value="禁用"/>
                        </c:if>
                        </span>
                    </b></div>
                    <div style="height: 1px; width: 600px; background: #D5D5D5; position: relative; top: -20px;"></div>
                </div>
                <div style="position: relative; left: 40px; height: 30px; top: 140px;">
                    <div style="width: 300px; color: gray;">部门名称</div>
                    <div style="width: 500px;position: relative; left: 200px; top: -20px;">
                        <b><span id="deptName2">${updateUser.dept.deptName}</span></b></div>
                    <div style="height: 1px; width: 600px; background: #D5D5D5; position: relative; top: -20px;"></div>
                    <button style="position: relative; left: 76%; top: -40px;" type="button" class="btn btn-default"
                            id="updateUserBut"

                            data-toggle="modal" data-target="#editUserModal"><span
                            class="glyphicon glyphicon-edit"></span> 编辑
                    </button>
                </div>
            </div>
        </div>
        <div class="tab-pane fade" id="permission-info">
            <div style="position: relative; top: 20px; left: 0px;">
                <ul id="treeDemo" class="ztree" style="position: relative; top: 15px; left: 15px;"></ul>
                <div style="position: relative;top: 30px; left: 76%;">
                    <button type="button" class="btn btn-default" data-toggle="modal"
                            data-target="#assignRoleForUserModal"><span class="glyphicon glyphicon-edit"></span> 分配角色
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>