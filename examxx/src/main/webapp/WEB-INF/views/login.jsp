<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
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
	<title>Multi-page template</title>
	<link rel="stylesheet" href="resources/jqm/css/themes/default/jquery.mobile-1.4.5.min.css">
	<link rel="stylesheet" href="resources/jqm/_assets/css/jqm-demos.css">
	<link rel="shortcut icon" href="resources/jqm/favicon.ico">
	<script src="resources/jqm/js/jquery.js"></script>
	<script src="resources/jqm/_assets/js/index.js"></script>
	<script type="text/javascript">
		$(document).bind("mobileinit", function () {
		    $.mobile.ajaxEnabled = false;
		});
	</script>
	<script src="resources/jqm/js/jquery.mobile-1.4.5.min.js"></script>
</head>

<body>

<div data-role="page">

	<div data-role="header">
		<h1>企金考试系统</h1>
	</div><!-- /header -->
	<div role="main" class="ui-content" id="login">
	 <!--div data-role="page" id="login">    
        <div data-role="content"-->  
            <form method="post" action="j_spring_security_check">  
              <div data-role="fieldcontain">  
                <input type="text" name="j_username" id="username" placeholder="用户名">  
                <input type="password" name="j_password" id="password" placeholder="密码">  
  
                <input type="submit" data-role="button" value="登录">  

              </div>  
            </form>  
			<h5>说明: 用户名为四位工号, 密码为分行考核系统密码</h5> 	
					
    </div>  

	<div data-role="footer">
		<h5>分行科技部 Copyright © </h5>
	</div><!-- /footer -->

</div><!-- /page -->

</body>
</html>

