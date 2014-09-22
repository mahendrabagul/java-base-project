package com.neova.dao;

import java.util.List;

import com.neova.model.Role;

public interface RoleDAO {

	public void createRole(Role role);

	public void updateRole(Role role);

	public Role readRole(String roleName);

	public void deleteRole(String roleName);

	public List<Role> getRoles();

}
