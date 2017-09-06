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
	<script src="resources/jqm/js/jquery.mobile-1.4.5.min.js"></script>
</head>

<body>

<div data-role="page">

	<div data-role="header">
		<h1>Single page</h1>
	</div><!-- /header -->

	<div role="main" class="ui-content">
		<p>This is a single page boilerplate template that you can copy to build your first jQuery Mobile page. Each link or form from here will pull a new page in via Ajax to support the animated page transitions.</p>
		<p>Just view the source and copy the code to get started. All the CSS and JS is linked to the jQuery CDN versions so this is super easy to set up. Remember to include a meta viewport tag in the head to set the zoom level.</p>
		<p>This template is standard HTML document with a single "page" container inside, unlike a <a href="resources/jqm/pages-multi-page/" data-ajax="false">multi-page template</a> that has multiple pages within it. We strongly recommend building your site or app as a series of separate pages like this because it's cleaner, more lightweight and works better without JavaScript.</p>
	</div><!-- /content -->

	<div data-role="footer">
		<h4>Footer content</h4>
	</div><!-- /footer -->

</div><!-- /page -->

</body>
</html>

