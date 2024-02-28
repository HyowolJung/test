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
	public UserDetails loadUserByUsername(String member_Id) throws UsernameNotFoundException {
		System.err.println("CustomUserDetailsService 도착 1");
		// TODO Auto-generated method stub
		CustomUserDetails user = mapper.loginID(member_Id);
		
//		System.err.println("설마 여기인가요? : " + member_Id);
//		if(member_Id != null) {
//			HttpSession session = null;
//			session.setAttribute(member_Id, "member_Id");
//		}
		
		
		if(member_Id==null) {
			System.err.println("CustomUserDetailsService 도착 2");
			throw new UsernameNotFoundException(member_Id);
		}
		
		return user;
		//return null;
	}

}
