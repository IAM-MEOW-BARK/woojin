package kr.co.dong.catdog;

public class WishDTO {

	private String user_id;
	private int product_group_id;
	
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public int getProduct_group_id() {
		return product_group_id;
	}
	public void setProduct_group_id(int product_group_id) {
		this.product_group_id = product_group_id;
	}
	
	@Override
	public String toString() {
		return "WishDTO [user_id=" + user_id + ", product_group_id=" + product_group_id + "]";
	}
	
}
