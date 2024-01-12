package com.jmh.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;

import com.jmh.dto.MemberDto;
import com.jmh.service.MemberService;

@Controller
public class MainController {
	
	@Autowired
	MemberService memberService;
	
	@GetMapping("/WellCome")
	public String wellCome(HttpSession session, Model model) {
		//model.addAttribute("member_Id_SE" , session.getAttribute("member_Id"));
		return "/common/WellCome";
	}
	@GetMapping("/main")
	public String main(HttpSession session, Model model, int member_Id, String member_Pw) {//int member_Id, String member_Pw, HttpSession session, MemberDto dto, Model model
		System.out.println("/main 도착했어요. GET MAPPING");
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/common/WellCome");
		mav.addObject("member_Id_SE", session.getAttribute("member_Id"));
		
		List<MemberDto> loginCk = memberService.loginCk(member_Id, member_Pw);
		model.addAttribute("loginCk" , loginCk);
		System.err.println("loginCk2 : " + loginCk);
		return "/main";
	}
	
	@GetMapping("/success")
	public String success() {
		return "/success";	
	}
	
	@GetMapping("/login")
	public String login() {
		return "/login";	
	}
	
	@PostMapping("/login")
	public String memberLogin(int member_Id, String member_Pw, HttpSession session, MemberDto dto, Model model) {
		System.out.println("member_Id : " + member_Id);
		System.out.println("member_Pw : " + member_Pw);
		ModelAndView mav = new ModelAndView();
		List<MemberDto> loginCk = memberService.loginCk(member_Id, member_Pw);
		if(loginCk != null) {
			session.setAttribute("member_Id", dto.getMember_Id());
			mav.setViewName("/common/WellCome");
			mav.addObject("member_Id", session.getAttribute("member_Id"));
			model.addAttribute("loginCk" , loginCk);
			System.out.println("loginCk : " + loginCk);
			return "redirect:/main";
		}
		return "/login";
	}
	
	@GetMapping("/logout")
	public String memberLogout( HttpServletRequest request) {
		HttpSession session = request.getSession();
		session.invalidate();
		System.out.println("logout)session : " + session);
		return "redirect:/login";
	}
}
