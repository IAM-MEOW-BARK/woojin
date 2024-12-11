package kr.co.dong.catdog;

public class OrderItemDetailDTO {

	private int productCode;
	private String thumbnailImg;
	private String productName;
	private int orderQuantity;
	private int productPrice;
	private int totalPrice; // 상품 가격 * 수량
	private String orderStatus;
	private boolean isReview;

	public int getProductPrice() {
		return productPrice;
	}

	public void setProductPrice(int productPrice) {
		this.productPrice = productPrice;
	}


	public boolean isReview() {
		return isReview;
	}

	public void setReview(boolean isReview) {
		this.isReview = isReview;
	}

	public int getProductCode() {
		return productCode;
	}

	public void setProductCode(int productCode) {
		this.productCode = productCode;
	}

	public String getThumbnailImg() {
		return thumbnailImg;
	}

	public void setThumbnailImg(String thumbnailImg) {
		this.thumbnailImg = thumbnailImg;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public int getOrderQuantity() {
		return orderQuantity;
	}

	public void setOrderQuantity(int orderQuantity) {
		this.orderQuantity = orderQuantity;
	}

	public int getTotalPrice() {
		return totalPrice;
	}

	public void setTotalPrice(int totalPrice) {
		this.totalPrice = totalPrice;
	}

	public String getOrderStatus() {
		return orderStatus;
	}

	public void setOrderStatus(String orderStatus) {
		this.orderStatus = orderStatus;
	}

	@Override
	public String toString() {
		return "OrderItemDetailDTO [productCode=" + productCode + ", thumbnailImg=" + thumbnailImg + ", productName="
				+ productName + ", orderQuantity=" + orderQuantity + ", productPrice=" + productPrice + ", totalPrice="
				+ totalPrice + ", orderStatus=" + orderStatus + ", isReview=" + isReview + "]";
	}

}
