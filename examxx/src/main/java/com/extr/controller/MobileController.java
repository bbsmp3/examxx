package com.extr.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Set;
import java.util.TreeSet;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.extr.controller.domain.AnswerSheetItem;
import com.extr.controller.domain.Message;
import com.extr.controller.domain.PaperCreatorParam;
import com.extr.controller.domain.QuestionQueryResult;
import com.extr.domain.exam.ExamHistory;
import com.extr.domain.exam.ExamPaper;
import com.extr.domain.question.Field;
import com.extr.domain.question.Question;
import com.extr.domain.question.QuestionStruts;
import com.extr.security.UserInfo;
import com.extr.service.ExamService;
import com.extr.service.QuestionService;
import com.extr.util.Page;
import com.extr.util.PagingUtil;
import com.extr.util.QuestionAdapter;
import com.extr.util.xml.Object2Xml;

@Controller
public class MobileController {

	@Autowired
	private ExamService examService;
	@Autowired
	private QuestionService questionService;

	private static final String SUCCESS_Message = "success";
	private static final String failed_Message = "failed";


	@RequestMapping(value = "/mobile/exampaperfilter-{papertype}-{page}.html", method = RequestMethod.GET)
	public String mobileExampaperListFilterPage(Model model,
			@PathVariable("papertype") String papertype,
			@PathVariable("page") int page) {

		Page<ExamPaper> pageModel = new Page<ExamPaper>();
		pageModel.setPageNo(page);
		pageModel.setPageSize(10);
		List<ExamPaper> paper = examService.getExamPaperListByPaperType(
				papertype, pageModel);
		String pageStr = PagingUtil.getPageBtnlink(page,
				pageModel.getTotalPage());
		model.addAttribute("papertype", papertype);
		model.addAttribute("paper", paper);
		model.addAttribute("pageStr", pageStr);
		return "/mobile/home";
	}

	/**
	 * 准备模拟考试
	 * 
	 * @param model
	 * @param exam_history_id
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/mobile/examing/{examPaperId}", method = RequestMethod.GET)
	public String mobileExaming(Model model, HttpServletRequest request,
			@PathVariable("examPaperId") int examPaperId) {

		UserInfo userInfo = (UserInfo) SecurityContextHolder.getContext()
				.getAuthentication().getPrincipal();
		String strUrl = "http://" + request.getServerName() // 服务器地址
				+ ":" + request.getServerPort() + "/";
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		int duration = 0;
		ExamHistory examHistory = examService
				.getUserExamHistoryByUserIdAndExamPaperId(userInfo.getUserid(),
						examPaperId);
		ExamPaper examPaper = examService.getExamPaperById(examPaperId);
		String content = "";
		if (examHistory != null) {
			content = examHistory.getContent();
			
			/*duration = examHistory.getDuration();
			Date now = new Date();
			
			long startT = examHistory.getCreateTime().getTime();
			long endT = 0;
			try {
				endT = df.parse(df.format(now)).getTime();
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			long minutsPass = (endT - startT) / 1000;
			
			duration = (int) (minutsPass >= (long)duration ? 0 : duration - minutsPass);
			
			if(duration == 0)
				return "home";*/
		} else {
			
			content = examPaper.getContent();
			examHistory = new ExamHistory();
			examHistory.setContent(content);
			examHistory.setExamPaperId(examPaperId);
			examHistory.setUserId(userInfo.getUserid());
			examHistory.setDuration(examPaper.getDuration());
			examService.addUserExamHistory(examHistory);
			
		}
		duration = examPaper.getDuration();
		@SuppressWarnings("unchecked")
		List<QuestionQueryResult> questionList = Object2Xml.toBean(content,
				List.class);

		StringBuilder sb = new StringBuilder();
		for (QuestionQueryResult question : questionList) {
			QuestionAdapter adapter = new QuestionAdapter(question, strUrl);
			sb.append(adapter.getUserExamPaper());
		}

		model.addAttribute("examHistoryId", examHistory.getHistId());
		model.addAttribute("examPaperId", examPaperId);
		model.addAttribute("duration", duration * 60);
		model.addAttribute("htmlStr", sb.toString());
		return "mobile/examing";
	}

}
