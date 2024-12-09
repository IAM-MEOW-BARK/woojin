package kr.co.dong.catdog;

public class OrderItemDTO {
	private int order_item_id;
	private String order_code;
	private int product_code;
	private int cart_quantity;
	private int order_status;
	private int order_return;
	private int productPrice;
	
	private String thumbnail_img;
	private int order_quantity;
	private int total_price;
	private String product_name;
	
	
	public String getProduct_name() {
		return product_name;
	}
	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}
	public String getThumbnail_img() {
		return thumbnail_img;
	}
	public void setThumbnail_img(String thumbnail_img) {
		this.thumbnail_img = thumbnail_img;
	}
	public int getOrder_quantity() {
		return order_quantity;
	}
	public void setOrder_quantity(int order_quantity) {
		this.order_quantity = order_quantity;
	}
	public int getTotal_price() {
		return total_price;
	}
	public void setTotal_price(int total_price) {
		this.total_price = total_price;
	}
	public int getOrder_item_id() {
		return order_item_id;
	}
	public void setOrder_item_id(int order_item_id) {
		this.order_item_id = order_item_id;
	}
	public String getOrder_code() {
		return order_code;
	}
	public void setOrder_code(String order_code) {
		this.order_code = order_code;
	}
	public int getProduct_code() {
		return product_code;
	}
	public void setProduct_code(int product_code) {
		this.product_code = product_code;
	}
	public int getCart_quantity() {
		return cart_quantity;
	}
	public void setCart_quantity(int cart_quantity) {
		this.cart_quantity = cart_quantity;
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
	public int getProduct_price() {
		return productPrice;
	}
	public void setProduct_price(int product_price) {
		this.productPrice = product_price;
	}
	
	@Override
	public String toString() {
		return "OrderItemDTO [order_item_id=" + order_item_id + ", order_code=" + order_code + ", product_code="
				+ product_code + ", cart_quantity=" + cart_quantity + ", order_status=" + order_status + ", order_return="
				+ order_return + ", productPrice=" + productPrice + ", thumbnail_img=" + thumbnail_img
				+ ", order_quantity=" + order_quantity + ", total_price=" + total_price + ", product_name="
				+ product_name + "]";
	}
}
