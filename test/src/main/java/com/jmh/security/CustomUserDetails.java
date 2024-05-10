//package com.jmh.security;
//
//import java.util.ArrayList;
//import java.util.Collection;
//
//import javax.servlet.http.HttpSession;
//
//import org.springframework.security.core.GrantedAuthority;
//import org.springframework.security.core.authority.SimpleGrantedAuthority;
//import org.springframework.security.core.userdetails.UserDetails;
//
//public class CustomUserDetails implements UserDetails{
//	/**
//	 * 
//	 */
//	private static final long serialVersionUID = 1L;
//	/**
//	 * 
//	 */
//	private String memberId;
//	private String memberPw;
//	private String memberName;
//	private String memberDept;
//	private String memberAuth;
//	//private boolean member_Enabled;
//	
//	@Override
//	public Collection<? extends GrantedAuthority> getAuthorities() {
//		System.err.println("CustomUserDetails 도착했어요!! 1 : " + memberAuth);
//		ArrayList<GrantedAuthority> auth = new ArrayList<GrantedAuthority>();
//		auth.add(new SimpleGrantedAuthority(memberAuth));
//		return auth;
//	}
//
//	@Override
//	public String getPassword() {
//		// TODO Auto-generated method stub
//		return memberPw;
//	}
//
//	@Override
//	public String getUsername() {
//		// TODO Auto-generated method stub
//		return memberId;
//	}
//
//	@Override
//	public boolean isAccountNonExpired() {
//		// TODO Auto-generated method stub
//		return true;
//	}
//
//	@Override
//	public boolean isAccountNonLocked() {
//		// TODO Auto-generated method stub
//		return true;
//	}
//
//	@Override
//	public boolean isCredentialsNonExpired() {
//		// TODO Auto-generated method stub
//		return true;
//	}
//
//	@Override
//	public boolean isEnabled() {
//		// TODO Auto-generated method stub
//		return true;
//	}
//
//	
//	
//	
////	public String getMemberName() {
////		System.err.println("CustomUserDetails 도착했어요!! 2 : " + memberName);
////		return memberName;
////	}
////
////	public void setMemberName(String memberName) {
////		System.err.println("CustomUserDetails 도착했어요!! 3 : " + memberName);
////		this.memberName = memberName;
////	}
////	
////	public String getMemeberDept() {
////		System.err.println("CustomUserDetails 도착했어요!! 10");
////		return memberDept;
////	}
////
////	public void setMemeberDept(String memberDept) {
////		System.err.println("CustomUserDetails 도착했어요!! 11");
////		this.memberDept = memberDept;
////	}
////	
////	@Override
////	public String getPassword() {
////		// TODO Auto-generated method stub
////		System.err.println("CustomUserDetails 도착했어요!! 4");
////		return memberPw;
////	}
////
////	@Override
////	public String getUsername() {
////		// TODO Auto-generated method stub
////		System.err.println("CustomUserDetails 도착했어요!! 5 : " + memberId);
////		return memberId;
////	}
////
////	@Override                                                                         
////	public boolean isAccountNonExpired() {
////		// TODO Auto-generated method stub
////		System.err.println("CustomUserDetails 도착했어요!! 6");
////		return true;
////	}
////
////	@Override
////	public boolean isAccountNonLocked() {
////		// TODO Auto-generated method stub
////		System.err.println("CustomUserDetails 도착했어요!! 7");
////		return true;
////	}
////
////	@Override
////	public boolean isCredentialsNonExpired() {
////		// TODO Auto-generated method stub
////		System.err.println("CustomUserDetails 도착했어요!! 8");
////		return true;
////	}
////
////	@Override
////	public boolean isEnabled() {
////		// TODO Auto-generated method stub
////		System.err.println("CustomUserDetails 도착했어요!! 9");
////		return true;
////	}
//}
//
