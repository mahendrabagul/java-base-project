package com.neova.model.embedded.id;

import java.io.Serializable;

import javax.persistence.Embeddable;
import javax.persistence.ManyToOne;

import com.neova.model.Group;
import com.neova.model.User;

@Embeddable
public class UserGroupID implements Serializable {
	private static final long serialVersionUID = 1364855096459627788L;
	@ManyToOne
	private Group group;
	@ManyToOne
	private User user;

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (!(obj instanceof UserGroupID))
			return false;
		UserGroupID other = (UserGroupID) obj;
		if (group == null) {
			if (other.group != null)
				return false;
		} else if (!group.equals(other.group))
			return false;
		if (user == null) {
			if (other.user != null)
				return false;
		} else if (!user.equals(other.user))
			return false;
		return true;
	}

	public Group getGroup() {
		return group;
	}

	public User getUser() {
		return user;
	}

	@Override
	public int hashCode() {
		int result;
		result = (user != null ? user.hashCode() : 0);
		result = 17 * result + (group != null ? group.hashCode() : 0);
		return result;
	}

	public void setGroup(Group group) {
		this.group = group;
	}

	public void setUser(User user) {
		this.user = user;
	}
}
