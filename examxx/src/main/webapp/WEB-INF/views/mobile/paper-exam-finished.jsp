<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
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
<title>分行考试系统</title>
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
			<h1>分行考试系统</h1>
		</div>
		<div role="main" class="ui-content">
			<div class="form-line add-role">
				<span class="form-label">考试名称：</span> <span>${examName } </span>
			</div>
			<div class="form-line add-role">
				<span class="form-label">开考时间：</span> 
				<span> <fmt:formatDate
						value="${create_time }" type="time" timeStyle="full"
						pattern="yyyy-MM-dd HH:mm" />
				</span>
			</div>
			<div class="form-line add-role">
				<span class="form-label">交卷时间：</span> 
				<span> <fmt:formatDate
						value="${submit_time }" type="time" timeStyle="full"
						pattern="yyyy-MM-dd HH:mm" />
				</span>
			</div>
			<div class="form-line add-role">
				<span class="form-label">总题目：</span> <span class="label label-info">
					${total } </span>
			</div>
			<div class="form-line exam-report-correct">
				<span class="form-label">正确题目：</span> <span
					class="label label-success"> ${right } </span>
			</div>
			<div class="form-line exam-report-error">
				<span class="form-label">错误题目：</span> <span
					class="label label-danger"> ${wrong } </span>
			</div>
			<div class="form-line">
				<span class="form-label">最终得分：</span> <span
					class="label label-danger"> ${pointGet } </span>
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

