package kr.co.dong.catdog;

public class QnaDTO {
	private int qna_no;
	private int product_code_fk;
	private String user_id;
	private String qna_content;
	private int qna_secret;
	private String qna_date;
	private String qna_reply;
	private String qna_pwd;
	private String product_name;
	public int getQna_no() {
		return qna_no;
	}
	public void setQna_no(int qna_no) {
		this.qna_no = qna_no;
	}
	public int getProduct_code_fk() {
		return product_code_fk;
	}
	public void setProduct_code_fk(int product_code_fk) {
		this.product_code_fk = product_code_fk;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getQna_content() {
		return qna_content;
	}
	public void setQna_content(String qna_content) {
		this.qna_content = qna_content;
	}
	public int getQna_secret() {
		return qna_secret;
	}
	public void setQna_secret(int qna_secret) {
		this.qna_secret = qna_secret;
	}
	public String getQna_date() {
		return qna_date;
	}
	public void setQna_date(String qna_date) {
		this.qna_date = qna_date;
	}
	public String getQna_reply() {
		return qna_reply;
	}
	public void setQna_reply(String qna_reply) {
		this.qna_reply = qna_reply;
	}
	public String getQna_pwd() {
		return qna_pwd;
	}
	public void setQna_pwd(String qna_pwd) {
		this.qna_pwd = qna_pwd;
	}
	public String getProduct_name() {
		return product_name;
	}
	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}
	@Override
	public String toString() {
		return "QnaDTO [qna_no=" + qna_no + ", product_code_fk=" + product_code_fk + ", user_id=" + user_id
				+ ", qna_content=" + qna_content + ", qna_secret=" + qna_secret + ", qna_date=" + qna_date
				+ ", qna_reply=" + qna_reply + ", qna_pwd=" + qna_pwd + ", product_name=" + product_name + "]";
	}
	
	
}
