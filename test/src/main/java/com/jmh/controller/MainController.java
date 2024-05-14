package com.jmh.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.security.web.csrf.CsrfToken;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;

import com.jmh.dto.MemberDto;
import com.jmh.service.MemberService;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
//@CrossOrigin(origins = "http://localhost:9091")
public class MainController {
	
	@Autowired
	MemberService memberService;
	
	@GetMapping("/header")
	public String header(HttpSession session, Model model) {
		model.addAttribute("memberId" , session.getAttribute("memberId"));
		return "/common/header";
	}
	
	@GetMapping("/myPage")
	public String myPage() {
		return "/myPage";
	}
	
	@CrossOrigin(origins = "*")
	@GetMapping("/hello")
	public ResponseEntity<List<MemberDto>> hello() {
	    List<MemberDto> memberList = memberService.getMemberListt();
	    return ResponseEntity.ok(memberList); // JSON 형식으로 회원 목록 반환
	}
	
	@PostMapping("/hello")
	public ResponseEntity<List<MemberDto>> hello2(@RequestBody String memberId) {
		System.err.println("memberId 는  : " + memberId);
	    List<MemberDto> memberList = memberService.getMemberListt();
	    return ResponseEntity.ok(memberList); // JSON 형식으로 회원 목록 반환
	}
	
	@GetMapping("/main")
	public String main(HttpSession session, Model model, String memberId) {
		memberId = "99999999";
        session.setAttribute("memberId", memberId);
		        
		model.addAttribute("memberDept" , session.getAttribute("memberDept"));
		model.addAttribute("memberId", session.getAttribute("memberId"));
		//model.addAttribute("member_Department" , "인사부");
		System.err.println("여기는 main");
		return "/main";
	}
	
	@PostMapping("/main")
	public String main2(HttpSession session, Model model, String memberId) {
		model.addAttribute("memberDept" , session.getAttribute("memberDept"));
		model.addAttribute("memberId", session.getAttribute("memberId"));
		//model.addAttribute("member_Department" , "인사부");
		return "/main";
	}
	
	@GetMapping("/success")
	public String success() {
		return "/success";	
	}
	
	@GetMapping("/error")
	public void error() {}
	
	@PostMapping("/error")
	public void error2() {}
	
	//@CrossOrigin(origins = "http://localhost:8080")
	@GetMapping("/login")
	public void login() {}
	
	@PostMapping("/login")
	@ResponseBody
	public List<MemberDto> memberLogin(int memberId, String memberPw, HttpSession session, MemberDto dto, Model model) {
		session.setAttribute("member_Id", dto.getMemberId());
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/common/header");
		mav.addObject("memberId", session.getAttribute("memberId"));
		System.err.println("memberLoginP 의 : " + session.getAttribute("memberId"));
		//List<MemberDto> loginCk = memberService.loginCk(member_Id, member_Pw);
		//return loginCk;
		//boolean isValid = false;
		//List<MemberDto> loginCk = null;
		
		//String member_Pw_ck = memberService.getmember_Pw(memberId);
		//System.err.println("member_Pw : " + memberPw);
		//System.err.println("member_Pw_ck : " + member_Pw_ck);
		
		
//		if(member_Pw_ck != null) {
//			System.err.println("member_Pw_ck : " + member_Pw_ck);
//			isValid = BCrypt.checkpw(memberPw, member_Pw_ck);
//			System.err.println("isValid : " + isValid);
//			
//			if(isValid == true) {
//				System.err.println("isValid TRUE 진입");
//				ModelAndView mav = new ModelAndView();
//				mav.setViewName("/common/header");
//				mav.addObject("memberId", session.getAttribute("memberId"));
//				
//				loginCk = memberService.loginCk(memberId, member_Pw_ck);
//				MemberDto loginCk_member_Department = loginCk.get(0);
//				String member_Department = loginCk_member_Department.getMemberDept();
//				session.setAttribute("member_Department" , member_Department);
//				
//				System.err.println("loginCk 일치합니다. : " + loginCk);
//				return loginCk; 
//			}
//			
//			if(isValid == false) {
//				System.out.println("loginCk 비밀번호 불일치 : " + loginCk);
//				return loginCk;
//			}
//			
//		}
		return null;
	}
	
	
	@PostMapping("/logout")
	public void logout() {}
	
	//@CrossOrigin(origins = "http://localhost:8080")
	@GetMapping("/csrftoken")
	public ResponseEntity<String> getCsrfToken(HttpServletRequest request) {
	    CsrfToken csrfToken = (CsrfToken) request.getAttribute(CsrfToken.class.getName());
	    //System.out.println("===>>> getParameterName() = "+csrfToken.getParameterName());
	    //System.out.println("===>>> getToken() = "+csrfToken.getToken());
	    if (csrfToken != null) {
	        return ResponseEntity.ok(csrfToken.getToken());
	    } else {
	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("CSRF token not found");
	    }
	}
	
	@GetMapping("/mainPage")
    public ResponseEntity<Map<String, Object>> getMainData(HttpSession session) {
        Map<String, Object> data = new HashMap<>();
        data.put("memberDept", session.getAttribute("memberDept"));
        data.put("memberId", session.getAttribute("memberId"));

        return ResponseEntity.ok(data);
    }
	
//	@GetMapping("/hello")
//	@CrossOrigin(origins = "*")
//	public String hello(HttpSession session, Model model) {
//		List<MemberDto> memberList = memberService.getMemberListt();
//		model.addAttribute("memberList", memberList);
//		return "/hello";
//	}
}


//@GetMapping("/login")
//public String login(Model model , CsrfToken csrfToken) {
//	model.addAttribute("_csrf", csrfToken);
//	return "/login";	
//}
//



//	@GetMapping("/logout")
//	public String memberLogout(HttpServletRequest request) {
//		HttpSession session = request.getSession();
//		session.invalidate();
//		System.out.println("logout)session : " + session);
//		return "redirect:/login";
//	}
//}

//List<MemberDto> loginCk = memberService.loginCk(member_Id, member_Pw);
//if(loginCk != null) {
//	session.setAttribute("member_Id", dto.getMember_Id());
//	mav.setViewName("/common/header");
//	mav.addObject("member_Id", session.getAttribute("member_Id"));
//	model.addAttribute("loginCk" , loginCk);
//	//System.out.println("loginCk : " + loginCk);
//	//return "redirect:/main";
//	return "redirect:/main";
//}
//return "/login";
