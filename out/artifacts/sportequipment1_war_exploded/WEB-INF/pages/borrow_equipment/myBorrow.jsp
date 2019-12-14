<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%
	Object login = session.getAttribute("user");
	if (login == null) {
		response.sendRedirect("login.jsp");
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
<link rel="stylesheet" href="css/returnequip.css" />
<script type="text/javascript" src="js/jquery-1.8.3.js"></script>
<script type="text/javascript" src="js/My97DatePicker/calendar.js"></script>
<script type="text/javascript" src="js/My97DatePicker/WdatePicker.js"></script>
</head>
</head>
<body>
	<div class="equipment-seek-input">

		<form action="borrowServlet?opr=myBorrow" method="post">

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
				<button type="submit">搜索</button>
			</div>
		</form>

	</div>

	<div class="borrow-seek-show">
		<div class="ui_tb">
			<table class="table" cellspacing="0" cellpadding="0" width="100%"
				onclick="doclick()" align="center" border="0">
				<tr>
					<th>租借用户名</th>
					<th>器材型号</th>
					<th>借出时间</th>
					<th>使用时间</th>
					<th>器材数量</th>
				</tr>

				<c:forEach var="borrow" items="${requestScope.borrowPage.list}"
					varStatus="status">
					<tr>
						<td>${borrow.loginName}</td>
						<td>${borrow.equipmentId}</td>
						<td>${borrow.lendDate}</td>
						<td>${borrow.willDate}</td>
						<td>${borrow.equipmentcount}</td>
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

	function equipmentshow() {
		$(".usershow").slideUp();
		$(".equipmentshow").slideDown();
		$(".selectshow").slideUp();
	}
	function equipmentconceal() {
		$(".equipmentshow").slideUp();
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
			$
					.ajax({
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
