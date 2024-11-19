package kr.co.dong.catdog;

public class ReviewDTO {

	private int review_no;
	private int product_id;
	private String user_id;
	private int review_score;
	private String review_img;
	private String review_content;
	private String review_date;
	private int review_readcnt;
	private int order_status;
	private int option_num;
	
	public ReviewDTO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public int getReview_no() {
		return review_no;
	}

	public void setReview_no(int review_no) {
		this.review_no = review_no;
	}

	public int getProduct_id() {
		return product_id;
	}

	public void setProduct_id(int product_id) {
		this.product_id = product_id;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public int getReview_score() {
		return review_score;
	}

	public void setReview_score(int review_score) {
		this.review_score = review_score;
	}

	public String getReview_img() {
		return review_img;
	}

	public void setReview_img(String review_img) {
		this.review_img = review_img;
	}

	public String getReview_content() {
		return review_content;
	}

	public void setReview_content(String review_content) {
		this.review_content = review_content;
	}

	public String getReview_date() {
		return review_date;
	}

	public void setReview_date(String review_date) {
		this.review_date = review_date;
	}

	public int getReview_readcnt() {
		return review_readcnt;
	}

	public void setReview_readcnt(int review_readcnt) {
		this.review_readcnt = review_readcnt;
	}

	public int getOrder_status() {
		return order_status;
	}

	public void setOrder_status(int order_status) {
		this.order_status = order_status;
	}

	public int getOption_num() {
		return option_num;
	}

	public void setOption_num(int option_num) {
		this.option_num = option_num;
	}

	@Override
	public String toString() {
		return "ReviewDTO [review_no=" + review_no + ", product_id=" + product_id + ", user_id=" + user_id
				+ ", review_score=" + review_score + ", review_img=" + review_img + ", review_content=" + review_content
				+ ", review_date=" + review_date + ", review_readcnt=" + review_readcnt + ", order_status="
				+ order_status + ", option_num=" + option_num + "]";
	}	
}
