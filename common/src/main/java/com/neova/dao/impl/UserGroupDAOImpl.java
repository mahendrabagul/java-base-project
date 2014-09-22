package com.neova.dao.impl;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.neova.dao.UserGroupDAO;
import com.neova.model.User;
import com.neova.model.jointable.UserGroup;

@Repository
public class UserGroupDAOImpl implements UserGroupDAO {

	@Autowired
	private SessionFactory sessionFactory;

	private Session getCurrentSession() {
		return sessionFactory.getCurrentSession();
	}

	@Override
	public void addUserToGroup(UserGroup userGroup, User user) {
		getCurrentSession().save(userGroup);
		getCurrentSession().save(user);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<UserGroup> getUserGroupByUserID(int userId) {
		Query query = sessionFactory.getCurrentSession().createQuery(
				"from UserGroup userGroup where userGroup.USER_ID = :userId");
		query.setParameter("USER_ID", userId);
		return query.list();
	}

	@Override
	public void deleteUserGroupByUserID(int userId) {

	}

	@SuppressWarnings("unchecked")
	@Override
	public List<UserGroup> getUserGroupByGroupID(int groupId) {
		Query query = sessionFactory.getCurrentSession().createSQLQuery(
				"select GROUP_ID from user_group where USER_ID = '2'");
		return query.list();
	}

	@Override
	public void deleteUserGroupByGroupID(int groupId) {

	}

	@SuppressWarnings("unchecked")
	@Override
	public List<UserGroup> getUserGroups() {
		Query query = sessionFactory.getCurrentSession().createQuery(
				"from UserGroup");
		return query.list();
	}

}
