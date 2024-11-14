package kr.co.dong.board;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

@Repository
public class BoardDAOImpl implements BoardDAO{
	
	@Inject SqlSession sqlSession;
	
	private static final String namespace ="kr.co.dong.boardMapper";

//	@Override
//	public List<BoardDTO> list() {
//		// TODO Auto-generated method stub
//		return sqlSession.selectList(namespace + ".list");
//	}

	@Override
	public BoardDTO detail(int bno) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(namespace + ".detail", bno);
	}
	
	@Override
	public int update(BoardDTO boardDto) {
		// TODO Auto-generated method stub
		return sqlSession.update(namespace + ".update", boardDto);
	}

	@Override
	public int delete(int bno) {
		// TODO Auto-generated method stub
		return sqlSession.update(namespace + ".delete", bno);
	}

	@Override
	public Map login(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(namespace + ".login", map);
	}

	@Override
	public int register(BoardDTO boardDto) {
		// TODO Auto-generated method stub
		return sqlSession.insert(namespace + ".register", boardDto);
	}

	@Override
	public int updateReadCnt(int bno) {
		// TODO Auto-generated method stub
		return sqlSession.insert(namespace + ".updateReadCnt", bno);
	}

	@Override
	public int reply(BoardReply boardReply) {
		// TODO Auto-generated method stub
		return sqlSession.insert(namespace + ".reply", boardReply);
	}

	@Override
	public List<BoardReply> replylist(int bno) {
		// TODO Auto-generated method stub
		return sqlSession.selectList(namespace + ".replylist", bno);
	}

	@Override
	public BoardReply detailreply(int reno) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(namespace + ".detailreply", reno);
	}

	@Override
	public int replyUpdate(BoardReply boardReply) {
		// TODO Auto-generated method stub
		return sqlSession.update(namespace + ".replyupdate", boardReply);
	}

	@Override
	public int readCnt(int bno) {
		// TODO Auto-generated method stub
		return sqlSession.update(namespace + ".readCnt", bno);
	}

	@Override
	public int replydelete(int reno) {
		// TODO Auto-generated method stub
		return sqlSession.delete(namespace + ".deletereply", reno);
	}

	@Override
	public int totalRecord() {
		// TODO Auto-generated method stub		
		return sqlSession.selectOne(namespace + ".totalRecord");
	}

	@Override
	public List<BoardDTO> pagingList(int start, int end) {
		// TODO Auto-generated method stub
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put("start", start);
		map.put("end", end);
		
		return sqlSession.selectList(namespace + ".findAll", map);
	}
}
