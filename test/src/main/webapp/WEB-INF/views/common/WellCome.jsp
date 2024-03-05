<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/security/tags"%>	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="_csrf" content="${_csrf.token}" />
<meta name="_csrf_header" content="${_csrf.headerName}" />
<title>Insert title here</title>
<style type="text/css">
.user-info {
  display: flex;
  justify-content: flex-end; /* 요소들을 오른쪽 끝으로 정렬 */
  align-items: center;
  padding: 5px;
}

.text-container {
  margin-right: 10px; /* 텍스트와 버튼 사이의 간격 조정 */
}

.logout-button {
  background-color: #007bff;
  color: #fff;
  border: none;
  padding: 5px 9px;
  border-radius: 4px;
  text-decoration: none;
  cursor: pointer;
}

.logout-button:hover {
  background-color: #0056b3;
}
</style>

</head>
<body>

<div class="user-info">
  <div class="text-container">
    <s:authentication property="principal.username"/> 님 환영합니다.
  </div>
  <form method="post" action="/logout">
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
    <button class="logout-button">로그아웃</button>
  </form>
  <button class="logout-button" onclick="main()">메인화면</button>
</div>

</body>
<script type="text/javascript">
	function main(){
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
	
		var form = $('<form></form>', {
        	method: 'GET',
        	action: '/main'
    	});
	
    	form.append($('<input>', {
        	type: 'hidden',
        	name: '${_csrf.parameterName}',
        	value: '${_csrf.token}'
    	}));
    
    	// 폼을 body에 추가하고 제출
    	$('body').append(form);
    	form.submit();
	}
	
</script>
</html>