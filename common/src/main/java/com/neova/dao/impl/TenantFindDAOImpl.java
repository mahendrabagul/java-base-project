package com.neova.dao.impl;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.neova.dao.TenantFindDAO;

@Repository
public class TenantFindDAOImpl implements TenantFindDAO {

	@Autowired
	private SessionFactory sessionFactory;

	private Session getCurrentSession() {
		return sessionFactory.getCurrentSession();
	}

	@Override
	public String findTenantByUserName(String userName) {
		Query query = getCurrentSession().createSQLQuery(
				"SELECT tenantName FROM user_tenant WHERE userName='"
						+ userName + "'");
		return (String) query.list().get(0);

	}
}
