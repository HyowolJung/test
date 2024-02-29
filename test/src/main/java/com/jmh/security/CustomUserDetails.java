package com.jmh.security;

import java.util.ArrayList;
import java.util.Collection;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

public class CustomUserDetails implements UserDetails{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	/**
	 * 
	 */
	private String member_Id;
	private String member_Pw;
	private String member_Name;
	private String member_Authority;
	private boolean member_Enabled;
	
	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		System.err.println("CustomUserDetails 도착했어요!! 1 : " + member_Authority);
		ArrayList<GrantedAuthority> auth = new ArrayList<GrantedAuthority>();
		auth.add(new SimpleGrantedAuthority(member_Authority));
		
		return auth;
	}

	public String getMember_Name() {
		System.err.println("CustomUserDetails 도착했어요!! 2 : " + member_Name);
		return member_Name;
	}

	public void setMember_Name(String member_Name) {
		System.err.println("CustomUserDetails 도착했어요!! 3 : " + member_Name);
		this.member_Name = member_Name;
	}

	@Override
	public String getPassword() {
		// TODO Auto-generated method stub
		System.err.println("CustomUserDetails 도착했어요!! 4");
		return member_Pw;
	}

	@Override
	public String getUsername() {
		// TODO Auto-generated method stub
		System.err.println("CustomUserDetails 도착했어요!! 5 : " + member_Id);
		return member_Id;
	}

	@Override                                                                         
	public boolean isAccountNonExpired() {
		// TODO Auto-generated method stub
		System.err.println("CustomUserDetails 도착했어요!! 6");
		return true;
	}

	@Override
	public boolean isAccountNonLocked() {
		// TODO Auto-generated method stub
		System.err.println("CustomUserDetails 도착했어요!! 7");
		return true;
	}

	@Override
	public boolean isCredentialsNonExpired() {
		// TODO Auto-generated method stub
		System.err.println("CustomUserDetails 도착했어요!! 8");
		return true;
	}

	@Override
	public boolean isEnabled() {
		// TODO Auto-generated method stub
		System.err.println("CustomUserDetails 도착했어요!! 9");
		return true;
	}
	
}
