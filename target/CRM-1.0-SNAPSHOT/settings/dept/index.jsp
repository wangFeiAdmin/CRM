<%--
  Created by IntelliJ IDEA.
  User: wf
  Date: 2020/8/18
  Time: 10:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="/head.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
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





        //编号框失去焦点，触发事件，数据库查询编号是否重复
        $("#deptCode").on("blur", function () {
            var code = $("#deptCode").val();
            $.ajax({
                url: "${pageContext.request.contextPath}/dept/verifyDeptCode",
                type: "get",
                data: {
                    "deptNo": code
                },
                success: function (json) {
                    //判断部门编号是否重复
                    if (json.target) {
                        $("#deptCode").val("");
                    }
                }
            })
        })



        //判断是否更新成功，显示更新成功提示框
        <c:if test="${Ststus.target}">
        $("#tanContent").html("<center>${Ststus.title}</center>");
        $("#tan").show().delay(1500).hide(300);
        </c:if>

        //判断是否更新失败，显示更新失败提示框
        <c:if test="${Ststus.target==false}">
        $("#tanContent").html("<center>${Ststus.title}</center>");
        $("#tan").show().delay(1500).hide(300);
        </c:if>





        //给全选按钮添加点击事件
        $("input[name='chekcItems']").click(function () {
            $("input[name='deptids']").prop("checked", this.checked);//找到复选框添加属性checked并赋值
        });
        //找到每一个复选框并添加点击事件
        $("input[name='deptids']").click(function () {
            if ($("input[name='deptids']:checked").length == $("input[name='deptids']").length) {//被选中复选框的个数等于复选框的总个数
                $("input[name='chekcItems']").prop("checked", true);//为全选/全不选复选框添加属性checked并赋值true
            } else {
                $("input[name='chekcItems']").prop("checked", false);//否则赋值false
            }
        });

    })

    //删除勾选部门的方法
    function deleteDepts() {
        var deptids = [];
        $("input[name='deptids']:checked").each(function (i) {
            deptids.push($(this).val())
        })
        if (deptids.length <1) {
            //让消息框显示
            $("#tanContent").html("<center>至少勾选一个~~</center>");
            $("#tan").show().delay(1500).hide(300);
        }else{
            $("#deleteLocation").attr("href","${pageContext.request.contextPath}/dept/deleteDepts/"+deptids);
        }
    }

    //验证发送请求填写修改信息的方法
    function che() {
        var ids = [];
        $("input[name='deptids']:checked").each(function (i) {
            ids.push($(this).val())

        })
        if (ids.length != 1) {
            //让修改的弹框不出现
            $("#updateDept").attr("data-toggle", "");
            //让消息框显示
            $("#tanContent").html("<center>请勾选一个~~</center>");
            $("#tan").show().delay(1500).hide(300);
        } else {
            //获取需要修改的部门主键
            var deptId = ids[0];
            $.ajax({
                url: "${pageContext.request.contextPath}/dept/selectSingle",
                type: "post",
                data: {
                    "id": deptId
                },
                dataType: "json",
                success: function (json) {
//
                    $("#update-id").val(json.id);//部门主键
                    $("#update-code").val(json.deptNo);//部门编号
                    $("#update-name").val(json.deptName);//部门名称
                    $("#update-manager").val(json.deptfunctionary);//负责人
                    $("#update-describe").val(json.deptremark);//描述
                    $("#update-phone").val(json.deptphone);//电话
                    $("#updateDept").attr("data-toggle", "modal");
                }
            })


        }


    }

</script>
<body>



<!-- 创建部门的模态窗口 -->
<div class="modal fade" id="createDeptModal" role="dialog">
    <div class="modal-dialog" role="document" style="width: 80%;">
        <div class="modal-content">

            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">×</span>
                </button>
                <h4 class="modal-title" id="myModalLabel"><span class="glyphicon glyphicon-plus"></span> 新增部门</h4>
            </div>
            <form class="form-horizontal" id="addDeptFrom" role="form" method="post"
                  action="${pageContext.request.contextPath}/dept/add">
                <div class="modal-body">
                    <div class="form-group">
                        <label for="create-code" class="col-sm-2 control-label">编号<span
                                style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input required type="text" class="form-control" id="deptCode" id="create-code"
                                   style="width: 200%;"
                                   placeholder="编号不能为空，具有唯一性" name="deptNo">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="create-name" class="col-sm-2 control-label">名称</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input required type="text" name="deptName" class="form-control" id="create-name"
                                   style="width: 200%;">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="create-manager" class="col-sm-2 control-label">负责人</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input required type="text" name="deptfunctionary" class="form-control" id="create-manager"
                                   style="width: 200%;">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="create-phone" class="col-sm-2 control-label">电话</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input required type="text" name="deptphone" class="form-control" id="create-phone"
                                   style="width: 200%;">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="create-describe" class="col-sm-2 control-label">描述</label>
                        <div class="col-sm-10" style="width: 55%;">
                            <textarea class="form-control" name="deptremark" rows="3" id="create-describe"></textarea>
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

<!-- 修改部门的模态窗口 -->
<div class="modal fade" id="editDeptModal" role="dialog">
    <div class="modal-dialog" role="document" style="width: 80%;">
        <div class="modal-content">

            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">×</span>
                </button>
                <h4 class="modal-title" id="myModalLabel"><span class="glyphicon glyphicon-edit"></span> 编辑部门</h4>
            </div>
            <form class="form-horizontal" role="form" method="post"
                  action="${pageContext.request.contextPath}/dept/update">
                <div class="modal-body">
                    <div class="form-group">
                        <label for="create-code" class="col-sm-2 control-label">编号<span
                                style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input required type="text" class="form-control" id="update-code" style="width: 200%;"
                                   placeholder="不能为空，具有唯一性" name="deptNo">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="create-name" class="col-sm-2 control-label">名称</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input required type="text" class="form-control" id="update-name" style="width: 200%;"
                                   name="deptName"
                            >
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="create-manager" class="col-sm-2 control-label">负责人</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input required type="text" class="form-control" id="update-manager" style="width: 200%;"
                                   name="deptfunctionary"
                            >
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="create-phone" class="col-sm-2 control-label">电话</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input required type="text" class="form-control" id="update-phone" style="width: 200%;"
                                   name="deptphone">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="create-describe" class="col-sm-2 control-label">描述</label>
                        <div class="col-sm-10" style="width: 55%;">
                            <input type="hidden" name="id" id="update-id">
                            <textarea class="form-control" name="deptremark" rows="3" id="update-describe">description info</textarea>
                        </div>
                    </div>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="submit" class="btn btn-primary">更新</button>
                </div>
            </form>
        </div>
    </div>
</div>

<div style="width: 95%">
    <div>
        <div style="position: relative; left: 30px; top: -10px;">
            <div class="page-header">
                <h3>部门列表</h3>
            </div>
        </div>
    </div>
    <div class="btn-toolbar" role="toolbar"
         style="background-color: #F7F7F7; height: 50px; position: relative;left: 30px; top:-30px;">
        <div class="btn-group" style="position: relative; top: 18%;">
            <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#createDeptModal"><span
                    class="glyphicon glyphicon-plus"></span> 创建
            </button>
            <button type="button" id="updateDept" class="btn btn-default" data-target="#editDeptModal"
                    onclick="che()"><span
                    class="glyphicon glyphicon-edit"></span> 编辑
            </button>
           <a href="#" id="deleteLocation" onclick="deleteDepts()"><button type="button" class="btn btn-danger"><span class="glyphicon glyphicon-minus"></span> 删除</button></a>
        </div>
    </div>
    <div style="position: relative; left: 30px; top: -10px;">
        <table class="table table-hover">
            <thead>
            <tr style="color: #B3B3B3;">
                <td><input type="checkbox" name="chekcItems" id="select"/></td>
                <td>编号</td>
                <td>名称</td>
                <td>负责人</td>
                <td>电话</td>
                <td>描述</td>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${sessionScope.Page.list}" var="dept">
                <tr class="active">
                    <td><input type="checkbox" name="deptids" value="${dept.id}"/></td>
                    <td>${dept.deptNo}</td>
                    <td>${dept.deptName}</td>
                    <td>${dept.deptfunctionary}</td>
                    <td>${dept.deptphone}</td>
                    <td>${dept.deptremark}</td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>

    <div style="height: 50px; position: relative;top: 0px; left:30px;">
        <div>
            <button type="button" class="btn btn-default" style="cursor: default;">共<b>${sessionScope.Page.total}</b>条记录
            </button>
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
                        <li><a href="${pageContext.request.contextPath}/dept/limitSelect/10/1">
                            10
                        </a></li>
                    </c:if>
                    <li><a href="${pageContext.request.contextPath}/dept/limitSelect/15/1">
                        15
                    </a></li>
                    <li><a href="${pageContext.request.contextPath}/dept/limitSelect/20/1">
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
                                                       href="${pageContext.request.contextPath}/dept/limitSelect/${sessionScope.Page.pageSize}/1">首页</a>
                    </li>
                    <li class="disabled" id="befo"><a id="a2"
                                                      href="${pageContext.request.contextPath}/dept/limitSelect/${sessionScope.Page.pageSize}/${sessionScope.Page.pageno-1}">上一页</a>
                    </li>
                    <li class="disabled" id="next"><a id="a3"
                                                      href="${pageContext.request.contextPath}/dept/limitSelect/${sessionScope.Page.pageSize}/${sessionScope.Page.pageno+1}">下一页</a>
                    </li>
                    <li class="disabled" id="last"><a id="a4"
                                                      href="${pageContext.request.contextPath}/dept/limitSelect/${sessionScope.Page.pageSize}/${sessionScope.Page.pages}">末页</a>
                    </li>
                </ul>
            </nav>
        </div>
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