package kr.co.dong.catdog;

import java.util.List;
import java.util.Map;


public interface CatDogDAO {
	// 로그인
	public Map login(Map<String, Object> map);
	
	// 회원가입
	public int create(MemberDTO meber) throws Exception;
	
	// 이메일 중복
	public int getMemberByEmail(String user_id) throws Exception;
	
	// 회원 정보 찾기 (아이디)
	public int findId(String name, int phone_num) throws Exception;
	
	// 회원 정보 찾기 (비밀번호)
	public int findPw(String user_id, String name, int phone_num) throws Exception;
	
	//제품 캐러셀 리스트 출력
	public List <ProductDTO> list();
	
	// 찜하기 추가
    public int addWish(String user_id, int product_id) throws Exception;

    // 찜하기 삭제
    public int removeWish(String user_id, int product_id) throws Exception;
    
    /*장바구니 보류*/    
    // 장바구니 추가
    public int addCart(CartDTO cartDTO) throws Exception;
    
    // 장바구니 삭제
    public int deleteCart(int product_id) throws Exception;
    
    // 찜한 상품 리스트 조회
    public List<ProductDTO> getWish(String user_id) throws Exception;
    
    // 회원 정보 수정
    public int updateProfile(MemberDTO memberDTO);
    
    // 회원 탈퇴
	/* public int deleteUser(String user_id); */
    public int deleteUsers(List<String> userIds);

    // 최근 주문 내역 (최신 5개 등 제한)
    public List<OrderDTO> getRecentOrders(String user_id) throws Exception;

    // 전체 주문 내역
    public List<OrderDTO> getAllOrders(String user_id, String order_code) throws Exception;

    // 주문 내역 상세 표시
    public OrderDTO getOrderDetail(int order_code) throws Exception;
    
    /*관리자*/
    // 전체 상품 관리 리스트
    public List <ProductDTO> getTotalProduct(int start, int pageSize);
    
    // 상품 등록
    public int addProduct(ProductDTO productDTO) throws Exception;
    
    // 상품 수정
    public int updateProduct(ProductDTO productDTO);
    
    // 상품 삭제
    public int deleteProduct(List<String> productCode);
    
    // 전체 회원 리스트
    public List <MemberDTO> getTotalMember();
    
    // 회원 리스트 검색 필터
    List<Map<String, Object>> searchWithFilters(String searchType, String searchKeyword, String startDate, String endDate);
    
    // 회원 삭제 위에 deleteUser 참고
    
    // 결제 skip 2차
    
    // 상품 리스트 페이징
    public int productPaging();
}
