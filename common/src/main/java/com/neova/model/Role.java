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

@Entity
@DynamicUpdate(value = true)
@DynamicInsert(value = true)
@SelectBeforeUpdate(value = true)
public class Role implements Serializable {

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result
				+ ((roleName == null) ? 0 : roleName.hashCode());
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
		Role other = (Role) obj;
		if (roleName == null) {
			if (other.roleName != null)
				return false;
		} else if (!roleName.equals(other.roleName))
			return false;
		return true;
	}

	private static final long serialVersionUID = -4238733882336114492L;

	@OneToMany(fetch = FetchType.EAGER, mappedBy = "groupRoleID.role", cascade = CascadeType.ALL,orphanRemoval=true)
	private Set<GroupRole> groupRoles = new HashSet<GroupRole>(0);

	@Column(name = "roleDescription")
	private String roleDescription;
	@Id
	@Column(name = "roleName")
	private String roleName;

	public Role() {
		// Default Constructor
	}

	public Role(String roleName) {
		super();
		this.roleName = roleName;
	}

	public Set<GroupRole> getGroupRoles() {
		return groupRoles;
	}

	public String getRoleDescription() {
		return roleDescription;
	}

	public String getRoleName() {
		return roleName;
	}

	public void setGroupRoles(Set<GroupRole> groupRoles) {
		this.groupRoles = groupRoles;
	}

	public void setRoleDescription(String roleDescription) {
		this.roleDescription = roleDescription;
	}

	public void setRoleName(String roleName) {
		this.roleName = roleName;
	}

	public String toString() {
		return this.getRoleName();
	}
}
