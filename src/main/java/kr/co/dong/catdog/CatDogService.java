package kr.co.dong.catdog;

import java.util.List;
import java.util.Map;

public interface CatDogService {
	// 로그인
	public Map login(Map<String, Object> map);
	
	// 회원가입
	public int create(MemberDTO meber) throws Exception;
	
	// 전체 회원 리스트
	public List <MemberDTO> getTotalMember();
	
	// 회원 탈퇴
	public int deleteUser(String user_id);
	public int deleteUsers(List<String> userIds);
}
