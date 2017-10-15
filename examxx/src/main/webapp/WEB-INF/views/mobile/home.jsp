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
<script type="text/javascript">
		$(document).bind("mobileinit", function () {
		    $.mobile.ajaxEnabled = false;
		});
		
		$(document).on("pagecreate",function(){
			if($("#input-msg").val() == "error") {
				$("#button-message").trigger("click");
			}
		});
	</script>
<script src="resources/jqm/js/jquery.mobile-1.4.5.min.js"></script>
</head>

<body>

	<div data-role="page" class="ui-page-theme-b">

		<div data-role="header" >
			<a href="#" class="ui-btn ui-btn-left ui-icon-user ui-btn-icon-left">${truename}</a> 
			<a href="j_spring_security_logout" class="ui-btn ui-btn-right ui-icon-action ui-btn-icon-right">退出</a> 
			<h1>企金考试系统</h1>
		</div>
<%-- 		<c:if test="${message.result == 'error' }"> --%>
<%-- 			<div><span style="color:red;text-align:center;">${message.messageInfo }</span></div> --%>
<%-- 		</c:if> --%>
		<div data-role="controlgroup">
			<input type="hidden" id="input-msg" value="${message.result}"> 
			<a href="#popupDialogM" data-rel="popup" id="button-message"
					data-position-to="window" data-transition="pop" style="display:none;"
					class="ui-btn ui-corner-all ui-shadow  ui-icon-forward ui-btn-icon-left ui-btn-c"></a>
			<div data-role="popup" id="popupDialogM"
					data-overlay-theme="a" data-theme="b" data-dismissible="false"
					style="max-width: 400px;">
					<div data-role="header" data-theme="b">
						<h1>错误</h1>
					</div>
					<div role="main" class="ui-content" data-theme="b">
						<h3 class="ui-title">${message.messageInfo }</h3>
						<a href="#"
							class="ui-btn ui-corner-all ui-shadow ui-btn-inline ui-btn-b"
							data-rel="back">好的</a>

					</div>
				</div>
			<c:forEach items="${paper }" var="item">
				<a href="#popupDialog${item.id}" data-rel="popup"
					data-position-to="window" data-transition="pop"
					class="ui-btn ui-corner-all ui-shadow  ui-icon-forward ui-btn-icon-left ui-btn-c">${item.name }</a>

				<div data-role="popup" id="popupDialog${item.id}"
					data-overlay-theme="a" data-theme="b" data-dismissible="false"
					style="max-width: 400px;">
					<div data-role="header" data-theme="b">
						<h1>是否进入考试?</h1>
					</div>
					<div role="main" class="ui-content" data-theme="b">
						<h3 class="ui-title">是否进入考试 ${item.name}?
							持续时间${item.duration}分钟</h3>
						<a href="mobile/examing/${item.id}"
							class="ui-btn ui-corner-all ui-shadow ui-btn-inline ui-btn-b"
							 data-transition="flow">确认</a> 
						<a href="#"
							class="ui-btn ui-corner-all ui-shadow ui-btn-inline ui-btn-b"
							data-rel="back">取消</a>

					</div>
				</div>
			</c:forEach>
			
		</div>
		
	

			
	
		<div data-role="footer">
			<h5>分行科技部 Copyright ©</h5>
		</div>
		<!-- /footer -->
		
	</div>
	<!-- /page -->

</body>
</html>

