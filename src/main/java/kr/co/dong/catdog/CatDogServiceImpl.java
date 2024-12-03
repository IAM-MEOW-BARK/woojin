package kr.co.dong.catdog;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

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
	public int create(MemberDTO meber) throws Exception {
		// TODO Auto-generated method stub
		return catDogDAO.create(meber);
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
	public PaymentDTO getMember(String user_id) {
		// TODO Auto-generated method stub
		PaymentDTO member = catDogDAO.getMember(user_id);
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

		// 데이터베이스 삽입
		return catDogDAO.addOrder(orderDTO);
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
	
	public List<MyDTO> getMyOrders(String user_id) throws Exception {
		return catDogDAO.getMyOrders(user_id);
	}

	
	
}