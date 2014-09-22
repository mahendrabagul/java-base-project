package com.neova.model.jointable;

import java.io.Serializable;

import javax.persistence.AssociationOverride;
import javax.persistence.AssociationOverrides;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.Transient;

import com.neova.model.Group;
import com.neova.model.Role;
import com.neova.model.embedded.id.GroupRoleID;

@Entity
@AssociationOverrides({
		@AssociationOverride(name = "groupRoleID.group", joinColumns = @JoinColumn(name = "groupName")),
		@AssociationOverride(name = "groupRoleID.role", joinColumns = @JoinColumn(name = "roleName")) })
public class GroupRole implements Serializable {

	private static final long serialVersionUID = 7547671742834389644L;
	@EmbeddedId
	GroupRoleID groupRoleID = new GroupRoleID();

	public GroupRole() {
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (!(obj instanceof GroupRole))
			return false;
		GroupRole other = (GroupRole) obj;
		if (groupRoleID == null) {
			if (other.groupRoleID != null)
				return false;
		} else if (!groupRoleID.equals(other.groupRoleID))
			return false;

		return true;
	}

	@Transient
	public Group getGroup() {
		return getGroupRoleID().getGroup();
	}

	public GroupRoleID getGroupRoleID() {
		return groupRoleID;
	}

	@Transient
	public Role getRole() {
		return getGroupRoleID().getRole();
	}

	@Override
	public int hashCode() {
		return (getGroupRoleID() != null ? getGroupRoleID().hashCode() : 0);
	}

	public void setGroup(Group group) {
		getGroupRoleID().setGroup(group);
	}

	public void setGroupRoleID(GroupRoleID groupRoleID) {
		this.groupRoleID = groupRoleID;
	}

	public void setRole(Role role) {
		getGroupRoleID().setRole(role);
	}
}
