package kr.co.dong.catdog;

public class QADTO {

	private int qa_no;
	private int product_id;
	private String qa_content;
	private String qa_date;
	private String qa_reply;
	private boolean secret;
	private String user_id;

	public QADTO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public int getQa_no() {
		return qa_no;
	}
	public void setQa_no(int qa_no) {
		this.qa_no = qa_no;
	}
	public int getProduct_id() {
		return product_id;
	}
	public void setProduct_id(int product_id) {
		this.product_id = product_id;
	}
	public String getQa_content() {
		return qa_content;
	}
	public void setQa_content(String qa_content) {
		this.qa_content = qa_content;
	}
	public String getQa_date() {
		return qa_date;
	}
	public void setQa_date(String qa_date) {
		this.qa_date = qa_date;
	}
	public String getQa_reply() {
		return qa_reply;
	}
	public void setQa_reply(String qa_reply) {
		this.qa_reply = qa_reply;
	}
	public boolean isSecret() {
		return secret;
	}
	public void setSecret(boolean secret) {
		this.secret = secret;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	@Override
	public String toString() {
		return "QADTO [qa_no=" + qa_no + ", product_id=" + product_id + ", qa_content=" + qa_content + ", qa_date="
				+ qa_date + ", qa_reply=" + qa_reply + ", secret=" + secret + ", user_id=" + user_id + "]";
	}	
}
