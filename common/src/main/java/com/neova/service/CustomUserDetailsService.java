/**
 * 
 * CustomUserDetailsService.java
 * 
 * Version:
 * 		1.0
 * 
 * Revisions:
 * 		
 *
 */
package com.neova.service;

import java.util.Collection;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.neova.dao.TenantFindDAO;
import com.neova.dao.UserDAO;
import com.neova.model.jointable.GroupRole;
import com.neova.model.jointable.UserGroup;

/**
 * This is CustomUserDetailService
 * 
 * It contains Spring Security related functionalities (Hibernate)
 * 
 * 
 * @author Mahendra Bagul
 * 
 *         Neova Solutions Pvt. Ltd.
 * 
 */

@Service
@Transactional(readOnly = true)
public class CustomUserDetailsService implements UserDetailsService {

	public static Set<GrantedAuthority> getGrantedAuthorities(Set<String> roles) {
		Set<GrantedAuthority> authorities = new HashSet<GrantedAuthority>();
		for (String role : roles) {
			authorities.add(new SimpleGrantedAuthority(role));
		}
		return authorities;
	}

	@Autowired
	private UserDAO userDAO;

	@Autowired
	private TenantFindDAO tenantFindDAO;

	public CustomUserDetailsService() {

	}

	public Collection<? extends GrantedAuthority> getAuthorities(
			com.neova.model.User user) {
		Set<GrantedAuthority> authList = getGrantedAuthorities(getRoles(user));

		return authList;
	}

	public Set<String> getRoles(com.neova.model.User user) {
		Set<String> roles = new HashSet<String>();
		Set<UserGroup> userGroupSet = user.getUserGroup();
		// Iterate UserGroup i.e. one user may be in multiple groups
		for (Iterator<UserGroup> iteratorUserGroup = userGroupSet.iterator(); iteratorUserGroup
				.hasNext();) {
			UserGroup userGroup = (UserGroup) iteratorUserGroup.next();
			Set<GroupRole> groupRolesSet = userGroup.getUserGroupID()
					.getGroup().getGroupRoles();
			// Iterate GroupRole i.e. one Group may have multiple Roles
			for (Iterator<GroupRole> iteratorGroupRole = groupRolesSet
					.iterator(); iteratorGroupRole.hasNext();) {
				GroupRole groupRole = (GroupRole) iteratorGroupRole.next();

				roles.add(groupRole.getRole().getRoleName());
			}
		}
		return roles;
	}

	/**
	 * Given the id, gets role from current session
	 * 
	 * @param login
	 *            login is username of user
	 * 
	 * @exception UsernameNotFoundException
	 *                if user is not in database
	 * 
	 */

	@Override
	public UserDetails loadUserByUsername(String userName)
			throws UsernameNotFoundException {
		String tenantByUserName = tenantFindDAO.findTenantByUserName(userName);
		com.neova.model.User domainUser = null;

		// createNewConfiguration(tenantByUserName);

		if (tenantByUserName != null) {
			domainUser = userDAO.readUser(userName);
		}
		boolean enabled = domainUser.isEnabled();
		boolean accountNonExpired = domainUser.isAccountNonExpired();
		boolean credentialsNonExpired = domainUser.isCredentialsNonExpired();
		boolean accountNonLocked = domainUser.isAccountNonLocked();

		return new User(domainUser.getUserName(), domainUser.getPassword(),
				enabled, accountNonExpired, credentialsNonExpired,
				accountNonLocked, getAuthorities(domainUser));

	}

	/*
	 * @SuppressWarnings("unused") private void createNewConfiguration(String
	 * tenantByUserName) { System.out.println("+++++++++++++++++++++++++++");
	 * System.out.println("Starting of createNewConfiguration()");
	 * System.out.println("+++++++++++++++++++++++++++"); WebAppConfig appConfig
	 * = new WebAppConfig(); appConfig.sessionFactory().setNamingStrategy(
	 * appConfig.namingStrategy(tenantByUserName));
	 * System.out.println("+++++++++++++++++++++++++++");
	 * System.out.println("End of createNewConfiguration()");
	 * System.out.println("+++++++++++++++++++++++++++");
	 * 
	 * }
	 */
}
