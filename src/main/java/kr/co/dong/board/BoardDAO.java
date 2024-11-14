package kr.co.dong.board;

import java.util.List;
import java.util.Map;

public interface BoardDAO {	
	
	// 로그인
	public Map login(Map<String, Object> map);
	
	// 글 목록 조회
	/* public List <BoardDTO> list(); */
	
	// 글 상세보기
	public BoardDTO detail(int bno);
	public int updateReadCnt(int bno);	
	
	// 글 등록
	public int register(BoardDTO boardDTO);
		
	// 글 수정
	public int update(BoardDTO boardDTO);
	
	// 글 삭제
	public int delete(int bno);
	
	// 댓글 등록
	public int reply(BoardReply boardReply);
	
	// 게시물번호에 해당하는 댓글 조회
	public List <BoardReply> replylist(int bno);
	
	// 댓글 수정 보기
	public BoardReply detailreply(int reno);
	
	// 댓글 수정 처리
	public int replyUpdate(BoardReply boardReply);
	
	// 댓글 삭제
	public int replydelete(int reno);
	
	// 조회수 증가
	public int readCnt(int bno);
	
	// 페이징 처리
	public int totalRecord();
	
	public List<BoardDTO> pagingList(int start, int end);
}
