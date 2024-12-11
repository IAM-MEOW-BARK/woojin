package kr.co.dong.controller;

import java.io.File;
import java.net.HttpURLConnection;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.co.dong.catdog.CartDTO;
import kr.co.dong.catdog.CatDogService;
import kr.co.dong.catdog.FaqDTO;
import kr.co.dong.catdog.MemberDTO;
import kr.co.dong.catdog.MyDTO;
import kr.co.dong.catdog.NoticeDTO;
import kr.co.dong.catdog.OrderDTO;
import kr.co.dong.catdog.OrderDetailDTO;
import kr.co.dong.catdog.OrderItemDTO;
import kr.co.dong.catdog.OrderItemDetailDTO;
import kr.co.dong.catdog.ProductDTO;
import kr.co.dong.catdog.QnaDTO;
import kr.co.dong.catdog.ReviewDTO;

@Controller
public class CatDogController {
	private static final Logger logger = LoggerFactory.getLogger(CatDogController.class);

	@Inject
	CatDogService catDogService;

	// 전체 상품 출력
	@GetMapping(value = "/home")
	public ModelAndView list(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		// 세션에서 사용자 ID 가져오기
		Map<String, Object> userMap = (Map<String, Object>) session.getAttribute("user");
		String user_id = userMap != null ? (String) userMap.get("user_id") : null;

		// 파라미터 맵 구성
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("user_id", user_id);

		// 카테고리별 상품 목록 조회
		param.put("product_category", 1);
		List<ProductDTO> list01 = catDogService.mainlist(param);
		param.put("product_category", 2);
		List<ProductDTO> list02 = catDogService.mainlist(param);
		param.put("product_category", 3);
		List<ProductDTO> list03 = catDogService.mainlist(param);
		param.put("product_category", 4);
		List<ProductDTO> list04 = catDogService.mainlist(param);
		param.put("product_category", 5);
		List<ProductDTO> list05 = catDogService.mainlist(param);

		// 뷰에 데이터 추가
		mav.addObject("list01", list01);
		mav.addObject("list02", list02);
		mav.addObject("list03", list03);
		mav.addObject("list04", list04);
		mav.addObject("list05", list05);

		mav.setViewName("home");
		return mav;
	}

	@GetMapping(value = "/catdog-term")
	public String catdogTerm() {
		return "catdog-term";
	}

	@GetMapping(value = "/catdog-add-product-admin")
	public String catdogAddProductAdmin() {
		return "catdog-add-product-admin";
	}

	// 상품 단일 선택 수정 페이지
	@GetMapping(value = "catdog-product-modify")
	public String getProductByCode(@RequestParam("product_code") int product_code, Model model) {
		ProductDTO productDTO = catDogService.getProductByCode(product_code);
		model.addAttribute("product", productDTO);

		return "catdog-product-modify";
	}

	// 상품 수정
	@PostMapping(value = "catdog-product-modified")
	public String update(ProductDTO productDTO, @RequestParam("thumbnail_imgFile") MultipartFile file,
			HttpServletRequest request) throws Exception {
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
	@PostMapping(value = "catdog/deleteProduct")
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
	public String catDogAddProduct(@ModelAttribute ProductDTO productDTO, HttpServletRequest request,
			HttpSession session) throws Exception {
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
		if (productFile != null && !productFile.isEmpty()) {
			String safeDetailFileName = productFile.getOriginalFilename().replaceAll("[^a-zA-Z0-9._-]", "_");
			File uploadedDetailFile = new File(loc, safeDetailFileName);
			productFile.transferTo(uploadedDetailFile);

			// 상세 이미지 파일 저장 확인 while (!uploadedDetailFile.exists()) { Thread.sleep(100);
			// 디스크 반영 대기 }

			productDTO.setProduct_img(safeDetailFileName); // 상세 이미지 파일 이름 설정 } else {
			System.out.println("상세 이미지 파일이 업로드되지 않았습니다.");
		}

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
	public String findId(@RequestParam Map<String, Object> map, Model model, HttpServletRequest request)
			throws Exception {
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
	public String findPw(@RequestParam Map<String, Object> map, Model model, HttpServletRequest request)
			throws Exception {
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
			model.addAttribute("loginError", "아이디 또는 비밀번호가 일치하지 않습니다.");
			return "forward:/WEB-INF/views/catdog-login.jsp"; // forward로 JSP에 메시지 전달
		}

		Integer userStatus = (Integer) user.get("user_status");

		if (userStatus == 1) {
			logger.info("로그인 실패: 비활성화된 사용자");
			model.addAttribute("msg", "아이디 또는 비밀번호가 유효하지 않습니다.");
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
			return "redirect:/home";
		} else {
			logger.warn("알 수 없는 USER_AUTH 값: " + userAuth);
			return "redirect:/catdog-login";
		}
	}

	@RequestMapping("/kakao/login")
	public String home(@RequestParam(value = "code", required = false) String code, HttpServletRequest request,
			HttpServletResponse response, HttpSession session, Model model) throws Exception {
		request.setCharacterEncoding("utf-8");
		System.out.println("######### Code: " + code);

		// Access Token 가져오기
		String access_Token = catDogService.getAccessToken(code);

		// 유저 정보 가져오기
		HashMap<String, Object> userInfo = catDogService.getUserInfo(access_Token);
		if (userInfo == null || userInfo.isEmpty()) {
			System.out.println("유저 정보 가져오기 실패!");
			model.addAttribute("error", "유저 정보를 가져오는 데 실패했습니다.");
			return "error";
		}

		String userId = (String) userInfo.get("user_id");
		String name = (String) userInfo.get("name");

		// 회원 정보 조회
		Map<String, Object> userMap = new HashMap<>();
		userMap.put("user_id", userId);

		Map<String, Object> foundUser = catDogService.checkUserId(userMap);

		if (foundUser != null) {
			System.out.println("회원 정보 있음 - 로그인 처리");

			catDogService.socialLogin(foundUser);
			session.setAttribute("user", foundUser);
			session.setAttribute("access_token", access_Token);
		}

		if (foundUser == null || foundUser.isEmpty()) {
			System.out.println("회원 정보 없음 - 새로 생성");
			MemberDTO member = new MemberDTO();
			member.setUser_id(userId);
			member.setName(name);
			member.setSocial_id(1);

			System.out.println("회원 정보 생성 member :::::::::::" + member);

			// DB에 저장
			catDogService.create(member);

			// 새로 생성된 유저 정보를 세션에 저장
			session.setAttribute("user", member);
		}

		System.out.println("###access_Token#### : " + access_Token);
		System.out.println("###userInfo#### : " + userInfo.get("user_id"));
		System.out.println("###nickname#### : " + userInfo.get("name"));

		return "redirect:/";
	}

	@GetMapping(value = "/catdog-logout")
	public String logout(@RequestParam(value = "isKakao", required = false, defaultValue = "false") boolean isKakao,
			HttpServletRequest request, HttpServletResponse response, HttpSession session, RedirectAttributes rttr) {

		try {
			// 1. 카카오 로그아웃 처리 (isKakao=true인 경우만 실행)
			if (isKakao) {
				String accessToken = (String) session.getAttribute("access_token");
				if (accessToken != null) {
					String reqURL = "https://kapi.kakao.com/v1/user/logout";
					URL url = new URL(reqURL);
					HttpURLConnection conn = (HttpURLConnection) url.openConnection();
					conn.setRequestMethod("POST");
					conn.setRequestProperty("Authorization", "Bearer " + accessToken);

					int responseCode = conn.getResponseCode();
					if (responseCode == 200) {
						System.out.println("카카오 로그아웃 성공");
					} else {
						System.err.println("카카오 로그아웃 실패: 응답 코드 " + responseCode);
					}
				}
			}

			// 2. 세션 무효화
			if (session != null) {
				session.invalidate(); // 서버 세션 삭제
				System.out.println("세션 제거 완료");
			}

			// 3. 클라이언트 JSESSIONID 쿠키 삭제
			Cookie cookie = new Cookie("JSESSIONID", null); // 쿠키 값 null
			cookie.setPath("/");
			cookie.setMaxAge(0); // 즉시 만료
			response.addCookie(cookie);

			System.out.println("JSESSIONID 쿠키 삭제 완료");

			// 로그아웃 메시지 추가
			rttr.addFlashAttribute("msg", "로그아웃 성공");

		} catch (Exception e) {
			System.err.println("로그아웃 중 오류 발생: " + e.getMessage());
			rttr.addFlashAttribute("msg", "로그아웃 처리 중 오류가 발생했습니다.");
		}

		// 4. 카카오 로그인 창으로 리다이렉트 (isKakao=true인 경우)
		if (isKakao) {
			String kakaoLoginUrl = "https://kauth.kakao.com/oauth/authorize"
					+ "?client_id=26fead75e8276cd122d06ab66a97fe89" // 카카오 REST API 키
					+ "&redirect_uri=http://localhost:8080/kakao/login" // 로그인 후 리다이렉트 URI
					+ "&response_type=code";
			return "redirect:" + kakaoLoginUrl;
		}

		// 5. 일반 로그아웃 리다이렉트
		return "redirect:/";
	}

	// 관리자 회원 목록 + 페이징
	@GetMapping(value = "/catdog-user-list-admin")
	public ModelAndView list(@RequestParam(value = "searchType", required = false) String searchType,
			@RequestParam(value = "searchKeyword", required = false) String searchKeyword,
			@RequestParam(value = "startDate", required = false) String startDate,
			@RequestParam(value = "endDate", required = false) String endDate,
			@RequestParam(value = "pageNum", defaultValue = "1") int pageNum,
			@RequestParam(value = "pageListNum", defaultValue = "1") int pageListNum) {

		int pageSize = 10; // 한 페이지당 게시글 수
		int pageListSize = 10; // 한 번에 표시할 페이지 수

		// 검색 키워드와 검색 타입 처리
		if (searchKeyword != null && searchKeyword.trim().isEmpty()) {
			searchKeyword = null;
		}

		if (searchType != null && searchType.trim().isEmpty()) {
			searchType = null;
		}

		// 날짜 처리
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

		// 전체 게시글 수 (검색 조건 포함)
		int totalList = catDogService.getFilteredMemberCount(searchType, searchKeyword, startDate, endDate);
		int totalPage = (int) Math.ceil((double) totalList / pageSize);

		// 현재 페이지에서 가져올 데이터의 시작 인덱스 계산
		int start = (pageNum - 1) * pageSize;

		// 현재 페이지 번호 목록의 시작과 끝
		int startPage = (pageListNum - 1) * pageListSize + 1;
		int endPage = Math.min(startPage + pageListSize - 1, totalPage);

		// 검색 조건에 맞는 회원 리스트 가져오기
		List<MemberDTO> list = catDogService.searchMemberWithPaging(searchType, searchKeyword, startDate, endDate,
				start, pageSize);

		// ModelAndView로 데이터 전달
		ModelAndView mAV = new ModelAndView();
		mAV.addObject("memberList", list);
		mAV.addObject("totalPage", totalPage); // 전체 페이지 수
		mAV.addObject("currentPage", pageNum); // 현재 페이지 번호
		mAV.addObject("pageListNum", pageListNum);
		mAV.addObject("startPage", startPage); // 페이지 네비게이션 시작
		mAV.addObject("endPage", endPage); // 페이지 네비게이션 끝
		mAV.addObject("searchType", searchType); // 검색 조건
		mAV.addObject("searchKeyword", searchKeyword);
		mAV.addObject("startDate", startDate);
		mAV.addObject("endDate", endDate);
		mAV.setViewName("catdog-user-list-admin");

		return mAV;
	}

	/*
	 * @GetMapping(value = "/catdog-user-list-admin") public ModelAndView list(
	 * 
	 * @RequestParam(value = "searchType", required = false) String searchType,
	 * 
	 * @RequestParam(value = "searchKeyword", required = false) String
	 * searchKeyword,
	 * 
	 * @RequestParam(value = "startDate", required = false) String startDate,
	 * 
	 * @RequestParam(value = "endDate", required = false) String endDate,
	 * 
	 * @RequestParam(value = "pageNum", defaultValue = "1") int pageNum,
	 * 
	 * @RequestParam(value = "pageListNum", defaultValue = "1") int pageListNum) {
	 * 
	 * int pageSize = 10; // 한 페이지당 게시글 수 int pageListSize = 10; // 한 번에 표시할 페이지 수
	 * 
	 * // 전체 게시글 수 int totalList = catDogService.memberPaging(); int totalPage =
	 * (int) Math.ceil((double) totalList / pageSize);
	 * 
	 * // 현재 페이지에서 가져올 데이터의 시작 인덱스 계산 int start = (pageNum - 1) * pageSize;
	 * 
	 * // 현재 페이지 번호 목록의 시작과 끝 int startPage = (pageListNum - 1) * pageListSize + 1;
	 * int endPage = Math.min(startPage + pageListSize - 1, totalPage);
	 * 
	 * ModelAndView mAV = new ModelAndView(); List<MemberDTO> list =
	 * catDogService.getTotalMember(start, pageSize); mAV.addObject("memberList",
	 * list); mAV.addObject("totalPage", totalPage); // 전체 페이지 수
	 * mAV.addObject("currentPage", pageNum); // 현재 페이지 번호
	 * mAV.addObject("pageListNum", pageListNum); mAV.addObject("startPage",
	 * startPage); // 페이지 네비게이션 시작 mAV.addObject("endPage", endPage); // 페이지 네비게이션 끝
	 * mAV.setViewName("catdog-user-list-admin");
	 * 
	 * return mAV; }
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

	// 일반 유저 회원가입
	@GetMapping(value = "/catdog-signup")
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

	public static int start = 1;
	public static int startPage = 1;
	public static int endPage = 0;

	// 회원 리스트 검색 필터
	public static final int PAGE_SIZE = 10; // 한 페이지당 게시글 수
	public static final int PAGE_LIST_SIZE = 10; // 한 번에 표시할 페이지 수

	/**
	 * 검색 필터를 이용한 회원 조회
	 */
	@RequestMapping(value = "/searchMember", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView searchMember(@RequestParam(value = "searchType", required = false) String searchType,
			@RequestParam(value = "searchKeyword", required = false) String searchKeyword,
			@RequestParam(value = "startDate", required = false) String startDate,
			@RequestParam(value = "endDate", required = false) String endDate,
			@RequestParam(value = "pageNum", defaultValue = "1") int pageNum,
			@RequestParam(value = "pageListNum", defaultValue = "1") int pageListNum) {

		// 검색 키워드와 검색 타입 처리
		if (searchKeyword != null && searchKeyword.trim().isEmpty()) {
			searchKeyword = null;
		}
		if (searchType != null && searchType.trim().isEmpty()) {
			searchType = null;
		}

		// 날짜 처리
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

		// 페이징 계산
		int totalList = catDogService.getFilteredMemberCount(searchType, searchKeyword, startDate, endDate);
		int totalPage = (int) Math.ceil((double) totalList / PAGE_SIZE);
		int start = (pageNum - 1) * PAGE_SIZE;
		int startPage = (pageListNum - 1) * PAGE_LIST_SIZE + 1;
		int endPage = Math.min(startPage + PAGE_LIST_SIZE - 1, totalPage);

		// 검색 결과 가져오기
		List<MemberDTO> members = catDogService.searchMemberWithPaging(searchType, searchKeyword, startDate, endDate,
				start, PAGE_SIZE);

		// ModelAndView 생성
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
	@RequestMapping(value = "/searchProduct", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView searchProduct(@RequestParam(value = "searchType", required = false) String searchType,
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
		List<ProductDTO> products = catDogService.searchProductWithPaging(searchType, searchKeyword, startDate, endDate,
				start, pageSize);

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
	public String paymentMember(@RequestParam("user_id") String user_id, @RequestParam("order_code") String order_code,
			Model model, HttpSession session) {
		// 회원 정보 가져오기
		Map<String, Object> user = (Map<String, Object>) session.getAttribute("user");

		if (user == null) {
			System.out.println("세션에 사용자가 없습니다.");
			return "redirect:/catdog-login";
		}

		// 회원 정보
		MemberDTO pdto = catDogService.getMember((String) user.get("user_id"));
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
	public String processPayment(@RequestParam("name") String name, @RequestParam("phone_num") String phone_num,
			@RequestParam("zipcode") String zipcode, @RequestParam("address") String address,
			@RequestParam("detailaddress") String detailaddress, HttpSession session, Model model,
			RedirectAttributes redirectAttributes) {
		Map<String, Object> user = (Map<String, Object>) session.getAttribute("user");

		Object userIdObj = user.get("user_id");
		System.out.println("user_id 값: " + userIdObj);
		System.out.println("user_id 타입: " + (userIdObj != null ? userIdObj.getClass().getName() : "null"));

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

			redirectAttributes.addFlashAttribute("paymentSuccess", true);
			return "redirect:/";
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("errorMessage", "결제 처리 중 오류가 발생했습니다.");
			System.out.println("errorMessage" + "결제 처리 중 오류가 발생했습니다.");
			return "catdog-payment";
		}
	}

	// 장바구니
	@GetMapping("/cart")
	public String cart(HttpSession session, Model model) throws Exception {
		Map<String, Object> user = (Map<String, Object>) session.getAttribute("user");
		if (user == null) {
			return "redirect:/catdog-login";
		}
		String userId = (String) user.get("user_id");
		model.addAttribute("user_name", user.get("name"));
		model.addAttribute("user_id", userId);

		List<CartDTO> cartInfo = catDogService.getCartInfo(userId);
		if (cartInfo.isEmpty()) {
			model.addAttribute("isCartEmpty", true);
		} else {
			model.addAttribute("isCartEmpty", false);
			model.addAttribute("cartInfo", cartInfo);
			System.out.println("cartInfo = " + cartInfo);
			session.setAttribute("cartInfo", cartInfo); // post할 세션
			model.addAttribute("cartCost", catDogService.getCartCost(userId));
		}

		return "cart";
	}

	@PostMapping(value = "/addCart")
	public String addToCart(@ModelAttribute CartDTO cartDTO, HttpSession session,
			RedirectAttributes redirectAttributes) {
		// 로그인 확인
		Map<String, Object> user = (Map<String, Object>) session.getAttribute("user");

		// 로그인 여부 확인
		if (user == null || user.get("user_id") == null) {
			redirectAttributes.addFlashAttribute("error", "로그인이 필요합니다.");
			return "redirect:/catdog-login";
		}
		// 세션에서 사용자 ID 가져오기
		String userId = (String) user.get("user_id");
		cartDTO.setUser_id(userId); // CartDTO에 사용자 ID 설정

		try {
			// 장바구니 추가
			catDogService.addCart(cartDTO);
			redirectAttributes.addFlashAttribute("message", "장바구니에 추가되었습니다.");
		} catch (Exception e) {
			e.printStackTrace();
			redirectAttributes.addFlashAttribute("error", "장바구니 추가 중 오류가 발생했습니다.");
		}
		return "redirect:/cart";
	}

	@PostMapping("/cart")
	public String processOrder(HttpSession session, HttpServletRequest request, RedirectAttributes rttr, Model model)
			throws Exception {
		Map<String, Object> user = (Map<String, Object>) session.getAttribute("user");
		if (user == null) {
			return "redirect:/catdog-login";
		}
		String userId = (String) user.get("user_id");
		model.addAttribute("user_name", user.get("name"));
		model.addAttribute("user_id", userId);

		OrderDTO orderDTO = new OrderDTO();

		orderDTO.setUser_id_fk(userId);
		orderDTO.setPayment_status(0);
		String orderCode = catDogService.addOrder(orderDTO);
		orderDTO.setOrder_code(orderCode);

		List<CartDTO> cartItems = catDogService.getCartInfo(userId);

		List<OrderItemDTO> orderItems = new ArrayList<>();
		for (CartDTO cartItem : cartItems) {
			OrderItemDTO orderItem = new OrderItemDTO();
			orderItem.setOrder_code(orderCode);
			orderItem.setProduct_code(cartItem.getProduct_code());
			orderItem.setProduct_name(cartItem.getProduct_name());
			orderItem.setThumbnail_img(cartItem.getThumbnail_img());
			orderItem.setProduct_price(cartItem.getProduct_price());
			orderItem.setCart_quantity(cartItem.getCart_quantity());
			orderItem.setOrder_quantity(cartItem.getCart_quantity());
			orderItem.setTotal_price(cartItem.getCart_quantity() * cartItem.getProduct_price());
			orderItems.add(orderItem);
		}
		catDogService.addOrderItems(orderItems);

		model.addAttribute("orderDTO", orderDTO);
		model.addAttribute("orderItems", orderItems);

		System.out.println("~~~~~~~~ orderDTO ~~~~~~~ = " + orderDTO);
		System.out.println("~~~~~~~~ orderItems ~~~~~~~ = " + orderItems);

		OrderDetailDTO orderInfo = catDogService.getOrderDetail(orderCode);
		System.out.println("~~~~~~~~ orderInfo ~~~~~~~ = " + orderInfo);
		model.addAttribute("orderInfo", orderInfo);

		int totalCost = catDogService.getTotalCost(orderCode);
		model.addAttribute("totalCost", totalCost);

		System.out.println("  💛💛💛💛💛💛💛💛💛💛 orderDTO: " + orderDTO);
		System.out.println("  💛💛💛💛💛💛💛💛💛💛 OrderItems: " + orderItems);
		System.out.println("  💛💛💛💛💛💛💛💛💛💛 totalCost: " + totalCost);

		return "/catdog-payment";
	}

	@PostMapping("/cart/update")
	public String updateCartQuantity(CartDTO cartDTO) throws Exception {

		System.out.println("업데이트 아직인겨 = " + cartDTO);
		System.out.println("업데이트 아직이여 = " + cartDTO.getCart_quantity());
		catDogService.updateCartQuantity(cartDTO);
		System.out.println("업데이트 눌럿슈 = " + cartDTO);
		System.out.println("업데이트 햇슈 = " + cartDTO.getCart_quantity());
		return "redirect:/cart";
	}

	@PostMapping("/cart/delete")
	@ResponseBody
	public String deleteCart(CartDTO cartDTO) throws Exception {
		System.out.println("뭐 가져온겨???????? " + cartDTO);
		int result = catDogService.deleteCart(cartDTO);
		return result > 0 ? "success" : "failure";
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

		List<MyDTO> recentOrders  = catDogService.getRecentOrders((String) user.get("user_id"));
		model.addAttribute("recentOrders", recentOrders );

		System.out.println(recentOrders );

		return "mypage";
	}
	
	@GetMapping("/totalOrder")
	public String totalOrder(HttpSession session, Model model) throws Exception {
		Map<String, Object> user = (Map<String, Object>) session.getAttribute("user");
		if (user == null) {
			return "redirect:/catdog-login";
		}
		model.addAttribute("user_name", user.get("name"));
		model.addAttribute("user_id", user.get("user_id"));

		List<MyDTO> myOrders = catDogService.getMyOrders((String) user.get("user_id"));
		model.addAttribute("myOrders", myOrders);

		System.out.println(myOrders);
		return "totalOrder";
	}
	
	@GetMapping("/checkPW")
	public String checkPW(Model model, HttpSession session) throws Exception {
		Map<String, Object> user = (Map<String, Object>) session.getAttribute("user");
		if (user == null) {
			return "redirect:/catdog-login";
		}
		model.addAttribute("user_id", user.get("user_id"));
		return "checkPW";
	}

	@PostMapping("/checkPW")
	public String chekcPW(@RequestParam Map<String, Object> map, HttpServletRequest request, HttpSession session,
			Model model) throws Exception {
		request.setCharacterEncoding("UTF-8");

		System.out.println(map);

		Map user = catDogService.login(map);

		if (user == null) {
			logger.info("비밀번호가 틀립니다.");
			model.addAttribute("errorMessage", "비밀번호가 틀립니다.");
			model.addAttribute("user_id", map.get("user_id"));
			return "/checkPW";
		}
		logger.info("회원 조회 뿅");

		session.setAttribute("name", user.get("name"));
		session.setAttribute("user_id", user.get("user_id"));
		session.setAttribute("phone_num", user.get("phone_num"));
		session.setAttribute("zipcode", user.get("zipcode"));
		session.setAttribute("address", user.get("address"));
		session.setAttribute("detailaddress", user.get("detailaddress"));
		session.setAttribute("password", map.get("password"));

		System.out.println("정보 간다~" + user);

		return "redirect:/updateProfile";
	}

	@GetMapping("/updateProfile")
	public String updateProfile(HttpSession session, Model model) {
		// 세션에서 사용자 정보를 가져와 모델에 추가
		model.addAttribute("name", session.getAttribute("name"));
		model.addAttribute("user_id", session.getAttribute("user_id"));
		model.addAttribute("phone_num", session.getAttribute("phone_num"));
		model.addAttribute("zipcode", session.getAttribute("zipcode"));
		model.addAttribute("address", session.getAttribute("address"));
		model.addAttribute("detailaddress", session.getAttribute("detailaddress"));

		return "updateProfile"; // updateProfile.jsp 렌더링
	}

	@PostMapping("/updateProfile")
	public String updateProfile(@ModelAttribute MemberDTO memberDTO, HttpSession session, HttpServletRequest request,
			Model model, RedirectAttributes redirectAttributes) throws Exception {

		request.setCharacterEncoding("UTF-8");

		// 세션에서 현재 비밀번호 가져오기
		String currentPW = (String) session.getAttribute("password");

		System.out.println("지금 비번이 머꼬???????" + currentPW);

		// 새 비밀번호가 비어있는지 확인
		if (memberDTO.getPassword() == null || memberDTO.getPassword().isEmpty()) {
			// 새 비밀번호가 null 이거나 empty하다면
			System.out.println(memberDTO.getPassword());
			memberDTO.setPassword(currentPW);
		}

		model.addAttribute(memberDTO);
		System.out.println("===== 프로필 업데이트 할겨 ===== ");
		System.out.println(memberDTO);
		catDogService.updateProfile(memberDTO);
		System.out.println("===== 프로필 업데이트 된겨 ===== ");

		// 플래시 메시지 추가
		redirectAttributes.addFlashAttribute("successMessage", "회원 정보가 성공적으로 수정되었습니다.");

		return "redirect:/mypage";
	}
	
	@GetMapping("/detailOrder")
	   public String detailOrder(@RequestParam("order_code") String order_code, Model model, HttpSession session) throws Exception {
	      System.out.println("전달 받은 order_code = " + order_code);

	      // 주문 상세 정보 가져오기
	      OrderDetailDTO orderDetail = catDogService.getOrderDetail(order_code); // orderDetail에 order_code 전달
	      System.out.println(orderDetail);
	      model.addAttribute("orderDetail", orderDetail); // jsp 사용할 데이터

	       // 사용자 정보 가져오기
	       Map<String, Object> user = (Map<String, Object>) session.getAttribute("user");
	       String userId = (String) user.get("user_id");
	      
	       // 주문 아이템 상세 정보 가져오기
	      List<OrderItemDetailDTO> orderItemDetail = catDogService.getOrderItemDetail(order_code);
	      System.out.println(orderItemDetail);
	      model.addAttribute("orderItemDetail", orderItemDetail);

	      // 각 상품에 대해 리뷰 여부 확인
	       for (OrderItemDetailDTO item : orderItemDetail) {
	       int isReview = catDogService.isReview(item.getProductCode(), userId);
	       item.setReview(isReview > 0); // 리뷰 존재 여부 설정
	       }
	      
	      // 총 비용 계산
	      int totalCost = catDogService.getTotalCost(order_code);
	      model.addAttribute("totalCost", totalCost);

	      return "detailOrder"; // 상세 페이지
	   }
	
	   @GetMapping("/getProductInfo")
	   @ResponseBody
	   public ProductDTO getProductInfo(@RequestParam int product_code) throws Exception {
	      return catDogService.getProductByCode(product_code);
	   }


	// 지혜
	// 상품 상세페이지
	@RequestMapping(value = "/productDetail", method = RequestMethod.GET)
	public String productDetail(@RequestParam("product_code") int product_code, Model model) {

		// 배송 예정일
		Calendar calendar = Calendar.getInstance();
		int hour = calendar.get(Calendar.HOUR_OF_DAY);

		if (hour < 15) {
			calendar.add(Calendar.DATE, 1);
		} else {
			calendar.add(Calendar.DATE, 2);
		}

		Date delivery = calendar.getTime();
		SimpleDateFormat dateFormat = new SimpleDateFormat("MM월 dd일(E)"); // 날짜와 요일 형식

		String deliveryDate = dateFormat.format(delivery);

		// 1. 상품 상세 정보
		ProductDTO productDTO = catDogService.productDetail(product_code);

		// 2. 리뷰 리스트 (최신 5개)
		List<ReviewDTO> getReview = catDogService.getReview(product_code);
		// 3. Q&A 리스트 (최신 5개)
		List<QnaDTO> getQna = catDogService.getQna(product_code);
		// 4. 상품 코드에 해당하는 게시글 개수 가져오기
		int product_reviewTotal = catDogService.product_reviewTotal(product_code);
		int product_qnaTotal = catDogService.product_qnaTotal(product_code);

		model.addAttribute("productDetail", productDTO);
		model.addAttribute("getReview", getReview);
		model.addAttribute("getQna", getQna);
		model.addAttribute("product_reviewTotal", product_reviewTotal);
		model.addAttribute("product_qnaTotal", product_qnaTotal);
		model.addAttribute("deliveryDate", deliveryDate);
		return "/productDetail";
	}

	// 카테고리 리스트

	@RequestMapping(value = "/categoryList", method = RequestMethod.GET)
	public String categoryList(

			@RequestParam(value = "pageNum", defaultValue = "1") int pageNum,
			@RequestParam(value = "pageListNum", defaultValue = "1") int pageListNum,
			@RequestParam(value = "product_category") int product_category, Model model) {

		int pageSize = 12;
		int pageListSize = 10;

		int totalPost = catDogService.categoryTotalPost(product_category);
		int totalPage = (int) Math.ceil((double) totalPost / pageSize);
		int start = (pageNum - 1) * pageSize;
		int startPage = (pageListNum - 1) * pageListSize + 1;
		int endPage = Math.min(startPage + pageListSize - 1, totalPage);

		System.out.println("totalPost: " + totalPost);
		System.out.println("totalPage: " + totalPage);
		System.out.println("start: " + start);
		System.out.println("pageSize: " + pageSize);

		List<ProductDTO> categoryList = catDogService.categoryList(start, pageSize, product_category);

		System.out.println("categoryList in Controller: " + categoryList);

		model.addAttribute("totalPage", totalPage);
		model.addAttribute("currentPage", pageNum);
		model.addAttribute("pageListNum", pageListNum);
		model.addAttribute("startPage", startPage);
		model.addAttribute("endPage", endPage);
		model.addAttribute("productCategory", product_category);
		model.addAttribute("categoryList", categoryList);

		return "categoryList";
	}

	// 공지사항 리스트
	@RequestMapping(value = "noticeList", method = RequestMethod.GET)
	public ModelAndView noticeList(@RequestParam(value = "pageNum", defaultValue = "1") int pageNum,
			@RequestParam(value = "pageListNum", defaultValue = "1") int pageListNum, HttpSession session) {

		int pageSize = 10; // 한 페이지당 게시글 수
		int pageListSize = 10; // 한 번에 표시할 페이지 수

		// 세션에서 사용자 정보 가져오기
		Map<String, Object> user = (Map<String, Object>) session.getAttribute("user");
		int user_auth = (user != null && user.get("user_auth") != null) ? (int) user.get("user_auth") : 0;

		// 전체 게시글 수
		int totalPost = catDogService.noticeTotalPost();
		int totalPage = (int) Math.ceil((double) totalPost / pageSize);

		// 현재 페이지에서 가져올 데이터의 시작 인덱스 계산
		int start = (pageNum - 1) * pageSize;

		// 현재 페이지 번호 목록의 시작과 끝
		int startPage = (pageListNum - 1) * pageListSize + 1;
		int endPage = Math.min(startPage + pageListSize - 1, totalPage);

		ModelAndView mav = new ModelAndView();
		mav.addObject("noticeList", catDogService.noticeList(start, pageSize)); // 게시글 목록
		mav.addObject("totalPage", totalPage); // 전체 페이지 수
		mav.addObject("currentPage", pageNum); // 현재 페이지 번호
		mav.addObject("pageListNum", pageListNum); // 1~10, 11~20 ...
		mav.addObject("startPage", startPage); // 페이지 네비게이션 시작
		mav.addObject("endPage", endPage); // 페이지 네비게이션 끝
		mav.addObject("user_auth", user_auth); // 사용자 권한
		mav.setViewName("noticeList");
		return mav;
	}

	// 리뷰 리스트
	@RequestMapping(value = "reviewList", method = RequestMethod.GET)
	public ModelAndView reviewList(@RequestParam(value = "pageNum", defaultValue = "1") int pageNum,
			@RequestParam(value = "pageListNum", defaultValue = "1") int pageListNum) {

		int pageSize = 10; // 한 페이지당 게시글 수
		int pageListSize = 10; // 한 번에 표시할 페이지 수

		// 전체 게시글 수
		int totalPost = catDogService.reviewTotalPost();
		int totalPage = (int) Math.ceil((double) totalPost / pageSize);

		// 현재 페이지에서 가져올 데이터의 시작 인덱스 계산
		int start = (pageNum - 1) * pageSize;

		// 현재 페이지 번호 목록의 시작과 끝
		int startPage = (pageListNum - 1) * pageListSize + 1;
		int endPage = Math.min(startPage + pageListSize - 1, totalPage);

		ModelAndView mav = new ModelAndView();
		mav.addObject("reviewList", catDogService.reviewList(start, pageSize)); // 게시글 목록
		mav.addObject("totalPage", totalPage); // 전체 페이지 수
		mav.addObject("currentPage", pageNum); // 현재 페이지 번호
		mav.addObject("pageListNum", pageListNum);
		mav.addObject("startPage", startPage); // 페이지 네비게이션 시작
		mav.addObject("endPage", endPage); // 페이지 네비게이션 끝
		mav.setViewName("reviewList");
		return mav;
	}

	// 리뷰 상세조회
	@RequestMapping(value = "/reviewDetail", method = RequestMethod.GET)
	public String reviewDetail(@RequestParam("review_no") int review_no, Model model) {
		ReviewDTO reviewDTO = catDogService.reviewDetail(review_no);
		catDogService.reviewUpdateReadCnt(review_no);
		model.addAttribute("reviewDetail", reviewDTO);

		return "/reviewDetail";
	}
	
	// 리뷰 작성
	@PostMapping("/regReview")
	   public ResponseEntity<String> regReview(@RequestBody ReviewDTO reviewDTO) throws Exception {
	       if (reviewDTO.getProduct_code() == 0 || 
	           reviewDTO.getReview_score() == 0 || 
	           reviewDTO.getReview_content() == null) {
	           return ResponseEntity.badRequest().body("필수 파라미터가 누락되었습니다.");
	       }

	       catDogService.regReview(reviewDTO);
	       return ResponseEntity.ok("리뷰 등록 성공!");
	   }

	// Q&A 리스트
	@RequestMapping(value = "qnaList", method = RequestMethod.GET)
	public ModelAndView qnaList(@RequestParam(value = "pageNum", defaultValue = "1") int pageNum,
			@RequestParam(value = "pageListNum", defaultValue = "1") int pageListNum, HttpSession session) {

		int pageSize = 10; // 한 페이지당 게시글 수
		int pageListSize = 10; // 한 번에 표시할 페이지 수

		// 세션에서 사용자 정보 가져오기
		Map<String, Object> user = (Map<String, Object>) session.getAttribute("user");
		int user_auth = (user != null && user.get("user_auth") != null) ? (int) user.get("user_auth") : 0;

		// 전체 게시글 수
		int totalPost = catDogService.qnaTotalPost();
		int totalPage = (int) Math.ceil((double) totalPost / pageSize);

		// 현재 페이지에서 가져올 데이터의 시작 인덱스 계산
		int start = (pageNum - 1) * pageSize;

		// 현재 페이지 번호 목록의 시작과 끝
		int startPage = (pageListNum - 1) * pageListSize + 1;
		int endPage = Math.min(startPage + pageListSize - 1, totalPage);

		ModelAndView mav = new ModelAndView();
		mav.addObject("qnaList", catDogService.qnaList(start, pageSize)); // 게시글 목록
		mav.addObject("totalPage", totalPage); // 전체 페이지 수
		mav.addObject("currentPage", pageNum); // 현재 페이지 번호
		mav.addObject("pageListNum", pageListNum);
		mav.addObject("startPage", startPage); // 페이지 네비게이션 시작
		mav.addObject("endPage", endPage); // 페이지 네비게이션 끝
		mav.addObject("user_auth", user_auth);
		mav.setViewName("qnaList");
		return mav;
	}

	// FAQ 리스트
	@RequestMapping(value = "faqList", method = RequestMethod.GET)
	public ModelAndView faqList(@RequestParam(value = "pageNum", defaultValue = "1") int pageNum,
			@RequestParam(value = "pageListNum", defaultValue = "1") int pageListNum,
			@RequestParam(value = "faq_division", required = false) Integer faq_division, HttpSession session) {
		int pageSize = 10; // 한 페이지당 게시글 수
		int pageListSize = 10; // 한 번에 표시할 페이지 수

		// 세션에서 사용자 정보 가져오기
		Map<String, Object> user = (Map<String, Object>) session.getAttribute("user");
		int user_auth = (user != null && user.get("user_auth") != null) ? (int) user.get("user_auth") : 0;

		int totalPost;
		List<FaqDTO> faqList;

		if (faq_division == null) {
			// 전체 게시글 수 및 리스트 가져오기
			totalPost = catDogService.faqTotalPost();
			faqList = catDogService.faqList((pageNum - 1) * pageSize, pageSize);
		} else {
			// 특정 구분에 해당하는 게시글 수 및 리스트 가져오기
			totalPost = catDogService.faqTotalPostDivision(faq_division);
			faqList = catDogService.faqListDivision((pageNum - 1) * pageSize, pageSize, faq_division);
		}

		// 총 페이지 계산
		int totalPage = (int) Math.ceil((double) totalPost / pageSize);

		// 현재 페이지 번호 목록의 시작과 끝
		int startPage = (pageListNum - 1) * pageListSize + 1;
		int endPage = Math.min(startPage + pageListSize - 1, totalPage);

		ModelAndView mav = new ModelAndView();
		mav.addObject("faqList", faqList); // 게시글 목록
		mav.addObject("totalPage", totalPage); // 전체 페이지 수
		mav.addObject("currentPage", pageNum); // 현재 페이지 번호
		mav.addObject("pageListNum", pageListNum); // 현재 페이지 리스트 번호
		mav.addObject("startPage", startPage); // 페이지 네비게이션 시작
		mav.addObject("endPage", endPage); // 페이지 네비게이션 끝
		mav.addObject("selectedDivision", faq_division);
		mav.addObject("user_auth", user_auth);
		mav.setViewName("faqList");
		return mav;
	}

	// FAQ 수정
	@RequestMapping(value = "/faqUpdate", method = RequestMethod.GET)
	public String faqUpdate(@RequestParam("faq_no") int faq_no, Model model) {
		// FAQ 번호에 해당하는 데이터를 가져옴
		FaqDTO faqDTO = catDogService.faqDetail(faq_no);
		model.addAttribute("faqUpdate", faqDTO);
		return "/faqUpdate"; // 수정 폼으로 이동
	}

	@RequestMapping(value = "/faqUpdate", method = RequestMethod.POST)
	public String faqUpdate(FaqDTO faqDTO, RedirectAttributes attr, HttpServletRequest request) throws Exception {
		request.setCharacterEncoding("UTF-8");
		// 수정 실행
		int r = catDogService.faqUpdate(faqDTO);

		if (r > 0) {
			attr.addFlashAttribute("msg", "FAQ가 성공적으로 수정되었습니다.");
		} else {
			attr.addFlashAttribute("msg", "FAQ 수정에 실패하였습니다.");
		}
		return "redirect:/faqList"; // 수정 후 FAQ 리스트로 이동
	}

	// FAQ 삭제
	@RequestMapping(value = "/faqDelete", method = RequestMethod.POST)
	public String faqDelete(@RequestParam("faq_no") int faq_no, RedirectAttributes redirectAttributes) {
		// 삭제 실행
		int result = catDogService.faqDelete(faq_no);
		if (result > 0) {
			redirectAttributes.addFlashAttribute("message", "FAQ가 성공적으로 삭제되었습니다.");
		} else {
			redirectAttributes.addFlashAttribute("message", "FAQ 삭제에 실패하였습니다.");
		}
		return "redirect:/faqList"; // 삭제 후 FAQ 리스트로 이동
	}

	// 공지사항 상세조회
	@RequestMapping(value = "/noticeDetail", method = RequestMethod.GET)
	public String noticeDetail(@RequestParam("notice_no") int notice_no, Model model, HttpSession session) {
		NoticeDTO noticeDTO = catDogService.noticeDetail(notice_no);
		catDogService.noticeUpdateReadCnt(notice_no);
		model.addAttribute("noticeDetail", noticeDTO);

		// 세션에서 사용자 권한 가져오기
		Map<String, Object> user = (Map<String, Object>) session.getAttribute("user");
		int user_auth = (user != null && user.get("user_auth") != null) ? (int) user.get("user_auth") : 0;

		model.addAttribute("noticeDetail", noticeDTO);
		model.addAttribute("user_auth", user_auth);

		return "/noticeDetail";
	}

	@RequestMapping(value = "backToList", method = RequestMethod.GET)
	public String backToList(@RequestParam("notice_no") int notice_no, Model model) {
		int totalPost = catDogService.noticeTotalPost();
		int no = totalPost - notice_no + 1;
		int pageSize = 10; // 해당 게시판을 호출할 때 사용한 pageSize
		int pageListSize = 10; // 해당 게시판을 호출할 때 사용한 pageListSize
		int pageNUM = (no / pageSize) + 1;
		int pageListNUM = (no / (pageSize * pageListSize)) + 1;

		return "redirect:noticeList?pageNUM=" + pageNUM + "&pageListNUM=" + pageListNUM;
	}

	/*
	 * @RequestMapping(value = "/qnaDetail", method = RequestMethod.GET) public
	 * String qnaDetail(
	 * 
	 * @RequestParam(value = "qna_no") int qna_no, HttpSession session, Model model,
	 * RedirectAttributes rttr) {
	 * 
	 * // 사용자 권한 확인 Map<String, Object> user = (Map<String, Object>)
	 * session.getAttribute("user"); int user_auth = (user != null &&
	 * user.get("user_auth") != null) ? (int) user.get("user_auth") : 0;
	 * 
	 * // Q&A 데이터 가져오기 QnaDTO qnaDTO = catDogService.qnaDetail(qna_no); if (qnaDTO
	 * == null) { rttr.addFlashAttribute("error", "Q&A 정보를 찾을 수 없습니다."); return
	 * "redirect:/qnaList"; }
	 * 
	 * // 비밀글 접근 권한 확인 if (qnaDTO.getQna_secret() == 1) { if (user_auth != 1) { //
	 * 관리자가 아닌 경우 Boolean hasAccess = (Boolean) session.getAttribute("qnaAccess_" +
	 * qna_no); if (hasAccess == null || !hasAccess) {
	 * rttr.addFlashAttribute("error", "비밀글에 접근 권한이 없습니다."); return
	 * "redirect:/qnaList"; } } }
	 * 
	 * // Q&A 상세 데이터 전달 model.addAttribute("qnaDetail", qnaDTO);
	 * model.addAttribute("user_auth", user_auth); return "/qnaDetail"; }
	 */

	@RequestMapping(value = "/validatePassword", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> validatePassword(@RequestBody Map<String, Object> payload, HttpSession session) {
		int qna_no = Integer.parseInt(payload.get("qna_no").toString());
		String qna_pwd = payload.get("qna_pwd").toString();

		QnaDTO qnaDTO = catDogService.qnaDetail(qna_no); // qna_pwd ?
		Map<String, Object> response = new HashMap<>();

		if (qnaDTO != null && qna_pwd.equals(qnaDTO.getQna_pwd())) {
			session.setAttribute("qnaAccess_" + qna_no, true); // 세션에 접근 권한 저장
			response.put("success", true);
		} else {
			response.put("success", false);
		}

		return response;
	}

	// 공지사항 작성
	@RequestMapping(value = "/noticeRegister", method = RequestMethod.GET)
	public String noticeRegister() {
		return "/noticeRegister";
	}

	@RequestMapping(value = "/noticeRegister", method = RequestMethod.POST)
	public String noticeRegister(NoticeDTO noticeDTO, HttpServletRequest request, RedirectAttributes rttr)
			throws Exception {
		request.setCharacterEncoding("UTF-8");

		int r = catDogService.noticeRegister(noticeDTO);

		if (r > 0) {
			rttr.addFlashAttribute("msg", "추가에 성공하였습니다."); // 세션저장
		}
		return "redirect:/noticeList";
	}

	// 공지사항 수정
	@RequestMapping(value = "/noticeUpdate", method = RequestMethod.GET)
	public String noticeUpdate(@RequestParam("notice_no") int notice_no, Model model) {
		NoticeDTO noticeDTO = catDogService.noticeDetail(notice_no);
		model.addAttribute("noticeUpdate", noticeDTO);

		return "/noticeUpdate";
	}

	@RequestMapping(value = "/noticeUpdate", method = RequestMethod.POST)
	public String noticeUpdate(NoticeDTO noticeDTO, RedirectAttributes attr, HttpServletRequest request)
			throws Exception {
		request.setCharacterEncoding("UTF-8");

		int r = catDogService.noticeUpdate(noticeDTO);

		if (r > 0) {
			attr.addFlashAttribute("msg", "수정에 성공 하였습니다.");
			return "redirect:noticeList";
		}
		return "redirect:/noticeUpdate?notice_no=" + noticeDTO.getNotice_no();
	}

	// 공지사항 삭제
	@RequestMapping(value = "/noticeDelete", method = RequestMethod.GET)
	public String noticeDelete(@RequestParam("notice_no") int notice_no, RedirectAttributes rttr) {
		int r = catDogService.noticeDelete(notice_no);

		if (r > 0) {
			rttr.addFlashAttribute("msg", "글삭제에 성공하였습니다.");
			return "redirect:noticeList";
		}
		return "redirect:/noticeDetail?notice_no=" + notice_no;
	}

	// Q&A 작성
	@RequestMapping(value = "/qnaRegister", method = RequestMethod.GET)
	public String qnaRegister(HttpSession session, RedirectAttributes rttr) {
		// 세션에서 사용자 정보 가져오기
		Map<String, Object> user = (Map<String, Object>) session.getAttribute("user");
		if (user == null) {
			rttr.addFlashAttribute("error", "로그인이 필요합니다.");
			return "redirect:/catdog-login"; // 로그인 페이지로 리다이렉트
		}

		return "/qnaRegister"; // 로그인된 사용자라면 작성 페이지로 이동
	}

	@RequestMapping(value = "/qnaRegister", method = RequestMethod.POST)
	public String qnaRegister(QnaDTO qnaDTO, HttpServletRequest request, HttpSession session, RedirectAttributes rttr)
			throws Exception {

		request.setCharacterEncoding("UTF-8"); // 요청 인코딩 설정

		// 세션에서 사용자 정보 가져오기
		Map<String, Object> user = (Map<String, Object>) session.getAttribute("user");
		if (user == null) {
			rttr.addFlashAttribute("error", "로그인이 필요합니다.");
			return "redirect:/catdog-login"; // 로그인 페이지로 리다이렉트
		}

		// user_id 설정
		String userId = (String) user.get("user_id");
		qnaDTO.setUser_id(userId);

		// 비밀글 여부에 따른 비밀번호 처리
		if (qnaDTO.getQna_secret() == 0) {
			qnaDTO.setQna_pwd(null); // 공개글인 경우 비밀번호 제거
		}

		// Q&A 등록 처리
		int result = catDogService.qnaRegister(qnaDTO);

		// 등록 성공 여부 확인 및 메시지 설정
		if (result > 0) {
			rttr.addFlashAttribute("msg", "문의글이 성공적으로 등록되었습니다.");
		} else {
			rttr.addFlashAttribute("msg", "문의글 등록에 실패하였습니다.");
		}

		// Q&A 리스트 페이지로 리다이렉트
		return "redirect:/qnaList";
	}

	// Q&A 수정
	@RequestMapping(value = "/qnaUpdate", method = RequestMethod.GET)
	public String qnaUpdate(@RequestParam("qna_no") int qna_no, Model model) {
		QnaDTO qnaDTO = catDogService.qnaDetail(qna_no);

		model.addAttribute("qnaUpdate", qnaDTO);
		return "/qnaUpdate";
	}

	@RequestMapping(value = "/qnaUpdate", method = RequestMethod.POST)
	public String qnaUpdate(QnaDTO qnaDTO, RedirectAttributes attr, HttpServletRequest request) throws Exception {
		request.setCharacterEncoding("UTF-8");

		int r = catDogService.qnaUpdate(qnaDTO);

		if (r > 0) {
			attr.addFlashAttribute("msg", "수정에 성공 하였습니다.");
			return "redirect:/qnaDetail?qna_no=" + qnaDTO.getQna_no();
		}
		return "redirect:/qnaUpdate?qna_no=" + qnaDTO.getQna_no();
	}

	// Q&A 삭제
	@RequestMapping(value = "/qnaDelete", method = RequestMethod.GET)
	public String qnaDelete(@RequestParam("qna_no") int qna_no, RedirectAttributes rttr) {
		int r = catDogService.qnaDelete(qna_no);

		if (r > 0) {
			rttr.addFlashAttribute("msg", "글삭제에 성공하였습니다.");
			return "redirect:qnaList";
		}
		return "redirect:/qnaDetail?qna_no=" + qna_no;
	}

	/*
	 * @RequestMapping(value = "/qnaReplyDetail", method = RequestMethod.GET) public
	 * String qnaReplyDetail(@RequestParam(value = "qna_no") int qna_no, HttpSession
	 * session, Model model, RedirectAttributes rttr) {
	 * 
	 * // 사용자 권한 확인 Map<String, Object> user = (Map<String, Object>)
	 * session.getAttribute("user"); int user_auth = (user != null &&
	 * user.get("user_auth") != null) ? (int) user.get("user_auth") : 0;
	 * 
	 * // Q&A 데이터 가져오기 QnaDTO qnaDTO = catDogService.qnaReplyDetail(qna_no); if
	 * (qnaDTO == null) { rttr.addFlashAttribute("error", "Q&A 정보를 찾을 수 없습니다.");
	 * return "redirect:/qnaList"; }
	 * 
	 * // 비밀글 접근 권한 확인 if (qnaDTO.getQna_secret() == 1) { if (user_auth != 1) { //
	 * 관리자가 아닌 경우 Boolean hasAccess = (Boolean) session.getAttribute("qnaAccess_" +
	 * qna_no); if (hasAccess == null || !hasAccess) {
	 * rttr.addFlashAttribute("error", "비밀글에 접근 권한이 없습니다."); return
	 * "redirect:/qnaList"; } } }
	 * 
	 * // Q&A 상세 데이터 전달 model.addAttribute("qnaDetail", qnaDTO); //
	 * model.addAttribute("user_auth", user_auth); return "/qnaReplyDetail"; }
	 */

	// Q&A 답변 작성
	@RequestMapping(value = "/qnaReply", method = RequestMethod.GET)
	public String qnaReply(@RequestParam("qna_no") int qna_no, Model model) {
		QnaDTO qnaDTO = catDogService.qnaDetail(qna_no);

		model.addAttribute("qnaReply", qnaDTO);
		return "/qnaReply";
	}

	@RequestMapping(value = "/qnaReply", method = RequestMethod.POST)
	public String qnaReply(QnaDTO qnaDTO, RedirectAttributes attr, HttpServletRequest request) throws Exception {
		request.setCharacterEncoding("UTF-8");

		int r = catDogService.qnaReply(qnaDTO);

		if (r > 0) {
			attr.addFlashAttribute("msg", "답변이 작성되었습니다.");
			return "redirect:/qnaDetail?qna_no=" + qnaDTO.getQna_no();
		}
		return "redirect:/qnaReply?qna_no=" + qnaDTO.getQna_no();
	}

	// Q&A 답변 수정
	@RequestMapping(value = "/qnaReplyUpdate", method = RequestMethod.GET)
	public String qnaReplyUpdate(@RequestParam("qna_no") int qna_no, Model model) {
		QnaDTO qnaDTO = catDogService.qnaDetail(qna_no);

		model.addAttribute("qnaReplyUpdate", qnaDTO);
		return "/qnaReplyUpdate";
	}

	@RequestMapping(value = "/qnaReplyUpdate", method = RequestMethod.POST)
	public String qnaReplyUpdate(QnaDTO qnaDTO, RedirectAttributes attr, HttpServletRequest request) throws Exception {
		request.setCharacterEncoding("UTF-8");

		int r = catDogService.qnaReplyUpdate(qnaDTO);

		if (r > 0) {
			attr.addFlashAttribute("msg", "수정에 성공 하였습니다.");
			return "redirect:/qnaDetail?qna_no=" + qnaDTO.getQna_no();
		}
		return "redirect:/qnaUpdate?qna_no=" + qnaDTO.getQna_no();
	}

	// Q&A 답변 삭제
	@RequestMapping(value = "/qnaReplyDelete", method = RequestMethod.GET)
	public String qnaReplyClear(@RequestParam("qna_no") int qna_no, RedirectAttributes redirectAttributes) {
		try {
			catDogService.qnaReplyDelete(qna_no);
			redirectAttributes.addFlashAttribute("msg", "Q&A 답변이 삭제되었습니다.");
		} catch (Exception e) {
			e.printStackTrace();
			redirectAttributes.addFlashAttribute("error", "답변 삭제 중 오류가 발생했습니다.");
		}
		return "redirect:/qnaList";
	}

	
	@RequestMapping(value = "/qnaReplyDetail", method = RequestMethod.GET)
	public String qnaReplyDetail(
	    @RequestParam("qna_no") int qna_no,
	    HttpSession session,
	    RedirectAttributes rttr,
	    Model model) {

	    // Q&A 데이터 가져오기
	    QnaDTO qnaDTO = catDogService.qnaReplyDetail(qna_no);
	    if (qnaDTO == null) {
	        rttr.addFlashAttribute("error", "Q&A 정보를 찾을 수 없습니다.");
	        return "redirect:/qnaList";
	    }

	    // 사용자 권한 확인
	    Map<String, Object> user = (Map<String, Object>) session.getAttribute("user");
	    int user_auth = (user != null && user.get("user_auth") != null) ? (int) user.get("user_auth") : 0;

	    // 비밀 답변글 접근 처리
	    if (qnaDTO.getQna_secret() == 1) { // 비밀글일 경우
	        if (user_auth != 1) { // 관리자가 아닌 경우 비밀번호 확인 필요
	            Boolean hasAccess = (Boolean) session.getAttribute("qnaAccess_" + qna_no);
	            if (hasAccess == null || !hasAccess) {
	                rttr.addFlashAttribute("error", "비밀글은 비밀번호 입력이 필요합니다.");
	                return "redirect:/qnaList"; // 비밀번호 입력이 필요한 경우
	            }
	        }
	    }

	    // 공개글일 경우 비밀번호 확인 없이 접근 가능
	    model.addAttribute("qnaReplyDetail", qnaDTO);
	    model.addAttribute("user_auth", user_auth);
	    return "/qnaReplyDetail";
	}
	
	@RequestMapping(value = "/qnaReplyDetail", method = RequestMethod.POST)
	public String qnaReplyDetailPost(
	    @RequestParam("qna_no") int qna_no,
	    @RequestParam("qna_pwd") String qna_pwd,
	    HttpSession session, Model model, RedirectAttributes rttr) {

	    QnaDTO qnaDTO = catDogService.qnaReplyDetail(qna_no);
	    if (qnaDTO == null) {
	        rttr.addFlashAttribute("error", "Q&A 정보를 찾을 수 없습니다.");
	        return "redirect:/qnaList";
	    }

	    // 사용자 권한 확인
	    Map<String, Object> user = (Map<String, Object>) session.getAttribute("user");
	    int userAuth = (user != null && user.get("user_auth") != null) ? (int) user.get("user_auth") : 0;

	    // 관리자 접근 시 비밀번호 확인 건너뜀
	    if (qnaDTO.getQna_secret() == 1 && userAuth != 1) {
	        if (!qna_pwd.equals(qnaDTO.getQna_pwd())) {
	            rttr.addFlashAttribute("error", "비밀번호가 일치하지 않습니다.");
	            return "redirect:/qnaList";
	        }
	    }

	    model.addAttribute("qnaReplyDetail", qnaDTO);
	    return "/qnaReplyDetail";
	}
	
	@RequestMapping(value = "/qnaDetail", method = RequestMethod.GET)
	public String qnaDetailGet(
	    @RequestParam("qna_no") int qna_no,
	    HttpSession session, Model model, RedirectAttributes rttr) {

	    // Q&A 정보 조회
	    QnaDTO qnaDTO = catDogService.qnaDetail(qna_no);
	    if (qnaDTO == null) {
	        rttr.addFlashAttribute("error", "Q&A 정보를 찾을 수 없습니다.");
	        return "redirect:/qnaList";
	    }

	    // 사용자 권한 확인
	    Map<String, Object> user = (Map<String, Object>) session.getAttribute("user");
	    int userAuth = (user != null && user.get("user_auth") != null) ? (int) user.get("user_auth") : 0;

	    // 비밀 글 접근 제한 (일반 회원만 제한)
	    if (qnaDTO.getQna_secret() == 1 && userAuth != 1) { // 관리자 제외
	        rttr.addFlashAttribute("error", "비밀글은 비밀번호 입력이 필요합니다.");
	        return "redirect:/qnaList";
	    }

	    model.addAttribute("qnaDetail", qnaDTO);
	    return "/qnaDetail";
	}


	@RequestMapping(value = "/qnaDetail", method = RequestMethod.POST)
	public String qnaDetailPost(
	    @RequestParam("qna_no") int qna_no,
	    @RequestParam("qna_pwd") String qna_pwd,
	    HttpSession session, Model model, RedirectAttributes rttr) {

	    QnaDTO qnaDTO = catDogService.qnaDetail(qna_no);
	    if (qnaDTO == null) {
	        rttr.addFlashAttribute("error", "Q&A 정보를 찾을 수 없습니다.");
	        return "redirect:/qnaList";
	    }

	    // 사용자 권한 확인
	    Map<String, Object> user = (Map<String, Object>) session.getAttribute("user");
	    int userAuth = (user != null && user.get("user_auth") != null) ? (int) user.get("user_auth") : 0;

	    // 관리자 접근 시 비밀번호 확인 건너뜀
	    if (qnaDTO.getQna_secret() == 1 && userAuth != 1) {
	        if (!qna_pwd.equals(qnaDTO.getQna_pwd())) {
	            rttr.addFlashAttribute("error", "비밀번호가 일치하지 않습니다.");
	            return "redirect:/qnaList";
	        }
	    }

	    model.addAttribute("qnaDetail", qnaDTO);
	    return "/qnaDetail";
	}
  

	 

	// 상품 검색
	@RequestMapping(value = "/productSearch", method = RequestMethod.GET)
	public String productSearch(@RequestParam String keyword, Model model) {

		List<ProductDTO> productSearch = catDogService.productSearch(keyword);
		model.addAttribute("keyword", keyword);
		model.addAttribute("productSearch", productSearch);
		return "/productSearch";
	}

}