package com.neova.dao.impl;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.neova.dao.RoleDAO;
import com.neova.model.Role;

@Repository
public class RoleDAOImpl implements RoleDAO {

	@Autowired
	private SessionFactory sessionFactory;

	private Session getCurrentSession() {
		return sessionFactory.getCurrentSession();
	}

	public void createRole(Role role) {
		getCurrentSession().save(role);
	}

	public void updateRole(Role role) {
		getCurrentSession().update(role);
	}

	public Role readRole(String roleName) {
		Role role = (Role) getCurrentSession().get(Role.class, roleName);
		return role;
	}

	public void deleteRole(String roleName) {
		Role role = readRole(roleName);
		if (role != null)
			getCurrentSession().delete(role);
	}

	@SuppressWarnings("unchecked")
	public List<Role> getRoles() {
		return getCurrentSession().createQuery("from Role").list();
	}

}
