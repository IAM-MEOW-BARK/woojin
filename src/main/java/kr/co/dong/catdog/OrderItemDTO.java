package kr.co.dong.catdog;

public class OrderItemDTO {
	private String order_code;
	private int product_id;
	private String option_name;
	private int quantity;
	private int order_status;
	private int order_return;
	public String getOrder_code() {
		return order_code;
	}
	public void setOrder_code(String order_code) {
		this.order_code = order_code;
	}
	public int getProduct_id() {
		return product_id;
	}
	public void setProduct_id(int product_id) {
		this.product_id = product_id;
	}
	public String getOption_name() {
		return option_name;
	}
	public void setOption_name(String option_name) {
		this.option_name = option_name;
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	public int getOrder_status() {
		return order_status;
	}
	public void setOrder_status(int order_status) {
		this.order_status = order_status;
	}
	public int getOrder_return() {
		return order_return;
	}
	public void setOrder_return(int order_return) {
		this.order_return = order_return;
	}
	
	@Override
	public String toString() {
		return "OrderItemDTO [order_code=" + order_code + ", product_id=" + product_id + ", option_name=" + option_name
				+ ", quantity=" + quantity + ", order_status=" + order_status + ", order_return=" + order_return + "]";
	}
}
