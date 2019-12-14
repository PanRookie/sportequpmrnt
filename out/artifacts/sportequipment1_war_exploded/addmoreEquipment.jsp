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

<title>My JSP 'addmoreEquipment.jsp' starting page</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<link rel="stylesheet" href="css/moreadd.css" />
</head>

<body>
	<div class="addequipment">
		<table border="1">
			<tr>
			    <th>序号</th>
				<th>器材型号</th>
				<th>器材名称</th>
				<th>器材类型</th>
				<th>器材价格</th>
				<th>器材数量</th>
				<th>入库时间</th>
				<th>操作人员</th>
				<th>器材规格</th>
			</tr>
			<tr>
		       	<td>1</td>
				<td><input type="text" name="equipmentId" required pattern=".{1,20}" /></td>
				<td><input type="text" name="equipmentName" required pattern=".{1,20}" /></td>
				<td><select name="equipmentType" id="equipmentTypeId">
						<option value="篮球">篮球</option>
						<option value="足球">足球</option>
						<option value="乒乓球">乒乓球</option>
						<option value="网球">网球</option>
						<option value="羽毛球">羽毛球</option>
						<option value="羽毛球拍">羽毛球拍</option>
						<option value="网球">网球</option>
						<option value="标枪">标枪</option>
					</select></td>
				<td><input type="text" name="equipmenPrice" required pattern="[0-9]+([.]{1}[0-9]+){0,1}" /></td>
				
				<td><input class="min" name="" type="button" value="-" /> 
				  <input class="text_number" name="equipmennumber" type="text" value="1" required pattern="[1-9]\d*" /> 
				  <input class="add" name="" type="button" value="+" /></td>
				<td>2019-11-1</td>
				<td>panxiaozheng</td>

				<td><input type="text" name="equipmentSpecification" /></td>
			</tr>
			<tr>
			    <td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>
		</table>
	</div>
</body>
</html>
