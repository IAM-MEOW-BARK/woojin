package kr.co.dong.controller;

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

@Controller
public class BoardController {
	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);
	
	@Inject
	BoardService boardService;	
	
	@RequestMapping(value="board/login", method = RequestMethod.GET)	
	public String login() {
		logger.info("로그인 성공");
		return "login"; // jsp
	}	

	
	/*
	 * @RequestMapping(value="board/login", method = RequestMethod.POST) public
	 * String login(@RequestParam Map<String,Object> map, HttpServletRequest
	 * request, HttpServletResponse response, HttpSession session) throws Exception
	 * { request.setCharacterEncoding("UTF-8");
	 * 
	 * Map user = boardService.login(map);
	 * 
	 * if(user == null) { logger.info("실패"); return "redirect:login"; //prefix
	 * suffix 이용해서 이동 } else { logger.info("성공"); session.setAttribute("user",
	 * user); return "redirect:/"; // kr.co.dong.HomeController return문(home) } }
	 */	 
	
	@RequestMapping(value="board/logout", method = RequestMethod.GET)
	public String logout(HttpSession session, RedirectAttributes rttr) {
		session.invalidate(); // 세션에 저장되어 있는 정보 삭제
		rttr.addFlashAttribute("msg", "로그아웃 성공"); // 1회성 저장
		return "redirect:/";
	}
	
	/*
	 * @RequestMapping(value="board/list", method = RequestMethod.GET) public
	 * ModelAndView list() { logger.info("����Ʈ ������");
	 * 
	 * ModelAndView mAV = new ModelAndView();
	 * 
	 * List<BoardDTO> list = boardService.list();
	 * 
	 * mAV.addObject("list", list); mAV.setViewName("list"); return mAV; }
	 */
	
	@RequestMapping(value="board/register", method = RequestMethod.GET)
	public String register() {
		logger.info("등록 성공");
		return "register";
	}
	
	@RequestMapping(value="board/register", method = RequestMethod.POST)
	public String register(BoardDTO boardDTO, HttpServletRequest request, RedirectAttributes rttr) throws Exception {
		request.setCharacterEncoding("utf-8");
		
		int r = boardService.register(boardDTO);
		
		if(r > 0) {
			rttr.addFlashAttribute("msg", "등록 성공");
		}
		return "redirect:list";
	}
	
	@RequestMapping(value="board/detail", method = RequestMethod.GET)
	public String detail(@RequestParam("bno") int bno, Model model) {
		BoardDTO boardDTO = boardService.detail(bno);		
		boardService.readCnt(bno);
		model.addAttribute("board", boardDTO);
		
		// ��� ��� ��ȸ
		List<BoardReply> replylist = boardService.replylist(bno);
		model.addAttribute("replylist", replylist);
		
		return "detail";
	}
	
	@RequestMapping(value="board/update", method = RequestMethod.GET)
	public String update(@RequestParam("bno") int bno, Model model) {
		BoardDTO boardDTO = boardService.detail(bno);
		model.addAttribute("board", boardDTO);	
		return "update";
	}
	
	@RequestMapping(value="board/update", method = RequestMethod.POST)
	public String update(BoardDTO boardDTO, HttpServletRequest request) throws Exception {
		request.setCharacterEncoding("UTF-8");
		
		int r = boardService.update(boardDTO);
		
		return "redirect:list";
	}
	
	@RequestMapping(value="board/delete", method = RequestMethod.GET)
	public String delete(@RequestParam("bno") int bno) {
		int r = boardService.delete(bno);
		
		return "redirect:list";
	}
	
	@RequestMapping(value="board/reply", method = RequestMethod.GET)
	public String reply() { return "reply"; }
	
	@RequestMapping(value="board/reply", method = RequestMethod.POST)
	public String reply(BoardReply boardReply) {
		int r = boardService.reply(boardReply);
		
		if (r > 0) {
			return "redirect:detail?bno=" + boardReply.getBno();
		}
		
		return "reply";
	}
	
	/*
	 *  ���
	 * */
	
	@ResponseBody
	@RequestMapping(value="board/replylist", method = RequestMethod.POST)
	public List<BoardReply> replylist(@RequestParam("bno")int bno){
		return boardService.replylist(bno);
	}	
	
	@RequestMapping(value="board/reply2", method = RequestMethod.POST)
	public int reply2(BoardReply boardReply) {
		return boardService.reply(boardReply);
	}
	
  @ResponseBody
  @RequestMapping(value="board/replyupdate2", method = RequestMethod.POST)
	  public int replyupdate2(BoardReply boardReply) {
		  int r = 0;
		  try {
			  r = boardService.replyUpdate(boardReply);
		  } catch (Exception e) {
			  e.printStackTrace();
		  }		  
		  return r;
	  }
  
  @ResponseBody
  @RequestMapping(value="board/replydelete2", method = RequestMethod.POST)
  public int replydelete2(@RequestParam("reno") int reno) {
		int r = boardService.replydelete(reno);
		
		return r;
	}
  
  public static int pageSIZE = 10; // 한페이지에 보여줄 레코드 수
  public static int totalRecord = 0; // 가져올 레코드 수 초기값 
  public static int totalPage = 1; // 페이지 수 초기값
  public static int blockSize = 10; // 페이지 개수
  
  @RequestMapping
  (value="board/list", method = RequestMethod.GET)
  public ModelAndView list(@RequestParam(value="pageNUM", defaultValue="1") int pageNUM) {
	  
       totalRecord = boardService.totalRecord();
       totalPage = totalRecord / pageSIZE;
      
      if(totalRecord % pageSIZE != 0) {
    	  totalPage++;
      }
      
      int start = (pageNUM - 1) * pageSIZE + 1;
      int end = start + pageSIZE - 1;      
      
      ModelAndView mAV = new ModelAndView();
      mAV.addObject("list", boardService.pagingList(start, end));
      mAV.addObject("totalPage", totalPage);      
      mAV.setViewName("list"); 
      
      return mAV;
  }
  
  // 게시물 목록 컨트롤러
//  @RequestMapping(value ="board/list", method = RequestMethod.GET)
//  public String listView(Model model, Criteria cri) throws Exception{
//      logger.info("list");
//      List<BoardDTO> vo = boardService.list(scri);
//      model.addAttribute("list", vo);
//      model.addAttribute("cri", cri);
//      PagingFunction.setCri(cri);
//      PagingFunction.setTotalCount(boardService.listCount(scri));
//      model.addAttribute("pagingFunction", PagingFunction);
//
//      return "board/list";
//  }
}
