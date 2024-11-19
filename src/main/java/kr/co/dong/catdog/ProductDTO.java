package kr.co.dong.catdog;

public class ProductDTO {
	private int product_id;
	private String product_name;
	private String thumbnail_img;
	private String product_img;
	private String product_info;
	private String created_at;
	private String changed_at;
	public int getProduct_id() {
		return product_id;
	}
	public void setProduct_id(int product_id) {
		this.product_id = product_id;
	}
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
	public String getProduct_img() {
		return product_img;
	}
	public void setProduct_img(String product_img) {
		this.product_img = product_img;
	}
	public String getProduct_info() {
		return product_info;
	}
	public void setProduct_info(String product_info) {
		this.product_info = product_info;
	}
	public String getCreated_at() {
		return created_at;
	}
	public void setCreated_at(String created_at) {
		this.created_at = created_at;
	}
	public String getChanged_at() {
		return changed_at;
	}
	public void setChanged_at(String changed_at) {
		this.changed_at = changed_at;
	}
	@Override
	public String toString() {
		return "ProductDTO [product_id=" + product_id + ", product_name=" + product_name + ", thumbnail_img="
				+ thumbnail_img + ", product_img=" + product_img + ", product_info=" + product_info + ", created_at="
				+ created_at + ", changed_at=" + changed_at + "]";
	}
	
	
	
}
