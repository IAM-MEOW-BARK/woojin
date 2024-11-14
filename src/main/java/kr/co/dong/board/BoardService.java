package kr.co.dong.board;

import java.util.List;
import java.util.Map;

public interface BoardService {
	// 로그인
		public Map login(Map<String, Object> map);
		
		// 글 목록 조회
		/* public List <BoardDTO> list(); */ 
		
		// 글 선택
		public BoardDTO detail(int bno);
		
		// 글 등록
		public int register(BoardDTO boardDto);
		
		// 글 수정
		public int update(BoardDTO boardDto);
		
		// 글 삭제
		public int delete(int bno);
		
		// 조회수 증가
		public int readCnt(int bno);
		
		// 댓글 조회
		public List <BoardReply> replylist(int bno);
		
		// 댓글 등록
		public int reply(BoardReply boardReply);
		
		// 댓글 수정 처리
		public int replyUpdate(BoardReply boardReply);
		
		// 댓글 삭제
		public int replydelete(int reno);
		
		// 페이징 처리
		public int totalRecord();
		
		public List<BoardDTO> pagingList(int start, int end);
//		public List<BoardDTO> paginList(cri)
}
