package kr.co.dong.catdog;

public class MemberDTO {
	private String user_id;
	private int social_id;
	private String password;
	private String name;
	private int phone_num;
	private int zipcode;
	private String address;
	private String detailaddress;
	private String user_address;
	private int user_auth;
	private String user_created_at;
	private int user_status;
	private String connected_at;
	
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public int getSocial_id() {
		return social_id;
	}
	public void setSocial_id(int social_id) {
		this.social_id = social_id;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
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
	public String getUser_address() {
		return user_address;
	}
	public void setUser_address(String user_address) {
		this.user_address = user_address;
	}
	public int getUser_auth() {
		return user_auth;
	}
	public void setUser_auth(int user_auth) {
		this.user_auth = user_auth;
	}
	public String getUser_created_at() {
		return user_created_at;
	}
	public void setUser_created_at(String user_created_at) {
		this.user_created_at = user_created_at;
	}
	public int getUser_status() {
		return user_status;
	}
	public void setUser_status(int user_status) {
		this.user_status = user_status;
	}
	public String getConnected_at() {
		return connected_at;
	}
	public void setConnected_at(String connected_at) {
		this.connected_at = connected_at;
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
	public String getDetailaddress() {
		return detailaddress;
	}
	public void setDetailaddress(String detailaddress) {
		this.detailaddress = detailaddress;
	}
	
	@Override
	public String toString() {
		return "MemberDTO [user_id=" + user_id + ", social_id=" + social_id + ", password=" + password + ", name="
				+ name + ", phone_num=" + phone_num + ", zipcode=" + zipcode + ", address=" + address
				+ ", detailaddress=" + detailaddress + ", user_address=" + user_address + ", user_auth=" + user_auth
				+ ", user_created_at=" + user_created_at + ", user_status=" + user_status + ", connected_at="
				+ connected_at + "]";
	}
}
