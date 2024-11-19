package kr.co.dong.catdog;

public class ProductOptionDTO {

	private int product_id;
	private int option_num;
	private String option_name;
	private int option_price;
	
	public int getProduct_id() {
		return product_id;
	}
	public void setProduct_id(int product_id) {
		this.product_id = product_id;
	}
	public int getOption_num() {
		return option_num;
	}
	public void setOption_num(int option_num) {
		this.option_num = option_num;
	}
	public String getOption_name() {
		return option_name;
	}
	public void setOption_name(String option_name) {
		this.option_name = option_name;
	}
	public int getOption_price() {
		return option_price;
	}
	public void setOption_price(int option_price) {
		this.option_price = option_price;
	}
	
	@Override
	public String toString() {
		return "productOptionDTO [product_id=" + product_id + ", option_num=" + option_num + ", option_name="
				+ option_name + ", option_price=" + option_price + "]";
	}
	
}
