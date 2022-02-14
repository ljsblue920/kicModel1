package model;

public class Member {
	String id,pass,name,tel,email,picture;
	int gender;
	
	public Member(String id, String pass, String name,int gender, String tel, String email, String picture) {
		super();
		this.id = id;
		this.pass = pass;
		this.name = name;
		this.tel = tel;
		this.email = email;
		this.picture = picture;
		this.gender = gender;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPass() {
		return pass;
	}

	public void setPass(String pass) {
		this.pass = pass;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPicture() {
		return picture;
	}

	public void setPicture(String picture) {
		this.picture = picture;
	}

	public int getGender() {
		return gender;
	}

	public void setGender(int gender) {
		this.gender = gender;
	}

	@Override
	public String toString() {
		return "Member [id=" + id + ", pass=" + pass + ", name=" + name + ", tel=" + tel + ", email=" + email
				+ ", picture=" + picture + ", gender=" + gender + "]";
	}

	
}
