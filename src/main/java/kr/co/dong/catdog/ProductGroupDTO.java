package kr.co.dong.catdog;

public class ProductGroupDTO {
	private int product_group_id;
	private String product_group_name;
	private int product_category;
	private String thumbnail_img;
	private String product_img;
	private String product_info;
	private String product_regdate;
	private String product_update;
	
	public int getProduct_group_id() {
		return product_group_id;
	}
	public void setProduct_group_id(int product_group_id) {
		this.product_group_id = product_group_id;
	}
	public String getProduct_group_name() {
		return product_group_name;
	}
	public void setProduct_group_name(String product_group_name) {
		this.product_group_name = product_group_name;
	}
	public int getProduct_category() {
		return product_category;
	}
	public void setProduct_category(int product_category) {
		this.product_category = product_category;
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
	public String getProduct_regdate() {
		return product_regdate;
	}
	public void setProduct_regdate(String product_regdate) {
		this.product_regdate = product_regdate;
	}
	public String getProduct_update() {
		return product_update;
	}
	public void setProduct_update(String product_update) {
		this.product_update = product_update;
	}
	
	@Override
	public String toString() {
		return "ProductGroupDTO [product_group_id=" + product_group_id + ", product_group_name=" + product_group_name
				+ ", product_category=" + product_category + ", thumbnail_img=" + thumbnail_img + ", product_img="
				+ product_img + ", product_info=" + product_info + ", product_regdate=" + product_regdate
				+ ", product_update=" + product_update + "]";
	}
}
