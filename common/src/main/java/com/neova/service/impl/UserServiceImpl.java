package com.neova.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.neova.dao.UserDAO;
import com.neova.model.User;
import com.neova.model.jointable.UserGroup;
import com.neova.service.UserService;

@Service("userService")
@Transactional
public class UserServiceImpl implements UserService {

	@Autowired
	private UserDAO userDAO;

	public void createUser(User user) {
		userDAO.createUser(user);
	}

	public void updateUser(User user) {
		userDAO.updateUser(user);
	}

	public User readUser(String userName) {
		return userDAO.readUser(userName);
	}

	public void deleteUser(String userName) {
		userDAO.deleteUser(userName);
	}

	public List<User> getUsers() {
		return userDAO.getUsers();
	}

	@Override
	public void addUserToGroup(UserGroup userGroup, User user) {

	}

	@Override
	public User findByEmailId(String email) {
		return userDAO.findByEmailId(email);
	}

}
