package kr.co.dong.catdog;

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
	public MemberDTO getMemberByEmail(String user_id) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}



	
}
