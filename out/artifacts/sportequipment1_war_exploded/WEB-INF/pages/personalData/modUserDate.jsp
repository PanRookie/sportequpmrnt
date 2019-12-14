<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.sportequipment.domain.User"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	User user = (User) request.getSession().getAttribute("user");
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
<title>Detail Admin - My Info</title>

<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<link rel="stylesheet" href="css/personal-info.css" type="text/css"
	media="screen" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script type="text/javascript" src="js/jquery-1.8.3.js"></script>
<script type="text/javascript">
	var majordata = [
			[ "计算机科学与技术", "软件工程", "信息工程", "电子信息科学与技术", "通信工程", "电气工程及其自动化电子",
					"信息工程技术", "电气自动化技术" ],
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
	window.onload = function() {
		$
				.ajax({
					"url" : "borrowServlet?opr=userauthentication",
					"data" : {
						"loginName" :<%=user.getLoginname()%>
	},
					"dataType" : "json",
					"contentType" : "application/json;charset=utf-8",
					"success" : function(data) {
						document.getElementById("loginname").innerHTML = data.loginname;
						document.getElementsByName("username")[0].value = data.username;
						document.getElementById("position").innerHTML = data.schoolposition;
						if (data.sex == "男") {
							$('input:radio:first').attr('checked', 'true');
						}
						document.getElementsByName("phone")[0].value = data.phonenumber;
						document.getElementsByName("email")[0].value = data.email;
						document.getElementsByName("identityCode")[0].value = data.identityCode;

						document.getElementById("academy").innerHTML = "   ("
								+ data.dapartment + ")";
						document.getElementById("major").innerHTML = "   ("
								+ data.major + ")";
						var img = document
								.querySelector(".usershow .form-group img").src = "./images/test.jpg";

					}
				});
		 
		 ///sportequipment1/WebRoot/WEB-INF/pages/personalData/modUserDate.jsp
	};
function checkData() {
		/*用户名验证*/
		var email = document.getElementsByName("email")[0];
		if (email.validity.valueMissing == true) {
			email.setCustomValidity("邮箱不能为空");
		} else if (email.validity.patternMismatch == true) {
			email.setCustomValidity("邮箱格式不正确");
		} else {
			email.setCustomValidity("");
		}

		var mobile = document.getElementsByName("phone")[0];
		if (mobile.validity.valueMissing == true) {
			mobile.setCustomValidity("电话号码不能为空");
		} else if (mobile.validity.patternMismatch == true) {
			mobile.setCustomValidity("电话号码格式不正确");
		} else {
			mobile.setCustomValidity("");
		}

		var username = document.getElementsByName("username")[0];
		if (username.validity.valueMissing == true) {
			username.setCustomValidity("姓名不能为空");
		} else if (username.validity.patternMismatch == true) {
			username.setCustomValidity("姓名格式不正确");
		} else {
			username.setCustomValidity("");
		}

		var identityCode = document.getElementsByName("identityCode")[0];
		if (identityCode.validity.valueMissing == true) {
			identityCode.setCustomValidity("证件号码不能为空");
		} else if (identityCode.validity.patternMismatch == true) {
			identityCode.setCustomValidity("证件号码格式不正确");
		} else {
			identityCode.setCustomValidity("");
		}

	}
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

	<div class="wide-content">
		<!-- avatar column -->

		<div class="avatar-box">
			<p>更改头像图片</p>
			<div class="personal-image">
				<img src="images/test.jpg" class="avatar img-circle" />
			</div>
			<div class="file">
				<input type="file" />
			</div>
		</div>

		<div class="personal-info">
			<form action="userServlet?opr=updateUserData" method="post">
				<div class="field-box">
					<label>账号：</label> <a id="loginname"></a>
				</div>

				<div class="field-box">
					<label>姓名：</label> <input type="text" name="username" required
						value="" pattern="[\u4E00-\u9FA5]{2,10}$" />
				</div>

				<div class="field-box">
					<label>性别：</label> <input type="radio" name="sex" checked value="男" />男<input
						type="radio" name="sex" checked value="女" />女
				</div>

				<div class="field-box">
					<label>职位：</label> <a id="position"></a>
				</div>

				<div class="field-box">
					<label>电话号码：</label> <input type="text" name="phone" required
						pattern="((0\d{2,3}-\d{7,8})|(1[3584]\d{9}))" />
				</div>

				<div class="field-box">
					<label>电子邮箱：</label> <input type="text" name="email" required
						pattern="\w+@[a-zA-Z0-9]{2,10}(?:\.[a-z]{2,4}){1,3}$" />
				</div>
				<div class="field-box">
					<label>身份证号码：</label> <input type="text" name="identityCode"
						required
						pattern="[1-9]\d{5}(18|19|([23]\d))\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\d{3}[0-9Xx]" />&nbsp;&nbsp;&nbsp;&nbsp;<a
						class="identityCodemsg"></a>
				</div>
				<div class="field-box">
					<label>学院：</label> <select name="academy" onChange="getMajor()"
						id="academyid">
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
					</select><a id="academy"></a>
				</div>

				<div class="field-box">
					<label>专业：</label> <select name="major" id="majorid">
						<option value="">请选择专业</option>
					</select><a id="major"></a>
				</div>
				<div class="field-box">
					<button class="btnsubmit" onclick="checkData();">注册</button>
				</div>
			</form>
		</div>
	</div>
</body>
</html>