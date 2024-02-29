<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

메인페이지
<%@include file="/WEB-INF/views/common/WellCome.jsp" %><br><br>
<input type ="text" id="member_Id" value = "${member_Id}" disabled="disabled" style="display: none;">

<!-- <a href="#" onclick="submitPost()" style="display: inline;">자유 게시판</a> -->
<a href="/board/home" style="display: inline;">자유 게시판</a><!-- onclick="submitPost()"  -->
<a href="/member/memberList" style="display: inline;">회원 관리</a>
<a href="/project/projectList?pageNo=1" style="display: inline;">프로젝트 관리</a>

<%-- <c:if test="${member_Department == '인사부'}">
	<a href="/member/memberList" style="display: inline;">회원 관리</a>
</c:if>
<c:if test="${member_Department == 'IT부'}">
 	<a href="/project/projectList?pageNo=1" style="display: inline;">프로젝트 관리</a>
</c:if> --%>

</body>
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">
/* var member_Id = $("#member_Id").val();
function submitPost() {
	//alert("pageNo : " + pageNo);
	//alert("member_Id : " + member_Id);
    // 폼 생성
    var form = $('<form></form>', {
        method: 'POST',
        action: '/board/home'
    });

    // memberId와 pageNo 값을 input으로 추가
    form.append($('<input>', {
        type: 'hidden',
        name: 'member_Id',
        value: member_Id
    }));

    // 폼을 body에 추가하고 제출
    $('body').append(form);
    form.submit();
} */
</script>
</html>