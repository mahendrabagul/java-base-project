package com.neova.dao.impl;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.neova.dao.GroupDAO;
import com.neova.model.Group;

@Repository
public class GroupDAOImpl implements GroupDAO {

	@Autowired
	private SessionFactory sessionFactory;

	private Session getCurrentSession() {
		return sessionFactory.getCurrentSession();
	}

	public void createGroup(Group group) {
		getCurrentSession().save(group);
	}

	public void updateGroup(Group group) {
		Group groupToUpdate = readGroup(group.getGroupName());
		groupToUpdate.setGroupDescription(group.getGroupDescription());
		groupToUpdate.setGroupName(group.getGroupName());
		getCurrentSession().update(groupToUpdate);

	}

	public Group readGroup(String groupName) {
		Group group = (Group) getCurrentSession().get(Group.class, groupName);
		return group;
	}

	public void deleteGroup(String groupName) {
		Group group = readGroup(groupName);
		if (group != null)
			getCurrentSession().delete(group);
	}

	@SuppressWarnings("unchecked")
	public List<Group> getGroups() {
			return getCurrentSession().createQuery("from Group").list();
	}

}
