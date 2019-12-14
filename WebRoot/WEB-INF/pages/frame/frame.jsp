<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
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

<title>My JSP 'index.jsp' starting page</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
</head>

<frameset rows="10%,*" cols="*" frameborder="no" border="0"
	framespacing="0">
	<frame src="${pageContext.request.contextPath}/top"  scrolling="No"
		noresize="noresize" title="topFrame" />
	<frameset rows="*" cols="11%,*" frameborder="no" border="0"
		framespacing="0">
		<frame src="${pageContext.request.contextPath}/control" scrolling="No" noresize="noresize" title="leftFrame" />
		<frameset rows="5%,*" cols="*" frameborder="no" border="0"
			framespacing="0">
			<frame src="${pageContext.request.contextPath}/location" scrolling="No" noresize="noresize" name="locationFrame" id="locationFrame" title="locationFrame" />
		    <frame src="${pageContext.request.contextPath}/right" scrolling="No" noresize="noresize" name="rightFrame" id="rightFrame" title="rightFrame" />
		</frameset>
		  
	</frameset>
</frameset>
<noframes>
	<body>
	</body>
</noframes>
</html>
