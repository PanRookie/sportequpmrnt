<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%
	String userName = "";
	String checked = "";
	//得到客户端保存的Cookie数据
	Cookie[] cookies = request.getCookies();
	for (int i = 0; cookies != null && i < cookies.length; i++) {
		if ("userName".equals(cookies[i].getName())) {
			userName = cookies[i].getValue();
			checked = "checked='checked'";
		}
	}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>My JSP 'login.jsp' starting page</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<link rel="stylesheet" href="css/Login.css" />
<script type="text/javascript" src="js/jquery-1.8.3.js"></script>
<script type="text/javascript">
	var error = "${requestScope.err}";
	if (error != "") {
		alert(error);
	}
	function register() {
		/* 		var myselect = document.getElementById("select");
		 var index = myselect.selectedIndex; */

		var logName = document.getElementsByName("loginName")[0];
		if (logName.validity.valueMissing == true) {
			logName.setCustomValidity("用户名不能为空");
		} else if (logName.validity.patternMismatch == true) {
			logName.setCustomValidity("用户名以9~11位数字组成");
		} else {
			logName.setCustomValidity("");

		}
		var pwd = document.getElementsByName("password")[0];
		if (pwd.validity.valueMissing == true) {
			pwd.setCustomValidity("密码不能为空");

		} else if (pwd.validity.patternMismatch == true) {
			pwd.setCustomValidity("密码为4~10位");
		} else {
			pwd.setCustomValidity("");
		}
	}
	var validateCode = document.getElementsByName("validateCode")[0];
	if (validateCode.validity.valueMissing == true) {
		validateCode.setCustomValidity("请输入验证码");
	} else {
		validateCode.setCustomValidity("");

	}

	function changeCode() {
		//得到图片元素
		var img = document
				.querySelector(".login-main .login-main-input .form-group:nth-child(4) img");
		//img.setAttribute("src","/day09_00_HttpServletResponse/servlet/demo4");//XML Dom 语法
		img.src = "${pageContext.request.contextPath}/servlet/CodeServlet?time="
				+ new Date().getTime();
	}
</script>
</head>

<body>
	<form action="userServlet?opr=login" method="post">
		<div class="imagetitle">
			<img alt="login.jpg" src="./images/ms_login.png" />
		</div>
		<div class="login-main">
			<div class="login-main-input">

				<div class="form-group">
					<!-- 					<select name="identity" id="select">
						<option value="user">用户登录</option>
						<option value="admin">管理登录</option>
					</select> -->
					<a>用户登录</a>
				</div>
				<div class="form-group">
					<input type="text" name="loginName" value="<%=userName%>" required
						placeholder="   请输入学号或工号" pattern="[0-9]\w{9,12}" />
					</td>
				</div>
				<div class="form-group">
					<input type="password" name="password" required
						placeholder="   请输入密码" pattern="\w{6,10}" />
				</div>
				<div class="form-group">
					<input type="text" required placeholder="   验证码"
						name="validateCode" /><img
						src="${pageContext.request.contextPath}/servlet/CodeServlet" onclick="changeCode()" /><a
						href="javascript:changeCode()">看不清换一张</a>
				</div>
				<div class="form-group">
					<div class="remember">
						<input type="checkbox" name="remember" checked>记住密码
					</div>
					<div class="forgetpassword">
						<a href="./WEB-INF/pages/index.jsp">忘记密码？</a>
					</div>
				</div>
				<div class="form-group">
					<input type="submit" value="登录" class="btnsubmit"
						onclick="register();"> <input type="button" value="注册"
						onclick="location.href='register.jsp'" class="btnregister">
				</div>
			</div>

		</div>
	</form>
</body>
</html>
