<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.sportequipment.domain.Admin"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	Admin admin = (Admin) request.getSession().getAttribute("admin");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>My JSP 'borrow_equipment.jsp' starting page</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<link rel="stylesheet" href="css/borrow.css" />
<script type="text/javascript" src="js/jquery-1.8.3.js"></script>
<script type="text/javascript">
	var borrowErr = "${requestScope.borrowErr}";
	$(function() {

		if (borrowErr != "") {
			alert(borrowErr);
		}

		showTime();
		$(".add").click(function() {
			$(".text_number").val(parseInt($(".text_number").val()) + 1);
		});

		$(".min").click(function() {
			if (parseInt($(".text_number").val()) > 1) {
				$(".text_number").val(parseInt($(".text_number").val()) - 1);
			}
		});

		$("[name='loginName']")
				.blur(
						function() {
							$
									.ajax({
										"url" : "borrowServlet?opr=userauthentication",
										"data" : {
											"loginName" : $(this).val()
										},
										"dataType" : "json",
										"contentType" : "application/json;charset=utf-8",
										"success" : function(data) {

											document.getElementById("position").innerHTML = data.schoolposition;
											if (data.schoolposition == "学生") {

												$.ajax({
															"url" : "borrowServlet?opr=course",
															"data" : {
																"loginName" : data.loginname
															},
															"dataType" : "json",
															"contentType" : "application/json;charset=utf-8",
															"success" : function(data) {

															}
														});

											}
											document.getElementById("username").innerHTML = data.username;
											document
													.getElementById("loginname").innerHTML = data.loginname;
											document
													.getElementById("dapartment").innerHTML = data.dapartment;
											document.getElementById("major").innerHTML = data.major;
											var img = document
													.querySelector(".userdata .personqge .right img").src = "./images/test.jpg";
											if (data.loginname == "") {
												$("#userMsg").text("无此用户！");
											} else {
												$("#userMsg").text("");
											}
										}
									});
						});

		$("[name='equipmentId']")
				.blur(
						function() {
							$
									.ajax({
										"url" : "borrowServlet?opr=equipmentaut",
										"data" : {
											"equipmentId" : $(this).val()
										},
										"dataType" : "json",
										"contentType" : "application/json;charset=utf-8",
										"success" : function(data) {
											document
													.getElementById("equipmentname").innerHTML = data.equipmentname;
											document.getElementById("Typeid").innerHTML = data.equipmentType;
											document.getElementById("Acountid").innerHTML = data.equipmentAmount;
											document
													.getElementById("specificationid").innerHTML = data.equipmentspecification;
											var img = document
													.querySelector(".userdata .equipment .right img").src = "./images/register_ok.jpg";

											if (data.equipmentname == "") {
												$("#equipMsg").text("无此器材！");
											} else {
												$("#equipMsg").text("");
											}
										}
									});
						});

	});
	function showTime() {
		var now = new Date();
		var year = now.getFullYear();
		var month = now.getMonth() + 1; //js获取的月份是从0开始；
		var day = now.getDate();
		document.getElementById("show").innerHTML = "" + year + " 年 " + month
				+ " 月 " + day + " 日    ";
	}
	function datacheck() {
		var equipmennumber = document.getElementsByName("equipmennumber")[0];
		if (equipmennumber.validity.valueMissing == true) {
			equipmennumber.setCustomValidity("数量不能为空");
		} else if (equipmennumber.value == 0 && equipmennumber.value > 200) {
			equipmennumber.setCustomValidity("数量不合理");
		} else {
			equipmennumber.setCustomValidity("");
		}
	}
</script>
</head>
<body>
	<form action="borrowServlet?opr=adminborrow" method="post">
		<div class="borrow">
			<div class="equipment-borrow">

				<div class="user-authentication">
					<div class="form-group">
						用户名：<input type="text" name="loginName" required />&nbsp;&nbsp;&nbsp;<span
							id="userMsg" style="color:red"></span>
					</div>

					<div class="form-group">
						密码：<input type="password" name="password" required />
					</div>
				</div>

				<div class="select-borrow">
					<div class="form-group">
						器材型号：<input type="text" name="equipmentId" required />&nbsp;&nbsp;&nbsp;<span
							id="equipMsg" style="color:red"></span>
					</div>
					<div class="form-group">
						剩余数量：
						<button class="min" type="button">-</button>
						<input class="text_number" name="equipmennumber" type="text"
							value="1" required pattern="[1-9]\d*" />
						<button class="add" type="button">+</button>
					</div>
					<div class="form-group">
						借出时间：<a id="show"></a>
					</div>
					<div class="form-group">
						操作人员：<%=admin.getAdminName()%></div>
				</div>

				<div class="form-group">
					<input type="submit" value="借出" class="btnborrow"
						onclick="datacheck();">
				</div>
			</div>

			<div class="userdata">
				<div class="personqge">
					<div class="left">
						<div class="form-group">
							用户职位：<a id="position"></a>
						</div>
						<div class="form-group">
							用户姓名：<a id="username"></a>
						</div>
						<div class="form-group">
							学号：<a id="loginname"></a>
						</div>
						<div class="form-group">
							直属学院：<a id="dapartment"></a>
						</div>
						<div class="form-group">
							专业：<a id="major"></a>
						</div>
					</div>
					<div class="right">
						<img alt="user.jpg" src="">
					</div>
				</div>

				<div class="equipment">
					<div class="left">
						<div class="form-group">
							器材名称：<a id="equipmentname"></a>&nbsp;&nbsp;&nbsp;<span
								id="equipMsg" style="color:red"></span>
						</div>

						<div class="form-group">
							器材类型：<a id="Typeid"></a>
						</div>

						<div class="form-group">
							器材数量：<a id="Acountid"></a>
						</div>

						<div class="form-group">
							器材规格：<a id="specificationid"></a>
						</div>
					</div>
					<div class="right">
						<img alt="equipment.jpg" src="">
					</div>
				</div>
				<div class="course"></div>
			</div>
	</form>
</body>
</html>
