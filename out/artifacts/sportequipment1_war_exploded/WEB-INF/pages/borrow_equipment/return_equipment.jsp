<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.sportequipment.domain.Admin"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	Admin admin = (Admin) request.getSession().getAttribute("admin");
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

<title>My JSP 'equipemntSelectByPage.jsp' starting page</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<link rel="stylesheet" href="css/returnequip.css" />
<script type="text/javascript" src="js/jquery-1.8.3.js"></script>
<script type="text/javascript" src="js/My97DatePicker/calendar.js"></script>
<script type="text/javascript" src="js/My97DatePicker/WdatePicker.js"></script>
</head>
</head>
<body>
	<div class="equipment-seek-input">

		<form action="borrowServlet?opr=borrowPage" method="post">

			<div class="form-group">
				租借用户名：<input type="text" name="loginName" value="" />
			</div>
			<div class="form-group">
				器材型号：<input type="text" name="equipmentId" value="" />
			</div>
			<div class="form-group">
				借出日期： <input type="text"
					onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"
					class="input-text Wdate" style="width:130px;" name="startDate">
				- <input type="text"
					onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"
					class="input-text Wdate" style="width:130px;" name="endDate">
			</div>
			<div class="form-group">
				<button type="submit">搜索</button>
			</div>
		</form>

	</div>

	<div class="borrow-seek-show">
		<div class="ui_tb">
			<table class="table" cellspacing="0" cellpadding="0" width="100%"
				onclick="doclick()" align="center" border="0">
				<tr>
					<th>租借用户名</th>
					<th>器材型号</th>
					<th>借出时间</th>
					<th>使用时间</th>
					<th>器材数量</th>
					<th>操作</th>
				</tr>

				<c:forEach var="borrow" items="${requestScope.borrowPage.list}"
					varStatus="status">
					<tr>
						<td>${borrow.loginName}</td>
						<td>${borrow.equipmentId}</td>
						<td>${borrow.lendDate}</td>
						<td>${borrow.willDate}</td>
						<td>${borrow.equipmentcount}</td>
						<td>
							<button
								onclick="returnfunction('${borrow.loginName}','${borrow.equipmentId}','${borrow.equipmentcount}','<%=admin.getAdminName()%>');">归还</button>
							<button
								onclick="deletefunction('${borrow.loginName}','${borrow.equipmentId}','${borrow.equipmentcount}');">删除</button>
							<%-- <button
								onclick="selectshow()('${borrow.loginName}','${borrow.equipmentId}','${borrow.equipmentcount}','${borrow.lendDate}');">修改</button> --%>
						</td>
					</tr>
				</c:forEach>
			</table>
		</div>


		<div class="page-record--number">
			<div class="record--number">
				共有 <a> ${requestScope.borrowPage.totalCount}</a>
				条记录;&nbsp;&nbsp;&nbsp;&nbsp;当前页/总页数：<a>${requestScope.borrowPage.pageNo}/${requestScope.borrowPage.pageCount}</a>
			</div>
			<div class="page-number">

				<button
					onclick="javascipt:location='borrowServlet?opr=borrowPage&pageNo=1';">首页</button>


				<c:if test="${requestScope.borrowPage.pageNo>1 }">

					<button
						onclick="javascipt:location='borrowServlet?opr=borrowPage&pageNo=${requestScope.borrowPage.pageNo-1}';">&#8249;</button>
				</c:if>


				<c:forEach var="i" begin="1"
					end="${requestScope.borrowPage.pageCount}" varStatus="status">
					<button
						onclick="javascipt:location='borrowServlet?opr=borrowPage&pageNo=${i}';">${i}</button>

				</c:forEach>


				<c:if
					test="${requestScope.borrowPage.pageNo<requestScope.borrowPage.pageCount }">
					<button
						onclick="javascipt:location='borrowServlet?opr=borrowPage&pageNo=${requestScope.borrowPage.pageNo+1 }';">&#8250;</button>

				</c:if>

				<button
					onclick="javascipt:location='borrowServlet?opr=borrowPage&pageNo=${requestScope.borrowPage.pageCount }';">尾页</button>

			</div>
		</div>
	</div>
	<!-- <div class="selectshow">
		<div class="cancel" onclick="selectconceal()"><img alt="" src="./images/schu.png"></div>
		<div class="form-group"><h2>修改数据</h2></div>
		<div class="form-group"></div>
		<div class="form-group"></div>
	</div> -->

	<div class="equipmentshow" onclick="equipmentconceal()">
		<div class="form-group">
			器材名称：<a id="equipmentname"></a>
		</div>

		<div class="form-group">
			器材类型：<a id="Typeid"></a>
		</div>

		<div class="form-group">
			剩余数量：<a id="Acountid"></a>
		</div>

		<div class="form-group">
			器材规格：<a id="specificationid"></a>
		</div>
	</div>
	<div class="usershow" onclick="userconceal()">
		<div class="form-group">
			<img alt="user.jpg" src="">
		</div>
		<div class="form-group">
			学号：<a id="loginname"></a>
		</div>
		<div class="form-group">
			姓名：<a id="username"></a>
		</div>
		<div class="form-group">
			性别：<a id="sex"></a>
		</div>
		<div class="form-group">
			学院：<a id="academy"></a>
		</div>
		<div class="form-group">
			专业：<a id="major"></a>
		</div>
		<div class="form-group">
			职位：<a id="position"></a>
		</div>
	</div>
</body>
</html>
<script type="text/javaScript">
	var returnErr = "${requestScope.returnErr}";
	var deleteErr = "${requestScope.deleteErr}";
	$(function() {

		if (returnErr != "") {
			alert(returnErr);
		}
		if (deleteErr != "") {
			alert(deleteErr);
		}
		/* 	$(".reigsterinput-progress-authm").slideUp();
		 $(".reigsterinput-progress-accom").slideUp(); */

	});
	function selectshow() {
		$(".usershow").slideUp();
		$(".equipmentshow").slideUp();
		$(".selectshow").slideDown();
	}
	function equipmentshow() {
		$(".usershow").slideUp();
		$(".equipmentshow").slideDown();
		$(".selectshow").slideUp();
	}
	function usershow() {
		$(".usershow").slideDown();
		$(".equipmentshow").slideUp();
		$(".selectshow").slideUp();
	}

	function selectconceal() {
		$(".selectshow").slideUp();
	}
	function equipmentconceal() {
		$(".equipmentshow").slideUp();
	}
	function userconceal() {
		$(".usershow").slideUp();
	}
	function returnfunction(loginName, equipmentId, equipmentcount,
			operatperson) {
		var num = prompt("请输入归还数量:");
		var type = "^[0-9]*[1-9][0-9]*$";
		var r = new RegExp(type);
		var flag = r.test(num);
		if (flag) {
			if (parseInt(num) <= equipmentcount) {

				if (confirm("是否将器材归还")) {
					location = "borrowServlet?opr=returnequip&loginName="
							+ loginName + "&equipmentId=" + equipmentId
							+ "&equipmentcount=" + num + "&operatperson="
							+ operatperson;
				} else {
					return;
				}

			} else {
				alert("请输入正确数量");
			}
		} else {
			alert("请输入的正整数,不能为空");
		}

	}
	function deletefunction(loginName, equipmentId, equipmentcount) {
		var num = prompt("请输入删除数量:");
		var type = "^[0-9]*[1-9][0-9]*$";
		var r = new RegExp(type);
		var flag = r.test(num);
		if (flag) {
			if (parseInt(num) <= equipmentcount) {

				if (confirm("是否删除借出记录?")) {
					location = "borrowServlet?opr=deleteborrow&loginName="
							+ loginName + "&equipmentId=" + equipmentId
							+ "&equipmentcount=" + num;
				} else {
					return;
				}

			} else {
				alert("请输入正确数量");
			}
		} else {
			alert("请输入的正整数,不能为空");
		}
	}
/* 	function updatefunction(loginName, equipmentId, equipmentcount, lendDate) {
		if (confirm("是否修该记录?")) {
			selectshow();
		}
	} */

	function doclick() {
		var td = event.srcElement; // 通过event.srcElement 获取激活事件的对象 td
		if (td.cellIndex == 0 && td.parentElement.rowIndex >= 1) {
			usershow();
			//alert("列号：" + td.cellIndex + "行号："+ ( + 1) + "，内容：" + td.innerText);
			$
					.ajax({
						"url" : "borrowServlet?opr=userauthentication",
						"data" : {
							"loginName" : td.innerText
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
							var img = document
									.querySelector(".usershow .form-group img").src = "./images/test.jpg";

						}
					});
		} else if (td.cellIndex == 1 && td.parentElement.rowIndex >= 1) {

			equipmentshow();
			$
					.ajax({
						"url" : "borrowServlet?opr=equipmentaut",
						"data" : {
							"equipmentId" : td.innerText
						},
						"dataType" : "json",
						"contentType" : "application/json;charset=utf-8",
						"success" : function(data) {
							document.getElementById("equipmentname").innerHTML = data.equipmentname;
							document.getElementById("Typeid").innerHTML = data.equipmentType;
							document.getElementById("Acountid").innerHTML = data.equipmentAmount;
							document.getElementById("specificationid").innerHTML = data.equipmentspecification;
						}
					});
		}
	}
</script>
