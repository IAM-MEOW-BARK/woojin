package kr.co.dong.controller;

import java.util.Arrays;
import java.util.List;
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
	
	/*
	 * @PostMapping(value="member/emailCheck") public int emailCheck(String user_id)
	 * throws Exception { return catDogService.getMemberByEmail(user_id); }
	 */
	
	@PostMapping(value="member/emailCheck")
	@ResponseBody
	public int emailCheck(@RequestParam("user_id") String user_id) throws Exception {
	    return catDogService.getMemberByEmail(user_id);
	}
	
	// 로그인
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

	        Integer userAuth = (Integer) user.get("user_auth");

	        if (userAuth == 1) {
	            logger.info("관리자 계정으로 로그인");
	            return "redirect:/catdog-user-list-admin";
	        } else if (userAuth == 0) {
	            logger.info("일반 사용자 계정으로 로그인");
	            return "redirect:/catdog-main";
	        } else {
	            logger.warn("알 수 없는 USER_AUTH 값: " + userAuth);
	            return "redirect:/catdog-login";
	        }
		}
	}	
	
	// 관리자 회원 목록
	@GetMapping(value="/catdog-user-list-admin")
	public ModelAndView list() {
	    ModelAndView mAV = new ModelAndView();

	    List<MemberDTO> list = catDogService.getTotalMember();

	    mAV.addObject("memberList", list); 
	    mAV.setViewName("catdog-user-list-admin"); 
	    return mAV; 
	}
	
	/*
	 * @PostMapping(value="catdog/deleteUser") public String
	 * deleteUser(@RequestParam("id") String user_id) { int r =
	 * catDogService.deleteUser(user_id);
	 * 
	 * return "redirect:catdog-user-list-admin"; }
	 */
	
	// 회원 탈퇴 관리자
	@PostMapping(value = "catdog/deleteUsers")
	public String deleteUsers(@RequestParam("selectedIds") String selectedIds) {
	    // 쉼표로 구분된 ID 문자열을 List로 변환
	    List<String> userIds = Arrays.asList(selectedIds.split(","));
	    
	    // Service 호출
	    catDogService.deleteUsers(userIds);

	    return "redirect:/catdog-user-list-admin";
	}
	
	/*
	 * @RequestMapping(value="/catdog-user-list-admin", method = RequestMethod.GET)
	 * public ModelAndView list() { ModelAndView mAV = new ModelAndView();
	 * 
	 * List<MemberDTO> list = catDogService.getTotalMember();
	 * 
	 * mAV.addObject("list-admin", list); mAV.setViewName("list-admin"); return mAV;
	 * }
	 */
	
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
	
	// 일반 유저 회원가입
	@PostMapping(value="/catdog-signup")
	public String signup(MemberDTO member, HttpServletRequest request, RedirectAttributes rttr) throws Exception {
		request.setCharacterEncoding("utf-8");
		
		int r = catDogService.create(member);
		
		return "redirect:/";
	}
	
	// 관리자 회원가입
	@PostMapping(value="/catdog-add-user-admin")
	public String adminSignup(MemberDTO member, HttpServletRequest request, RedirectAttributes rttr) throws Exception {
		request.setCharacterEncoding("utf-8");
		
		int r = catDogService.create(member);
		
		return "redirect:/catdog-user-list-admin";
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
	
	// 회원 리스트 검색 필터
	 @PostMapping("/searchMember")
	    public String searchMember(@RequestParam("searchType") String searchType,
	                               @RequestParam("searchKeyword") String searchKeyword,
	                               @RequestParam(value = "startDate", required = false) String startDate,
	                               @RequestParam(value = "endDate", required = false) String endDate,
	                               Model model) {
		 	if (startDate != null && endDate != null && startDate.compareTo(endDate) > 0) {
			    // startDate가 endDate보다 클 경우 스왑
			    String temp = startDate;
			    startDate = endDate;
			    endDate = temp;
			}
		 	
		 	if (searchKeyword == null || searchKeyword.trim().isEmpty()) {
		 	    searchKeyword = null; // Mapper에서 처리
		 	}
		 	if (startDate != null && !startDate.isEmpty()) {
		 	    startDate += " 00:00:00";
		 	}
		 	if (endDate != null && !endDate.isEmpty()) {
		 	    endDate += " 23:59:59";
		 	}
		 	if (startDate != null && endDate != null && startDate.compareTo(endDate) > 0) {
		 	    String temp = startDate;
		 	    startDate = endDate;
		 	    endDate = temp;
		 	}
		    
		    System.out.println("searchType: " + searchType);
		    System.out.println("searchKeyword: " + searchKeyword);
		    System.out.println("startDate: " + startDate);
		    System.out.println("endDate: " + endDate);
		    
	        List<Map<String, Object>> members = catDogService.searchMember(searchType, searchKeyword, startDate, endDate);
	        model.addAttribute("memberList", members);
	        return "catdog-user-list-admin"; // JSP 경로
	    }
}
