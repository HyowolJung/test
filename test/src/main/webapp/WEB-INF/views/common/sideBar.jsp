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