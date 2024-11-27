package kr.co.dong.controller;


import java.io.File;
import java.io.FileOutputStream;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Cookie;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.co.dong.board.BoardDTO;
import kr.co.dong.board.BoardService;
import kr.co.dong.catdog.CatDogService;
import kr.co.dong.catdog.MemberDTO;
import kr.co.dong.catdog.ProductDTO;

@Controller
public class CatDogController {
	private static final Logger logger = LoggerFactory.getLogger(CatDogController.class);

	@Inject
	CatDogService catDogService;

	@GetMapping(value = "/catdog-term")
	public String catdogTerm() {
		return "catdog-term";
	}

	@GetMapping(value = "/catdog-add-product-admin")
	public String catdogAddProductAdmin() {
		return "catdog-add-product-admin";
	}
	
	// 상품 단일 선택 수정 페이지
	@GetMapping(value="catdog-product-modify")
	public String getProductByCode(@RequestParam("product_code") int product_code, Model model) {
		ProductDTO productDTO = catDogService.getProductByCode(product_code);
		model.addAttribute("product", productDTO);
		
		return "catdog-product-modify";
	}
	
	// 상품 수정
	@PostMapping(value = "catdog-product-modified")
	public String update(ProductDTO productDTO, @RequestParam("thumbnail_imgFile") MultipartFile file, HttpServletRequest request) throws Exception {
	    request.setCharacterEncoding("UTF-8");

	    if (!file.isEmpty()) {
	    	// 파일 업로드 경로
		    String loc = "C:\\WEB_WORKSPACE\\status200\\src\\main\\webapp\\resources\\upload";
		    File dir = new File(loc);
		    if (!dir.exists()) {
		        dir.mkdirs(); // 디렉터리가 없으면 생성
		    }

		 // 파일 저장		    
		    if (file != null && !file.isEmpty()) {
		        String safeFileName = file.getOriginalFilename().replaceAll("[^a-zA-Z0-9._-]", "_");
		        File uploadedFile = new File(loc, safeFileName);
		        file.transferTo(uploadedFile); // 파일 저장

		        // 파일 저장 완료 확인
		        while (!uploadedFile.exists()) {
		            Thread.sleep(100); // 디스크 반영 대기
		        }

		        productDTO.setThumbnail_img(safeFileName); // 저장된 파일 이름 설정
		    } else {
		        System.out.println("파일이 업로드되지 않았습니다.");
		    }
	    } else {
	        // 이미지 파일이 없으면 기존 이미지 유지
	        ProductDTO existingProduct = catDogService.getProductByCode(productDTO.getProduct_code());
	        productDTO.setThumbnail_img(existingProduct.getThumbnail_img());
	    }

	    int r = catDogService.updateProduct(productDTO);

	    return "redirect:catdog-product-list-admin";
	}
	
	// 상품 삭제
	@PostMapping(value="catdog/deleteProduct")
	public String deleteProduct(@RequestParam("selectedCode") String selectedCode) {
		// 쉼표로 구분된 ID 문자열을 List로 변환
		List<String> productCode = Arrays.asList(selectedCode.split(","));

		// Service 호출
		catDogService.deleteProduct(productCode);

		return "redirect:/catdog-product-list-admin";			
	}	
	
	// 상품 등록
	@PostMapping("/catdog-add-product")
	public String catDogAddProduct(@ModelAttribute ProductDTO productDTO, HttpServletRequest request) throws Exception {
	    request.setCharacterEncoding("UTF-8");

	    // 파일 업로드 경로
	    String loc = "C:\\WEB_WORKSPACE\\status200\\src\\main\\webapp\\resources\\upload";
	    File dir = new File(loc);
	    if (!dir.exists()) {
	        dir.mkdirs(); // 디렉터리가 없으면 생성
	    }

	 // 파일 저장
	    MultipartFile file = productDTO.getThumbnail_imgFile();
	    if (file != null && !file.isEmpty()) {
	        String safeFileName = file.getOriginalFilename().replaceAll("[^a-zA-Z0-9._-]", "_");
	        File uploadedFile = new File(loc, safeFileName);
	        file.transferTo(uploadedFile); // 파일 저장

	        // 파일 저장 완료 확인
	        while (!uploadedFile.exists()) {
	            Thread.sleep(100); // 디스크 반영 대기
	        }

	        productDTO.setThumbnail_img(safeFileName); // 저장된 파일 이름 설정
	    } else {
	        System.out.println("파일이 업로드되지 않았습니다.");
	    }

	    // 서비스 호출
	    int result = catDogService.addProduct(productDTO);
	    System.out.println(productDTO);

	    return "redirect:/catdog-product-list-admin";
	}
	
	// 상품 목록 + 페이징
	@GetMapping("/catdog-product-list-admin")
	public ModelAndView productList(HttpServletResponse response,
		@RequestParam(value = "pageNum", defaultValue = "1") int pageNum,
        @RequestParam(value = "pageListNum", defaultValue = "1") int pageListNum) {
	    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
	    response.setHeader("Pragma", "no-cache");
	    response.setDateHeader("Expires", 0);
	    
	    int pageSize = 10; // 한 페이지당 게시글 수
	    int pageListSize = 10; // 한 번에 표시할 페이지 수
	    
	    // 전체 게시글 수
	    int totalList = catDogService.productPaging();
	    int totalPage = (int) Math.ceil((double) totalList / pageSize);
	    
	    // 현재 페이지에서 가져올 데이터의 시작 인덱스 계산
	    int start = (pageNum - 1) * pageSize;
	    
	    // 현재 페이지 번호 목록의 시작과 끝
	    int startPage = (pageListNum - 1) * pageListSize + 1;
	    int endPage = Math.min(startPage + pageListSize - 1, totalPage);

	    ModelAndView mAV = new ModelAndView();	    
	    List<ProductDTO> productList = catDogService.getTotalProduct(start, pageSize);	    
	    mAV.addObject("totalPage", totalPage); // 전체 페이지 수
	    mAV.addObject("currentPage", pageNum); // 현재 페이지 번호
		mAV.addObject("productList", productList); 
	    mAV.addObject("pageListNum", pageListNum);
	    mAV.addObject("startPage", startPage); // 페이지 네비게이션 시작
	    mAV.addObject("endPage", endPage); // 페이지 네비게이션 끝
	    mAV.setViewName("catdog-product-list-admin");
		
	    return mAV;
	}

	@GetMapping(value = "/catdog-login")
	public String catdogLogin() {
		return "catdog-login";
	}

	@PostMapping(value = "member/emailCheck")
	@ResponseBody
	public int emailCheck(@RequestParam("user_id") String user_id) throws Exception {
		return catDogService.getMemberByEmail(user_id);
	}
	
	// 아이디 찾기
	@PostMapping(value = "/catdog-findId")
	public String findId(@RequestParam Map<String, Object> map, Model model, HttpServletRequest request) throws Exception {
	    request.setCharacterEncoding("UTF-8");

	    // 이름과 전화번호로 DB 조회
	    Map info = catDogService.findId(map);

	    if (info == null || !info.containsKey("user_id")) {
	        // 검색 결과 없음
	        logger.info("아이디 없음");
	        model.addAttribute("error", "아이디가 존재하지 않습니다."); // 에러 메시지 추가
	    } else {
	        // 검색 결과 있음
	        logger.info("아이디 찾기 성공");
	        model.addAttribute("user_id", info.get("user_id")); // user_id만 전달
	    }

	    return "catdog-find-id"; // JSP 페이지 이름
	}
	
	// 비밀번호 찾기
		@PostMapping(value = "/catdog-findPw")
		public String findPw(@RequestParam Map<String, Object> map, Model model, HttpServletRequest request) throws Exception {
		    request.setCharacterEncoding("UTF-8");

		    // 이름과 전화번호로 DB 조회
		    Map info = catDogService.findPw(map);

		    if (info == null || !info.containsKey("password")) {
		        // 검색 결과 없음
		        logger.info("아이디 없음");
		        model.addAttribute("error", "아이디가 존재하지 않습니다."); // 에러 메시지 추가
		    } else {
		        // 검색 결과 있음
		        logger.info("아이디 찾기 성공");
		        model.addAttribute("password", info.get("password")); // user_id만 전달
		    }

		    return "catdog-find-pw"; // JSP 페이지 이름
		}

	// 로그인
	@RequestMapping(value = "/catdog-login", method = RequestMethod.POST)
	public String login(@RequestParam Map<String, Object> map, HttpServletRequest request, HttpServletResponse response,
			HttpSession session) throws Exception {
		request.setCharacterEncoding("UTF-8");

		Map user = catDogService.login(map);
		
		Integer userStatus = (Integer) user.get("user_status");
		
		if (user == null || userStatus == 1) {
			logger.info("실패");
			return "redirect:catdog-login"; // prefix suffix 이용해서 이동
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
	
	// 로그아웃
	@GetMapping(value = "/catdog-logout")
	public String logout(HttpServletRequest request, HttpServletResponse response, HttpSession session, RedirectAttributes rttr) {
	    // 1. 세션 무효화
	    if (session != null) {
	        session.invalidate(); // 서버 세션 삭제
	    }

	    // 2. 클라이언트 JSESSIONID 쿠키 삭제
	    // 직접 Set-Cookie 헤더를 통해 HttpOnly 포함
	    Cookie cookie = new Cookie("JSESSIONID", null); // 쿠키 값 null
	    cookie.setPath("/"); // 경로 설정
	    cookie.setMaxAge(0); // 즉시 만료
	    response.addCookie(cookie); // 기본 쿠키 설정 추가
	    
	    // HttpOnly 속성을 명시적으로 추가
	    response.addHeader("Set-Cookie", "JSESSIONID=; Path=/; HttpOnly; Max-Age=0");

	    // 3. 로그아웃 메시지 추가
	    rttr.addFlashAttribute("msg", "로그아웃 성공"); // 사용자 알림 메시지 추가

	    // 4. 홈으로 리다이렉트
	    return "redirect:/";
	}

	// 관리자 회원 목록 + 페이징
	@GetMapping(value = "/catdog-user-list-admin")
	public ModelAndView list(
			@RequestParam(value = "pageNum", defaultValue = "1") int pageNum,
            @RequestParam(value = "pageListNum", defaultValue = "1") int pageListNum) {
		
		int pageSize = 10; // 한 페이지당 게시글 수
	    int pageListSize = 10; // 한 번에 표시할 페이지 수
	    
	    // 전체 게시글 수
	    int totalList = catDogService.memberPaging();
	    int totalPage = (int) Math.ceil((double) totalList / pageSize);
	    
	    // 현재 페이지에서 가져올 데이터의 시작 인덱스 계산
	    int start = (pageNum - 1) * pageSize;
	    
	    // 현재 페이지 번호 목록의 시작과 끝
	    int startPage = (pageListNum - 1) * pageListSize + 1;
	    int endPage = Math.min(startPage + pageListSize - 1, totalPage);
	    
		ModelAndView mAV = new ModelAndView();
		List<MemberDTO> list = catDogService.getTotalMember(start, pageSize);
		mAV.addObject("memberList", list);
		mAV.addObject("totalPage", totalPage); // 전체 페이지 수
	    mAV.addObject("currentPage", pageNum); // 현재 페이지 번호
	    mAV.addObject("pageListNum", pageListNum);
	    mAV.addObject("startPage", startPage); // 페이지 네비게이션 시작
	    mAV.addObject("endPage", endPage); // 페이지 네비게이션 끝
	    mAV.setViewName("catdog-user-list-admin");
		
		return mAV;
	}

	// 회원 탈퇴 관리자
	@PostMapping(value = "catdog/deleteUsers")
	public String deleteUsers(@RequestParam("selectedIds") String selectedIds) {
		// 쉼표로 구분된 ID 문자열을 List로 변환
		List<String> userIds = Arrays.asList(selectedIds.split(","));

		// Service 호출
		catDogService.deleteUsers(userIds);

		return "redirect:/catdog-user-list-admin";
	}

	@GetMapping(value = "/catdog-add-user-admin")
	public String catdogAddUserAdmin() {
		return "catdog-add-user-admin";
	}

	@GetMapping(value = "/catdog-find-id")
	public String catdogFindId() {
		return "catdog-find-id";
	}

	@GetMapping(value = "/catdog-find-pw")
	public String catdogFindPw() {
		return "catdog-find-pw";
	}

	@GetMapping(value = "/catdog-main")
	public String catDogMain() {
		return "catdog-main";
	}

	@GetMapping(value = "/catdog-payment")
	public String catDogPayment() {
		return "catdog-payment";
	}
	
	@GetMapping(value="/catdog-signup")
	public String catDogSignUp() {
		return "catdog-signup";
	}

	// 일반 유저 회원가입
	@PostMapping(value = "/catdog-signup")
	public String signup(MemberDTO member, HttpServletRequest request, RedirectAttributes rttr) throws Exception {
		request.setCharacterEncoding("utf-8");

		int r = catDogService.create(member);

		return "redirect:/";
	}

	// 관리자 회원가입
	@PostMapping(value = "/catdog-add-user-admin")
	public String adminSignup(MemberDTO member, HttpServletRequest request, RedirectAttributes rttr) throws Exception {
		request.setCharacterEncoding("utf-8");

		int r = catDogService.create(member);

		return "redirect:/catdog-user-list-admin";
	}

	// 회원 리스트 검색 필터
	@PostMapping("/searchMember")
	public String searchMember(
			@RequestParam("searchType") String searchType,
			@RequestParam("searchKeyword") String searchKeyword,
			@RequestParam(value = "startDate", required = false) String startDate,
			@RequestParam(value = "endDate", required = false) String endDate, Model model) {
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
	
	// 상품 리스트 검색 필터
	@PostMapping("/searchProduct")
	public String searchProduct(
			@RequestParam("searchType") String searchType,
			@RequestParam("searchKeyword") String searchKeyword,
			@RequestParam(value = "startDate", required = false) String startDate,
			@RequestParam(value = "endDate", required = false) String endDate, Model model) {
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

		List<Map<String, Object>> products = catDogService.searchProduct(searchType, searchKeyword, startDate, endDate);
		model.addAttribute("productList", products);
		return "catdog-product-list-admin"; // JSP 경로
	}
}
