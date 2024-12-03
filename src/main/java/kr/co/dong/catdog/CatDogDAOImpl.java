package kr.co.dong.catdog;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

@Repository
public class CatDogDAOImpl implements CatDogDAO{
	
	@Inject SqlSession sqlSession;	
	
	private static final String namespace ="kr.co.dong.boardMapper";

	@Override
	public Map login(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(namespace + ".login", map);
	}
	
	 @Override
	    public void updateConnectedAt(Map<String, Object> map) {
	        sqlSession.update(namespace + ".updateConnectedAt", map); // connected_at 업데이트 실행
 }

	@Override
	public int create(MemberDTO meber) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.insert(namespace + ".sign-up", meber);
	}

	@Override
	public int getMemberByEmail(String user_id) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(namespace + ".email-check", user_id);
	}

	@Override
	public Map findId(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(namespace + ".find-id", map);
	}

	@Override
	public Map findPw(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(namespace + ".find-pw", map);
	}

	@Override
	public List<ProductDTO> list() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int addWish(String user_id, int product_id) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int removeWish(String user_id, int product_id) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int addCart(CartDTO cartDTO) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int deleteCart(int product_id) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<ProductDTO> getWish(String user_id) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int updateProfile(MemberDTO memberDTO) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int deleteUsers(List<String> userIds) {
	    return sqlSession.update(namespace + ".deleteUsers", userIds);
	}
	/*
	 * public int deleteUser(String user_id) { // TODO Auto-generated method stub
	 * return sqlSession.update(namespace + ".deleteUser", user_id); }
	 */

	@Override
	public List<OrderDTO> getRecentOrders(String user_id) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<OrderDTO> getAllOrders(String user_id, String order_code) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public OrderDTO getOrderDetail(int order_code) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<ProductDTO> getTotalProduct(int start, int pageSize) {
		Map<String, Integer> map = new HashMap<>();
		map.put("start", start);
	    map.put("pageSize", pageSize);
	    
		// TODO Auto-generated method stub
		return sqlSession.selectList(namespace + ".getTotalProduct", map);
	}

	@Override
	public int addProduct(ProductDTO productDTO) {
		// TODO Auto-generated method stub
		return sqlSession.insert(namespace + ".add-product", productDTO);
	}
	
	@Override
	public int checkProductCode(int product_code) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(namespace + ".product-code-check" , product_code);
	}

	@Override
	public int updateProduct(ProductDTO productDTO) {
		// TODO Auto-generated method stub
		return sqlSession.update(namespace + ".updateProduct", productDTO);
	}

	@Override
	public int deleteProduct(List<String> productCode) {
		// TODO Auto-generated method stub
		return sqlSession.delete(namespace + ".deleteProduct", productCode);
	}

	@Override
	public List<MemberDTO> getTotalMember(int start, int pageSize) {
		Map<String, Integer> map = new HashMap<>();
		map.put("start", start);
	    map.put("pageSize", pageSize);
	    
		// TODO Auto-generated method stub
		return sqlSession.selectList(namespace + ".getTotalMember", map);
	}

	//
	@Override
	public List<Map<String, Object>> searchWithFilters(String searchType, String searchKeyword, String startDate,
			String endDate) {
		// TODO Auto-generated method stub
			Map<String, Object> params = new HashMap<>();
	        params.put("searchType", searchType);
	        params.put("searchKeyword", searchKeyword);
	        params.put("startDate", startDate);
	        params.put("endDate", endDate);
	
	        return sqlSession.selectList(namespace + ".searchWithFilters", params);
	}

	@Override
	public int productPaging() {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(namespace+".productPaging");
	}

	@Override
	public List<Map<String, Object>> productListFilter(String searchType, String searchKeyword, String startDate,
			String endDate) {
		// TODO Auto-generated method stub
		Map<String, Object> params = new HashMap<String, Object>();
        params.put("searchType", searchType);
        params.put("searchKeyword", searchKeyword);
        params.put("startDate", startDate);
        params.put("endDate", endDate);
        
		/*
		 * // 페이징 계산 int offset = (pageNum - 1) * pageSize; params.put("offset",
		 * offset); // 시작 인덱스 params.put("pageSize", pageSize); // 페이지 크기
		 */
        return sqlSession.selectList(namespace + ".productListFilter", params);
	}

	@Override
	public int memberPaging() {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(namespace+".memberPaging");
	}

	@Override
	public ProductDTO getProductByCode(int product_code) {
	    ProductDTO product = sqlSession.selectOne(namespace + ".getProductByCode", product_code);
	    System.out.println("DAO에서 조회된 상품: " + product); // 디버깅 로그
	    return product;
	}

	@Override
	public List<PaymentDTO> productPayment(String user_id) {
		// TODO Auto-generated method stub
		return sqlSession.selectList(namespace + ".productPayment", user_id);
	}

	 // 주문 총 결제액
    public int getTotalCost(String order_code) throws Exception {
       return sqlSession.selectOne(namespace + ".getTotalCost", order_code);
    }

	@Override
	public int productUser(String user_id) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(namespace + ".productPaymentMember" , user_id);
	}

	@Override
	public PaymentDTO getMember(String user_id) {
		// TODO Auto-generated method stub
		 PaymentDTO member = sqlSession.selectOne(namespace + ".getMember", user_id);
	     System.out.println("DAO: 회원 정보: " + member);
	     return member;
	}

	@Override
	public List<OrderItemDTO> getOrderInfo(String order_code) {
		// TODO Auto-generated method stub
		List<OrderItemDTO> orderInfo = sqlSession.selectList(namespace + ".getOrderInfo", order_code);
	    System.out.println("DAO: 주문 정보: " + orderInfo);
	    return orderInfo;
	}

	@Override
	public List<String> getOrderCodeByUserId(String user_id) {
	    return sqlSession.selectList(namespace + ".getOrderCodeByUserId", user_id);
	}
	
	// 결제
	@Override
	public void updateAddress(String user_id, String name, String phone_num, String zipcode, String address, String detailaddress) {
	    Map<String, Object> params = new HashMap<>();
	    params.put("user_id", user_id);
	    params.put("name", name);
	    params.put("phone_num", phone_num);
	    params.put("zipcode", zipcode);
	    params.put("address", address);
	    params.put("detailaddress", detailaddress);
	    sqlSession.update(namespace + ".updateAddress", params);
	}

	@Override
	public void updatePaymentStatus(String user_id) {
	    sqlSession.update(namespace + ".updatePaymentStatus", user_id);
	}	
	
	@Override
	public void deleteOrderItems(String user_id, List<Integer> product_code) {
		// TODO Auto-generated method stub
		Map<String, Object> params = new HashMap<>();
	    params.put("user_id", user_id);
	    params.put("product_code", product_code);

	    sqlSession.delete(namespace + ".deleteOrderItems", params);
	}

	@Override
	public List<Integer> getProductCodeByUserId(String user_id) {
	    return sqlSession.selectList(namespace + ".getProductCodeByUserId", user_id);
	}

	@Override
    public List<MemberDTO> searchMemberWithPaging(String searchType, String searchKeyword, String startDate,
                                                  String endDate, int start, int pageSize) {
        // 파라미터 생성
        Map<String, Object> params = new HashMap<>();
        params.put("searchType", searchType);
        params.put("searchKeyword", searchKeyword);
        params.put("startDate", startDate);
        params.put("endDate", endDate);
        params.put("start", start);
        params.put("pageSize", pageSize);

        // SQL 실행
        return sqlSession.selectList(namespace + ".searchMemberWithPaging", params);
    }
	
	@Override
    public int getFilteredMemberCount(String searchType, String searchKeyword, String startDate, String endDate) {
        // 파라미터 생성
        Map<String, Object> params = new HashMap<>();
        params.put("searchType", searchType);
        params.put("searchKeyword", searchKeyword);
        params.put("startDate", startDate);
        params.put("endDate", endDate);

        // SQL 실행
        return sqlSession.selectOne(namespace + ".getFilteredMemberCount", params);
    }

	@Override
	public List<ProductDTO> searchProductWithPaging(String searchType, String searchKeyword, String startDate,
			String endDate, int start, int pageSize) {
		 // 파라미터 생성
        Map<String, Object> params = new HashMap<>();
        params.put("searchType", searchType);
        params.put("searchKeyword", searchKeyword);
        params.put("startDate", startDate);
        params.put("endDate", endDate);
        params.put("start", start);
        params.put("pageSize", pageSize);

        // SQL 실행
        return sqlSession.selectList(namespace + ".searchProductWithPaging", params);
	}

	@Override
	public int getFilteredProductCount(String searchType, String searchKeyword, String startDate, String endDate) {
		// 파라미터 생성
        Map<String, Object> params = new HashMap<>();
        params.put("searchType", searchType);
        params.put("searchKeyword", searchKeyword);
        params.put("startDate", startDate);
        params.put("endDate", endDate);

        // SQL 실행
        return sqlSession.selectOne(namespace + ".getFilteredProductCount", params);
	}
	
	@Override
	public String addOrder(OrderDTO orderDTO) throws Exception {
	    sqlSession.insert(namespace + ".addOrder", orderDTO);
	    return orderDTO.getOrder_code(); // MyBatis에서 반환된 order_code 사용
	}

	@Override
	public void addOrderItems(List<OrderItemDTO> orderItems) throws Exception {
		sqlSession.insert(namespace + ".addOrderItems", orderItems);
	}
	
	 // 장바구니 정보
    public List<CartDTO> getCartInfo(String user_id) throws Exception {
    	return sqlSession.selectList(namespace + ".getCartInfo", user_id);
    }

    // 장바구니 상품 정보
    public List<CartDTO> getCartItem(String user_id) throws Exception {
    	return sqlSession.selectList(namespace + ".getCartItem", user_id);
    }
    
    // 마이페이지
    public List<MyDTO> getMyOrders(String user_id) throws Exception {
		return sqlSession.selectList(namespace + ".getMyOrders", user_id);
	}

    
}
