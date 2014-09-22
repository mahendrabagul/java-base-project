package com.neova.dao;

import java.util.List;

import com.neova.model.User;
import com.neova.model.jointable.UserGroup;

public interface UserGroupDAO {

	public void addUserToGroup(UserGroup userGroup, User user);

	public List<UserGroup> getUserGroupByUserID(int userId);

	public void deleteUserGroupByUserID(int userId);

	public List<UserGroup> getUserGroupByGroupID(int groupId);

	public void deleteUserGroupByGroupID(int groupId);

	public List<UserGroup> getUserGroups();

}
