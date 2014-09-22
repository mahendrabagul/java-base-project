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

import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;
import org.hibernate.annotations.SelectBeforeUpdate;

import com.neova.model.jointable.GroupRole;
import com.neova.model.jointable.UserGroup;

@Entity
@DynamicUpdate(value = true)
@DynamicInsert(value = true)
@SelectBeforeUpdate(value = true)
public class Group implements Serializable {

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result
				+ ((groupName == null) ? 0 : groupName.hashCode());
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
		Group other = (Group) obj;
		if (groupName == null) {
			if (other.groupName != null)
				return false;
		} else if (!groupName.equals(other.groupName))
			return false;
		return true;
	}

	private static final long serialVersionUID = -7336474250618387810L;

	@Id
	@Column(name = "groupName")
	private String groupName;

	@Column(name = "groupDescription")
	private String groupDescription;

	public String getGroupDescription() {
		return groupDescription;
	}

	public void setGroupDescription(String groupDescription) {
		this.groupDescription = groupDescription;
	}

	@OneToMany(fetch = FetchType.EAGER, mappedBy = "groupRoleID.group", cascade = CascadeType.ALL, orphanRemoval = true)
	private Set<GroupRole> groupRoles = new HashSet<GroupRole>(0);
	@OneToMany(fetch = FetchType.EAGER, mappedBy = "userGroupID.group", cascade = CascadeType.ALL, orphanRemoval = true)
	private Set<UserGroup> userGroups = new HashSet<UserGroup>(0);

	public Group() {
	}

	public Group(String groupName) {
		super();
		this.groupName = groupName;
	}

	public String getGroupName() {
		return groupName;
	}

	public Set<GroupRole> getGroupRoles() {
		return groupRoles;
	}

	public Set<UserGroup> getUserGroups() {
		return userGroups;
	}

	public void setGroupName(String groupName) {
		this.groupName = groupName;
	}

	public void setGroupRoles(Set<GroupRole> groupRoles) {
		this.groupRoles = groupRoles;
	}

	public void setUserGroups(Set<UserGroup> userGroups) {
		this.userGroups = userGroups;
	}

	public String toString() {
		return this.getGroupName();
	}

}
