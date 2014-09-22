package com.neova.model.embedded.id;

import java.io.Serializable;

import javax.persistence.Embeddable;
import javax.persistence.ManyToOne;

import com.neova.model.Group;
import com.neova.model.Role;

@Embeddable
public class GroupRoleID implements Serializable {

	private static final long serialVersionUID = -3390554853626304068L;
	@ManyToOne
	private Group group;

	@ManyToOne
	private Role role;

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (!(obj instanceof GroupRoleID))
			return false;
		GroupRoleID other = (GroupRoleID) obj;
		if (role == null) {
			if (other.role != null)
				return false;
		} else if (!role.equals(other.role))
			return false;
		if (group == null) {
			if (other.group != null)
				return false;
		} else if (!group.equals(other.group))
			return false;
		return true;
	}

	public Group getGroup() {
		return group;
	}

	public Role getRole() {
		return role;
	}

	@Override
	public int hashCode() {
		int result;
		result = (group != null ? group.hashCode() : 0);
		result = 17 * result + (role != null ? role.hashCode() : 0);
		return result;
	}

	public void setGroup(Group group) {
		this.group = group;
	}

	public void setRole(Role role) {
		this.role = role;
	}
}
