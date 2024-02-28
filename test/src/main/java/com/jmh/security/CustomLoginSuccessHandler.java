package com.jmh.security;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;


public class CustomLoginSuccessHandler implements AuthenticationSuccessHandler{

	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws IOException, ServletException {
		System.err.println("CustomLoginSuccessHandler 도착 1");
		List<String> roleNames = new ArrayList<String>();
		
		authentication.getAuthorities().forEach(authrity -> {
			roleNames.add(authrity.getAuthority());
			
		});
		
		response.sendRedirect("/main");
		
//		if(roleNames.contains("ROLE_MEMBER")) {
//			response.sendRedirect("/member/memberList");
//			return;
//		}
//		
//		if(roleNames.contains("ROLE_PROJECT")) {
//			response.sendRedirect("/member/memberList");
//			return;
//		}
		
		//response.sendRedirect("/");
		
	}

}
