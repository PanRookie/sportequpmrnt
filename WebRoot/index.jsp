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
<script type="text/javascript" src="js/jquery-1.8.3.js"></script>
<script type="text/javascript">
	/* function setcity(province, city) {
		cities = new Object();
		cities[0] = new Array('计算机科学与技术', '软件工程', '信息工程');
		cities[1] = new Array('太原市', '大同市', '朔州市', '阳泉市', '临汾地区', '运城地区');
		var pv, cv;
		var ii;

		pv = province.selectedIndex;
		alert(pv);
		cv = city.value;

		city.length = 1;

		if (pv == '0')
			return;
		if (typeof (cities[pv]) == 'undefined')
			return; 

		for ( var i = 0; i < cities[pv].length; i++) {
			ii = i + 1;
			city.options[ii] = new Option();

			//根据id查找对象， 
			var obj = document.getElementById("citys");
			//添加一个选项 
			obj.options.add(new Option("text",cities[0][i])); //这个兼容IE与firefox 
		}

	} */
	/* 		var myselect = document.getElementById("select");
	 var index = myselect.selectedIndex; */

	var major = [ [ "计算机科学与技术", "软件工程", "信息工程","电子信息科学与技术","通信工程","电气工程及其自动化电子","信息工程技术","电气自动化技术"], 
	              ["化学","应用化学","材料化学 "],
		       	  ["体育教育","社会体育","社会体育"], 
		       	  ["会计","工商企业管理","物流管理","旅游管理","保险学","市场营销","电子商务","国际经济与贸易","证券与期货" ],
			      ["生物科学","生物技术","食品科学与工程","食品营养与检测"],
			      ["美术学","书法学","视觉传达设计","环境设计","产品设计","视觉传播与制作","广告设计与制作","环境设计","工业设计","雕塑"],
			      ["土木工程","工程管理","历史建筑工程保护","建筑工程技术","古建筑工程技术"],
			      ["数学与应用数学","物理学","信息与计算科学","教育技术学"],
			      ["思想政治教育","历史学","法学","人文教育","社会工作"],
			      ["音乐学","音乐表演","舞蹈学","舞蹈表演"],
			      ["英语","商务英语","日语","翻译","应用英语"],
			      ["汉语言文学","新闻学","戏剧影视文学","播音与主持艺术"],
			      ["教育学","心理学","学前教育","小学教育","小学教育","心理咨询"]
			      ];
	function getMajor() {
		//获得省份下拉框的对象
		var sltacademy = document.getElementById("academyid");
		//获得城市下拉框的对象
		var sltmajor = document.getElementById("majorid");
       alert(sltacademy.selectedIndex);
		//得到对应省份的城市数组
		var academyMajor = major[sltacademy.selectedIndex - 1];

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
		<select name="academy" onChange="getMajor()" id="academyid">
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
		 <select name="major" id="majorid">
			<option value="0">请选择专业</option>
		</select>
</body>
</html>
