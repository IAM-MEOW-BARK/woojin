package kr.co.dong.catdog;

import java.util.Map;

public interface CatDogService {
	// 로그인
	public Map login(Map<String, Object> map);
	
	// 회원가입
	public int create(MemberDTO meber) throws Exception;
}
