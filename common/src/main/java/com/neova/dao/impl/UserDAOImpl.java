package com.neova.dao.impl;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.neova.dao.UserDAO;
import com.neova.model.User;
import com.neova.model.jointable.UserGroup;

@Repository
public class UserDAOImpl implements UserDAO {

	@Autowired
	private SessionFactory sessionFactory;

	private Session getCurrentSession() {

		return sessionFactory.getCurrentSession();
	}

	public void createUser(User user) {
		getCurrentSession().save(user);
	}

	public void updateUser(User user) {
		getCurrentSession().update(user);
	}

	public User readUser(String userName) {
		User user = (User) getCurrentSession().get(User.class, userName);
		if (user != null)
			return user;
		return null;
	}

	public void deleteUser(String userName) {
		User user = readUser(userName);
		if (user != null)
			getCurrentSession().delete(user);
	}

	@SuppressWarnings("unchecked")
	public List<User> getUsers() {
		return getCurrentSession().createQuery("from User").list();
	}

	@Override
	public void addUserToGroup(UserGroup userGroup, User user) {
		user.getUserGroup().add(userGroup);
		getCurrentSession().save(user);
	}

	@Override
	public User findByEmailId(String email) {
		Query query = getCurrentSession().createQuery(
				"from User user where user.email = :email");
		query.setParameter("email", email);
		if (query.list().isEmpty()) {
			return null;
		}
		return (User) query.list().get(0);
	}

}
