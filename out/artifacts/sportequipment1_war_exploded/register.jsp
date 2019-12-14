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

<title>My JSP 'register.jsp' starting page</title>
<mata content="text/html;charset=uft-8" http-equiv="Content-Type">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">

<script type="text/javascript" src="js/jquery-1.8.3.js"></script> <script
	type="text/javascript">
	var isregiter = true;
	var success = "${requestScope.success}";
	$(function() {
		$("[name='loginName']").blur(function() {
			$.ajax({
				"url" : "userServlet?opr=isLoginName",
				"data" : {
					"loginName" : $(this).val()
				},
				"dataType" : "text",

				"success" : function(data) {
					if (data == "yes") {
						$("#loginMsg").text("该用户名已注册！");
						isregiter = false;
						accom();
					} else {
						$("#loginMsg").text("");
						isregiter = true;
					}
				}
			});
		});

		$("form").submit(function() {
			if (isregiter == true) {
				return true;
			}
			return false;
		});

		if (success != "") {
			ok();
			alert(success);

			$(".reigster-progress .reigster-progress-ok").mouseover(function() {
				ok();
			});
		}

		

		$(".reigster-progress-accom").css("background-color", "#01B6FF");
		$(".reigster-progress-accom").css("color", "white");

		$(".reigster-progress .reigster-progress-authm").mouseover(function() {
			authm();
		});
		$(".reigster-progress .reigster-progress-accom").mouseover(function() {
			accom();
		});
	});

	function ok() {
		$(".reigsterinput-progress-authm").slideUp();
		$(".reigsterinput-progress-accom").slideUp();
		$(".reigsterinput-progress-ok").slideDown();

		$(".reigster-progress-accom").css("background-color", "#E4ECE5");
		$(".reigster-progress-accom").css("color", "black");

		$(".reigster-progress-authm").css("background-color", "#E4ECE5");
		$(".reigster-progress-authm").css("color", "black");

		$(".reigster-progress-ok").css("background-color", "#01B6FF");
		$(".reigster-progress-ok").css("color", "white");

	}
	function authm() {
		$(".reigsterinput-progress-accom").slideUp();
		$(".reigsterinput-progress-authm").slideDown();
		$(".reigsterinput-progress-ok").slideUp();

		$(".reigster-progress-accom").css("background-color", "#E4ECE5");
		$(".reigster-progress-accom").css("color", "black");

		$(".reigster-progress-authm").css("background-color", "#01B6FF");
		$(".reigster-progress-authm").css("color", "white");

		$(".reigster-progress-ok").css("background-color", "#E4ECE5");
		$(".reigster-progress-ok").css("color", "black");

	}
	function accom() {
		$(".reigsterinput-progress-authm").slideUp();
		$(".reigsterinput-progress-accom").slideDown();
		$(".reigsterinput-progress-ok").slideUp();

		$(".reigster-progress-authm").css("background-color", "#E4ECE5");
		$(".reigster-progress-authm").css("color", "black");
		$(".reigster-progress-accom").css("background-color", "#01B6FF");
		$(".reigster-progress-accom").css("color", "white");
		$(".reigster-progress-ok").css("background-color", "#E4ECE5");
		$(".reigster-progress-ok").css("color", "black");
	}

	function register() {
		/*用户名验证*/
		var logName = document.getElementsByName("loginName")[0];
		if (logName.validity.valueMissing == true) {
			logName.setCustomValidity("用户名不能为空");
		} else if (logName.validity.patternMismatch == true) {
			logName.setCustomValidity("用户名为11位数字");
		} else {
			logName.setCustomValidity("");
		}
		/*密码验证*/
		var pwd = document.getElementsByName("password")[0];
		if (pwd.validity.valueMissing == true) {
			pwd.setCustomValidity("密码不能为空");
		} else if (pwd.validity.patternMismatch == true) {
			pwd.setCustomValidity("密码为6~10位");
		} else {
			pwd.setCustomValidity("");
		}

		var repwd = document.getElementsByName("repassword")[0];
		if (pwd.value != repwd.value) {
			repwd.setCustomValidity("两次密码要一致");
		} else {
			repwd.setCustomValidity("");
		}

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

		var validateCode = document.getElementsByName("code")[0];
		if (validateCode.validity.valueMissing == true) {
			validateCode.setCustomValidity("请输入验证码");
		} else {
			validateCode.setCustomValidity("");

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

	function changeCode() {
		//得到图片元素
		var img = document
				.querySelector(".reigsterinput-progress-accom .form-group:nth-child(7) img");
		//img.setAttribute("src","/day09_00_HttpServletResponse/servlet/demo4");//XML Dom 语法
		img.src = "${pageContext.request.contextPath}/servlet/CodeServlet?time="
				+ new Date().getTime();
	}

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
</script> <!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<link rel="stylesheet" href="css/Reigster.css" />
</head>

<body>
	<form action="userServlet?opr=register" method="post">
		<div class="imagetitle">
			<img alt="logon.jpg" src="./images/ms_login.png" />
		</div>
		<div class="reigster-input">
			<div class="reigster-progress">
				<div class="reigster-progress-accom">
					<a>1.填写基本信息</a>
				</div>
				<div class="reigster-progress-authm">
					<a>2.填写认证资料</a>
				</div>
				<div class="reigster-progress-ok">
					<a>3.注册完成</a>
				</div>
			</div>
			<div class="reigsterinput-progress-accom">
				<div class="form-group">
					用户名<font color="red">*</font><input type="text" name="loginName"
						required placeholder="    输入学号或工号" pattern="[0-9]\w{9,12}" /> <span
						id="loginMsg" style="color:red"></span>
				</div>

				<div class="form-group">
					密码<font color="red">*</font><input type="password" name="password"
						required placeholder="    密码不为空，6-10字符" pattern="\w{6,10}" />
				</div>
				<div class="form-group">
					确认密码<font color="red">*</font><input type="password"
						name="repassword" />
				</div>

				<div class="form-group">
					性别<font color="red">*</font><input type="radio" name="sex" checked
						value="男" />男<input type="radio" name="sex" value="女" />女
				</div>
				<div class="form-group">
					电子邮箱<font color="red">*</font><input type="text" name="email"
						required pattern="\w+@[a-zA-Z0-9]{2,10}(?:\.[a-z]{2,4}){1,3}$" />
				</div>
				<div class="form-group">
					电话号码<font color="red">*</font><input type="text" name="phone"
						required pattern="((0\d{2,3}-\d{7,8})|(1[3584]\d{9}))" />
				</div>

				<div class="form-group">
					验证码<font color="red">*</font><input type="text" name="code" /><img
						src="${pageContext.request.contextPath}/servlet/CodeServlet" onclick="changeCode()" /><a
						href="javascript:changeCode()">看不清换一张</a>
				</div>
			</div>

			<div class="reigsterinput-progress-authm">

				<div class="form-group">
					职位<font color="red">*</font><select name="position" id="positionid">
						<option value="学生">学生</option>
						<option value="老师">老师</option>
					</select>
				</div>



				<div class="form-group">
					姓名<font color="red">*</font><input type="text" name="username"
						required placeholder="    输入真实姓名" pattern="[\u4E00-\u9FA5]{2,10}$" />
				</div>

				<div class="form-group">
					直属学院<font color="red">*</font> <select name="academy"
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
					专业<font color="red">*</font> <select name="major" id="majorid">
						<option value="">请选择专业</option>
					</select>
				</div>
				<div class="form-group">
					身份证号码<font color="red">*</font> <input type="text"
						name="identityCode" required placeholder="    输入证件号码"
						pattern="[1-9]\d{5}(18|19|([23]\d))\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\d{3}[0-9Xx]" />&nbsp;&nbsp;&nbsp;&nbsp;<a
						class="identityCodemsg"></a>
				</div>
				
				<div class="form-group">

					<button class="btnsubmit" onclick="register();">注册</button>
				</div>
			</div>
			<div class="reigsterinput-progress-ok">
				<div class="titleok">
					<img alt="register_success" src="./images/registerok.png">
				</div>
				<button class="btnReturnLogin" onclick="location.href='login.jsp'">返回登录</button>
			</div>
		</div>
	</form>
</body>
</html>