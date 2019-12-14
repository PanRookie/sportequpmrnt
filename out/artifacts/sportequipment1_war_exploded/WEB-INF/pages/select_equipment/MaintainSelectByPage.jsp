<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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

<title>My JSP 'equipemntSelectByPage.jsp' starting page</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<link rel="stylesheet" href="css/equipemntSelectByPage.css" />
<script type="text/javascript" src="js/jquery-1.8.3.js"></script>
</head>
<body>
	<div class="equipment-seek-input">
		<form action="maintainServlet?opr=equipmentPage" method="post">

			<div class="form-group">
				器材型号：<input type="text" name="equipmentId" value="" />
			</div>
			<div class="form-group">
				器材名称：<input type="text" name="equipmentName" value="" />
			</div>
			<div class="form-group">
				器材类型：<select name="equipmentType">
					<option value="">--请选择--</option>
					<option value="篮球">篮球</option>
					<option value="足球">足球</option>
					<option value="乒乓球">乒乓球</option>
					<option value="网球">网球</option>
					<option value="羽毛球">羽毛球</option>
					<option value="羽毛球拍">羽毛球拍</option>
					<option value="标枪">标枪</option>
				</select>
			</div>
			<div class="form-group">
				操作人员：<input type="text" name="operatPerson" value="" />
			</div>
			<div class="form-group">
				器材规格：<input type="text" name="equipmentSpecification" value="" />
			</div>
			<div class="form-group">

				<button type="submit">搜索</button>
			</div>

		</form>

	</div>

	<div class="equipment-seek-show">
		<div class="ui_tb">
			<table class="table" cellspacing="0" cellpadding="0" width="100%"
				align="center" border="0">


				<!-- 				<tr>
					<td>器材型号</td>
					<td>器材名称</td>
					<td>器材类型</td>
					<td>器材价格</td>
					<td>器材数量</td>
					<td>器材规格</td>
					<td>入库时间</td>
					<td>操作人员</td>
					<td>操作</td>
				</tr> -->
				<tr>
					<th>器材型号</th>
					<th>器材名称</th>
					<th>器材类型</th>
					<th>器材价格</th>
					<th>器材数量</th>
					<th>器材规格</th>
					<th>入库时间</th>
					<th>操作人员</th>
					<th>操作</th>
				</tr>





				<c:forEach var="equipment" items="${requestScope.maintainPage.list}"
					varStatus="status">
					<tr>
						<td>${equipment.equipmentId}</td>
						<td>${equipment.equipmentName}</td>
						<td>${equipment.equipmentType}</td>
						<td>${equipment.equipmentPrice}</td>
						<td>${equipment.equipmentAmount}</td>
						<td>${equipment.equipmentspecification}</td>
						<td>${equipment. putime}</td>
						<td>${equipment.operatPerson}</td>
						<td>
							<button onclick="deletefunction('${equipment.equipmentId}');">删除</button>
							<button onclick="maintainfunction('${equipment.equipmentId}');">正常</button>
							<button onclick="delMsg('${equipment.equipmentId}');">修改</button>
						</td>
					</tr>
				</c:forEach>
			</table>
		</div>


		<div class="page-record--number">
			<div class="record--number">
				共有 <a> ${requestScope.maintainPage.totalCount}</a>
				条记录;&nbsp;&nbsp;&nbsp;&nbsp;当前页/总页数：<a>${requestScope.maintainPage.pageNo}/${requestScope.maintainPage.pageCount}</a>
			</div>
			<div class="page-number">
				<button
					onclick="javascipt:location='maintainServlet?opr=equipmentPage&pageNo=1';">首页</button>

				<c:if test="${requestScope.maintainPage.pageNo>1 }">
					<button
						onclick="javascipt:location='maintainServlet?opr=equipmentPage&pageNo=${requestScope.maintainPage.pageNo-1}';">上一页</button>
				</c:if>


				<c:forEach var="i" begin="1"
					end="${requestScope.maintainPage.pageCount}" varStatus="status">
					<button
						onclick="javascipt:location='maintainServlet?opr=equipmentPage&pageNo=${i}';">${i}</button>
				</c:forEach>


				<c:if
					test="${requestScope.maintainPage.pageNo<requestScope.maintainPage.pageCount }">
					<button
						onclick="javascipt:location='maintainServlet?opr=equipmentPage&pageNo=${requestScope.maintainPage.pageNo+1 }';">下一页</button>
				</c:if>

				<button
					onclick="javascipt:location='maintainServlet?opr=equipmentPage&pageNo=${requestScope.maintainPage.pageCount }';">尾页</button>
			
			</div>
		</div>
	</div>
</body>
</html>
<script type="text/javaScript">
	function deletefunction(equipmentId) {
		if (confirm("是否删除改记录")) {
			location = "maintainServlet?opr=delequipment&equipmentId="
					+ equipmentId;

		}
	}
	function maintainfunction(equipmentId) {
		if (confirm("是否将其列入正常器材?")) {
			location = "maintainServlet?opr=maintainquipment&equipmentId="
					+ equipmentId;

		}
	}
</script>
