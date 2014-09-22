package com.neova.model.jointable;

import java.io.Serializable;

import javax.persistence.AssociationOverride;
import javax.persistence.AssociationOverrides;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.Transient;

import com.neova.model.Group;
import com.neova.model.User;
import com.neova.model.embedded.id.UserGroupID;

@Entity
@AssociationOverrides({
		@AssociationOverride(name = "userGroupID.user", joinColumns = @JoinColumn(name = "userName")),
		@AssociationOverride(name = "userGroupID.group", joinColumns = @JoinColumn(name = "groupName")) })
public class UserGroup implements Serializable {
	private static final long serialVersionUID = -9210264937753443719L;

	@EmbeddedId
	private UserGroupID userGroupID = new UserGroupID();

	public UserGroup() {
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (!(obj instanceof UserGroup))
			return false;
		UserGroup other = (UserGroup) obj;
		if (userGroupID == null) {
			if (other.userGroupID != null)
				return false;
		} else if (!userGroupID.equals(other.userGroupID))
			return false;

		return true;
	}

	@Transient
	public Group getGroup() {
		return getUserGroupID().getGroup();
	}

	@Transient
	public User getUser() {
		return getUserGroupID().getUser();
	}

	public UserGroupID getUserGroupID() {
		return userGroupID;
	}

	@Override
	public int hashCode() {
		return (getUserGroupID() != null ? getUserGroupID().hashCode() : 0);
	}

	public void setGroup(Group group) {
		getUserGroupID().setGroup(group);
	}

	public void setUser(User user) {
		getUserGroupID().setUser(user);
	}

	public void setUserGroupID(UserGroupID userGroupID) {
		this.userGroupID = userGroupID;
	}

}
