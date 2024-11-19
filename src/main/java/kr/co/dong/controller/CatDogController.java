package kr.co.dong.controller;

import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.co.dong.board.BoardDTO;
import kr.co.dong.board.BoardReply;
import kr.co.dong.board.BoardService;
import kr.co.dong.catdog.CatDogService;
import kr.co.dong.catdog.MemberDTO;

@Controller
public class CatDogController {
	private static final Logger logger = LoggerFactory.getLogger(CatDogController.class);
		
	@Inject
	CatDogService catDogService;  
	
	@GetMapping(value="/catdog-term")
	public String catdogTerm(){
		return "catdog-term";
	}
	
	@GetMapping(value="/catdog-add-product-admin")
	public String catdogAddProductAdmin(){
		return "catdog-add-product-admin";
	}
	
	@GetMapping(value="/catdog-product-list-admin")
	public String catdogProductListAdmin(){
		return "catdog-product-list-admin";
	}
	
	@GetMapping(value="/catdog-login")
	public String catdogLogin(){
		return "catdog-login";
	}
	
	@RequestMapping(value="/catdog-login", method = RequestMethod.POST)
	public String login(@RequestParam Map<String,Object> map, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		request.setCharacterEncoding("UTF-8");
		
		Map user = catDogService.login(map);
		
		if(user == null) {
			logger.info("실패");
			return "redirect:catdog-login"; //prefix suffix 이용해서 이동
		} else {
			logger.info("성공");
			session.setAttribute("user", user);
			return "redirect:/"; // kr.co.dong.HomeController return문(home)
		}
	}
	
	@GetMapping(value="/catdog-user-list-admin")
	public String catdogUserListAdmin(){
		return "catdog-user-list-admin";
	}
	
	@GetMapping(value="/catdog-add-user-admin")
	public String catdogAddUserAdmin(){
		return "catdog-add-user-admin";
	}
	
	@GetMapping(value="/catdog-find-id")
	public String catdogFindId(){
		return "catdog-find-id";
	}
	
	@GetMapping(value="/catdog-find-pw")
	public String catdogFindPw(){
		return "catdog-find-pw";
	}
	
	@GetMapping(value="/catdog-main")
	public String catDogMain(){
		return "catdog-main";
	}
	
	@GetMapping(value="/catdog-payment")
	public String catDogPayment(){
		return "catdog-payment";
	}
	
	
	
	
	// 회원가입
	@GetMapping(value="/catdog-signup")
	public String catdogSignup(){
		return "catdog-signup";
	}
	
	// 회원가입
	@PostMapping(value="/catdog-signup")
	public String signup(MemberDTO member, HttpServletRequest request, RedirectAttributes rttr) throws Exception {
		request.setCharacterEncoding("utf-8");
		
		int r = catDogService.create(member);
		
		return "redirect:/";
	}
	
//	@RequestMapping(value="board/logout", method = RequestMethod.GET)
//	public String logout(HttpSession session, RedirectAttributes rttr) {
//		session.invalidate(); // 세션에 저장되어 있는 정보 삭제
//		rttr.addFlashAttribute("msg", "로그아웃 성공"); // 1회성 저장
//		return "redirect:/";
//	}
//	
//	
//	@RequestMapping(value="board/register", method = RequestMethod.GET)
//	public String register() {
//		logger.info("등록 성공");
//		return "register";
//	}
}
