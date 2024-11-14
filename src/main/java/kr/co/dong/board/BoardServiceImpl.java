package kr.co.dong.board;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

@Service
public class BoardServiceImpl implements BoardService {
	@Inject
	private BoardDAO boardDAO;

	@Override
	public Map login(Map<String, Object>map) {
		// TODO Auto-generated method stub
		return boardDAO.login(map);
	}

//	@Override
//	public List<BoardDTO> list() {
//		// TODO Auto-generated method stub
//		return boardDAO.list();
//	}

	@Override
	public BoardDTO detail(int bno) {
		// TODO Auto-generated method stub
		return boardDAO.detail(bno);
	}

	@Override
	public int register(BoardDTO boardDTO) {
		// TODO Auto-generated method stub
		return boardDAO.register(boardDTO);
	}

	@Override
	public int update(BoardDTO boardDto) {
		// TODO Auto-generated method stub
		return boardDAO.update(boardDto);
	}
	
	@Override
	public int readCnt(int bno) {
		// TODO Auto-generated method stub
		return boardDAO.readCnt(bno);
	}

	@Override
	public int delete(int bno) {
		// TODO Auto-generated method stub
		return boardDAO.delete(bno);
	}

	@Override
	public int reply(BoardReply boardReply) {
		// TODO Auto-generated method stub
		return boardDAO.reply(boardReply);
	}

	@Override
	public List<BoardReply> replylist(int bno) {
		// TODO Auto-generated method stub
		return boardDAO.replylist(bno);
	}

	@Override
	public int replyUpdate(BoardReply boardReply) {
		// TODO Auto-generated method stub
		return boardDAO.replyUpdate(boardReply);
	}

	@Override
	public int replydelete(int reno) {
		// TODO Auto-generated method stub
		return boardDAO.replydelete(reno);
	}

	@Override
	public int totalRecord() {
		// TODO Auto-generated method stub
		return boardDAO.totalRecord();
	}

	@Override
	public List<BoardDTO> pagingList(int start, int end) {
		// TODO Auto-generated method stub
		return boardDAO.pagingList(start, end);
	}
	

	/*
	 * @Override public List<BoardReply> detail1(int bno) { // TODO Auto-generated
	 * method stub return boardDAO.detail1(bno); }
	 */
}
