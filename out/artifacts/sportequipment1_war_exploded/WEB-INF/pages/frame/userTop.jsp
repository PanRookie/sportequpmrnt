<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="com.sportequipment.domain.User" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	User user = (User)request.getSession().getAttribute("user");
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>体育器材管理系统</title>
<link rel="stylesheet" href="css/top.css" />
</head>
<script type="text/javascript">
	window.onload = function() {
		showTime(); //网页一加载就调用showTime()函数；
	}

	function checkTime(i) { //补位处理
		if (i < 10) {
			i = "0" + i; //当秒分小于10时，在左边补0；
		}
		return i;
	}
	function showTime() {
		var now = new Date();
		var year = now.getFullYear();
		var month = now.getMonth() + 1; //js获取的月份是从0开始；
		var day = now.getDate();
		var h = now.getHours();
		var m = now.getMinutes();
		var s = now.getSeconds();
		m = checkTime(m);
		s = checkTime(s);

		var weekday = new Array(7);
		weekday[0] = "星期日";
		weekday[1] = "星期一";
		weekday[2] = "星期二";
		weekday[3] = "星期三";
		weekday[4] = "星期四";
		weekday[5] = "星期五";
		weekday[6] = "星期六";
		var w = weekday[now.getDay()]; //js获取的星期是0~6,0是星期天；

		document.getElementById("show").innerHTML = "" + year + " 年 " + month
				+ " 月 " + day + " 日    " + w + "  " + h + ":" + m + ":" + s;

		setTimeout('showTime()', 1000);//
	}
</script>
<body>
	<!--头部-->
	<header class="publicHeader">
	<h1>体育器材管理系统</h1>

	<div class="publicHeaderR">
		<p>
			<span>您好！</span><span style="color: #fff21b"><%=user.getUsername()%></span> 欢迎使用体育器材管理系统！
		</p>
		<a href="Login.aspx" onclick="loginOut()" target="_top">退出</a>
	</div>
	</header>
	<section class="publicTime"> <span class="timeshow"><a
		id="show"></a>
	</span></section>
</body>

</html>