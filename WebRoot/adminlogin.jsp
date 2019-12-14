<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>My JSP 'adminRegister.jsp' starting page</title>
<meta charset="UTF-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<link rel="stylesheet" href="css/Adminlogin.css">
</head>
<body>
	<div class="login">
		<div class="login-screen">
			<div class="app-title">
				<h1>Login</h1>
			</div>
			<form action="adminServlet?opr=login" method="post">
				<div class="login-form">

					<div class="control-group">
						<input type="text" class="login-field" value="" name="adminacount"
							placeholder="username" id="login-name"> <label
							class="login-field-icon fui-user" for="login-name"></label>
					</div>

					<div class="control-group">
						<input type="password" class="login-field" value=""
							name="password" placeholder="password" id="login-pass"> <label
							class="login-field-icon fui-lock" for="login-pass"></label>
					</div>

					<input type="submit" class="btn btn-primary btn-large btn-block"   value="login"/> <a
						class="login-link">Lost your password?</a>
				</div>
			</form>
		</div>
	</div>
</body>
</html>
