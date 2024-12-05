package kr.co.dong.catdog;

import java.util.List;

public class OrderDetailDTO {
	// 주문 정보
	private String orderCode;
	private String userId;
	private String name;
	private String orderedAt;
	private String phoneNum;

	// 배송지 정보
	private String zipcode;
	private String address;
	private String detailAddress;

	// 상품 리스트
	private List<OrderItemDTO> orderItems;

	public String getOrderCode() {
		return orderCode;
	}

	public void setOrderCode(String orderCode) {
		this.orderCode = orderCode;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getName() {
		return name;
	}

	public void setUserName(String name) {
		this.name = name;
	}

	public String getOrderedAt() {
		return orderedAt;
	}

	public void setOrderedAt(String orderedAt) {
		this.orderedAt = orderedAt;
	}

	public String getPhoneNum() {
		return phoneNum;
	}

	public void setPhoneNum(String phoneNum) {
		this.phoneNum = phoneNum;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getZipcode() {
		return zipcode;
	}

	public void setZipcode(String zipcode) {
		this.zipcode = zipcode;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getDetailAddress() {
		return detailAddress;
	}

	public void setDetailAddress(String detailAddress) {
		this.detailAddress = detailAddress;
	}

	public List<OrderItemDTO> getOrderItems() {
		return orderItems;
	}

	public void setOrderItems(List<OrderItemDTO> orderItems) {
		this.orderItems = orderItems;
	}

	@Override
	public String toString() {
		return "OrderDetailDTO [orderCode=" + orderCode + ", userId=" + userId + ", name=" + name + ", orderedAt="
				+ orderedAt + ", phoneNum=" + phoneNum + ", zipcode=" + zipcode + ", address=" + address
				+ ", detailAddress=" + detailAddress + ", orderItems=" + orderItems + "]";
	}

}