package com.neova.dao;

import java.util.List;

import com.neova.model.User;
import com.neova.model.jointable.UserGroup;

public interface UserDAO {

	public void createUser(User user);

	public void updateUser(User user);

	public void deleteUser(String userName);

	public List<User> getUsers();

	public User readUser(String userName);

	void addUserToGroup(UserGroup userGroup, User user);

	public User findByEmailId(String email);

}
