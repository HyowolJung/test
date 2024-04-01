<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
  /* 사이드 메뉴바 스타일 */
  .side-menu {
    width: 200px;
    background-color: #f4f4f4;
    position: fixed;
    height: 100%;
    overflow: auto;
  }

  /* 메뉴 항목 스타일 */
  .menu-item {
    padding: 8px;
    text-decoration: none;
    font-size: 25px;
    color: black;
    display: block;
  }

  .menu-item:hover {
    color: #f1f1f1;
    background-color: #555;
  }

  /* 하위 메뉴 항목 스타일 */
  .submenu {
    display: none;
    background-color: #f9f9f9;
    padding-left: 30px;
  }
</style>
</head>
<body>
<div class="side-menu">
  <a href="#" class="menu-item" onclick="toggleSubmenu()">사원 관리</a>
  <div class="submenu" id="submenu">
  	<a href="/member/memberList" class="menu-item">사원 조회</a>
  	<a href="/member/search" class="menu-item">사원 검색</a>
    <a href="/member/memberInsert" class="menu-item">사원 등록</a>
  </div>
  <a href="#" class="menu-item" onclick="toggleSubmenu()">프로젝트 관리</a>
  <div class="submenu" id="submenu">
  	<a href="#" class="menu-item">프로젝트 조회</a>
  	<a href="#" class="menu-item">프로젝트 검색</a>
    <a href="#" class="menu-item">프로젝트 등록</a>
  </div>
  <a href="#" class="menu-item" onclick="toggleSubmenu()">급여 관리</a>
  <div class="submenu" id="submenu">
  	<a href="#" class="menu-item">급여 내역 조회</a>
  	<a href="#" class="menu-item">급여 ??</a>
    <a href="#" class="menu-item">급여 ??</a>
  </div>
  <a href="#" class="menu-item" onclick="toggleSubmenu()">근태 관리</a>
  <div class="submenu" id="submenu">
  	<a href="#" class="menu-item">근태 ??</a>
  	<a href="#" class="menu-item">근태 ??</a>
    <a href="#" class="menu-item">근태 ??</a>
  </div>
  <a href="#" class="menu-item" onclick="toggleSubmenu()">커뮤니티</a>
  <div class="submenu" id="submenu">
  	<a href="#" class="menu-item">건의 게시판</a>
  	<a href="#" class="menu-item">자유 게시판</a>
    <a href="#" class="menu-item">익명 게시판</a>
    <a href="#" class="menu-item">사진 게시판</a>
  </div>
</div>
</body>
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">
function toggleSubmenu() {
	var submenu = document.getElementById("submenu");
    if (submenu.style.display === "block") {
		submenu.style.display = "none";
		localStorage.setItem("submenuVisible", "false");
    } else {
		submenu.style.display = "block";
		localStorage.setItem("submenuVisible", "true");
    }
}

window.onload = function() {
	var submenuVisible = localStorage.getItem("submenuVisible") === "true";
	document.getElementById("submenu").style.display = submenuVisible ? "block" : "none";
}
</script>
</html>