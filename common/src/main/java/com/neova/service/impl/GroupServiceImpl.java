package com.neova.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.neova.dao.GroupDAO;
import com.neova.model.Group;
import com.neova.service.GroupService;

@Service("groupService")
@Transactional
public class GroupServiceImpl implements GroupService {

	@Autowired
	private GroupDAO groupDAO;

	public void createGroup(Group group) {
		groupDAO.createGroup(group);
	}

	public void updateGroup(Group team) {
		groupDAO.updateGroup(team);
	}

	public Group readGroup(String groupName) {
		return groupDAO.readGroup(groupName);
	}

	public void deleteGroup(String groupName) {
		groupDAO.deleteGroup(groupName);
	}

	public List<Group> getGroups() {
		return groupDAO.getGroups();
	}

}
