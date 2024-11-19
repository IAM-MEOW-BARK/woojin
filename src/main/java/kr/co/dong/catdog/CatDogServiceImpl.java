package kr.co.dong.catdog;

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
	
	/*
	 * @Override public List<BoardReply> detail1(int bno) { // TODO Auto-generated
	 * method stub return boardDAO.detail1(bno); }
	 */
}
