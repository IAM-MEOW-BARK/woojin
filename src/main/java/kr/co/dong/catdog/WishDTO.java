package kr.co.dong.catdog;

public class WishDTO {

	private String user_id;
	private int product_id;	
	
	public WishDTO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public int getProduct_id() {
		return product_id;
	}
	public void setProduct_id(int product_id) {
		this.product_id = product_id;
	}
	
	@Override
	public String toString() {
		return "WishDTO [user_id=" + user_id + ", product_id=" + product_id + "]";
	}	
}
