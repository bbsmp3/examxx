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

		<div data-role="header" data-position="fixed">
			<a href="#" class="ui-btn ui-btn-left ui-icon-user ui-btn-icon-left">${truename}</a> 
			<!--  a href="#" class="ui-btn ui-btn-right ui-icon-action ui-btn-icon-right"></a--> 
			<h1>分行考试系统</h1>
			<div data-role="navbar">
					<ul>
						<li><a href="#" class="ui-btn type-selector" value="qt-singlechoice">单选(
							<span id="singlechoice-count">0</span>
							/
							<span id="singlechoice-sum">0</span>
						)</a></li>
						<li><a href="#" class="ui-btn type-selector" value="qt-multiplechoice">多选(
							<span id="multiplechoice-count">0</span>
							/
							<span id="multiplechoice-sum">0</span>
						)</a></li>
						<li><a href="#" class="ui-btn type-selector" value="qt-trueorfalse">判断(
							<span id="trueorfalse-count">0</span>
							/
							<span id="trueorfalse-sum">0</span>
						)</a></li>
					</ul>
				</div><!-- /navbar -->
		</div>
		<input type="hidden" id="hist-id" value="${examHistoryId }"> 
		<input type="hidden" id="paper-id" value="${examPaperId }">
		<div id="exampaper-body" data-role="collapsibleset" >
		
<!-- 		<div class="question qt-singlechoice ui-body-e"  data-role="collapsible" id="test"><h4><span class="question-no"></span>“专业尽职调查”，是指分行尽职调查中心的尽职调查人员会同客户</h4><div class="question-title"><div class="question-title-icon"></div><span class="question-no"></span><span class="question-type" style="display: none;">singlechoice</span><span class="knowledge-point-id" style="display: none;">6</span><span class="question-type-id" style="display: none;">1</span><span>[单选题]</span><span class="question-point-content"><span>(</span><span class="question-point">2</span><span>分)</span></span><span class="question-id" style="display:none;">271</span></div><form class="question-body"><p class="question-body-text">“专业尽职调查”，是指分行尽职调查中心的尽职调查人员会同客户经理，根据尽职调查真实性核查等相关要求，对         的真实性、完整性等有关情况进行核查，发表独立的验证和评价意见，为授信决策提供参考的行为。(  )</p> -->
<!-- 		<fieldset data-role="controlgroup"><input type="radio" value="A" name="question-radio1" class="question-input" id="question-radio-271A" ><label for="question-radio-271A" >A: 影响还款关键风险点</label></span><input type="radio" value="B" name="question-radio1" class="question-input" id="question-radio-271B" ><label for="question-radio-271B" >B: 重要财务科目</label></span><input type="radio" value="C" name="question-radio1" class="question-input" id="question-radio-271C" ><label for="question-radio-271C" >C: 授信基础资料</label></span><input type="radio" value="D" name="question-radio1" class="question-input" id="question-radio-271D" ><label for="question-radio-271D" >D: 影响贷款用途的关键风险点</label></span></fieldset></form></div> -->
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
				<h3 class="ui-title">您还有<span id="final-count">0</span>道题没有完成,是否结束考试？确认提交后将无法再次答题</h3>
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

