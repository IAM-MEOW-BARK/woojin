package kr.co.dong.catdog;

public class BoardDTO {
	private int board_no;
	private String board_title;
	private String board_content;
	private String board_date;
	private int board_readcnt;
	public int getBoard_no() {
		return board_no;
	}
	public void setBoard_no(int board_no) {
		this.board_no = board_no;
	}
	public String getBoard_title() {
		return board_title;
	}
	public void setBoard_title(String board_title) {
		this.board_title = board_title;
	}
	public String getBoard_content() {
		return board_content;
	}
	public void setBoard_content(String board_content) {
		this.board_content = board_content;
	}
	public String getBoard_date() {
		return board_date;
	}
	public void setBoard_date(String board_date) {
		this.board_date = board_date;
	}
	public int getBoard_readcnt() {
		return board_readcnt;
	}
	public void setBoard_readcnt(int board_readcnt) {
		this.board_readcnt = board_readcnt;
	}
	@Override
	public String toString() {
		return "BoardDTO [board_no=" + board_no + ", board_title=" + board_title + ", board_content=" + board_content
				+ ", board_date=" + board_date + ", board_readcnt=" + board_readcnt + "]";
	}
}
