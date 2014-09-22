package com.neova.model;

import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.OneToMany;

import org.codehaus.jackson.annotate.JsonIgnore;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;
import org.hibernate.annotations.SelectBeforeUpdate;

import com.neova.model.jointable.UserGroup;

@Entity
@DynamicUpdate(value = true)
@DynamicInsert(value = true)
@SelectBeforeUpdate(value = true)
public class User implements Serializable {

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result
				+ ((userName == null) ? 0 : userName.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		User other = (User) obj;
		if (userName == null) {
			if (other.userName != null)
				return false;
		} else if (!userName.equals(other.userName))
			return false;
		return true;
	}

	private static final long serialVersionUID = 4007596176781681354L;

	@Column(name = "accountNonExpired")
	private boolean accountNonExpired;

	@Column(name = "accountNonLocked")
	private boolean accountNonLocked;

	@Column(name = "credentialsNonExpired")
	private boolean credentialsNonExpired;

	@Column(name = "enabled")
	private boolean enabled;

	@Column(name = "firstName")
	private String firstName;

	@Column(name = "lastName")
	private String lastName;
	@Column(name = "password")
	private String password;

	@Column(name = "email")
	private String email;

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	@OneToMany(fetch = FetchType.EAGER, mappedBy = "userGroupID.user", cascade = CascadeType.ALL, orphanRemoval = true)
	@JsonIgnore
	private Set<UserGroup> userGroup = new HashSet<UserGroup>(0);

	@Id
	@Column(name = "userName")
	private String userName;

	public User() {
		// Default Constructor
	}

	public String getFirstName() {
		return firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public String getPassword() {
		return password;
	}

	public Set<UserGroup> getUserGroup() {
		return userGroup;
	}

	public String getUserName() {
		return userName;
	}

	public boolean isAccountNonExpired() {
		return accountNonExpired;
	}

	public boolean isAccountNonLocked() {
		return accountNonLocked;
	}

	public boolean isCredentialsNonExpired() {
		return credentialsNonExpired;
	}

	public boolean isEnabled() {
		return enabled;
	}

	public void setAccountNonExpired(boolean accountNonExpired) {
		this.accountNonExpired = accountNonExpired;
	}

	public void setAccountNonLocked(boolean accountNonLocked) {
		this.accountNonLocked = accountNonLocked;
	}

	public void setCredentialsNonExpired(boolean credentialsNonExpired) {
		this.credentialsNonExpired = credentialsNonExpired;
	}

	public void setEnabled(boolean enabled) {
		this.enabled = enabled;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public void setUserGroup(Set<UserGroup> userGroup) {
		this.userGroup = userGroup;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String toString() {
		return "First Name : " + this.getFirstName() + "\n Last Name : "
				+ this.getLastName() + "\n User Name : " + this.getUserName();

	}

}
