package com.jmh.intercepter;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class Login extends HandlerInterceptorAdapter{
	@Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws IOException {
        HttpSession session = request.getSession();
        System.err.println("interCepter)session.getAttribute() : " + session.getAttribute("member_Id"));
        if (session.getAttribute("member_Id") == null) {
            response.sendRedirect("/login"); // 로그인 페이지로 리다이렉트
            return false; // 컨트롤러 메소드 실행 중지
        }
        return true; // 컨트롤러 메소드 계속 실행
    }
}
