package com.neova.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.neova.controller.export.ExcelReportView;
import com.neova.controller.export.PdfReportView;
import com.neova.controller.export.UserReportDetails;
import com.neova.mail.EmailSender;
import com.neova.model.Group;
import com.neova.model.User;
import com.neova.model.jointable.UserGroup;
import com.neova.service.GroupService;
import com.neova.service.UserService;

@Controller
@RequestMapping(value = "/user")
public class UserController {
	@Autowired
	private EmailSender emailSender;

	@Resource(name = "userService")
	private UserService userService;

	@Resource(name = "groupService")
	private GroupService groupService;

	@RequestMapping(value = "/neova/signup", method = RequestMethod.GET)
	public ModelAndView signUpPage() {
		return new ModelAndView("neova-signup");
	}

	@RequestMapping(value = "/admin/manage", method = RequestMethod.GET)
	public ModelAndView addUserPage() {
		ModelAndView modelAndView = new ModelAndView("admin-manage");
		modelAndView.addObject("user", new User());
		modelAndView.addObject("userList", userService.getUsers());
		modelAndView.addObject("userNames", getUserNames());
		modelAndView.addObject("groupNames", getGroupNames());
		return modelAndView;
	}

	@RequestMapping(value = "/admin/addUserToGroup/", method = RequestMethod.POST)
	@ResponseBody
	public String addUserToGroup(HttpServletRequest httpServletRequest) {

		User readUser = userService.readUser(httpServletRequest
				.getParameter("userName"));
		if (null == readUser) {
			return "Response1 : Please Select At Least One User";
		}
		String[] parameterValues = httpServletRequest
				.getParameterValues("groupNames");

		if (null == parameterValues) {
			return "Response2 : Please Select At Least One Group";
		}

		UserGroup userGroup[] = new UserGroup[parameterValues.length];
		for (int i = 0; i < parameterValues.length; i++) {
			userGroup[i] = new UserGroup();
			Group readGroup = groupService.readGroup(parameterValues[i].trim());
			userGroup[i].setGroup(readGroup);
			userGroup[i].setUser(readUser);

			readUser.getUserGroup().add(userGroup[i]);
			System.out.print(parameterValues[i] + "\t");
		}

		userService.updateUser(readUser);

		return "Response3 : User was added to Selected Group(s) Successfully";
	}

	/**
	 * This returns all groupNames from database
	 * 
	 * @return
	 */

	private List<String> getGroupNames() {
		List<Group> groups = groupService.getGroups();
		List<String> groupNames = new ArrayList<String>();
		for (Iterator<Group> iterator = groups.iterator(); iterator.hasNext();) {
			Group group = (Group) iterator.next();
			groupNames.add(group.getGroupName());
		}
		return groupNames;
	}

	/**
	 * This returns all userNames from database
	 * 
	 * @return
	 */
	private List<String> getUserNames() {
		List<User> users = userService.getUsers();
		List<String> userNames = new ArrayList<String>();
		for (Iterator<User> iterator = users.iterator(); iterator.hasNext();) {
			User user = (User) iterator.next();
			userNames.add(user.getUserName());
		}
		return userNames;
	}

	@RequestMapping(value = "/admin/insert", method = RequestMethod.POST)
	@ResponseBody
	public String createUser(User user) {
		if (!user.getUserName().equals("") && (!user.getEmail().equals(""))) {
			// Check User Name already exists or not
			User readUser1 = (User) userService.readUser(user.getUserName());
			if (null != readUser1) {
				return "Response1 : User Name Already Exists";
			}
			// Check email already exists or not
			User readUser2 = (User) userService.findByEmailId(user.getEmail());
			if (null != readUser2) {
				return "Response2 : Email Id Already Exists";
			}
			// save user to database with default group
			Group defaultGroup = new Group();
			defaultGroup.setGroupName("MODERATOR");
			UserGroup userGroup = new UserGroup();
			userGroup.setGroup(defaultGroup);
			userGroup.setUser(user);
			user.getUserGroup().add(userGroup);
			userService.createUser(user);
			emailSender.sendAccountCreationEmail("Creation of your Account",
					user);
			return "Response3: User was saved Successfully";
		} else {
			return "Response4: UserName and Email can not be empty";
		}
	}

	@RequestMapping(value = "/admin/delete/{userName}", method = RequestMethod.GET)
	@ResponseBody
	public String deleteUser(@PathVariable String userName) {
		User readUser = (User) userService.readUser(userName);
		if (readUser != null) {
			// For Removing Associations.. One solution with changing to LAZY
			// Loading but Couldn't proceed as EAGER is required for Other
			// Operation
			readUser.getUserGroup().clear();
			// Will remove data from user_group table
			userService.updateUser(readUser);
			userService.deleteUser(userName);
			emailSender.sendAccountDeletionEmail("Deletion of your Account",
					readUser);
			return "User was deleted successfully";
		} else {
			return "User could not get deleted";
		}
	}

	@RequestMapping(value = "/download/xls", method = RequestMethod.GET)
	public ModelAndView downloadReportXLS(HttpServletResponse response) {
		List<UserReportDetails> userList = new ArrayList<UserReportDetails>();
		List<User> users = userService.getUsers();
		for (Iterator<User> iterator = users.iterator(); iterator.hasNext();) {
			UserReportDetails temp = new UserReportDetails();
			User user = (User) iterator.next();
			temp.setUserName(user.getUserName());
			temp.setLastName(user.getLastName());
			temp.setFirstName(user.getFirstName());
			temp.setEmail(user.getEmail());
			userList.add(temp);
		}

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userList", userList);
		ModelAndView modelAndView = new ModelAndView(new ExcelReportView(), map);
		return modelAndView;
	}

	@RequestMapping(value = "/download/pdf", method = RequestMethod.GET)
	public ModelAndView downloadReportPDF(HttpServletResponse response) {
		List<UserReportDetails> userList = new ArrayList<UserReportDetails>();
		List<User> users = userService.getUsers();
		for (Iterator<User> iterator = users.iterator(); iterator.hasNext();) {
			UserReportDetails temp = new UserReportDetails();
			User user = (User) iterator.next();
			temp.setUserName(user.getUserName());
			temp.setLastName(user.getLastName());
			temp.setFirstName(user.getFirstName());
			temp.setEmail(user.getEmail());
			userList.add(temp);
		}

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userList", userList);
		ModelAndView modelAndView = new ModelAndView(new PdfReportView(), map);
		return modelAndView;
	}

	@RequestMapping(value = "/admin/update/{userName}", method = RequestMethod.GET)
	@ResponseBody
	public User updateUserGet(@PathVariable String userName) {
		User readUser = (User) userService.readUser(userName);
		if (readUser != null) {
			return readUser;
		} else {
			return null;
		}
	}

	@RequestMapping(value = "/admin/update", method = RequestMethod.POST)
	@ResponseBody
	public String updateUserPost(User user) {
		try {
			userService.updateUser(user);
			emailSender.sendAccountUpdationEmail("Updation of your Account",
					user);
			return "User was updated successfully";
		} catch (Exception e) {
			return "Error Occurred:" + e.getMessage();
		}
	}
}
