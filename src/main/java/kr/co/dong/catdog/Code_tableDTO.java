package kr.co.dong.catdog;

public class Code_tableDTO {
	private int code_type;
	private int code_value;
	private String code_desc;
	
	public int getCode_type() {
		return code_type;
	}
	public void setCode_type(int code_type) {
		this.code_type = code_type;
	}
	public int getCode_value() {
		return code_value;
	}
	public void setCode_value(int code_value) {
		this.code_value = code_value;
	}
	public String getCode_desc() {
		return code_desc;
	}
	public void setCode_desc(String code_desc) {
		this.code_desc = code_desc;
	}
	@Override
	public String toString() {
		return "Code_tableDTO [code_type=" + code_type + ", code_value=" + code_value + ", code_desc=" + code_desc
				+ "]";
	}
	
	
}
