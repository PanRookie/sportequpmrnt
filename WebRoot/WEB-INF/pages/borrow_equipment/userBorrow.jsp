<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.sportequipment.domain.User"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	User user = (User) request.getSession().getAttribute("user");
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
<style type="text/css">
.applyshow {
	width: 350px;
	height: 380px;
	position: absolute;
	top: 2%;
	left: 40%;
	border-radius: 8px;
	border: 1px solid #D0DDE9;
	display: none;
	background-color: white;
}

.applyshow .form-group {
	width: 270px;
	height: 30px;
	margin-top: 20px;
	font-size: 12px;
	margin-left: 50px;
}

.applyshow .form-group a {
	color: #5DBA0D;
	font-size: 13px;
}

.applyshow .form-group button {
	margin-left: 60px;
}
</style>
</head>
<body>
	<div class="equipment-seek-input">
		<form action="userServlet?opr=equipmentPage" method="post">

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





				<c:forEach var="equipment"
					items="${requestScope.equipmentPage.list}" varStatus="status">
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
							<button
								onclick="applyfunction('${equipment.equipmentId}','${equipment.equipmentAmount}','${equipment.equipmentName}');">申请租借</button>
							<button onclick="collectfunction('${equipment.equipmentId}');">收藏</button>
						</td>
					</tr>
				</c:forEach>
			</table>
		</div>


		<div class="page-record--number">
			<div class="record--number">
				共有 <a> ${requestScope.equipmentPage.totalCount}</a>
				条记录;&nbsp;&nbsp;&nbsp;&nbsp;当前页/总页数：<a>${requestScope.equipmentPage.pageNo}/${requestScope.equipmentPage.pageCount}</a>
			</div>
			<div class="page-number">
				<button
					onclick="javascipt:location='userServlet?opr=equipmentPage&pageNo=1';">首页</button>
				<%-- &${requestScope.params} --%>

				<c:if test="${requestScope.equipmentPage.pageNo>1 }">
					<%-- &${requestScope.params} --%>
					<button
						onclick="javascipt:location='userServlet?opr=equipmentPage&pageNo=${requestScope.equipmentPage.pageNo-1}';">&#8249;</button>
				</c:if>


				<c:forEach var="i" begin="1"
					end="${requestScope.equipmentPage.pageCount}" varStatus="status">
					<button
						onclick="javascipt:location='userServlet?opr=equipmentPage&pageNo=${i}';">${i}</button>
					<%-- &${requestScope.params} --%>
				</c:forEach>


				<c:if
					test="${requestScope.equipmentPage.pageNo<requestScope.equipmentPage.pageCount }">
					<button
						onclick="javascipt:location='userServlet?opr=equipmentPage&pageNo=${requestScope.equipmentPage.pageNo+1 }';">&#8250;</button>
					<%-- &${requestScope.params --%>
				</c:if>

				<button
					onclick="javascipt:location='userServlet?opr=equipmentPage&pageNo=${requestScope.equipmentPage.pageCount }';">尾页</button>
				<%--  &${requestScope.params} --%>
			</div>
		</div>
	</div>
	<div class="applyshow">
		<form id="form1" action="" method="post">
			<div class="form-group">
				<h2>申请表</h2>
			</div>

			<div class="form-group">
				申请人:&nbsp;&nbsp;&nbsp;&nbsp;<a><%=user.getUsername()%></a>
			</div>

			<div class="form-group">
				器材型号：<a id="equipmentId"></a>
			</div>
			<div class="form-group">
				器材名称：<a id="equipmentName"></a>
			</div>

			<div class="form-group">
				申请数量：<input class="text_number" name="equipmennumber" type="text"
					required />
			</div>
			<div class="form-group">
				申请备注：<input name="applyRemark" type="text" />
			</div>
			<div class="form-group">
				<button type="button" onclick="applyShow()">取消</button>
				<button type="submit" onclick="applysubmit();">申请</button>
			</div>
		</form>
	</div>

</body>
</html>
<script type="text/javaScript">
	var equipmentid = "";
	$("#form1").submit(
			function() {
				var equipmennumber = document
						.getElementsByName("equipmennumber")[0];

				var applyRemark = document.getElementsByName("applyRemark")[0];
				var equipmennumber = document
						.getElementsByName("equipmennumber")[0];

				location = "userServlet?opr=userBorrow&equipmentId="
						+ equipmentid + "&equipmennumber="
						+ equipmennumber.value;
				+"&applyRemark=" + applyRemark.value;
				return false;
			});

	function applyShow() {
		$(".applyshow").slideUp();
	}
	var num = 0;
	function applysubmit() {
		var equipmennumber = document.getElementsByName("equipmennumber")[0];
		var type = "^[0-9]*[1-9][0-9]*$";
		var r = new RegExp(type);
		var flag = r.test(equipmennumber.value);
		var equipmennumber = document.getElementsByName("equipmennumber")[0];
		if (equipmennumber.validity.valueMissing == true) {
			equipmennumber.setCustomValidity("数量不能为空");
		} else if (!flag || parseInt(equipmennumber.value) > parseInt(num)
				|| parseInt(equipmennumber.value) > 3) {
			equipmennumber.setCustomValidity("数量不合理");
		} else {
			equipmennumber.setCustomValidity("");
		}
	}
	function applyfunction(equipmentId, equipmentAmount, equipmentName) {
		$(".applyshow").slideDown();
		document.getElementById("equipmentId").innerHTML = equipmentId;
		document.getElementById("equipmentName").innerHTML = equipmentName;
		num = equipmentAmount;
		equipmentid = equipmentId
	}

	function collectfunction(equipmentId) {

		if (confirm("是否收藏该器材")) {
			location = "userServlet?opr=collectEquip&equipmentId="
					+ equipmentId;
		}

	}
</script>
