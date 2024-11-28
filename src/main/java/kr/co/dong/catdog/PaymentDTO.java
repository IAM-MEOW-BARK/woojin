package kr.co.dong.catdog;

public class PaymentDTO {
	// 회원
	private String user_id;
	private String name;
	private int phone_num;
	private int zipcode;
	private String address;
	private String detail_address;
	// 상품
	private int product_code;
	private String product_name;
	private int product_price;
	private String thumbnail_img;
	// 수량
	private int cart_quantity;
	
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getPhone_num() {
		return phone_num;
	}
	public void setPhone_num(int phone_num) {
		this.phone_num = phone_num;
	}
	public int getZipcode() {
		return zipcode;
	}
	public void setZipcode(int zipcode) {
		this.zipcode = zipcode;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getDetail_address() {
		return detail_address;
	}
	public void setDetail_address(String detail_address) {
		this.detail_address = detail_address;
	}
	public int getProduct_code() {
		return product_code;
	}
	public void setProduct_code(int product_code) {
		this.product_code = product_code;
	}
	public String getProduct_name() {
		return product_name;
	}
	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}
	public int getProduct_price() {
		return product_price;
	}
	public void setProduct_price(int product_price) {
		this.product_price = product_price;
	}
	public String getThumbnail_img() {
		return thumbnail_img;
	}
	public void setThumbnail_img(String thumbnail_img) {
		this.thumbnail_img = thumbnail_img;
	}
	public int getCart_quantity() {
		return cart_quantity;
	}
	public void setCart_quantity(int cart_quantity) {
		this.cart_quantity = cart_quantity;
	}
	
	@Override
	public String toString() {
		return "PaymentDTO [user_id=" + user_id + ", name=" + name + ", phone_num=" + phone_num + ", zipcode=" + zipcode
				+ ", address=" + address + ", detail_address=" + detail_address + ", product_code=" + product_code
				+ ", product_name=" + product_name + ", product_price=" + product_price + ", thumbnail_img="
				+ thumbnail_img + ", cart_quantity=" + cart_quantity + "]";
	}
}
