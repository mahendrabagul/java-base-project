package com.neova.service;

import java.util.List;

import com.neova.model.Group;

public interface GroupService {

	public void createGroup(Group group);

	public void updateGroup(Group group);

	public Group readGroup(String groupName);

	public void deleteGroup(String groupName);

	public List<Group> getGroups();

}
