package kr.co.dong.catdog;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;



@Service
public class CatDogServiceImpl implements CatDogService {
	@Inject
	private CatDogDAO catDogDAO;
	
	@Override
	public Map login(Map<String, Object>map) {
		// TODO Auto-generated method stub
		return catDogDAO.login(map);
	}

	@Override
	public int create(MemberDTO meber) throws Exception {
		// TODO Auto-generated method stub
		return catDogDAO.create(meber);
	}

	@Override
	public List<MemberDTO> getTotalMember() {
		// TODO Auto-generated method stub
		return catDogDAO.getTotalMember();
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
	public List<ProductDTO> getTotalProduct(int start, int pageSize) {
		// TODO Auto-generated method stub
		return catDogDAO.getTotalProduct(start, pageSize);
	}

	@Override
	public int productPaging() {
		// TODO Auto-generated method stub
		return catDogDAO.productPaging();
	}	

	/*
	 * @Override public List<BoardReply> detail1(int bno) { // TODO Auto-generated
	 * method stub return boardDAO.detail1(bno); }
	 */


	@Override
	public int deleteProduct(List<String> productCode) {
		// TODO Auto-generated method stub
		return catDogDAO.deleteProduct(productCode);
	}

	@Override
	public int deleteUser(String user_id) {
		// TODO Auto-generated method stub
		return 0;
	}}
