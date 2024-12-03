package kr.co.dong.controller;


import java.io.BufferedReader;
import java.io.File;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import kr.co.dong.catdog.CartDTO;
import kr.co.dong.catdog.CatDogService;
import kr.co.dong.catdog.MemberDTO;
import kr.co.dong.catdog.MyDTO;
import kr.co.dong.catdog.OrderDTO;
import kr.co.dong.catdog.OrderItemDTO;
import kr.co.dong.catdog.PaymentDTO;
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
	
	// 상품 코드 중복 체크
	@PostMapping(value = "product/checkProductCode")
	@ResponseBody
	public int checkCode(@RequestParam("product_code") int product_code) throws Exception {
		return catDogService.checkProductCode(product_code);
	}
	
	// 상품 등록
	@PostMapping("/catdog-add-product")
	public String catDogAddProduct(@ModelAttribute ProductDTO productDTO, HttpServletRequest request, HttpSession session) throws Exception {
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
	    
		
		  // 상세 이미지 파일 저장 
	      MultipartFile productFile = productDTO.getProduct_imgFile();
		  if (productFile != null && !productFile.isEmpty()) { String
		  safeDetailFileName =
		  productFile.getOriginalFilename().replaceAll("[^a-zA-Z0-9._-]", "_"); File
		  uploadedDetailFile = new File(loc, safeDetailFileName);
		  productFile.transferTo(uploadedDetailFile);
		  
		  // 상세 이미지 파일 저장 확인 while (!uploadedDetailFile.exists()) { Thread.sleep(100);
		  // 디스크 반영 대기 }
		  
		  productDTO.setProduct_img(safeDetailFileName); // 상세 이미지 파일 이름 설정 } else {
		  System.out.println("상세 이미지 파일이 업로드되지 않았습니다."); }

	    // 서비스 호출
	    int result = catDogService.addProduct(productDTO);
	    System.out.println(productDTO);
	    
	    // 성공 메시지 설정
	    if (result > 0) {
	    	 session.setAttribute("successMessage", "상품 등록 완료!");
	    } else {
	    	session.setAttribute("errorMessage", "상품 등록 실패. 다시 시도하세요.");
	    }

	    return "redirect:/catdog-add-product-admin";
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
	
	// 상품 목록 + 페이징
		@GetMapping("/catdog-product-test")
		public ModelAndView productTestList(HttpServletResponse response,
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
		    List<ProductDTO> productTestList = catDogService.getTotalProduct(start, pageSize);	    
		    mAV.addObject("totalPage", totalPage); // 전체 페이지 수
		    mAV.addObject("currentPage", pageNum); // 현재 페이지 번호
			mAV.addObject("productTestList", productTestList); 
		    mAV.addObject("pageListNum", pageListNum);
		    mAV.addObject("startPage", startPage); // 페이지 네비게이션 시작
		    mAV.addObject("endPage", endPage); // 페이지 네비게이션 끝
		    mAV.setViewName("catdog-product-test");
			
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
		@PostMapping(value = "/catdog-login")
		public String login(@RequestParam Map<String, Object> map, HttpServletRequest request, HttpServletResponse response,
		                    HttpSession session, Model model) throws Exception {
		    request.setCharacterEncoding("UTF-8");

		    Map user = catDogService.login(map);

		    if (user == null) {
		        logger.info("로그인 실패: 유효하지 않은 사용자");
		        return "redirect:/catdog-login"; // prefix suffix 이용해서 이동
		    }

		    Integer userStatus = (Integer) user.get("user_status"); 

		    if (userStatus == 1) {
		        logger.info("로그인 실패: 비활성화된 사용자");
		        return "redirect:/catdog-login";
		    }

		    logger.info("로그인 성공: " + user);
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
	
	/*
	 * @GetMapping(value="/catdog-payment") public String catDogPayment
	 * (@RequestParam("user_id") String user_id, Model model) throws Exception {
	 * List<PaymentDTO> p = catDogService.productPayment(user_id);
	 * model.addAttribute("p", p);
	 * 
	 * int t = catDogService.getTotalCost(user_id);
	 * 
	 * return "catdog-payment"; }
	 */
	
	// 일반 유저 회원가입
	@GetMapping(value="/catdog-signup")
	public String catDogSignUp() {
		return "catdog-signup";
	}
	
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
	public ModelAndView searchMember(
	        @RequestParam(value = "searchType", required = false) String searchType,
	        @RequestParam(value = "searchKeyword", required = false) String searchKeyword,
	        @RequestParam(value = "startDate", required = false) String startDate,
	        @RequestParam(value = "endDate", required = false) String endDate,
	        @RequestParam(value = "pageNum", defaultValue = "1") int pageNum,
	        @RequestParam(value = "pageListNum", defaultValue = "1") int pageListNum) {
	    
		// 날짜 검증 및 변환
	    if (startDate != null && endDate != null && startDate.compareTo(endDate) > 0) {
	        String temp = startDate;
	        startDate = endDate;
	        endDate = temp;
	    }
	    if (startDate != null && !startDate.isEmpty()) {
	        startDate += " 00:00:00";
	    }
	    if (endDate != null && !endDate.isEmpty()) {
	        endDate += " 23:59:59";
	    }
	    if (searchKeyword != null && searchKeyword.trim().isEmpty()) {
	        searchKeyword = null;
	    }

	    // 페이징 계산
	    int pageSize = 10; // 한 페이지당 게시글 수
	    int pageListSize = 10; // 한 번에 표시할 페이지 수
	    int totalList = catDogService.getFilteredMemberCount(searchType, searchKeyword, startDate, endDate);
	    int totalPage = (int) Math.ceil((double) totalList / pageSize);
	    int start = (pageNum - 1) * pageSize;
	    int startPage = (pageListNum - 1) * pageListSize + 1;
	    int endPage = Math.min(startPage + pageListSize - 1, totalPage);

	    // 검색 조건에 맞는 회원 리스트 가져오기
	    List<MemberDTO> members = catDogService.searchMemberWithPaging(searchType, searchKeyword, startDate, endDate, start, pageSize);

	    // ModelAndView로 데이터 전달
	    ModelAndView mAV = new ModelAndView();
	    mAV.addObject("memberList", members);
	    mAV.addObject("totalPage", totalPage);
	    mAV.addObject("currentPage", pageNum);
	    mAV.addObject("pageListNum", pageListNum);
	    mAV.addObject("startPage", startPage);
	    mAV.addObject("endPage", endPage);
	    mAV.addObject("searchType", searchType);
	    mAV.addObject("searchKeyword", searchKeyword);
	    mAV.addObject("startDate", startDate);
	    mAV.addObject("endDate", endDate);
	    mAV.setViewName("catdog-user-list-admin");
	    return mAV;
	}	
	
	// 상품 리스트 검색 필터
		@PostMapping("/searchProduct")
		public ModelAndView searchProduct(
		        @RequestParam(value = "searchType", required = false) String searchType,
		        @RequestParam(value = "searchKeyword", required = false) String searchKeyword,
		        @RequestParam(value = "startDate", required = false) String startDate,
		        @RequestParam(value = "endDate", required = false) String endDate,
		        @RequestParam(value = "pageNum", defaultValue = "1") int pageNum,
		        @RequestParam(value = "pageListNum", defaultValue = "1") int pageListNum) {
		    
		    // 날짜 검증 및 변환
		    if (startDate != null && endDate != null && startDate.compareTo(endDate) > 0) {
		        String temp = startDate;
		        startDate = endDate;
		        endDate = temp;
		    }
		    if (startDate != null && !startDate.isEmpty()) {
		        startDate += " 00:00:00";
		    }
		    if (endDate != null && !endDate.isEmpty()) {
		        endDate += " 23:59:59";
		    }
		    if (searchKeyword != null && searchKeyword.trim().isEmpty()) {
		        searchKeyword = null;
		    }

		    // 페이징 계산
		    int pageSize = 10; // 한 페이지당 게시글 수
		    int pageListSize = 10; // 한 번에 표시할 페이지 수
		    int totalList = catDogService.getFilteredProductCount(searchType, searchKeyword, startDate, endDate);
		    int totalPage = (int) Math.ceil((double) totalList / pageSize);
		    int start = (pageNum - 1) * pageSize;
		    int startPage = (pageListNum - 1) * pageListSize + 1;
		    int endPage = Math.min(startPage + pageListSize - 1, totalPage);

		    // 검색 조건에 맞는 회원 리스트 가져오기
		    List<ProductDTO> products = catDogService.searchProductWithPaging(searchType, searchKeyword, startDate, endDate, start, pageSize);

		    // ModelAndView로 데이터 전달
		    ModelAndView mAV = new ModelAndView();
		    mAV.addObject("productList", products);
		    mAV.addObject("totalPage", totalPage);
		    mAV.addObject("currentPage", pageNum);
		    mAV.addObject("pageListNum", pageListNum);
		    mAV.addObject("startPage", startPage);
		    mAV.addObject("endPage", endPage);
		    mAV.addObject("searchType", searchType);
		    mAV.addObject("searchKeyword", searchKeyword);
		    mAV.addObject("startDate", startDate);
		    mAV.addObject("endDate", endDate);
		    mAV.setViewName("catdog-product-list-admin");

		    return mAV;
		}
	
	// 결제 페이지 회원
	@GetMapping(value = "catdog-payment")
	public String paymentMember(
			@RequestParam("user_id") String user_id,
		    @RequestParam("order_code") String order_code, Model model, HttpSession session) {
	    // 회원 정보 가져오기
		Map<String, Object> user = (Map<String, Object>) session.getAttribute("user");		
		
		if (user == null) {
	        System.out.println("세션에 사용자가 없습니다.");
	        return "redirect:/catdog-login";
	    }
		
		// 회원 정보
		PaymentDTO pdto = catDogService.getMember((String) user.get("user_id"));
		model.addAttribute("paymentMember", pdto);
		
		System.out.println("Session user: " + session.getAttribute("user"));
		    
		// order_code로 주문 정보 가져오기
		List<OrderItemDTO> orderInfo = catDogService.getOrderInfo(order_code);
		
		model.addAttribute("orderInfo", orderInfo);
		System.out.println("orderInfo :::" + orderInfo);
		System.out.println("주문 코드:::: " + order_code);
		
		// 총 금액
		int totalPrice = 0;
	    for (OrderItemDTO item : orderInfo) {
	        totalPrice += item.getTotal_price();
	    }
	    model.addAttribute("totalPrice", totalPrice);
		
	    return "catdog-payment"; // 뷰 이름 반환
	}
	
	// 결제
	@PostMapping("/processPayment")
	public String processPayment(
	        @RequestParam("name") String name,
	        @RequestParam("phone_num") String phone_num,
	        @RequestParam("zipcode") String zipcode,
	        @RequestParam("address") String address,
	        @RequestParam("detailaddress") String detailaddress,
	        HttpSession session,
	        Model model) {
	    Map<String, Object> user = (Map<String, Object>) session.getAttribute("user");

	    String user_id = (String) user.get("user_id");
	    if (user_id == null || user_id.isEmpty()) {
	        return "redirect:/catdog-login";
	    }

	    // product_code를 데이터베이스에서 조회
	    List<Integer> product_code = catDogService.getProductCodeByUserId(user_id);
	    if (product_code == null) {
	        model.addAttribute("errorMessage", "Product code를 찾을 수 없습니다.");
	        return "catdog-payment";
	    }

	    try {
	        catDogService.updateAddress(user_id, name, phone_num, zipcode, address, detailaddress);
	        catDogService.updatePaymentStatus(user_id);
	        catDogService.deleteOrderItems(user_id, product_code); // product_code 전달

	        return "redirect:/";
	    } catch (Exception e) {
	        e.printStackTrace();
	        model.addAttribute("errorMessage", "결제 처리 중 오류가 발생했습니다.");
	        return "catdog-payment";
	    }
	}
	
	// 장바구니
	@GetMapping("/cart")
	public String cart(@RequestParam("user_id") String user_id, HttpSession session, Model model) throws Exception {
		Map<String, Object> user = (Map<String, Object>) session.getAttribute("user");
		if (user == null) {
			return "redirect:/catdog-login";
		}
		model.addAttribute("user_name", user.get("name"));
		model.addAttribute("user_id", user.get("user_id"));

		List<CartDTO> cartInfo = catDogService.getCartInfo(user_id);
		model.addAttribute("cartInfo", cartInfo);
		System.out.println("cartInfo = " + cartInfo);

		return "cart";
	}
	
	@PostMapping("/cart")
	public String cart(@RequestParam("user_id_fk") String user_id, HttpServletRequest request,
			RedirectAttributes rttr) throws Exception {
		
		request.setCharacterEncoding("UTF-8");

		// 1. OrderDTO 생성 및 저장
		OrderDTO order = new OrderDTO();
		order.setUser_id_fk(user_id);
		order.setPayment_status(0); // 0: 미결제
		String orderCode = catDogService.addOrder(order);
		logger.info("Generated order_code: " + orderCode); // orderCode 확인
		
		logger.info("Generated order_code: " + orderCode); // orderCode 반환 확인
		
		// 2. CartDTO 데이터를 OrderItemDTO로 변환하여 저장
		List<CartDTO> cartItems = catDogService.getCartInfo(user_id);
		List<OrderItemDTO> orderItems = new ArrayList<OrderItemDTO>();
		for (CartDTO cart : cartItems) {
			OrderItemDTO orderItem = new OrderItemDTO();
			orderItem.setOrder_code(orderCode);
			orderItem.setProduct_code(cart.getProduct_code());
			orderItem.setOrder_quantity(cart.getCart_quantity());
			orderItem.setProduct_name(cart.getProduct_name());
			orderItem.setProduct_price(cart.getProduct_price());
			orderItems.add(orderItem);			
		}
		catDogService.addOrderItems(orderItems);
		
		// 3. 결과 메시지 및 페이지 이동
		System.out.println("★★★★★★★★★★order = " + order);
		System.out.println("★★★★★★★★★★orderItems = " + orderItems);
//		int o = catDogService.addOrder(orderDTO);
//
//		if (o > 0) {
//			rttr.addFlashAttribute("msg", "주문 추가 성공");
//		}
		
		// RedirectAttributes로 데이터 전달
	    rttr.addAttribute("user_id", user_id);
	    rttr.addAttribute("order_code", orderCode);

	    return "redirect:/catdog-payment";
	}
	
	// 마이페이지
	@GetMapping("/mypage")
	public String mypage(HttpSession session, Model model) throws Exception {
		Map<String, Object> user = (Map<String, Object>) session.getAttribute("user");
		if (user == null) {
			return "redirect:/catdog-login";
		}

		model.addAttribute("user_name", user.get("name"));
		model.addAttribute("user_id", user.get("user_id"));

		List<MyDTO> myOrders = catDogService.getMyOrders((String) user.get("user_id"));
		model.addAttribute("myOrders", myOrders);

		System.out.println(myOrders);

		return "mypage";
	}
	
	private final String KAKAO_CLIENT_ID = "26fead75e8276cd122d06ab66a97fe89"; // 카카오 REST API 키
    private final String REDIRECT_URI = "http://localhost:8080/kakao/login";

    @GetMapping("/kakao/login")
    public String kakaoLogin() {
        String kakaoAuthUrl = "https://kauth.kakao.com/oauth/authorize" +
                "?client_id=" + KAKAO_CLIENT_ID +
                "&redirect_uri=" + REDIRECT_URI +
                "&response_type=code";
        return "redirect:" + kakaoAuthUrl;
    }    
    @ResponseBody
    public String kakaoCallback(@RequestParam String code) {
        try {
            // 1. Access Token 요청
            String tokenUrl = "https://kauth.kakao.com/oauth/token" +
                    "?grant_type=authorization_code" +
                    "&client_id=" + KAKAO_CLIENT_ID +
                    "&redirect_uri=" + REDIRECT_URI +
                    "&code=" + code;

            HttpURLConnection connection = (HttpURLConnection) new URL(tokenUrl).openConnection();
            connection.setRequestMethod("POST");
            connection.setDoOutput(true);

            BufferedReader br = new BufferedReader(new InputStreamReader(connection.getInputStream()));
            String responseLine;
            StringBuilder response = new StringBuilder();
            while ((responseLine = br.readLine()) != null) {
                response.append(responseLine);
            }
            br.close();

            // 2. Access Token 추출
            // JSON 파싱 예시로 대체
            String accessToken = extractAccessToken(response.toString());

            // 3. 사용자 정보 가져오기
            Map<String, Object> userInfo = getUserInfo(accessToken);
            return "카카오 사용자 정보: " + userInfo;

        } catch (Exception e) {
            e.printStackTrace();
            return "카카오 로그인 실패";
        }
    }

    private String extractAccessToken(String response) {
        // JSON 파싱하여 access_token 추출 (간략화된 예제)
        // 라이브러리 사용 가능: Jackson, Gson 등
        return "extracted_access_token";
    }

    private Map<String, Object> getUserInfo(String accessToken) throws Exception {
        String apiUrl = "https://kapi.kakao.com/v2/user/me";
        URL url = new URL(apiUrl);
        HttpURLConnection connection = (HttpURLConnection) url.openConnection();
        connection.setRequestMethod("GET");
        connection.setRequestProperty("Authorization", "Bearer " + accessToken);

        BufferedReader br = new BufferedReader(new InputStreamReader(connection.getInputStream()));
        StringBuilder response = new StringBuilder();
        String line;
        while ((line = br.readLine()) != null) {
            response.append(line);
        }
        br.close();

        // 사용자 정보 파싱
        ObjectMapper mapper = new ObjectMapper();
        return mapper.readValue(response.toString(), Map.class);
    }
    
    // 토큰 요청
    private String getAccessToken(String code) throws Exception {
        String tokenUrl = "https://kauth.kakao.com/oauth/token" +
                          "?grant_type=authorization_code" +
                          "&client_id=" + KAKAO_CLIENT_ID +
                          "&redirect_uri=" + REDIRECT_URI +
                          "&code=" + code;

        URL url = new URL(tokenUrl);
        HttpURLConnection connection = (HttpURLConnection) url.openConnection();
        connection.setRequestMethod("POST");
        connection.setDoOutput(true);

        BufferedReader br = new BufferedReader(new InputStreamReader(connection.getInputStream()));
        StringBuilder response = new StringBuilder();
        String line;
        while ((line = br.readLine()) != null) {
            response.append(line);
        }
        br.close();

        // Access Token 파싱
        ObjectMapper mapper = new ObjectMapper();
        Map<String, String> responseMap = mapper.readValue(response.toString(), Map.class);
        return responseMap.get("access_token");
    }
}
