/**
 * 
 * SecurityNavigation.java
 * 
 * Version:
 * 		1.0
 * 
 * Revisions:
 * 		
 *
 */
package com.neova.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.LockedException;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

/**
 * This is SecurityNavigation
 * 
 * It handles spring security related links
 * 
 * 
 * @author Mahendra Bagul
 * 
 *         Neova Solutions Pvt. Ltd.
 * 
 */
@Controller
public class SecurityNavigation {

	public SecurityNavigation() {
	}

	@RequestMapping(value = "/user-login", method = RequestMethod.GET)
	public ModelAndView loginForm(
			@RequestParam(value = "error", required = false) String error,
			@RequestParam(value = "logout", required = false) String logout,
			HttpServletRequest request) {

		ModelAndView model = new ModelAndView();
		if (error != null) {
			model.addObject("error",
					getErrorMessage(request, "SPRING_SECURITY_LAST_EXCEPTION"));
		}

		if (logout != null) {
			model.addObject("msg", "You've been logged out successfully.");
		}
		model.setViewName("login-form");

		return model;
	}

	// customize the error message
	private String getErrorMessage(HttpServletRequest request, String key) {

		Exception exception = (Exception) request.getSession()
				.getAttribute(key);

		String error = "";
		if (exception instanceof BadCredentialsException) {
			error = "Invalid username and password!";
		} else if (exception instanceof LockedException) {
			error = exception.getMessage();
		} else {
			error = "Invalid username and password!";
		}

		return error;
	}

	@RequestMapping(value = "/success-login", method = RequestMethod.GET)
	public ModelAndView successLogin() {
		return new ModelAndView("success-login");
	}

	@RequestMapping(value = "/access-denied", method = RequestMethod.GET)
	public ModelAndView accessDenied() {

		ModelAndView modelAndView = new ModelAndView();

		// check if user is login
		Authentication auth = SecurityContextHolder.getContext()
				.getAuthentication();
		if (!(auth instanceof AnonymousAuthenticationToken)) {
			UserDetails userDetail = (UserDetails) auth.getPrincipal();
			System.out.println(userDetail);
			modelAndView.addObject("username", userDetail.getUsername());
		}
		modelAndView.setViewName("access-denied");
		return modelAndView;

	}

}
