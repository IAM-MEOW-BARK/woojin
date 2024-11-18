package kr.co.dong.board;

import java.util.Map;


public interface CatDogDAO {
	// 로그인
	public Map login(Map<String, Object> map);
	
	// 회원가입
	public int create(MemberDTO meber) throws Exception;
	
	// 이메일 중복
	public MemberDTO getMemberByEmail(String user_id) throws Exception;
}
