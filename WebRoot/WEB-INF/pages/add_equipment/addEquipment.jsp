<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
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

<title>My JSP 'addEquipment.jsp' starting page</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<script type="text/javascript" src="js/jquery-1.8.3.js"></script>
<script type="text/javascript">
	$(function() {
		showTime(); //网页一加载就调用showTime()函数；

		$(".add").click(function() {
			$(this).prev().val(parseInt($(this).prev().val()) + 1);// $(this).prev() 就是当前元素的前一个元素，即 text_box
		});
		$(".min").click(function() {
			if (parseInt($(this).next().val()) > 0) {
				$(this).next().val(parseInt($(this).next().val()) - 1); // $(this).next() 就是当前元素的下一个元素，即 text_box
			}
		});
	});

	function showTime() {
		var now = new Date();
		var year = now.getFullYear();
		var month = now.getMonth() + 1; //js获取的月份是从0开始；
		var day = now.getDate();
		document.getElementById("show").innerHTML = "" + year + " 年 " + month
				+ " 月 " + day + " 日    ";
	}

	function datacheck() {
		var equipmentid = document.getElementsByName("equipmentId")[0];
		if (equipmentid.validity.valueMissing == true) {
			equipmentid.setCustomValidity("器材型号不能为空");
		} else if (equipmentid.validity.patternMismatch == true) {
			equipmentid.setCustomValidity("器材型号过长");
		} else {
			equipmentid.setCustomValidity("");
		}

		var equipmentname = document.getElementsByName("equipmentName")[0];
		if (equipmentname.validity.valueMissing == true) {
			equipmentname.setCustomValidity("器材名称不能为空");
		} else if (equipmentname.validity.patternMismatch == true) {
			equipmentname.setCustomValidity("器材名称过长");
		} else {
			equipmentname.setCustomValidity("");
		}
		var equipmenprice = document.getElementsByName("equipmenPrice")[0];
		if (equipmenprice.validity.valueMissing == true) {
			equipmenprice.setCustomValidity("价格不能为空");
		} else if (equipmenprice.validity.patternMismatch == true) {
			equipmenprice.setCustomValidity("价格不合理");
		} else {
			equipmenprice.setCustomValidity("");
		}
		var equipmennumber = document.getElementsByName("equipmennumber")[0];
		if (equipmennumber.validity.valueMissing == true) {
			equipmennumber.setCustomValidity("数量不能为空");
		} else if (equipmennumber.value == 0 && equipmennumber.value > 200) {
			equipmennumber.setCustomValidity("数量不合理");
		} else {
			equipmennumber.setCustomValidity("");
		}

	}
	function moreadd(){
	   location="${pageContext.request.contextPath}/addemorequipment";
	}


	var majordata = [
		[ "计时器", "软件工程", "信号旗", "沙坑", "信号旗", "计时台与终点裁判台","铅球", "实心球" ],
		[ "化学", "应用化学", "材料化学 " ],
		[ "体育教育", "社会体育", "社会体育" ],
		[ "会计", "工商企业管理", "物流管理", "旅游管理", "保险学", "市场营销", "电子商务", "国际经济与贸易",
			"证券与期货" ],
		[ "生物科学", "生物技术", "食品科学与工程", "食品营养与检测" ],
		[ "美术学", "书法学", "视觉传达设计", "环境设计", "产品设计", "视觉传播与制作", "广告设计与制作",
			"环境设计", "工业设计", "雕塑" ],
		[ "土木工程", "工程管理", "历史建筑工程保护", "建筑工程技术", "古建筑工程技术" ],
		[ "数学与应用数学", "物理学", "信息与计算科学", "教育技术学" ],
		[ "思想政治教育", "历史学", "法学", "人文教育", "社会工作" ],
		[ "音乐学", "音乐表演", "舞蹈学", "舞蹈表演" ],
		[ "英语", "商务英语", "日语", "翻译", "应用英语" ],
		[ "汉语言文学", "新闻学", "戏剧影视文学", "播音与主持艺术" ],
		[ "教育学", "心理学", "学前教育", "小学教育", "小学教育", "心理咨询" ] ];
	function getMajor() {
		//获得省份下拉框的对象
		var sltacademy = document.getElementById("academyid");
		//获得城市下拉框的对象
		var sltmajor = document.getElementById("majorid");
		//得到对应省份的城市数组
		var academyMajor = majordata[sltacademy.selectedIndex - 1];
		//清空城市下拉框，仅留提示选项
		sltmajor.length = 1;

		//将城市数组中的值填充到城市下拉框中
		for ( var i = 0; i < academyMajor.length; i++) {
			sltmajor[i + 1] = new Option(academyMajor[i], academyMajor[i]);
		}
	}



</script>
<link rel="stylesheet" href="css/addequipment.css" />
</head>

<body>
	<form action="equipmentServlet?opr=add" method="post">
		<div class="addequipment">
			<div class="addequipment-input">
				<div class="form-group">
					器材型号:<input type="text" name="equipmentId" required
						placeholder="器材型号" pattern=".{1,20}" />
				</div>
				<div class="form-group">
					器材名称:<input type="text" name="equipmentName" required
						placeholder="器材名称" pattern=".{1,20}" />
				</div>
				<div class="form-group">
					器材类型:<select name="equipmentType" id="equipmentTypeId">
						<option value="篮球">篮球</option>
						<option value="足球">足球</option>
						<option value="乒乓球">乒乓球</option>
						<option value="网球">网球</option>
						<option value="羽毛球">羽毛球</option>
						<option value="羽毛球拍">羽毛球拍</option>
						<option value="单杆">单杆</option>
						<option value="双杆">双杆</option>
						<option value="标枪">标枪</option>
						<option value="排球">排球</option>
						<option value="跳高杆">跳高杆</option>
						<option value="铅球">铅球</option>
						<option value="网球拍">网球拍</option>
						<option value="杠铃">杠铃</option>
						<option value="软垫">软垫</option>

					<option value="橄榄球">标枪</option>
					</select>
				</div>
				<div class="form-group">
					器材价格:<input type="text" name="equipmenPrice" required
						placeholder="器材价格" pattern="[0-9]+([.]{1}[0-9]+){0,1}" /> 元
				</div>
				<div class="form-group">
					器材数量:<input class="min" name="" type="button" value="-" /> <input
						class="text_number" name="equipmennumber" type="text" value="1"
						required pattern="[1-9]\d*" /> <input class="add" name=""
						type="button" value="+" />
				</div>
				<div class="form-group">
					入库时间:&nbsp;&nbsp;&nbsp;&nbsp;<a id="show"></a>
				</div>
				<div class="form-group">
					操作人员:&nbsp;&nbsp;&nbsp;&nbsp;<%=admin.getAdminName()%></div>
				<div class="form-group">
					器材规格:
					<div class="textarea ">
 					<textarea name="equipmentSpecification" cols="50" rows="3" id="Specification">
			        </textarea> 
					</div>

				</div>
				<div class="form-group">
					<input type="button" value="批量添加" class="btnmoreadd" onclick="moreadd()" target="rightFrame"/>
					<input type="submit" value="添加" class="btnsubmit"
						onclick="datacheck();" />
						
				</div>
			</div>
		</div>
	</form>
</body>
</html>
<!-- &nbsp;&nbsp;&nbsp;-->