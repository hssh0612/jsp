package member;

import java.sql.Timestamp;

// member 테이블과 매핑
// DTO(Data Transfer Object), VO(Value Object)
// MemberDTO, MemberVO
// 멤버 테이블 생성 - 9개의 필드로 구성
// id(아이디), pwd(비밀번호), name(이름), birthday(생년월일), email(이메일), tel(전화번호), address1(기본주소), address2(상세주소), reg_date(가입일)
public class MemberDataBean {
	private String id;
	private String pwd;
	private String name;
	private String birthday;
	private String email;
	private String tel;
	private String address1;
	private String address2;
	private Timestamp reg_date;
	
	public String getId() {
		return id;
	}
	
	public String getPwd() {
		return pwd;
	}
	
	public String getName() {
		return name;
	}
	
	public String getBirthday() {
		return birthday;
	}
	
	public String getEmail() {
		return email;
	}
	
	public String getTel() {
		return tel;
	}
	
	public String getAddress1() {
		return address1;
	}
	
	public String getAddress2() {
		return address2;
	}
	
	public Timestamp getReg_date() {
		return reg_date;
	}
	
	public void setId(String id) {
		this.id = id;
	}
	
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	
	public void setName(String name) {
		this.name = name;
	}
	
	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}
	
	public void setEmail(String email) {
		this.email = email;
	}
	
	public void setTel(String tel) {
		this.tel = tel;
	}
	
	public void setAddress1(String address1) {
		this.address1 = address1;
	}
	
	public void setAddress2(String address2) {
		this.address2 = address2;
	}
	
	public void setReg_date(Timestamp reg_date) {
		this.reg_date = reg_date;
	}

	@Override
	public String toString() {
		return "MemberDataBean [id=" + id + ", pwd=" + pwd + ", name=" + name + ", birthday=" + birthday + ", email="
				+ email + ", tel=" + tel + ", address1=" + address1 + ", address2=" + address2 + ", reg_date="
				+ reg_date + "]";
	}
	
	
}
