package com.jmh.security;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import com.jmh.mapper.MemberMapper;
import com.jmh.service.MemberService;

public class CustomLoginSuccessHandler implements AuthenticationSuccessHandler{
	@Autowired
	MemberService service;
	
	@Autowired
	MemberMapper mapper;
	
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws IOException, ServletException {
		System.err.println("CustomLoginSuccessHandler 도착 1");
		List<String> roleNames = new ArrayList<String>();
		
		authentication.getAuthorities().forEach(authrity -> {
			roleNames.add(authrity.getAuthority());
		});
		
		CustomUserDetails userDetails = (CustomUserDetails) authentication.getPrincipal();
        String memberId = userDetails.getUsername(); // 또는 getMember_Id()
        
        HttpSession session = request.getSession();
        session.setAttribute("memberId", memberId);
        
        //String member_Department = service.getDept(member_Id);
        //System.err.println("service.getDept(member_Id); : " + service.getDept(member_Id));
        //System.err.println("member_Department : " + member_Department);
//        if(!member_Department.equals( "A021")) {
//        	response.sendRedirect("/myPage");
//        	return;
//        }
        	
//        if(member_Id != null) {
//        	System.err.println("이미 로그인이 되어있습니다.");
//        	response.sendRedirect("/main");
//        	return;
//        }
        
        if (authentication.isAuthenticated()) {
            // Redirect to a different page
        	System.err.println("이미 로그인이 되어있습니다.");
            response.sendRedirect("/main");
            return;
        }
		
        response.sendRedirect("/login");
	}
}
