package com.neova.bean;

public class UserBean {

	private String country;

	private String emailId;

	private String firstName;

	private int id;

	private String lastName;

	private String mobileNo;

	private String password;

	private String username;

	public String getCountry() {
		return country;
	}

	public String getEmailId() {
		return emailId;
	}

	public String getFirstName() {
		return firstName;
	}

	public int getId() {
		return id;
	}

	public String getLastName() {
		return lastName;
	}

	public String getMobileNo() {
		return mobileNo;
	}

	public String getPassword() {
		return password;
	}

	public String getUsername() {
		return username;
	}

	public void setCountry(String country) {
		this.country = country;
	}

	public void setEmailId(String emailId) {
		this.emailId = emailId;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public void setId(int id) {
		this.id = id;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public void setMobileNo(String mobileNo) {
		this.mobileNo = mobileNo;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String toString() {
		return "User Details :" + "\nFirst Name:\t" + getFirstName()
				+ "\nLast Name:\t" + getLastName() + "\nEmail Id:\t"
				+ getEmailId() + "\nCountry:\t" + getCountry()
				+ "\nMobile No:\t" + getMobileNo() + "\nUser Name:\t"
				+ getUsername() + "\nPassword:\t" + getPassword();

	}

}