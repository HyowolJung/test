//package com.jmh.security;
//
//import org.springframework.security.crypto.password.PasswordEncoder;
//
//public class CustomNoOpPasswordEncoder implements PasswordEncoder{
//
//	@Override
//	public String encode(CharSequence rawPassword) {
//		// TODO Auto-generated method stub
//		System.err.println("CustomNoOpPasswordEncoder 도착했어요 1");
//		return rawPassword.toString();
//	}
//
//	@Override
//	public boolean matches(CharSequence rawPassword, String encodedPassword) {
//		System.err.println("CustomNoOpPasswordEncoder 도착했어요 2");
//		return rawPassword.toString().equals(encodedPassword);
//	}
//	
//	
//}
