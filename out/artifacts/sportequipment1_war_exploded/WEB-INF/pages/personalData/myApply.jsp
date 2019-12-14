<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.sportequipment.domain.User"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	User user = (User) request.getSession().getAttribute("user");
%>
<%
	Object login = session.getAttribute("user");
	if (login == null) {
		response.sendRedirect("adminlogin.jsp");
	}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>My JSP 'equipemntSelectByPage.jsp' starting page</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<link rel="stylesheet" href="css/Apply.css" />
<script type="text/javascript" src="js/jquery-1.8.3.js"></script>
<script type="text/javascript" src="js/My97DatePicker/calendar.js"></script>
<script type="text/javascript" src="js/My97DatePicker/WdatePicker.js"></script>
</head>
</head>
<body>
	<div class="borrow-seek-show">
		<div class="ui_tb">
			<table class="table" cellspacing="0" cellpadding="0" width="100%"
				onclick="doclick()" align="center" border="0">
				<tr>
					<th>申请人</th>
					<th>器材型号</th>
					<th>申请数量</th>
					<th>申请时间</th>
					<th>备注</th>
					<th>操作</th>
				</tr>

				<c:forEach var="apply" items="${requestScope.applyPage.list}"
					varStatus="status">
					<tr>
						<td>${apply.loginName}</td>
						<td>${apply.equipmentId}</td>
						<td>${apply.borrowAmount}</td>
						<td>${apply.applyDate}</td>
						<td>${apply.applyRemark}</td>
						<td>
							<button
								onclick="returnfunction('${borrow.loginName}','${borrow.equipmentId}','${borrow.equipmentcount}');">修改</button>
							<button
								onclick="deletefunction('${borrow.loginName}','${borrow.equipmentId}');">删除</button>
						</td>
					</tr>
				</c:forEach>
			</table>
		</div>
	</div>

	<div class="equipmentshow" onclick="equipmentconceal()">
		<div class="form-group">
			器材名称：<a id="equipmentname"></a>
		</div>

		<div class="form-group">
			器材类型：<a id="Typeid"></a>
		</div>

		<div class="form-group">
			剩余数量：<a id="Acountid"></a>
		</div>

		<div class="form-group">
			器材规格：<a id="specificationid"></a>
		</div>
	</div>
</body>
</html>
<script type="text/javaScript">
	var returnErr = "${requestScope.returnErr}";
	var deleteErr = "${requestScope.deleteErr}";
	$(function() {
          
		if (returnErr != "") {
			alert(returnErr);
		}
		if (deleteErr != "") {
			alert(deleteErr);
		}
		/* 	$(".reigsterinput-progress-authm").slideUp();
		 $(".reigsterinput-progress-accom").slideUp(); */

	});
	function selectshow() {
		$(".usershow").slideUp();
		$(".equipmentshow").slideUp();
		$(".selectshow").slideDown();
	}
	function equipmentshow() {
		$(".usershow").slideUp();
		$(".equipmentshow").slideDown();
		$(".selectshow").slideUp();
	}
	
	function selectconceal() {
		$(".selectshow").slideUp();
	}
	function equipmentconceal() {
		$(".equipmentshow").slideUp();
	}
	
	function returnfunction(loginName, equipmentId, equipmentcount,
			operatperson) {
		var num = prompt("请输入归还数量:");
		var type = "^[0-9]*[1-9][0-9]*$";
		var r = new RegExp(type);
		var flag = r.test(num);
		if (flag) {
			if (parseInt(num) <= equipmentcount) {

				if (confirm("是否将器材归还")) {
					location = "borrowServlet?opr=returnequip&loginName="
							+ loginName + "&equipmentId=" + equipmentId
							+ "&equipmentcount=" + num + "&operatperson="
							+ operatperson;
				} else {
					return;
				}

			} else {
				alert("请输入正确数量");
			}
		} else {
			alert("请输入的正整数,不能为空");
		}

	}
	function deletefunction(loginName, equipmentId) {
		if (confirm("是否删除改申请")) {
          location = "applyServlet?opr=deleteMyApply&loginName="
							+ loginName + "&equipmentId=" + equipmentId;
		}
	 
				
	}
	function doclick() {
		var td = event.srcElement; // 通过event.srcElement 获取激活事件的对象 td
       if (td.cellIndex == 1 && td.parentElement.rowIndex >= 1) {

			equipmentshow();
			$.ajax({
						"url" : "borrowServlet?opr=equipmentaut",
						"data" : {
							"equipmentId" : td.innerText
						},
						"dataType" : "json",
						"contentType" : "application/json;charset=utf-8",
						"success" : function(data) {
							document.getElementById("equipmentname").innerHTML = data.equipmentname;
							document.getElementById("Typeid").innerHTML = data.equipmentType;
							document.getElementById("Acountid").innerHTML = data.equipmentAmount;
							document.getElementById("specificationid").innerHTML = data.equipmentspecification;
						}
					});
		}
	}
</script>
