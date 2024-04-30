package com.jmh.security;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import com.jmh.mapper.MemberMapper;

public class CustomUserDetailsService implements UserDetailsService{

	@Autowired
	MemberMapper mapper;
	
	@Override
	public UserDetails loadUserByUsername(String memberId) throws UsernameNotFoundException {
		System.err.println("CustomUserDetailsService 도착 1 : " + memberId);
		// TODO Auto-generated method stub
		System.err.println("혹시 여기부터 에러인건가??? : " + memberId);
		CustomUserDetails user = mapper.loginID(memberId);
		System.err.println("user : " + user);
		if(memberId==null) {
			System.err.println("CustomUserDetailsService 도착 2");
			throw new UsernameNotFoundException(memberId);
		}
		
		return user;
	}
}
