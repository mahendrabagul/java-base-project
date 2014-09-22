package com.neova.controller;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.neova.model.Group;
import com.neova.service.GroupService;

@Controller
@RequestMapping(value = "/group")
public class GroupController {

	@Resource(name = "groupService")
	private GroupService groupService;

	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public ModelAndView addGroupPage() {
		ModelAndView modelAndView = new ModelAndView("add-group-form");
		modelAndView.addObject("group", new Group());
		return modelAndView;
	}

	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public ModelAndView addingGroup(@ModelAttribute Group group) {

		ModelAndView modelAndView = new ModelAndView("home");
		groupService.createGroup(group);

		String message = "Group was successfully added.";
		modelAndView.addObject("message", message);

		return modelAndView;
	}

	@RequestMapping(value = "/list")
	public ModelAndView listOfGroups() {
		ModelAndView modelAndView = new ModelAndView("list-of-groups");

		List<Group> groups = groupService.getGroups();
		modelAndView.addObject("groups", groups);

		return modelAndView;
	}

	@RequestMapping(value = "/edit/{groupName}", method = RequestMethod.GET)
	public ModelAndView editGroupPage(@PathVariable String groupName) {
		ModelAndView modelAndView = new ModelAndView("edit-group-form");
		Group group = groupService.readGroup(groupName);
		modelAndView.addObject("group", group);
		return modelAndView;
	}

	@RequestMapping(value = "/edit/{groupName}", method = RequestMethod.POST)
	public ModelAndView edditingGroup(@ModelAttribute Group group,
			@PathVariable String groupName) {

		ModelAndView modelAndView = new ModelAndView("home");

		groupService.updateGroup(group);

		String message = "Group was successfully edited.";
		modelAndView.addObject("message", message);

		return modelAndView;
	}

	@RequestMapping(value = "/delete/{groupName}", method = RequestMethod.GET)
	public ModelAndView deleteGroup(@PathVariable String groupName) {
		ModelAndView modelAndView = new ModelAndView("home");
		groupService.deleteGroup(groupName);
		String message = "Group was successfully deleted.";
		modelAndView.addObject("message", message);
		return modelAndView;
	}

}
