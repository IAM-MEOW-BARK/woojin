package kr.co.dong.catdog;

import java.util.List;
import java.util.Map;

public interface CatDogService {
	// 로그인
	public Map login(Map<String, Object> map);
	
	// 아이디 찾기
	public Map findId(Map<String, Object> map);
	
	// 비밀번호 찾기
	public Map findPw(Map<String, Object> map);
	
	// 회원가입
	public int create(MemberDTO member) throws Exception;
	
	// 이메일 중복 체크
	public int getMemberByEmail(String user_id) throws Exception;
	
	// 전체 회원 리스트
	public List <MemberDTO> getTotalMember(int start, int pageSize);
	
	// 회원 탈퇴	
	public int deleteUsers(List<String> userIds);
	
	// 회원 리스트 검색 필터
	public List<Map<String, Object>> searchMember(String searchType, String searchKeyword, String startDate, String endDate);
	
	// 회원 리스트 페이징
	// 검색 조건과 페이징을 사용한 회원 리스트 조회
	public List<MemberDTO> searchMemberWithPaging(String searchType, String searchKeyword, String startDate, String endDate, int start, int pageSize);
	// 검색 조건에 맞는 회원 수 조회
	public int getFilteredMemberCount(String searchType, String searchKeyword, String startDate, String endDate);
		
	// 상품 등록
    public int addProduct(ProductDTO productDTO) throws Exception;
    
    // 상품 코드 중복 체크
 	public int checkProductCode(int product_code) throws Exception;
    
    // 상품 수정
    public int updateProduct(ProductDTO productDTO);
    
    // 상품 삭제
    public int deleteProduct(List<String> productCode);
    
    // 상품 결제
    public List<PaymentDTO> productPayment(String user_id);
    
    // 상품 유저
    public int productUser(String user_id);
    
    // 상품 총액
    public int getTotalCost(String order_code) throws Exception;
    
    // 전체 상품 관리 리스트
    public List <ProductDTO> getTotalProduct(int start, int pageSize);
    
    // 상품 리스트 검색 필터
    public List<Map<String, Object>> searchProduct(String searchType, String searchKeyword, String startDate, String endDate);
    
    // 검색 조건과 페이징을 사용한 상품 리스트 조회
 	public List<ProductDTO> searchProductWithPaging(String searchType, String searchKeyword, String startDate, String endDate, int start, int pageSize);
 	// 검색 조건에 맞는 상품 수 조회
 	public int getFilteredProductCount(String searchType, String searchKeyword, String startDate, String endDate);
    
    // 상품 단일 조회
    public ProductDTO getProductByCode(int product_code);
    
    // 상품 목록 페이징
    public int productPaging();
    
    // 상품 리스트 페이징
    public int memberPaging();
    
    // 결제 페이지 단일 회원
    public PaymentDTO getMember(String user_id);
    
    // 결제 오더 정보
    public List<OrderItemDTO> getOrderInfo(String order_code);
    public List<String> getOrderCodeByUserId(String user_id);
    
    // 결제
    public void updateAddress(String user_id, String name, String phone_num, String zipcode, String address, String detailaddress);
    public void updatePaymentStatus(String user_id);
    public void deleteOrderItems(String user_id, List<Integer> product_code);
    public List<Integer> getProductCodeByUserId(String user_id);
    
    // 카트
	public String addOrder(OrderDTO orderDTO) throws Exception;
	public void addOrderItems(List<OrderItemDTO> orderItems) throws Exception;
	public List<CartDTO> getCartInfo(String user_id) throws Exception;
	public List<CartDTO> getCartItem(String user_id) throws Exception;
	
	// 장바구니
	public List<MyDTO> getMyOrders(String user_id) throws Exception;
}
