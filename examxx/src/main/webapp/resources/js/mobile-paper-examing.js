//$(function() {
//	modal.prepare();
//	examing.initial();
//
//});
$(document).on("mobileinit", function () {
	$.mobile.ajaxEnabled = false;
	//examing.initial();
});

$(document).on("pagecreate",function(){
	$(".question").addClass("ui-body-c");
	$(".question").attr("counted","false");
	examing.addNumber(); 
	examing.initNavBar();
	examing.doQuestionFilt("qt-singlechoice");
	examing.bindQuestionFilter();
	examing.bindFinishOne();
	examing.startTimer();
	examing.bindSubmit();
	//alert($(".question").attr("data-theme"));
});


var examing = {
	initial : function initial() {
		$(window).scroll(examing.fixSideBar);
		
		this.refreshNavi();
		this.bindNaviBehavior();
		this.addNumber();
//		this.securityHandler();

		this.bindOptClick();
		this.updateSummery();
		this.bindQuestionFilter();
		this.bindfocus();
		this.bindFinishOne();
		this.startTimer();

		this.bindSubmit();

		
	},
	
	singleChoiceCount : 0,
	multipleChoiceCount : 0,
	trueOrFalseCount : 0,
	
	initNavBar : function initNavBar() {
		$("#singlechoice-sum").text($(".qt-singlechoice").length);
		$("#multiplechoice-sum").text($(".qt-multiplechoice").length);
		$("#trueorfalse-sum").text($(".qt-trueorfalse").length);
	},
	
	
	fixSideBar : function fixSideBar() {
		var nav = $("#bk-exam-control");
		var title = $("#exampaper-title");
		var container = $("#exampaper-desc-container");
		if ($(this).scrollTop() > 147) {
			nav.addClass("fixed");
			title.addClass("exampaper-title-fixed");
			container.addClass("exampaper-desc-container-fixed");
			
		} else {
			nav.removeClass("fixed");
			title.removeClass("exampaper-title-fixed");
			container.removeClass("exampaper-desc-container-fixed");
		}
	},


	bindNaviBehavior : function bindNaviBehavior() {

		var nav = $("#question-navi");
		var naviheight = $("#question-navi").height() - 33;
		var bottompx = "-" + naviheight + "px;";
		// alert(naviheight);

		var scrollBottomRated = $("footer").height() + 2 + 100 + naviheight;
		// alert($("footer").height() );
		// alert(scrollBottomRated);

		$("#exampaper-footer").height($("#question-navi").height());

		nav.css({
			position : 'fixed',
			bottom : '0px',
			"z-index" : '1'	
		});

		// nav.attr("style", "position : \"fixed\";bottom:-" + naviheight +
		// "px;");

		/*$(window).scroll(function() {
			var nav = $("#question-navi");
			var scrollBottom = document.body.scrollHeight - $(this).scrollTop() - $(window).height();
			if (scrollBottom > scrollBottomRated) {
				// nav.addClass("fixed-navi");
				var naviheight = $("#question-navi").height() - 33;
				// nav.attr("style", "bottom:-" + naviheight + "px;");
				if (nav.css("position") == "relative") {
					nav.css({
						position : 'fixed',
						bottom : "-" + naviheight + "px"
					});
				}
				// nav.css({
				// // position : 'fixed',
				// bottom : "-" + naviheight + "px"
				// });

			} else {
				// nav.removeClass("fixed-navi");
				// nav.attr("style", "");
				nav.css({
					position : 'relative',
					bottom : 0
				});
			}

		});*/

		$("#question-navi-controller").click(function() {
			var scrollBottom = document.body.scrollHeight - $(window).scrollTop() - $(window).height();

			var nav = $("#question-navi");
			var attr = nav.attr("style");

			if (nav.css("position") == "fixed") {
				if (nav.css("bottom") == "0px") {
					nav.css({
						bottom : "-" + naviheight + "px"
					});
				} else {
					nav.css({
						bottom : 0
					});
				}

			}

		});

	},

	securityHandler : function securityHandler() {
		// 右键禁用
		if (document.addEventListener) {
			document.addEventListener("contextmenu", function(e) {
				 e.preventDefault();
			 }, false);
		} else {
			document.attachEvent("contextmenu", function(e) {
				 e.preventDefault();
			 });
		}

		$(window).bind('beforeunload', function() {
			return "考试正在进行中...";
		});
	},

	/**
	 * 刷新试题导航
	 */
	refreshNavi : function refreshNavi() {
		$("#exam-control #question-navi").empty();
		var questions = $("li.question");

		questions.each(function(index) {
			var btnhtml = "<a class=\"question-navi-item\">" + (index + 1) + "</a>";
			$("#question-navi-content").append(btnhtml);
		});
	},

	/**
	 * 更新题目简介信息
	 */
	updateSummery : function updateSummery() {
		if ($(".question").length === 0) {
			return false;
		}
		var questiontypes = this.questiontypes;
		var summery = "";
		for (var i = 0; i < questiontypes.length; i++) {
			var question_sum_q = $("." + questiontypes[i].code).length;
			if (question_sum_q == 0) {
				continue;
			} else {
				summery = summery + "<span class=\"exampaper-filter-item efi-" + questiontypes[i].code + "\">" 
				+ questiontypes[i].name + "[<span class=\"efi-fno\">0</span>/<span class=\"efi-tno\">" 
				+ $("." + questiontypes[i].code).length + "</span>]<span class=\"efi-qcode\" style=\"display:none;\">" 
				+ questiontypes[i].code + "</span></span>";
			}
		}
		// summery = summery.substring(0, summery.length - 2);
		$("#exampaper-desc").html(summery);
		
		examing.doQuestionFilt($($(".exampaper-filter-item")[0]).find(".efi-qcode").text());
	},

	questiontypes : new Array({
		"name" : "单选题",
		"code" : "qt-singlechoice"
	}, {
		"name" : "多选题",
		"code" : "qt-multiplechoice"
	}, {
		"name" : "判断题",
		"code" : "qt-trueorfalse"
	}, {
		"name" : "填空题",
		"code" : "qt-fillblank"
	}, {
		"name" : "简答题",
		"code" : "qt-shortanswer"
	}, {
		"name" : "论述题",
		"code" : "qt-essay"
	}, {
		"name" : "分析题",
		"code" : "qt-analytical"
	}),
	/**
	 * 绑定考题focus事件(点击考题导航)
	 */
	bindfocus : function bindfocus() {
		$("#question-navi").delegate("a.question-navi-item ", "click", function() {
			var clickindex = $("a.question-navi-item").index(this);
			var questions = $("li.question");
			var targetQuestion = questions[clickindex];
			
			var targetQuestionType = $(questions[clickindex]).find(".question-type").text();
			
			examing.doQuestionFilt("qt-" + targetQuestionType);
			
			examing.scrollToElement($(targetQuestion));
		});
	},

	scrollToElement : function scrollToElement(selector, time, verticalOffset) {
		time = typeof (time) != 'undefined' ? time : 500;
		verticalOffset = typeof (verticalOffset) != 'undefined' ? verticalOffset : 0;
		element = $(selector);
		offset = element.offset();
		offsetTop = offset.top + verticalOffset;
		$('html, body').animate({
			scrollTop : offsetTop
		}, time);
	},

	/**
	 * 完成一道题触发的function
	 */
//	bindFinishOne : function bindFinishOne() {
//		$(".question input[type=radio]").change(function() {
//			var current_index = $("li.question").index($(this).parent().parent());
//			$($("a.question-navi-item")[current_index]).addClass("pressed");
//		});
//
//		$(".question input[type=checkbox]").change(function() {
//			var current_question = $(this).parent().parent();
//			var current_index = $("li.question").index(current_question);
//			var checkedboxs = current_question.find("input[type=checkbox]:checked");
//			if (checkedboxs.length > 0) {
//				$($("a.question-navi-item")[current_index]).addClass("pressed");
//			} else {
//				$($("a.question-navi-item")[current_index]).removeClass("pressed");
//			}
//		});
//
//		$(".question textarea").bind('input propertychange', function() {
//
//			var current_index = $("li.question").index($(this).parent().parent());
//			if ($(this).val() != "") {
//				$($("a.question-navi-item")[current_index]).addClass("pressed");
//			} else {
//				$($("a.question-navi-item")[current_index]).removeClass("pressed");
//			}
//		});
//
//	},
	


	/**
	 * 开始倒计时
	 */
	startTimer : function startTimer() {
		var timestamp = parseInt($("#exam-timestamp").text());
		var int = setInterval(function() {
			$("#exam-timestamp").text(timestamp);
			$("#exam-clock").text("剩余时间：" + examing.toHHMMSS(timestamp));
//			if(timestamp < 600){
//				var exam_clock = $("#question-time");
//				exam_clock.removeClass("question-time-normal");
//				exam_clock.addClass("question-time-warning");
//			}
			timestamp--;
			if(timestamp <= 0) {
				examing.examTimeOut(int); 
			}
		}, 1000);
//		if(timestamp <= 0) {
//			examing.examTimeOut(int);
//		}
	},
	
	/**
	 * 考试时间到
	 * @param int
	 */
	examTimeOut : function examTimeOut (int){
		clearInterval(int); 
		examing.finishExam();
	},

	/**
	 * 时间formater
	 *
	 * @param timestamp
	 * @returns {String}
	 */
	toHHMMSS : function toHHMMSS(timestamp) {
		var sec_num = parseInt(timestamp, 10);
		var hours = Math.floor(sec_num / 3600);
		var minutes = Math.floor((sec_num - (hours * 3600)) / 60);
		var seconds = sec_num - (hours * 3600) - (minutes * 60);

		if (hours < 10) {
			hours = "0" + hours;
		}
		if (minutes < 10) {
			minutes = "0" + minutes;
		}
		if (seconds < 10) {
			seconds = "0" + seconds;
		}
		var time = hours + ':' + minutes + ':' + seconds;
		return time;
	},

	/**
	 * 完成一道题触发的function
	 */
	bindFinishOne : function bindFinishOne() {
		$(".qt-singlechoice input[type=radio]").on("change", function(event, ui) {
			var question = $(this).closest(".question");
			$(question).removeClass("ui-body-c");
			$(question).addClass("ui-body-e");
			if($(question).attr("counted") == "false") {
				examing.singleChoiceCount++;
				$("#singlechoice-count").text(examing.singleChoiceCount);
				$(question).attr("counted", "true");
			}
		});


		$(".qt-multiplechoice input[type=checkbox]").on("change", function(event, ui) {
			var question = $(this).closest(".question");
			var checkbox_checked = $(this).closest(".ui-controlgroup-controls").find("input[type=checkbox]:checked");
			if($(question).attr("counted") == "false") {
				$(question).removeClass("ui-body-c");
				$(question).addClass("ui-body-e");
				examing.multipleChoiceCount++;
				$("#multiplechoice-count").text(examing.multipleChoiceCount);
				$(question).attr("counted", "true");
			}
			if (checkbox_checked.length == 0 && $(question).attr("counted") == "true") {
				$(question).removeClass("ui-body-e");
				$(question).addClass("ui-body-c");
				examing.multipleChoiceCount--;
				$("#multiplechoice-count").text(examing.multipleChoiceCount);
				$(question).attr("counted", "false");
			} 
		});
		
		$(".qt-multiplechoice").on("collapsiblecollapse", function(event, ui) {
			
		});
		
		$(".qt-trueorfalse input[type=radio]").on("change", function(event, ui) {
			var question = $(this).closest(".question");
			$(question).removeClass("ui-body-c");
			$(question).addClass("ui-body-e");
			if($(question).attr("counted") == "false") {
				examing.trueOrFalseCount++;
				$("#trueorfalse-count").text(examing.trueOrFalseCount);
				$(question).attr("counted", "true");
			}	
		});

	},
	/**
	 * 对题目重新编号排序
	 */
	addNumber : function addNumber() {
		var questions = $("div.qt-singlechoice");
		questions.each(function(index) {
			$(this).find(".question-no").text(index + 1 + ".");
		});
		questions = $("div.qt-multiplechoice");
		questions.each(function(index) {
			$(this).find(".question-no").text(index + 1 + ".");
		});
		questions = $("div.qt-trueorfalse");
		questions.each(function(index) {
			$(this).find(".question-no").text(index + 1 + ".");
		});
	},

	/**
	 * 切换考题类型事件
	 */
	bindQuestionFilter : function bindQuestionFilter() {

		$(".type-selector").on("tap", function() {
			var qtype = $(this).attr("value")
//			this.removeClass("ui-btn-active");
//			this.addClass("ui-btn-c");
			examing.doQuestionFilt(qtype);
		});
	},
	
	
	/**
	 *切换到指定的题型 
	 */
	doQuestionFilt : function doQuestionFilt(questiontype) {
		var questions = $("div.question");
		questions.hide();
		$("#exampaper-body ." + questiontype).show();
	},

	bindSubmit : function bindSubmit() {
		  $("#a-popup").on("tap",function(){
			  var finalCount = $(".question").length - examing.singleChoiceCount
			  	- examing.multipleChoiceCount - examing.trueOrFalseCount;
			  $("#final-count").text(finalCount);
		  });
		  
		  $("#a-submit").on("tap",function(){  
			  examing.finishExam();
		  }); 
	},

	finishExam : function finishExam() {
		
		//modal.showProgress();
		var answerSheet = examing.genrateAnswerSheet();
		var data = new Object();
		var exam_history_id = $("#hist-id").val();
		data.exam_history_id = exam_history_id;
		data.as = answerSheet;
		var timeStr = $("#exam-clock").text();
		var time = timeStr.split(":");
		var hours = parseInt(time[0]);
		var minutes = parseInt(time[1]);
		var seconds = parseInt(time[2]);
		data.duration = hours * 3600 + minutes * 60 + seconds;
		$("#a-popup").addClass("ui-state-disabled");
		var request = $.ajax({
			headers : {
				'Accept' : 'application/json',
				'Content-Type' : 'application/json'
			},
			type : "POST",
			url : "mobile/exam-submit",
			data : JSON.stringify(data)
		});

		request.done(function(message, tst, jqXHR) {
			if (!util.checkSessionOut(jqXHR))
				return false;
			if (message.result == "success") {
				$(window).unbind('beforeunload');
				util.success("交卷成功！", function() {
					window.location.replace(document.getElementsByTagName('base')[0].href + 'mobile/finish-exam/' + $("#paper-id").val());

				});
			} else {
				util.error(message.result);
				$("#a-popup").removeClass("ui-state-disabled");
			}
			modal.hideProgress();
		});
		request.fail(function(jqXHR, textStatus) {
			alert("系统繁忙请稍后尝试");
			$("#a-popup").removeClass("ui-state-disabled");
			modal.hideProgress();
		});
	},

	genrateAnswerSheet : function genrateAnswerSheet() {
		//		var as = new Array();
		var as = {};
		var questions = $(".question");

		for (var i = 0; i < questions.length; i++) {
			var answerSheetItem = new Object();

			if ($(questions[i]).hasClass("qt-singlechoice")) {
				var radio_checked = $(questions[i]).find("input[type=radio]:checked");
				var radio_all = $(questions[i]).find("input[type=radio]");
				if (radio_checked.length == 0) {
					answerSheetItem.answer = "";
				} else {
					answerSheetItem.answer = $(radio_checked).attr("value");
				}
				answerSheetItem.question_type_id = 1;
			} else if ($(questions[i]).hasClass("qt-multiplechoice")) {

				var checkbox_checked = $(questions[i]).find("input[type=checkbox]:checked");
				var checkbox_all = $(questions[i]).find("input[type=checkbox]");
				var checked_values = new Array();
			
				if (checkbox_checked.length == 0) {
					answerSheetItem.answer = "";
				} else {
					var tm_answer = "";
					for (var l = 0; l < checkbox_checked.length; l++) {
						checked_values[l] = $(checkbox_checked[l]).attr("value");
					}
					checked_values.sort();
					tm_answer = checked_values.join("");
					answerSheetItem.answer = tm_answer;
				}
				answerSheetItem.question_type_id = 2;
			} else if ($(questions[i]).hasClass("qt-trueorfalse")) {

				var radio_checked = $(questions[i]).find("input[type=radio]:checked");
				var radio_all = $(questions[i]).find("input[type=radio]");
				if (radio_checked.length == 0) {
					answerSheetItem.answer = "";
				} else {
					var current_index = $(radio_all).index(radio_checked);
					answerSheetItem.answer = (current_index == 0) ? "T" : "F";
				}
				answerSheetItem.question_type_id = 3;
			} else if ($(questions[i]).hasClass("qt-fillblank")) {
				answerSheetItem.answer = $(questions[i]).find("textarea").val();
				answerSheetItem.question_type_id = 4;
			} else if ($(questions[i]).hasClass("qt-shortanswer")) {
				answerSheetItem.answer = $(questions[i]).find("textarea").val();
				answerSheetItem.question_type_id = 5;
			} else if ($(questions[i]).hasClass("qt-essay")) {
				answerSheetItem.answer = $(questions[i]).find("textarea").val();
				answerSheetItem.question_type_id = 6;
			} else if ($(questions[i]).hasClass("qt-analytical")) {
				answerSheetItem.answer = $(questions[i]).find("textarea").val();
				answerSheetItem.question_type_id = 7;
			}
			answerSheetItem.point = 0;

			var tmpkey = $(questions[i]).find(".question-id").text();
			var tmpvalue = answerSheetItem;

			as[tmpkey] = tmpvalue;
		}
		return as;
	},
	bindOptClick : function bindOptClick(){
		$(".question-list-item").click(function(){
			$(this).parent().find(".question-list-item-selected").removeClass("question-list-item-selected");
			$(this).addClass("question-list-item-selected");
			$(this).find("input").prop("checked", true);
		});
		
	}
};

var modal = {
	prepare : function prepare() {
		$(".content").append("<div id=\"loading-progress\" style=\"display:none;\"><div id=\"loading-content\"> <h2>正在提交您的答案</h2><img class=\"loading-gif\" src=\"resources/images/loading.gif\"/><div> </div>");

	},
	showProgress : function showProgress() {
		$("#loading-progress").show();
	},

	hideProgress : function hideProgress() {
		$("#loading-progress").hide();
	}
};
