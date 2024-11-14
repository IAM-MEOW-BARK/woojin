package kr.co.dong.board;

public class Criteria {
	private int page; // 페이지 번호
	private int perPageNum; // 페이지당 게시글 갯수
	private int rowStart; // 페이지 한 행의 첫번째 게시물 rowNum
	private int rowEnd; // 페이지 한 행의 마지막 게시물 rowNum
	
	public Criteria() {
		this.page = 1; // 페이지 1로 초기화
		this.perPageNum = 10; // 페이지당 게시글 10개
	}
	
	public int getPage() {
		return page;
	}
	
	public void setPage(int page) { // 페이지 번호 set
		if(page <= 0) {
			this.page = 1;
		}
		this.page = page;
	}
	
	public int getPerPageNum() {
		return perPageNum;
	}
	
	public void setPerPageNum(int perPageNum) {
		// 페이지당 게시물 갯수 set
		if(perPageNum <= 0 || perPageNum > 100) {
			this.perPageNum = 10;
		}
		this.perPageNum = perPageNum;
	}
	
    public int getPageStart() {
        // 현재 페이지의 페이지당 게시글 수를 곱하여
        // 현재 페이지의 시작 게시글 ROWNUM수를 구하는것
        return (this.page - 1) * perPageNum;
    }
	
	public int getRowStart() {
		return rowStart;
	}
	
	public void setRowStart(int rowStart) {
		this.rowStart = rowStart;
	}
	
	public int getRowEnd() {
		return rowEnd;
	}
	
	public void setRowEnd(int rowEnd) {
		this.rowEnd = rowEnd;
	}

	@Override
	public String toString() {
		return "Criteria [page=" + page + ", perPageNum=" + perPageNum + ", rowStart=" + rowStart + ", rowEnd=" + rowEnd
				+ "]";
	}
}
