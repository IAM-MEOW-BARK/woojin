package kr.co.dong.catdog;

public class OrderDTO {
	private String order_code;
	private String user_id;
	private String ordered_at;
	private int product_cost;
	private int payment_status;
	
	public String getOrder_code() {
		return order_code;
	}
	public void setOrder_code(String order_code) {
		this.order_code = order_code;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getOrdered_at() {
		return ordered_at;
	}
	public void setOrdered_at(String ordered_at) {
		this.ordered_at = ordered_at;
	}
	public int getProduct_cost() {
		return product_cost;
	}
	public void setProduct_cost(int product_cost) {
		this.product_cost = product_cost;
	}
	public int getPayment_status() {
		return payment_status;
	}
	public void setPayment_status(int payment_status) {
		this.payment_status = payment_status;
	}
	
	@Override
	public String toString() {
		return "OrderDTO [order_code=" + order_code + ", user_id=" + user_id + ", ordered_at=" + ordered_at
				+ ", product_cost=" + product_cost + ", payment_status=" + payment_status + "]";
	}
}
