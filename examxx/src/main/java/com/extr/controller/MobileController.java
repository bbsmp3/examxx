package com.extr.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
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

import com.extr.controller.ExamController.ReportResult;
import com.extr.controller.domain.AnswerSheetItem;
import com.extr.controller.domain.ExamFinishParam;
import com.extr.controller.domain.Message;
import com.extr.controller.domain.PaperCreatorParam;
import com.extr.controller.domain.QuestionQueryResult;
import com.extr.domain.exam.ExamHistory;
import com.extr.domain.exam.ExamPaper;
import com.extr.domain.question.Field;
import com.extr.domain.question.Question;
import com.extr.domain.question.QuestionStruts;
import com.extr.domain.user.User;
import com.extr.security.UserInfo;
import com.extr.service.ExamService;
import com.extr.service.QuestionService;
import com.extr.service.UserService;
import com.extr.util.Page;
import com.extr.util.PagingUtil;
import com.extr.util.QuestionAdapter;
import com.extr.util.xml.Object2Xml;

@Controller
public class MobileController {

	@Autowired
	private ExamService examService;
	@Autowired
	private UserService userService;
	@Autowired
	private QuestionService questionService;

	private static final String SUCCESS_MESSAGE = "success";
	private static final String FAILED_MESSAGE = "failed";
	private static final int SECONDS_PER_MINUTE = 60;
	private static final String PAPER_SUBMITTED = "ps";
	private static final int MOBILE_PAPER_TYPE = 4;

	public class ReportResult {
		public int sum;
		public int rightTimes;
		public int wrongTimes;

		public int getSum() {
			return sum;
		}

		public int getRightTimes() {
			return rightTimes;
		}

		public int getWrongTimes() {
			return wrongTimes;
		}
	};


	@RequestMapping(value = "/mobile/exampaperfilter-{papertype}-{page}.html", method = RequestMethod.GET)
	public String mobileExampaperListFilterPage(Model model,
			@PathVariable("papertype") String papertype,
			@PathVariable("page") int page) {
		UserInfo userInfo = (UserInfo) SecurityContextHolder.getContext()
				.getAuthentication().getPrincipal();
		Page<ExamPaper> pageModel = new Page<ExamPaper>();
		pageModel.setPageNo(page);
		pageModel.setPageSize(10);
		List<ExamPaper> paper = examService.getExamPaperList4Exam(MOBILE_PAPER_TYPE);
		User user = userService.getUserById(userInfo.getUserid());
		model.addAttribute("truename", user.getTruename());
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
		long startTime = 0L;
		long nowTime = 0L;
		int secondsPassed = 0;
		int secondsLeft = 0;
		ExamHistory examHistory = examService
				.getUserExamHistoryByUserIdAndExamPaperId(userInfo.getUserid(),
						examPaperId);
		ExamPaper examPaper = examService.getExamPaperById(examPaperId);
		User user = userService.getUserById(userInfo.getUserid());
		model.addAttribute("truename", user.getTruename());
		String content = "";
		if (examHistory != null) {
			content = examHistory.getContent();
//			if(examHistory.getSubmitTime() != null) {
//				return "redirect:/mobile/exampaperfilter-"+PAPER_SUBMITTED+"-1.html";
//			}
//			
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
			examHistory = examService
					.getUserExamHistoryByUserIdAndExamPaperId(userInfo.getUserid(),
							examPaperId);
			
		}
		
		duration = examPaper.getDuration();
		startTime = examHistory.getCreateTime().getTime();
		nowTime = new Date().getTime();
		secondsPassed = (int) ((nowTime - startTime) / 1000);
		secondsLeft = duration * SECONDS_PER_MINUTE -  secondsPassed;
		
		@SuppressWarnings("unchecked")
		List<QuestionQueryResult> questionList = Object2Xml.toBean(content,
				List.class);
		Collections.shuffle(questionList);

		StringBuilder sb = new StringBuilder();
		for (QuestionQueryResult question : questionList) {
			QuestionAdapter adapter = new QuestionAdapter(question, strUrl);
			sb.append(adapter.getMobileUserExamPaper());
		}

		model.addAttribute("examHistoryId", examHistory.getHistId());
		model.addAttribute("examPaperId", examPaperId);
		model.addAttribute("duration", duration * SECONDS_PER_MINUTE);
		model.addAttribute("secondsLeft", secondsLeft);
		model.addAttribute("htmlStr", sb.toString());
		return "mobile/examing";
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/mobile/exam-submit", method = RequestMethod.POST)
	public @ResponseBody
	Message mobileFinishExam(@RequestBody ExamFinishParam efp) {

		Message message = new Message();
		//message.setResult("error");
		try {
			ExamHistory examHistory = examService
					.getUserExamHistoryByHistId(efp.getExam_history_id());
			List<QuestionQueryResult> questionList = Object2Xml.toBean(examHistory.getContent(), List.class);
			float pointGet = 0f;
			for(QuestionQueryResult qqr : questionList){
				if(qqr.getAnswer().equals(efp.getAs().get(qqr.getQuestionId()).getAnswer()))
					pointGet += qqr.getQuestionPoint();
			}
			//计算得分
			examHistory.setPointGet(pointGet);
			examHistory.setAnswerSheet(Object2Xml.toXml(efp.getAs()));
			examHistory.setSubmitTime(new Date());
			//examHistory.setDuration(efp.getDuration());
			examService.updateExamHistory(examHistory);
		} catch (Exception e) {
			e.printStackTrace();
			message.setResult(e.getClass().getName());
		}

		return message;
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "mobile/finish-exam/{examPaperId}", method = RequestMethod.GET)
	public String mobilePaperExamFinishedPage(Model model,
			@PathVariable("examPaperId") int examPaperId) {
		UserInfo userInfo = (UserInfo) SecurityContextHolder.getContext()
				.getAuthentication().getPrincipal();

		ExamHistory examHistory = examService
				.getUserExamHistoryByUserIdAndExamPaperId(userInfo.getUserid(),
						examPaperId);
		HashMap<Integer, AnswerSheetItem> hm = Object2Xml.toBean(
				examHistory.getAnswerSheet(), HashMap.class);
		ExamPaper examPaper = examService.getExamPaperById(examHistory.getExamPaperId());
		User user = userService.getUserById(userInfo.getUserid());
		model.addAttribute("truename", user.getTruename());

		int total = hm.size();
		int wrong = 0;
		int right = 0;

		HashMap<String, ReportResult> reportResultList = new HashMap<String, ReportResult>();
		List<QuestionQueryResult> questionQueryList = Object2Xml.toBean(
				examHistory.getContent(), List.class);
		List<Integer> idList = new ArrayList<Integer>();
		HashMap<Integer, Boolean> answer = new HashMap<Integer, Boolean>();
		for (QuestionQueryResult q : questionQueryList) {
			String pointName = q.getPointName().split(">")[1];
			idList.add(q.getQuestionId());
			if (q.getQuestionTypeId() != 1 && q.getQuestionTypeId() != 2
					&& q.getQuestionTypeId() != 3)
				continue;
			if (hm.get(q.getQuestionId()) != null) {
				if (q.getAnswer().equals(hm.get(q.getQuestionId()).getAnswer())) {
					answer.put(q.getQuestionId(), true);
					right++;
					if (reportResultList.containsKey(pointName)) {
						ReportResult r = reportResultList.get(pointName);
						r.sum++;
						r.rightTimes++;
						reportResultList.put(pointName, r);
					} else {
						ReportResult r = new ReportResult();
						r.sum = 1;
						r.rightTimes = 1;
						reportResultList.put(pointName, r);
					}
				} else {
					answer.put(q.getQuestionId(), false);
					wrong++;
					if (reportResultList.containsKey(pointName)) {
						ReportResult r = reportResultList.get(pointName);
						r.sum++;
						r.wrongTimes++;
						reportResultList.put(pointName, r);
					} else {
						ReportResult r = new ReportResult();
						r.sum = 1;
						r.wrongTimes = 1;
						reportResultList.put(pointName, r);
					}
				}
				hm.remove(q.getQuestionId());
			}
		}

		model.addAttribute("total", total);
		model.addAttribute("wrong", wrong);
		model.addAttribute("right", right);
		model.addAttribute("reportResultList", reportResultList);
		model.addAttribute("create_time", examHistory.getCreateTime());
		model.addAttribute("submit_time", examHistory.getSubmitTime());
		model.addAttribute("pointGet", examHistory.getPointGet());
		model.addAttribute("duration", examHistory.getDuration());
		model.addAttribute("examName", examPaper.getName());
		model.addAttribute("answer", answer);
		model.addAttribute("idList", idList);
		model.addAttribute("examPaperId", examPaperId);
		return "mobile/paper-exam-finished";
	}

}
