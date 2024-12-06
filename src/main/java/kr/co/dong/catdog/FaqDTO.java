package kr.co.dong.catdog;

public class FaqDTO {
	private int faq_no;
	private int faq_division;
	private String faq_question;
	private String faq_reply;
	private String admin_pwd;
	
	public int getFaq_no() {
		return faq_no;
	}
	public void setFaq_no(int faq_no) {
		this.faq_no = faq_no;
	}
	public int getFaq_division() {
		return faq_division;
	}
	public void setFaq_division(int faq_division) {
		this.faq_division = faq_division;
	}
	public String getFaq_question() {
		return faq_question;
	}
	public void setFaq_question(String faq_question) {
		this.faq_question = faq_question;
	}
	public String getFaq_reply() {
		return faq_reply;
	}
	public void setFaq_reply(String faq_reply) {
		this.faq_reply = faq_reply;
	}
	public String getAdmin_pwd() {
		return admin_pwd;
	}
	public void setAdmin_pwd(String admin_pwd) {
		this.admin_pwd = admin_pwd;
	}
	@Override
	public String toString() {
		return "FaqDTO [faq_no=" + faq_no + ", faq_division=" + faq_division + ", faq_question=" + faq_question
				+ ", faq_reply=" + faq_reply + ", admin_pwd=" + admin_pwd + "]";
	}
	
	
	
}
