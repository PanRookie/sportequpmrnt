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
<link rel="stylesheet" href="css/userSelect.css" />
<script type="text/javascript" src="js/jquery-1.8.3.js"></script>
 <script type="text/javascript">
 var majordata = [
			[ "计算机科学与技术", "软件工程", "信息工程", "电子信息科学与技术", "通信工程", "电气工程及其自动化电子","信息工程技术", "电气自动化技术" ],
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
</head>
<body>
	<div class="user-seek-input">
		<form action="userServlet?opr=userPage" method="post">

			<div class="form-group">
				登录名：<input type="text" name="loginName" value="" />
			</div>
			
			<div class="form-group">
				姓名：<input type="text" name="userName" value="" />
			</div>
			
			<div class="form-group">
			  性别：<select name="sex" id="sex">
						<option value="男">男</option>
						<option value="女">女</option>
					</select>
			</div>
			
              <div class="form-group">
					职位：<select name="position" id="positionid">
						<option value="学生">学生</option>
						<option value="老师">老师</option>
					</select>
				</div>
				
			<div class="form-group">
					直属学院：<select name="academy"
						onChange="getMajor()" id="academyid">
						<option value="">请选择学院</option>
						<option value="电子信息工程学院">电子信息工程学院</option>
						<option value="化学与材料科学学院">化学与材料科学学院</option>
						<option value="体育学院">体育学院</option>
						<option value="经济学院与管理学院">经济学院与管理学院</option>
						<option value="生物与科学学院">生物与科学学院</option>
						<option value="美术学院">美术学院</option>
						<option value="建筑工程学院">建筑工程学院</option>
						<option value="理学院">理学院</option>
						<option value="社会发展学院">社会发展学院</option>
						<option value="音乐学院">音乐学院</option>
						<option value="外国语学院">外国语学院</option>
						<option value="文学院">文学院</option>
						<option value="教育学院">教育学院</option>
					</select>
				</div>
				
				<div class="form-group">
					专业：<select name="major" id="majorid">
						<option value="">请选择专业</option>
					      </select>
				</div>
				
			   <div class="form-group">
					电子邮箱：<input type="text" name="email" />
				</div>
				<div class="form-group">
					电话号码：<input type="text" name="phone"/>
				</div>
				
				 <div class="form-group">
					身份证号码：<input type="text" name="identityCode"/>
				</div>
				
			<div class="form-group">
				<button type="submit">搜索</button>
			</div>
			
		</form>

	</div>

	<div class="user-seek-show">
		<div class="ui_tb">
			<table class="table" cellspacing="0" cellpadding="0" width="100%"
				align="center" border="0">

				<tr>
				<th width="30"><input type="checkbox" id="all" onclick="selectOrClearAllCheckbox(this);" />
							</th>
				
					<th>登录名</th>
					<th>姓名</th>
					<th>性别</th>
					<th>职位</th>
					<th>学院</th>
					<th>专业</th>
					<th>电话号码</th>
					<th>电子邮箱</th>
					<th>身份证</th>
					<th>操作</th>
				</tr>
				
				<c:forEach var="user"
					items="${requestScope.userPage.list}" varStatus="status">
					<tr>
					    <td><input type="checkbox" name="IDCheck" class="acb" /></td>
						<td>${user.loginname}</td>
						<td>${user.username}</td>
						<td>${user.sex}</td>
						<td>${user.schoolposition}</td>
						<td>${user.dapartment}</td>
						<td>${user.major}</td>
						<td>${user.phonenumber}</td>
						<td>${user.email}</td>
						<td>${user.identityCode}</td>
						<td>
							<button
								onclick="deletefunction('${equipment.equipmentId}','${equipment.equipmentAmount}');">删除</button>
							<button onclick="maintainfunction('${equipment.equipmentId}','${equipment.equipmentAmount}');">维修</button>
							<button onclick="delMsg('${equipment.equipmentId}');">修改</button>
							<%-- <button onclick="javascript:location='bookServlet?opr=getBook&bid=${book.bId}'">修改</button>--%>
						</td>
					</tr>
				</c:forEach>
			</table>
		</div>

		<div class="page-record--number">
			<div class="record--number">
				共有 <a> ${requestScope.userPage.totalCount}</a>
				条记录;&nbsp;&nbsp;&nbsp;&nbsp;当前页/总页数：<a>${requestScope.userPage.pageNo}/${requestScope.userPage.pageCount}</a>
			</div>
			<div class="page-number">
				<button
					onclick="javascipt:location='userServlet?opr=userPage&pageNo=1';">首页</button>
				

				<c:if test="${requestScope.userPage.pageNo>1 }">
					
					<button
						onclick="javascipt:location='userServlet?opr=userPage&pageNo=${requestScope.userPage.pageNo-1}';">&#8249;</button>
				</c:if>


				<c:forEach var="i" begin="1"
					end="${requestScope.userPage.pageCount}" varStatus="status">
					<button
						onclick="javascipt:location='userServlet?opr=userPage&pageNo=${i}';">${i}</button>
					
				</c:forEach>


				<c:if
					test="${requestScope.userPage.pageNo<requestScope.userPage.pageCount }">
					<button
						onclick="javascipt:location='userServlet?opr=userPage&pageNo=${requestScope.userPage.pageNo+1 }';">&#8250;</button>
					
				</c:if>

				<button
					onclick="javascipt:location='userServlet?opr=userPage&pageNo=${requestScope.userPage.pageCount }';">尾页</button>
				
			</div>
		</div> 
	</div>
</body>
</html>
<script type="text/javaScript">
	function deletefunction(equipmentId, equipmentAmount) {
		var num = prompt("请输入删除数量:");
		var type = "^[0-9]*[1-9][0-9]*$";
		var r = new RegExp(type);
		var flag = r.test(num);
		if (flag) {
			if (parseInt(num) <= equipmentAmount) {
				if (confirm("是否删除改器材")) {
					location = "equipmentServlet?opr=delequipment&equipmentId="
							+ equipmentId + "&equipmentAmount=" + num;

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

	function maintainfunction(equipmentId,equipmentAmount) {

		var num = prompt("请输入维修数量:");
		var type = "^[0-9]*[1-9][0-9]*$";
		var r = new RegExp(type);
		var flag = r.test(num);
		if (flag) {
			if (parseInt(num) <= equipmentAmount) {
				if (confirm("是否将其列入维修器材?")) {
					location = "equipmentServlet?opr=maintainquipment&equipmentId="
							+ equipmentId+"&equipmentAmount="+num;
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
</script>
