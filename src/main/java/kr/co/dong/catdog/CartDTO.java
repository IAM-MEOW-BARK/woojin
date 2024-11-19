package kr.co.dong.catdog;

public class CartDTO {
	private String user_id;
	private int product_id;	
	private int cart_quantity;
	
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
	public int getCart_quantity() {
		return cart_quantity;
	}
	public void setCart_quantity(int cart_quantity) {
		this.cart_quantity = cart_quantity;
	}
	@Override
	public String toString() {
		return "CartDTO [user_id=" + user_id + ", product_id=" + product_id + ", cart_quantity=" + cart_quantity + "]";
	}
}
