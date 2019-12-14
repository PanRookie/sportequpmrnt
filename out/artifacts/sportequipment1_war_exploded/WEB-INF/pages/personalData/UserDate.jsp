<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
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
		response.sendRedirect("login.jsp");
	}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>Detail Admin - My Info</title>

<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<link rel="stylesheet" href="css/personal-info.css" type="text/css"
	media="screen" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script type="text/javascript" src="js/jquery-1.8.3.js"></script>
<script type="text/javascript">
	window.onload = function() {
		$.ajax({
					"url" : "borrowServlet?opr=userauthentication",
					"data" : {
						"loginName" : <%=user.getLoginname()%>,
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
						document.getElementById("phonenumber").innerHTML = data.phonenumber;
						document.getElementById("email").innerHTML = data.email;
						document.getElementById("identityCode").innerHTML = data.identityCode;
						var img = document
								.querySelector(".usershow .form-group img").src = "./images/test.jpg";

					}
				});
	};
</script>

</head>
<body>

	<div class="wide-content">
		<!-- avatar column -->

		<div class="avatar-box">
			<p>更改头像图片</p>
			<div class="personal-image">
				<img src="images/test.jpg" class="avatar img-circle" />

			</div>
			<div class="file">
				<input type="file" />
			</div>
		</div>

		<div class="personal-info">

			<div class="field-box">
				<label>账号：</label> <a id="loginname"></a>
			</div>

			<div class="field-box">
				<label>姓名：</label> <a id="username"></a>
			</div>

			<div class="field-box">
				<label>性别：</label> <a id="sex"></a>
			</div>

			<div class="field-box">
				<label>职位：</label> <a id="position"></a>
			</div>

			<div class="field-box">
				<label>学院：</label> <a id="academy"></a>
			</div>

			<div class="field-box">
				<label>专业：</label> <a id="major"></a>
			</div>

			<div class="field-box">
				<label>电话号码：</label> <a id="phonenumber"></a>
			</div>

			<div class="field-box">
				<label>电子邮箱：</label> <a id="email"></a>
			</div>
			<div class="field-box">
				<label>身份证号码：</label> <a id="identityCode"></a>
			</div>
		</div>

	</div>
</body>
</html>