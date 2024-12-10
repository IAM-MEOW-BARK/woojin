package kr.co.dong.catdog;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;


import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

@Service
public class CatDogServiceImpl implements CatDogService {
	@Inject
	private CatDogDAO catDogDAO;
	
	@Override
	public Map login(Map<String, Object>map) {
		// TODO Auto-generated method stub

		  // 1. 로그인 쿼리 실행
	    Map<String, Object> user = catDogDAO.login(map);

	    // 2. 로그인 성공 시 connected_at 업데이트
	    if (user != null) {
	        catDogDAO.updateConnectedAt(map); // connected_at 컬럼에 현재 시각 업데이트
	    }

	    // 3. 로그인 결과 반환
	    return user;
	}
	
	@Override
	public Map socialLogin(Map<String, Object> map) {
	    System.out.println("소셜 로그인 시도: " + map.get("user_id"));

	    // 로그인 쿼리 실행
	    Map<String, Object> user = catDogDAO.login(map);

	    if (user != null) {
	        // connected_at 업데이트
	        catDogDAO.updateConnectedAt(map);
	    }

	    return user;
	}

	@Override
	public Map findId(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return catDogDAO.findId(map);
	}

	@Override
	public Map findPw(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return catDogDAO.findPw(map);
	}
	
	@Override
	public Map checkUserId(Map<String, Object> map) throws Exception {
		return catDogDAO.checkUserId(map);
	}

	
	@Override
	public int create(MemberDTO member) throws Exception {
		// TODO Auto-generated method stub
		 // 중복 확인 로직 추가
	    Map<String, Object> userMap = new HashMap<>();
	    userMap.put("user_id", member.getUser_id());
	    
	    Map<String, Object> foundUser = catDogDAO.login(userMap);
	    if (foundUser != null) {
	        throw new RuntimeException("Duplicate user_id: " + member.getUser_id());
	    }
	    
	    System.out.println("회원 추가 됩니다잉" + userMap);

	    // 중복되지 않은 경우 INSERT 수행
	    return catDogDAO.create(member);
	}

	@Override
	public List<MemberDTO> getTotalMember(int start, int pageSize) {
		// TODO Auto-generated method stub
		return catDogDAO.getTotalMember(start, pageSize);
	}

	/*
	 * @Override public int deleteUser(String user_id) { // TODO Auto-generated
	 * method stub return catDogDAO.deleteUser(user_id); }
	 */
	
	@Override
	public int deleteUsers(List<String> userIds) {
	    return catDogDAO.deleteUsers(userIds);
	}

	@Override
	public int getMemberByEmail(String user_id) throws Exception {
		// TODO Auto-generated method stub
		return catDogDAO.getMemberByEmail(user_id);
	}

	@Override
	public List<Map<String, Object>> searchMember(String searchType, String searchKeyword, String startDate,
			String endDate) {
		// TODO Auto-generated method stub
		return catDogDAO.searchWithFilters(searchType, searchKeyword, startDate, endDate);
	}

	@Override
	public int addProduct(ProductDTO productDTO) throws Exception {
		// TODO Auto-generated method stub
		return catDogDAO.addProduct(productDTO);
	}
	
	@Override
	public int checkProductCode(int product_code) throws Exception {
		// TODO Auto-generated method stub
		return catDogDAO.checkProductCode(product_code);
	}

	@Override
	public List<ProductDTO> getTotalProduct(int start, int pageSize) {
		// TODO Auto-generated method stub
		return catDogDAO.getTotalProduct(start, pageSize);
	}

	@Override
	public int productPaging() {
		// TODO Auto-generated method stub
		return catDogDAO.productPaging();
	}

	@Override
	public int deleteProduct(List<String> productCode) {
		// TODO Auto-generated method stub
		return catDogDAO.deleteProduct(productCode);
	}

	@Override
	public List<Map<String, Object>> searchProduct(String searchType, String searchKeyword, String startDate,
			String endDate) {
		// TODO Auto-generated method stub
		return catDogDAO.productListFilter(searchType, searchKeyword, startDate, endDate);
	}

	@Override
	public int memberPaging() {
		// TODO Auto-generated method stub
		return catDogDAO.memberPaging();
	}

	@Override
	public int updateProduct(ProductDTO productDTO) {
		// TODO Auto-generated method stub
		return catDogDAO.updateProduct(productDTO);
	}

	@Override
	public ProductDTO getProductByCode(int product_code) {
	    ProductDTO product = catDogDAO.getProductByCode(product_code);
	    System.out.println("Service에서 전달된 상품: " + product); // 디버깅 로그
	    return product;
	}

	@Override
	public List<PaymentDTO> productPayment(String user_id) {
		// TODO Auto-generated method stub
		return catDogDAO.productPayment(user_id);
	}
	
	@Override
	public int productUser(String user_id) {
		// TODO Auto-generated method stub
		return catDogDAO.productUser(user_id);
	}	

	@Override
	public int getTotalCost(String order_code) throws Exception {
	   // TODO Auto-generated method stub
       return catDogDAO.getTotalCost(order_code);
   }

	@Override
	public MemberDTO getMember(String user_id) {
		// TODO Auto-generated method stub
		MemberDTO member = catDogDAO.getMember(user_id);
		System.out.println("Service: 회원 정보: " + member);
		return member;
		
	}

	@Override
	public List<OrderItemDTO> getOrderInfo(String order_code) {
		// TODO Auto-generated method stub
		  List<OrderItemDTO> orderInfo = catDogDAO.getOrderInfo(order_code);
	      System.out.println("Service: 주문 정보: " + orderInfo);
	      return orderInfo;
	}

	@Override
	public List<String> getOrderCodeByUserId(String user_id) {
		// TODO Auto-generated method stub
		 return catDogDAO.getOrderCodeByUserId(user_id);
	}
	
	public void updateAddress(String user_id, String name, String phone_num, String zipcode, String address, String detailaddress) {
	    catDogDAO.updateAddress(user_id, name, phone_num, zipcode, address, detailaddress);
	}

	public void updatePaymentStatus(String user_id) {
	    catDogDAO.updatePaymentStatus(user_id);
	}	
	
	@Override
	public void deleteOrderItems(String user_id, List<Integer> product_code) {
		// TODO Auto-generated method stub
		catDogDAO.deleteOrderItems(user_id, product_code);
	}

	
	@Override
	public List<Integer> getProductCodeByUserId(String user_id) {
	    return catDogDAO.getProductCodeByUserId(user_id);
	}
	
	// 검색 조건과 페이징을 사용한 회원 리스트 조회
	public List<MemberDTO> searchMemberWithPaging(String searchType, String searchKeyword, String startDate, String endDate, int start, int pageSize) {
	    return catDogDAO.searchMemberWithPaging(searchType, searchKeyword, startDate, endDate, start, pageSize);
	}

	// 검색 조건에 맞는 회원 수 조회
	public int getFilteredMemberCount(String searchType, String searchKeyword, String startDate, String endDate) {
	    return catDogDAO.getFilteredMemberCount(searchType, searchKeyword, startDate, endDate);
	}

	@Override
	public List<ProductDTO> searchProductWithPaging(String searchType, String searchKeyword, String startDate,
			String endDate, int start, int pageSize) {
		// TODO Auto-generated method stub
		 return catDogDAO.searchProductWithPaging(searchType, searchKeyword, startDate, endDate, start, pageSize);
	}

	@Override
	public int getFilteredProductCount(String searchType, String searchKeyword, String startDate, String endDate) {
		// TODO Auto-generated method stub
		return catDogDAO.getFilteredProductCount(searchType, searchKeyword, startDate, endDate);
	}	
	
	@Override
	public String addOrder(OrderDTO orderDTO) throws Exception {
		// 랜덤 코드 생성
		String orderCode = generateOrderCode();
		orderDTO.setOrder_code(orderCode);
		catDogDAO.addOrder(orderDTO);

		// 데이터베이스 삽입
		return orderCode;
	}

	private String generateOrderCode() {
		// UUID를 이용하여 랜덤 코드 생성
		String oc = LocalDate.now().format(DateTimeFormatter.ofPattern("yyMMdd"))
				+ UUID.randomUUID().toString().substring(0, 8).toUpperCase();
		return oc;
	}

	@Override
	public void addOrderItems(List<OrderItemDTO> orderItems) throws Exception {
		catDogDAO.addOrderItems(orderItems);
	}
	
	@Override
	public List<CartDTO> getCartInfo(String user_id) throws Exception {
		return catDogDAO.getCartInfo(user_id);
	}
	
	@Override
	public List<CartDTO> getCartItem(String user_id) throws Exception {
		return catDogDAO.getCartItem(user_id);
	}
	
	@Override
	public int getCartCost(String user_id) throws Exception {
		return catDogDAO.getCartCost(user_id);
	}
	
	@Override
	public int updateCartQuantity(CartDTO cartDTO) throws Exception {
		return catDogDAO.updateCartQuantity(cartDTO);
	}
	
	@Override
	public int deleteCart(CartDTO cartDTO) throws Exception {
		return catDogDAO.deleteCart(cartDTO);
	}
	
	public List<MyDTO> getMyOrders(String user_id) throws Exception {
		return catDogDAO.getMyOrders(user_id);
	}
	
	@Override
	public OrderDetailDTO getOrderDetail(String order_code) throws Exception {
		return catDogDAO.getOrderDetail(order_code); // DAO 호출
	}
	
	// (나현 추가) 카테고리 별 보기
	@Override
	public List<ProductDTO> mainlist(Map<String, Object> param) {
		return catDogDAO.mainlist(param);
	}
	
	@Override
	public int isReview(ReviewDTO reviewDTO) throws Exception {
		// TODO Auto-generated method stub
		return catDogDAO.isReview(reviewDTO);
	}

	@Override
	public int regReview(ReviewDTO reviewDTO) throws Exception {
		// TODO Auto-generated method stub
		return catDogDAO.regReview(reviewDTO);
	}

	@Override
	public int updateProfile(MemberDTO memberDTO) throws Exception {
		return catDogDAO.updateProfile(memberDTO);
	}
	
	// 카카오 로그인
	public String getAccessToken(String authorize_code) {
		String access_Token = "";
        String refresh_Token = "";
        String reqURL = "https://kauth.kakao.com/oauth/token";
        

        try {
            URL url = new URL(reqURL);
            String redirectUri = "http://localhost:8080/kakao/login";

            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("POST");
            conn.setDoOutput(true);

            BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
            StringBuilder sb = new StringBuilder();
            sb.append("grant_type=authorization_code");
            sb.append("&client_id=26fead75e8276cd122d06ab66a97fe89"); // 발급받은 키
            sb.append( "&redirect_uri=" + URLEncoder.encode(redirectUri, "UTF-8"));
            sb.append("&code=").append(authorize_code);
            bw.write(sb.toString());
            bw.flush();

            int responseCode = conn.getResponseCode();
            System.out.println("responseCode:::::::: " + responseCode);

            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            StringBuilder result = new StringBuilder();
            String line;

            while ((line = br.readLine()) != null) {
                result.append(line);
            }

            System.out.println("response body : " + result);

            JsonElement element = JsonParser.parseString(result.toString());
            JsonObject jsonObject = element.getAsJsonObject();

            access_Token = jsonObject.get("access_token").getAsString();
            refresh_Token = jsonObject.get("refresh_token").getAsString();

            System.out.println("access_token : " + access_Token);
            System.out.println("refresh_token : " + refresh_Token);

            br.close();
            bw.close();
        } catch (IOException e) {
            e.printStackTrace();
        }

        return access_Token;
    }
	
	public HashMap<String, Object> getUserInfo(String access_Token) {
        // 클라이언트별 정보를 저장하기 위한 HashMap
        HashMap<String, Object> userInfo = new HashMap<>();
        String reqURL = "https://kapi.kakao.com/v2/user/me";

        try {
            URL url = new URL(reqURL);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");

            // Authorization 헤더에 Access Token 추가
            conn.setRequestProperty("Authorization", "Bearer " + access_Token);

            int responseCode = conn.getResponseCode();
            System.out.println("responseCode : " + responseCode);

            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));

            String line;
            StringBuilder result = new StringBuilder();

            while ((line = br.readLine()) != null) {
                result.append(line);
            }
            System.out.println("response body : " + result);

            // JSON 파싱
            JsonElement element = JsonParser.parseString(result.toString());
            JsonObject properties = element.getAsJsonObject().get("properties").getAsJsonObject();
            JsonObject kakao_account = element.getAsJsonObject().get("kakao_account").getAsJsonObject();

            // 필요한 정보 추출
            String nickname = properties.get("nickname").getAsString();
            String email = kakao_account.get("email").getAsString();

            // HashMap에 저장
            userInfo.put("user_id", email); // 이메일을 user_id로
            userInfo.put("name", nickname); // 닉네임을 name으로

        } catch (IOException e) {
            e.printStackTrace();
        }

        return userInfo;
    }

	

	// 지혜	
	@Override
	public int addCart(CartDTO cartDTO) throws Exception {
		// TODO Auto-generated method stub
		return catDogDAO.addCart(cartDTO);
	}
	
	@Override
	public ProductDTO productDetail(int product_code) {
		// TODO Auto-generated method stub
		return catDogDAO.productDetail(product_code);
	}

	@Override
	public List<ReviewDTO> getReview(int product_code) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<QnaDTO> getQna(int product_code) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int product_reviewTotal(int product_code) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int product_qnaTotal(int product_code) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<ProductDTO> categoryList(int start, int pageSize, int product_category) {
		// TODO Auto-generated method stub
		return catDogDAO.categoryList(start, pageSize, product_category);
	}
	@Override
	public int categoryTotalPost(int product_category) {
		// TODO Auto-generated method stub
		return catDogDAO.categoryTotalPost(product_category);
	}

	@Override
	public List<NoticeDTO> noticeList(int start, int pageSize) {
		// TODO Auto-generated method stub
		return catDogDAO.noticeList(start, pageSize);
	}
	@Override
	public int noticeTotalPost() {
		// TODO Auto-generated method stub
		return catDogDAO.noticeTotalPost();
	}
	@Override
	public List<ReviewDTO> reviewList(int start, int pageSize) {
		// TODO Auto-generated method stub
		return catDogDAO.reviewList(start, pageSize);
	}
	@Override
	public int reviewTotalPost() {
		// TODO Auto-generated method stub
		return catDogDAO.reviewTotalPost();
	}
	@Override
	public List<QnaDTO> qnaList(int start, int pageSize) {
		// TODO Auto-generated method stub
		return catDogDAO.qnaList(start, pageSize);
	}
	@Override
	public int qnaTotalPost() {
		// TODO Auto-generated method stub
		return catDogDAO.qnaTotalPost();
	}
	@Override
	public List<FaqDTO> faqList(int start, int pageSize) {
		// TODO Auto-generated method stub
		return catDogDAO.faqList(start, pageSize);
	}
	@Override
	public int faqTotalPost() {
		// TODO Auto-generated method stub
		return catDogDAO.faqTotalPost();
	}
	@Override
	public List<FaqDTO> faqListDivision(int start, int pageSize, int faq_division) {
		// TODO Auto-generated method stub
		return catDogDAO.faqListDivision(start, pageSize, faq_division);
	}
	@Override
	public int faqTotalPostDivision(int faq_division) {
		// TODO Auto-generated method stub
		return catDogDAO.faqTotalPostDivision(faq_division);
	}
	
	@Override
	public NoticeDTO noticeDetail(int notice_no) {
		// TODO Auto-generated method stub
		return catDogDAO.noticeDetail(notice_no);
	}
	@Override
	public ReviewDTO reviewDetail(int review_no) {
		// TODO Auto-generated method stub
		return catDogDAO.reviewDetail(review_no);
	} 
	
	@Override
	public QnaDTO qnaDetail(int qna_no) {
		// TODO Auto-generated method stub
		return catDogDAO.qnaDetail(qna_no);
	}
	@Override
	public FaqDTO faqDetail(int faq_no) {
		// TODO Auto-generated method stub
		return catDogDAO.faqDetail(faq_no);
	}
	@Override
	public int noticeRegister(NoticeDTO noticeDTO) {
		// TODO Auto-generated method stub
		return catDogDAO.noticeRegister(noticeDTO);
	}
	@Override
	public int noticeUpdate(NoticeDTO noticeDTO) {
		// TODO Auto-generated method stub
		return catDogDAO.noticeUpdate(noticeDTO);
	}
	@Override
	public int noticeDelete(int notice_no) {
		// TODO Auto-generated method stub
		return catDogDAO.noticeDelete(notice_no);
	}
	@Override
	public int qnaRegister(QnaDTO qnaDTO) {
		// TODO Auto-generated method stub
		return catDogDAO.qnaRegister(qnaDTO);
	}
	@Override
	public int qnaUpdate(QnaDTO qnaDTO) {
		// TODO Auto-generated method stub
		return catDogDAO.qnaUpdate(qnaDTO);
	}
	@Override
	public int qnaDelete(int qna_no) {
		// TODO Auto-generated method stub
		return catDogDAO.qnaDelete(qna_no);
	}
	@Override
	public QnaDTO qnaReplyDetail(int qna_no) {
		// TODO Auto-generated method stub
		return catDogDAO.qnaReplyDetail(qna_no);
	}
	@Override
	public int qnaReply(QnaDTO qnaDTO) {
		// TODO Auto-generated method stub
		return catDogDAO.qnaReply(qnaDTO);
	}
	@Override
	public int qnaReplyUpdate(QnaDTO qnaDTO) {
		// TODO Auto-generated method stub
		return catDogDAO.qnaReplyUpdate(qnaDTO);
	}

	@Override
	public int qnaReplyDelete(int qna_no) {
		// TODO Auto-generated method stub
		return catDogDAO.qnaReplyDelete(qna_no);
	}
//	@Override
//	public List<ProductDTO> productList(int start, int pageSize) {
//		// TODO Auto-generated method stub
//		return catDogDAO.productList(start, pageSize);
//	}
	@Override
	public List<ProductDTO> productSearch(String keyword) {
		// TODO Auto-generated method stub
		return catDogDAO.productSearch(keyword);
	}
	@Override
	public int productTotal() {
		// TODO Auto-generated method stub
		return catDogDAO.productTotal();
	}
	@Override
	public int faqRegister(FaqDTO faqDTO) {
		// TODO Auto-generated method stub
		return catDogDAO.faqRegister(faqDTO);
	}
	@Override
	public int noticeUpdateReadCnt(int notice_no) {
		// TODO Auto-generated method stub
		return catDogDAO.noticeUpdateReadCnt(notice_no);
	}
	@Override
	public int reviewUpdateReadCnt(int review_no) {
		// TODO Auto-generated method stub
		return catDogDAO.reviewUpdateReadCnt(review_no);
	}
	@Override
	public int faqUpdate(FaqDTO faqDTO) {
		// TODO Auto-generated method stub
		return catDogDAO.faqUpdate(faqDTO);
	}

	@Override
	public int faqDelete(int faq_no) {
		// TODO Auto-generated method stub
		return catDogDAO.faqDelete(faq_no);
	}	
	
}