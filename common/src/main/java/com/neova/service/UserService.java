package com.neova.service;

import java.util.List;

import com.neova.model.User;
import com.neova.model.jointable.UserGroup;

public interface UserService {

	public void createUser(User user);

	public void updateUser(User user);

	public User readUser(String userName);

	public void deleteUser(String userName);

	public List<User> getUsers();

	public void addUserToGroup(UserGroup userGroup, User user);

	public User findByEmailId(String email);
	

}
