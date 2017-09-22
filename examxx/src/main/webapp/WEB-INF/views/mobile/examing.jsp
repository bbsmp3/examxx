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
<link rel="shortcut icon" href="resources/jqm/favicon.ico">
<script src="resources/jqm/js/jquery.js"></script>
<script src="resources/jqm/_assets/js/index.js"></script>
<script type="text/javascript" src="resources/js/all.js?v=0712"></script>
<script type="text/javascript" src="resources/js/mobile-paper-examing.js"></script>
<script src="resources/jqm/js/jquery.mobile-1.4.5.min.js"></script>
</head>

<body>

	<div data-role="page">

		<div data-role="header">
			<h1>企金考试系统</h1>
		</div>
		<input type="hidden" id="hist-id" value="${examHistoryId }"> 
		<input type="hidden" id="paper-id" value="${examPaperId }">
		<div id="exampaper-body" data-role="collapsibleset" data-theme="a">
			${htmlStr }</div>
		<a href="#popupDialog" data-rel="popup" id="a-popup"
			data-position-to="window" data-transition="pop"
			class="ui-btn ui-corner-all ui-shadow  ui-icon-check ui-btn-icon-left ui-btn-a">我要交卷</a>

		<div data-role="popup" id="popupDialog" data-overlay-theme="a"
			data-theme="a" data-dismissible="false" style="max-width: 400px;">
			<div data-role="header" data-theme="a">
				<h1>确认提交？</h1>
			</div>
			<div role="main" class="ui-content">
				<h3 class="ui-title">是否结束考试？确认提交后将无法再次答题</h3>
				<a href="#" id="a-submit"
					class="ui-btn ui-corner-all ui-shadow ui-btn-inline ui-btn-b"
					data-transition="flow">确认</a> <a href="#"
					class="ui-btn ui-corner-all ui-shadow ui-btn-inline ui-btn-b"
					data-rel="back">取消</a>

			</div>
		</div>
		<div data-role="footer">
			<h5>分行科技部 Copyright ©</h5>
		</div>
		<!-- /footer -->

	</div>
	<!-- /page -->
	

</body>
</html>

