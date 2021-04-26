package com.tjoeunit.view.members;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.tjoeunit.biz.flight.FlightVO;
import com.tjoeunit.biz.members.MembersService;
import com.tjoeunit.biz.members.MembersVO;

@Controller
@RequestMapping("/members")
public class MembersController {

	@Autowired
	private MembersService membersService;

	//회원가입 페이지
	@RequestMapping(value="/insertMembers.do", method=RequestMethod.GET)
	public String insertMembersPage() {
		System.out.println("회원가입 페이지");
		return "members/insertMembers";
	}

	//회원가입 처리
	@RequestMapping(value="/insertMembers.do", method=RequestMethod.POST)
	public String insertMembers(MembersVO vo, Model model) throws Exception {
		System.out.println("회원가입 처리");

		int cnt = membersService.insertMembers(vo);

		String msg="회원 가입 실패", url="/members/insertMembers.do";

		if(cnt>0) {
			msg="회원 가입 성공";
			url="/index.do";
		}

		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		model.addAttribute("member_id", vo.getMembers_id());

		return "common/message";

	}
	
	//회원 등록 시 아이디 중복 확인 (Ajax)
	@RequestMapping("/checkIdDup.do")
	@ResponseBody
	public int checkIdDup(@RequestParam String members_id) {
		System.out.println("members_id = " + members_id);
		int cnt = membersService.checkIdDup(members_id);
		System.out.println("cnt = "+cnt);
		return cnt;
	}
	
	//회원 로그인 페이지
	@RequestMapping(value="/loginMembers.do", method=RequestMethod.GET)
	public String loginMembersPage() {
		System.out.println("회원 로그인 페이지");
		return "members/loginMembers";
	}
	
	//회원 로그인 처리
	@RequestMapping(value="/loginMembers.do", method=RequestMethod.POST)
	public String loginMembers(@RequestParam String members_id, @RequestParam String members_pw,
			HttpServletRequest request, Model model) {
		System.out.println("회원 로그인 처리");
		System.out.println("members_id = " + members_id +", members_pw = " + members_pw);
		
		int result = membersService.loginMembers(members_id, members_pw);
		//result = 0 아이디가 존재하지 않거나 비밀번호가 일치하지 않음
		//result = 1 아이디가 존재하고 비밀번호 일치
		System.out.println("로그인 결과 result = " + result);
		
		//기본값 설정
		String msg = "로그인 실패", url = "/members/loginMembers.do";
		
		if(result == 1) {
			MembersVO vo = membersService.selectByMembersId(members_id);
				msg = vo.getMembers_id() + "님 로그인 성공";
				url = "/index.do";
				
				//세션에 저장
				HttpSession session = request.getSession();
				session.setAttribute("members_no", vo.getMembers_no());
				session.setAttribute("members_id", vo.getMembers_id());
				session.setAttribute("members_name", vo.getMembers_name());			
		
		}
		
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		
		return "common/message";
	}
	
	//회원 로그아웃 처리
	@RequestMapping(value="/logoutMembers.do", method=RequestMethod.GET)
	public String logoutMembers(Model model, HttpSession session) {
		
		String members_id = (String)session.getAttribute("members_id"); 
		String msg = members_id + "님 로그아웃 되었습니다";
		String url = "/index.do";		
		
		// 세션 전체 제거, 무효화 
		session.invalidate();		
		
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);

		return "common/messageLogout";
	}
	
	//회원 로그인 페이지
	@RequestMapping(value="/indexMembers.do", method=RequestMethod.GET)
	public String indexMembersPage() {
		System.out.println("마이페이지 첫 화면");
		return "members/indexMembers";
	}
	
	//회원 정보 페이지
	@RequestMapping(value="/infoMembers.do", method=RequestMethod.GET)
	public String infoMembersPage(HttpSession session, Model model) {
		System.out.println("회원정보 페이지");
		
		String members_id = (String)session.getAttribute("members_id");
		MembersVO members = membersService.selectByMembersId(members_id);
		
		model.addAttribute("members", members);		
		
		return "members/infoMembers";
	}
	
	//회원 탈퇴
	@RequestMapping("/deleteMembers.do")
	public String deleteMembers(HttpSession session, Model model) {
		
		int members_no = (Integer)session.getAttribute("members_no");
		String members_id = (String)session.getAttribute("members_id");
		System.out.println("회원 탈퇴 처리 members_no = " + members_no);
		System.out.println("회원 탈퇴 처리 members_id = " + members_id);
		
		String msg="회원 삭제 실패", url="/members/infoMembers.do";
		
		int cnt = membersService.deleteMembers(members_no);
		
		if(cnt>0) {
			msg= members_id + "님 탈퇴 처리되었습니다";
			url="/index.do";
		}
		
		// 세션 전체 제거, 무효화 
		session.invalidate();
		
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);

		return "common/messageLogout";
	}

	//비밀번호 변경 페이지
	@RequestMapping(value="/updatePw.do", method=RequestMethod.GET)
	public String updatePwPage() {
		System.out.println("비밀번호 변경 페이지");
		return "members/updatePw";
	}
	
	//비밀번호 변경
	@RequestMapping(value="/updatePw.do", method=RequestMethod.POST)
	public String updatePw(HttpSession session, HttpServletRequest request, MembersVO vo, Model model) {
		
		System.out.println("비밀번호 변경 처리");
		
		//로그인 되어있는 아이디
		String members_id = (String)session.getAttribute("members_id");
		
		//기존 비밀번호 입력 값
		String members_pw_use = request.getParameter("members_pw_use");
		
		//새 비밀번호 입력 값
		String members_pw = request.getParameter("members_pw");
		
		System.out.println("members_id = " + members_id);
		System.out.println("members_pw_use = " + members_pw_use);
		System.out.println("members_pw = " + members_pw);
				
		//1. 기존 비밀번호가 일치하는지 확인 (아이디를 통해 비밀번호 일치 여부 확인)
		
		//아이디를 통해 비밀번호를 가져옴
		String members_pw_db = membersService.checkPwById(members_id);
		System.out.println("members_pw_db = " + members_pw_db);		
		
		String msg="";
		String url="";
		
		//일치하지 않을 경우 : 비밀번호 불일치를 알려주고 비밀번호 변경 페이지로 이동
		if(!members_pw_db.equals(members_pw_use)) {
			
			msg = "비밀번호를 확인하세요";
			url = "/members/updatePw.do";
			
		//일치 할 경우	: 새 비밀번호로 변경시키고 회원정보 페이지로 이동
		}else {
			
			vo.setMembers_id(members_id);
			vo.setMembers_pw(members_pw);
			
			int result = membersService.updatePw(vo);
			System.out.println("result = " + result);
			
			msg = "비밀번호 변경 실패";
			url = "/members/updatePw.do";
			
			if(result > 0) {
				msg = "비밀번호가 변경되었습니다";
				url = "/members/infoMembers.do";
			}
			
		}
		
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		
		return "common/message";
	
	}
	
	//회원정보 변경 페이지
	@RequestMapping(value="/updateMembers.do", method=RequestMethod.GET)
	public String updateMembersPage(HttpSession session, Model model) {
		System.out.println("회원정보 변경 페이지");
		
		String members_id = (String)session.getAttribute("members_id");
		MembersVO members = membersService.selectByMembersId(members_id);
		
		model.addAttribute("members", members);
		
		return "members/updateMembers";
	}
	
	@RequestMapping(value="/updateMembers.do", method=RequestMethod.POST)
	public String updateMembers(MembersVO vo, Model model) {
		System.out.println("회원정보 변경 처리");
		
		int cnt = membersService.updateMembers(vo);
		
		String msg="회원정보 변경 실패", url="/members/updateMembers.do";
		
		if(cnt > 0) {
			msg = "회원정보 변경 성공";
			url = "/members/infoMembers.do";
		}
		
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		
		return "common/message";
	}
	
	
	
}