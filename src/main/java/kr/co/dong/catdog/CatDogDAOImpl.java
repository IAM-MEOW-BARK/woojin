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
	public int findId(String name, int phone_num) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int findPw(String user_id, String name, int phone_num) throws Exception {
		// TODO Auto-generated method stub
		return 0;
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
	public int updateProduct(ProductDTO productDTO) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int deleteProduct(List<String> productCode) {
		// TODO Auto-generated method stub
		return sqlSession.delete(namespace + ".delete-product", namespace);
	}

	@Override
	public List<MemberDTO> getTotalMember() {
		// TODO Auto-generated method stub
		return sqlSession.selectList(namespace + ".getTotalMember");
	}

	@Override
	public int deleteUser(String user_id) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<Map<String, Object>> searchWithFilters(String searchType, String searchKeyword, String startDate,
			String endDate) {
		// TODO Auto-generated method stub
			Map<String, Object> params = new HashMap<String, Object>();
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
	
}
