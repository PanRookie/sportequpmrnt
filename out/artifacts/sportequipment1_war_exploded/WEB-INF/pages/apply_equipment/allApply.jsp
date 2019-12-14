<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.sportequipment.domain.Admin"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%
	Object login = session.getAttribute("admin");
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
	 <div class="equipment-seek-input">

		<form action="applyServlet?opr=allApplyPage" method="post">

 			<div class="form-group">
				申请人：<input type="text" name="loginName" value="" />
			</div> 
			<div class="form-group">
				器材型号：<input type="text" name="equipmentId" value="" />
			</div>
			 <div class="form-group">
				借出日期： <input type="text"
					onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"
					class="input-text Wdate" style="width:130px;" name="startDate">
				- <input type="text"
					onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"
					class="input-text Wdate" style="width:130px;" name="endDate">
			</div>
			<div class="form-group">
				个数型号：<input type="text" name="borrowNum" value="" />
			</div> 
			<div class="form-group">
				<button type="submit">搜索</button>
			</div>
		</form>

	</div> 

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
								onclick="passfunction('${apply.loginName}','${apply.equipmentId}','${apply.borrowAmount}');">通过</button>
							<button
								onclick="refusefunction('${apply.loginName}','${apply.equipmentId}');">拒绝</button>
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
	<div class="usershow" onclick="userconceal()">
		<div class="form-group">
			<img alt="user.jpg" src="">
		</div>
		<div class="form-group">
			学号：<a id="loginname"></a>
		</div>
		<div class="form-group">
			姓名：<a id="username"></a>
		</div>
		<div class="form-group">
			性别：<a id="sex"></a>
		</div>
		<div class="form-group">
			学院：<a id="academy"></a>
		</div>
		<div class="form-group">
			专业：<a id="major"></a>
		</div>
		<div class="form-group">
			职位：<a id="position"></a>
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
	function usershow() {
		$(".usershow").slideDown();
		$(".equipmentshow").slideUp();
		$(".selectshow").slideUp();
	}

	function selectconceal() {
		$(".selectshow").slideUp();
	}
	function equipmentconceal() {
		$(".equipmentshow").slideUp();
	}
	function userconceal() {
		$(".usershow").slideUp();
	}
	
	function passfunction(loginName, equipmentId, equipmentcount) {
			if (confirm("是否同意借出该器材")) {
					location = "applyServlet?opr=passApply&loginName="
							+ loginName + "&equipmentId=" + equipmentId
							+ "&equipmentcount=" + equipmentcount;
				}
	}
	function deletefunction(loginName, equipmentId) {
		if (confirm("是否拒絕申请")) {
          location = "applyServlet?opr=deleteMyApply&loginName="
							+ loginName + "&equipmentId=" + equipmentId;
		}
	 
				
	}
	function doclick() {
		var td = event.srcElement; // 通过event.srcElement 获取激活事件的对象 td
       		if (td.cellIndex == 0 && td.parentElement.rowIndex >= 1) {
			usershow();
			//alert("列号：" + td.cellIndex + "行号："+ ( + 1) + "，内容：" + td.innerText);
			$
					.ajax({
						"url" : "borrowServlet?opr=userauthentication",
						"data" : {
							"loginName" : td.innerText
						},
						"dataType" : "json",
						"contentType" : "application/json;charset=utf-8",
						"success" : function(data) {
							document.getElementById("loginname").innerHTML = data.loginname;
							document.getElementById("username").innerHTML = data.username;
							document.getElementById("sex").innerHTML = data.sex;
							document.getElementById("academy").innerHTML = data.dapartment;
							document.getElementById("major").innerHTML = data.major;
							document.getElementById("position").innerHTML = data.schoolposition;
							var img = document
									.querySelector(".usershow .form-group img").src = "./images/test.jpg";

						}
		 });
		} else if (td.cellIndex == 1 && td.parentElement.rowIndex >= 1) {

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
