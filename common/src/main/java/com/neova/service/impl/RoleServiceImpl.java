package com.neova.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.neova.dao.RoleDAO;
import com.neova.model.Role;
import com.neova.service.RoleService;

@Service("roleService")
@Transactional
public class RoleServiceImpl implements RoleService {

	@Autowired
	private RoleDAO roleDAO;

	public void createRole(Role role) {
		roleDAO.createRole(role);
	}

	public void updateRole(Role role) {
		roleDAO.updateRole(role);
	}

	public Role readRole(String roleName) {
		return roleDAO.readRole(roleName);
	}

	public void deleteRole(String roleName) {
		roleDAO.deleteRole(roleName);
	}

	public List<Role> getRoles() {
		return roleDAO.getRoles();
	}

}
