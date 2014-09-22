package com.neova.controller;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.neova.model.Role;
import com.neova.service.RoleService;

@Controller
@RequestMapping(value = "/role")
public class RoleController {

	@Resource(name = "roleService")
	private RoleService roleService;

	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public ModelAndView addRolePage() {
		ModelAndView modelAndView = new ModelAndView("add-role-form");
		modelAndView.addObject("role", new Role());
		return modelAndView;
	}

	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public ModelAndView addingRole(@ModelAttribute Role role) {

		ModelAndView modelAndView = new ModelAndView("home");
		roleService.createRole(role);

		String message = "Role was successfully added.";
		modelAndView.addObject("message", message);

		return modelAndView;
	}

	@RequestMapping(value = "/list")
	public ModelAndView listOfRoles() {
		ModelAndView modelAndView = new ModelAndView("list-of-roles");

		List<Role> roles = roleService.getRoles();
		modelAndView.addObject("roles", roles);

		return modelAndView;
	}

	@RequestMapping(value = "/edit/{roleName}", method = RequestMethod.GET)
	public ModelAndView editRolePage(@PathVariable String roleName) {
		ModelAndView modelAndView = new ModelAndView("edit-role-form");
		Role role = roleService.readRole(roleName);
		modelAndView.addObject("role", role);
		return modelAndView;
	}

	@RequestMapping(value = "/edit/{roleName}", method = RequestMethod.POST)
	public ModelAndView edditingRole(@ModelAttribute Role role,
			@PathVariable String roleName) {

		ModelAndView modelAndView = new ModelAndView("home");

		roleService.updateRole(role);

		String message = "Role was successfully edited.";
		modelAndView.addObject("message", message);

		return modelAndView;
	}

	@RequestMapping(value = "/delete/{roleName}", method = RequestMethod.GET)
	public ModelAndView deleteRole(@PathVariable String roleName) {
		ModelAndView modelAndView = new ModelAndView("home");
		roleService.deleteRole(roleName);
		String message = "Role was successfully deleted.";
		modelAndView.addObject("message", message);
		return modelAndView;
	}

}
