package com.biz.nav.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.biz.nav.dao.MemberDao;
import com.biz.nav.model.MemberVO;
import com.biz.nav.service.FileService;
import com.biz.nav.service.MemberService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class HomeController {

	@Autowired
	@Qualifier("mServiceV1")
	private MemberService mService;

	@Autowired
	private MemberDao mDao;

	@Qualifier("fileServiceV1")
	@Autowired
	private FileService fileService;

	// 회원가입
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String join(@ModelAttribute("MEM_VO") MemberVO memVO, Model model) {

		model.addAttribute("BODY", "LOGIN");
		return "home";

	}

	// 회원가입
	@RequestMapping(value = "/", method = RequestMethod.POST)
	public String join(@ModelAttribute("MEM_VO") MemberVO memVO, Model model, HttpServletRequest req) {

		log.debug("회원가입할 정보:", memVO.toString());
		mService.insert(memVO);

		return "redirect:/";
	}

	// 회원 확인
	@ResponseBody
	@RequestMapping(value = "/idCheck", method = RequestMethod.POST)
	public int postIdCheck(HttpServletRequest req) throws Exception {
		log.debug("post ID Check");

		String n_userid = req.getParameter("n_userid");
		MemberVO idCheck = mService.idCheck(n_userid);
		int result = 0;
		if (idCheck != null || n_userid == "") {

			result = 1;
		}

		return result;
	}

	@ResponseBody
	@Mapper
	// 로그인 완료 된 상태에서 가는 map page
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String login(@ModelAttribute("MEM_VO") MemberVO loginVO, MemberVO memVO, HttpSession httpSession,
			HttpServletRequest req) {

		String n_password = req.getParameter("n_password");
		String n_userid = req.getParameter("n_userid");

		MemberVO passCheck = mService.passCheck(n_password, n_userid);

		if (passCheck == null) {
			return "0";
		} else {
			log.debug("passcheck:" + passCheck.toString());
			memVO = mService.login(loginVO);

			httpSession.setAttribute("LOGIN", memVO);

			log.debug("정보 : " + memVO.toString());
			return "1";
		}

	}

	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(@ModelAttribute("MEM_VO") MemberVO loginVO, MemberVO memVO, HttpSession httpSession) {
		httpSession.setAttribute("LOGIN", null);
		log.debug("로그아웃성공");
		log.debug(memVO.toString());

		return "redirect:/";
	}

	@RequestMapping(value = "/map", method = RequestMethod.GET)
	public String map() {

		return "map";
	}

	@RequestMapping(value = "/mypage", method = RequestMethod.GET)
	public String mypage(MemberVO memVO, Model model, HttpSession httpSession) {

		memVO = (MemberVO) httpSession.getAttribute("LOGIN");
		log.debug("세션 정보 >> " + memVO.toString());

		model.addAttribute("LOGIN", memVO);
		return "mypage";

	}

	@RequestMapping(value = "/mypage", method = RequestMethod.POST)
	public String mypage(MemberVO memVO, HttpSession httpSession) {

		log.debug("Update POST 변경 정보 >>> " + memVO.toString());
		int ret = mService.update(memVO);


		if (ret > 0) {
			log.debug("UPDATE 수행한 후 결과 {}개 성공 ", ret);
			httpSession.setAttribute("LOGIN", memVO);
		}
		return "mypage";

	}

	@RequestMapping(value = "/memberDelete", method = RequestMethod.GET)
	public String delete() {

		return "/deleteView";
	}

	@RequestMapping(value = "/memberDelete", method = RequestMethod.POST)
	public String delete(MemberVO memVO, HttpSession httpSession, RedirectAttributes rttr) {

		// 세션에 있는 member를 가져와서 member변수에 넣어줌
		MemberVO member = (MemberVO) httpSession.getAttribute("LOGIN");
		// 세션에 있는 비밀번호
		String sessionPass = member.getN_password();
		// memVO로 돌아오는 비밀번호
		String memPass = memVO.getN_password();

		if (!(sessionPass.equals(memPass))) {
			rttr.addFlashAttribute("msg", false);
			return "redirect:/memberDelete";
		}

		mService.delete(memVO);
		httpSession.invalidate();
		return "redirect:/";
	}
	
	@RequestMapping(value="/myinfo", method=RequestMethod.GET)
	public String myinfo(MemberVO memVO, Model model, HttpSession httpSession,String s) {
		

		memVO = (MemberVO) httpSession.getAttribute("LOGIN");
		log.debug("세션 정보 >> " + memVO.toString());

		model.addAttribute("LOGIN", memVO);
		return "myinfo";
	}

}