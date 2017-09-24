<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme() + "://"
+ request.getServerName() + ":" + request.getServerPort()
+ path + "/";
%>
<!DOCTYPE html>
<html>

<head>
<base href="<%=basePath%>">
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>企金考试系统</title>
<link rel="stylesheet" href="resources/jqm/css/themes/default/jquery.mobile-1.4.5.min.css">
<link rel="stylesheet" href="resources/jqm/_assets/css/jqm-demos.css">
<link rel="stylesheet" href="resources/jqm/css/themes/theme-classic.css">
<link rel="shortcut icon" href="resources/jqm/favicon.ico">

<script src="resources/jqm/js/jquery.js"></script>
<script src="resources/jqm/_assets/js/index.js"></script>
<script type="text/javascript" src="resources/js/all.js?v=0712"></script>
<script type="text/javascript" src="resources/js/mobile-paper-examing.js"></script>
<script src="resources/jqm/js/jquery.mobile-1.4.5.min.js"></script>
</head>

<body>

	<div data-role="page" class="ui-page-theme-b">

		<div data-role="header" >
			<a href="#" class="ui-btn ui-btn-left ui-icon-user ui-btn-icon-left">${truename}</a> 
			<a href="j_spring_security_logout" class="ui-btn ui-btn-right ui-icon-action ui-btn-icon-right">退出</a> 
			<h1>企金考试系统</h1>
		</div>
		<input type="hidden" id="hist-id" value="${examHistoryId }"> 
		<input type="hidden" id="paper-id" value="${examPaperId }">
		<div id="exampaper-body" data-role="collapsibleset" data-theme="c">
			${htmlStr }</div>
		<a href="#popupDialog" data-rel="popup" id="a-popup"
			data-position-to="window" data-transition="pop"
			class="ui-btn ui-corner-all ui-shadow  ui-icon-check ui-btn-icon-left ui-btn-b">我要交卷</a>

		<div data-role="popup" id="popupDialog" data-overlay-theme="a"
			data-theme="b" data-dismissible="false" style="max-width: 400px;">
			<div data-role="header" data-theme="b">
				<h1>确认提交？</h1>
			</div>
			<div role="main" class="ui-content">
				<h3 class="ui-title">是否结束考试？确认提交后将无法再次答题</h3>
				<a href="#" id="a-submit"
					class="ui-btn ui-corner-all ui-shadow ui-btn-inline"
					data-transition="flow">确认</a>
				<a href="#"
					class="ui-btn ui-corner-all ui-shadow ui-btn-inline"
					data-rel="back">取消</a>

			</div>
		</div>
		<div data-role="footer" data-position="fixed">
			<div data-role="navbar">
			<span id="exam-timestamp" style="display:none;">${secondsLeft }</span>
					<ul>
						<li><a href="#" id="exam-clock" style="color:yellow;">&nbsp;</a></li>
						<li><a href="#">分行科技部 Copyright ©</a></li>
					</ul>
				</div><!-- /navbar -->
			
		</div>
		<!-- /footer -->

	</div>
	<!-- /page -->
	

</body>
</html>

