package com.neova.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;

@Entity
public class UserAttempts {
	@Column(name = "attempts")
	private int attempts;

	@Id
	@GeneratedValue
	private int id;

	@Column(name = "lastModified")
	private String lastModified;

	@Column(name = "userName")
	private String userName;

	public int getAttempts() {
		return attempts;
	}

	public int getId() {
		return id;
	}

	public String getLastModified() {
		return lastModified;
	}

	public String getUsername() {
		return userName;
	}

	public void setAttempts(int attempts) {
		this.attempts = attempts;
	}

	public void setId(int id) {
		this.id = id;
	}

	public void setLastModified(String lastModified) {
		this.lastModified = lastModified;
	}

	public void setUsername(String username) {
		this.userName = username;
	}

}