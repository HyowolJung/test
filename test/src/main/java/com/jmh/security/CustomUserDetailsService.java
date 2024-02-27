package com.jmh.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import com.jmh.mapper.MemberMapper;

public class CustomUserDetailsService implements UserDetailsService{

	@Autowired
	MemberMapper mapper;
	
	@Override
	public UserDetails loadUserByUsername(String member_Id) throws UsernameNotFoundException {
		// TODO Auto-generated method stub
		CustomUserDetails user = mapper.loginID(member_Id);
		if(member_Id==null) {
			throw new UsernameNotFoundException(member_Id);
		}
		
		System.out.println("CustomUserDetailsService 들어왔다!!!!!!!!!!!!!!!!");
		return user;
	}

}
