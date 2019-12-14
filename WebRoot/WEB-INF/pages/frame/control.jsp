<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
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

<title>My JSP 'index.jsp' starting page</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<link rel="stylesheet" href="css/basestyle.css" />
<link rel="stylesheet" href="css/control.css" />
<script type="text/javascript" src="js/jquery-1.8.3.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$(".seek").click(function() {
			$(".seek-equipment").slideToggle();
		});
	});
</script>
</head>
<body>
	<div class="left">
		<div class="function-show">
			<span></span>----功能列表----<span></span>
		</div>
		<nav>
		<ul class="list">

			<li><a href="${pageContext.request.contextPath}/addequipment"
				target="rightFrame">添加器材</a>
			</li>
			<li><a href="${pageContext.request.contextPath}/borrowequipment"
				target="rightFrame">器材借出</a>
			</li>
			<li><a href="${pageContext.request.contextPath}/allApply"
				target="rightFrame">借出审核</a>
			</li>
			<li><a href="${pageContext.request.contextPath}/returnequipment"
				target="rightFrame">器材归还</a>
			</li>
			<li class="seek"><a>器材查询</a>
			</li>
			<div class="seek-equipment">
				<li><a
					href="${pageContext.request.contextPath}/equipmentSelectByPage"
					target="rightFrame">正常器材</a>
				</li>
				
				<li><a
					href="${pageContext.request.contextPath}/maintainSelectByPage"
					target="rightFrame">维修器材</a>
				</li>
				
				<li><a href="Revert.aspx" target="right">借还记录</a>
				</li>
				
			</div>
		
			
			<li><a
				href="${pageContext.request.contextPath}/equipnumberofuser"
				target="rightFrame">数据分析</a>
			</li>
			
			<li><a
				href="${pageContext.request.contextPath}/userSelectByPage"
				target="rightFrame">用户管理</a>
			</li>
			
			<li><a href="AdminSet.aspx" target="right">个人设置</a></li>
			
			<li><a href="UploadNote.aspx" target="right">通知发布</a></li>
			
			<li><a href="UserFeedback.aspx" target="right">用户反馈</a>
			</li>
			
			<li><a href="Login.aspx">退出系统</a>
			</li>
		</ul>
		</nav>
	</div>
</body>
</html>
