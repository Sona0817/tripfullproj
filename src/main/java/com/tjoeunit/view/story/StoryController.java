package com.tjoeunit.view.story;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.tjoeunit.biz.common.PagingVO;
import com.tjoeunit.biz.story.StoryService;
import com.tjoeunit.biz.story.StoryVO;

@Controller
@RequestMapping("/story")
public class StoryController {
	
	@Autowired
	private StoryService storyService;

// 글 등록 페이지 불러오기
	@RequestMapping(value="/insertStoryPage.do", method=RequestMethod.GET)
	public String insertStoryPage() throws IOException {
		System.out.println("여행 이야기 등록 페이지 호출");
		return null;
	}

	
// 글 등록
	@RequestMapping(value="/insertStory.do", method=RequestMethod.POST)
	public String insertStory(StoryVO vo, Model model) throws Exception {
		System.out.println("여행이야기 등록 처리");

		int cnt = storyService.insertStory(vo);
		
		String msg="여행 이야기 등록 실패", url="/story/insertStoryPage.do";

		if(cnt>0) {
			msg="등록되었습니다.";
			url="/story/getStoryList.do";
		}

		model.addAttribute("msg", msg);
		model.addAttribute("url", url);

		return "common/message";
	}

	
// 글 수정 페이지 불러오기
	@RequestMapping(value="/updateStoryPage.do", method=RequestMethod.GET)
	public String updateStoryPage(StoryVO vo, Model model) throws IOException {
		
		System.out.println("여행 이야기 수정 페이지 호출");
		StoryVO story = storyService.getStory(vo);
		
		model.addAttribute("story", story);
		return null;
	}

	
// 글 수정
	@RequestMapping("/updateStory.do")
	
	public String updateStory(StoryVO vo, Model model) throws Exception {
		
		System.out.println("여행 이야기 수정 처리");

		int cnt = storyService.updateStory(vo);
		
		String msg="수정 실패", url="/story/updateStoryPage.do";

		if(cnt>0) {
			msg="수정되었습니다.";
			url="/story/getStory.do?story_no="+vo.getStory_no();
		}

		model.addAttribute("msg", msg);
		model.addAttribute("url", url);

		return "common/message";
	}
	
// 글 삭제
	@RequestMapping("/deleteStory.do")
	public String deleteStory(StoryVO vo, Model model) throws Exception {
		System.out.println("여행 이야기 삭제 기능 처리");
		
		storyService.deleteStory(vo);
		
		String msg="삭제되었습니다.";
		String url="/story/getStoryList.do";
		
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);

		return "common/message";
	}
	

	
/* 글 목록 보기 : 페이징 처리 전
	@RequestMapping(value="/getStoryList.do",  method = RequestMethod.GET)
	public String getStoryList(StoryVO vo, Model model) {	//ModelAndView의 Model 딴에 있는 변수를 매개변수로

		List<StoryVO> storyList = storyService.getStoryList(vo);
				
		model.addAttribute("storyList", storyList);		//key Value
		
		System.out.println("여행 이야기 목록 보기");
		return "story/getStoryList";

	}
*/
	
// 글 목록 보기 : 페이징 처리 후
	@RequestMapping(value="/getStoryList.do", method = RequestMethod.GET)
	public String storyListPaging(PagingVO vo, Model model,
			@RequestParam(value="nowPage", required=false) String nowPage,
			@RequestParam(value="cntPerPage", required=false) String cntPerPage) {
		
		int total = storyService.countStory();
		if (nowPage == null && cntPerPage == null) {
			nowPage = "1";
			cntPerPage = "5";
		} else if (nowPage == null) {
			nowPage = "1";
		} else if (cntPerPage == null) { 
			cntPerPage = "5";
		}
		
		vo = new PagingVO(total, Integer.parseInt(nowPage), Integer.parseInt(cntPerPage));
		model.addAttribute("paging", vo);
		model.addAttribute("storyList", storyService.selectStory(vo));
		return "story/getStoryList";
	}		
	

// 글 상세 조회
	@RequestMapping(value="/getStory.do",  method = RequestMethod.GET)
	public String getStory(StoryVO vo, Model model) {
		System.out.println("여행 이야기 상세 조회 처리");
		
		storyService.viewCountStory(vo);
		
		StoryVO story = storyService.getStory(vo);
		
		model.addAttribute("story", story);
		
		return "story/getStory";
	}
}
