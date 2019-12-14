<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
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

<title>My JSP 'index.jsp' starting page</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<link rel="stylesheet" href="css/control.css" />
<script type="text/javascript" src="js/jquery-1.8.3.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$(".seek").click(function() {
			$(".seek-borrow").slideToggle();
		});
		$(".set").click(function() {
			$(".seek-set").slideToggle();
		});
	});
		 function loginOut() {
		 if (confirm("是个退出系统")) {
            top.location.href = "login.jsp";
            
	} 
       
     }
</script>
</head>
<body>
	<div class="left">
		<div class="function-show">
			<span></span>----功能列表----<span></span>
		</div>
		<nav>
		<ul class="list">
			<li class="seek"><a>租借管理</a>
			</li>
			<div class="seek-borrow">
				<li><a href="${pageContext.request.contextPath}/myApply" target="rightFrame">我的申请</a>
				</li>

				<li><a href="${pageContext.request.contextPath}/myBorrow" target="rightFrame">我的租借</a>
				</li>
			</div>
			<li><a href="${pageContext.request.contextPath}/userBorrow"
				target="rightFrame">器材查询</a>
			</li>
			<li><a href="${pageContext.request.contextPath}/UserDate" target="rightFrame">个人资料</a>
			</li>
			<li><a class="set">个人设置</a></li>
			<div class="seek-set">
				<li><a href="${pageContext.request.contextPath}/modUserDate" target="rightFrame">修改资料</a>
				</li>
				<li><a href="${pageContext.request.contextPath}/myBorrow" target="rightFrame">我的收藏</a>
				</li>
				<li><a href="${pageContext.request.contextPath}/myBorrow" target="rightFrame">设置密保</a>
				</li>
			</div>
			</li>
			<li><a onclick="loginOut()">退出系统</a>
			</li>
		</ul>
		</nav>
	</div>
</body>
</html>
