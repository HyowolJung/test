<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="_csrf" content="${_csrf.token}"/>
<meta name="_csrf_header" content="${_csrf.headerName}"/>
<title>회원 목록 조회</title>
<style>
body {
	font-family: 'Arial', sans-serif;
	margin: 20px;
}
.total-div{
	margin-top: 10px;
	margin-left: 230px; 
}
/* div {
            margin-bottom: 20px;
        } */
input, select {
	margin-right: 10px;
}

table {
	border-collapse: collapse;
	width: 100%;
	margin-bottom: 20px;
}

th, td {
	border: 1px solid #ddd;
	padding: 8px;
	text-align: center;
}

th {
	background-color: #f2f2f2;
}

button {
	padding: 10px;
	cursor: pointer;
}

#pagination {
	margin-top: 20px;
}

ul.pagination {
	display: flex;
	list-style: none;
	padding: 0;
	margin: 0;
}

li.page-item {
	margin-right: 10px;
}

a.page-link {
	text-decoration: none;
	padding: 8px 12px;
	border: 1px solid #ddd;
	color: #333;
	background-color: #fff;
	cursor: pointer;
}

a.page-link.active {
	background-color: #007bff;
	color: #fff;
}

.result-message {
	text-align: center;
	font-style: italic;
	color: #777;
}
.DetailedSearchForm {
	display: none;
}

.total-div {
	margin-top: 20px;
}

.choiceSort, .selectSort {
	display: inline-block; /* 요소들을 인라인 블록으로 만들어 한 줄에 배치 */
    
}

.choiceSort button {
	background: none;
  	border: none;
  	padding: 0;
  	cursor: pointer;
}

.selectSort {
	margin-left: 100px; /* choiceSort와 selectSort 사이 간격 */
	/* //margin-left: 50%; */
}

.choiceSort button:hover {
  text-decoration: underline;
}

.choiceSort button, .selectSort select {
    font-size: 16px; /* 글자 크기 */
    margin: 5px; /* 버튼과 셀렉트 박스 주변 여백 */
}

</style>
</head>
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<body>
<%@include file="/WEB-INF/views/common/header.jsp"%>
<%@include file="/WEB-INF/views/common/sideBar.jsp" %>
<div class="total-div" style="text-align: center;">
<div>
<%-- <input id="pageNo" name="pageNo" value="${pageDto.cri.pageNo }" disabled="disabled" > --%><!-- style="display: none"  -->
<input id="pageNo" name="pageNo" value="${empty pageDto.cri.pageNo ? 1 : pageDto.cri.pageNo}" disabled="disabled" style="display: none"> <!-- style="display: none"  -->
<input id="choiceValue" name="choiceValue" value="${choiceValue }"  disabled="disabled"  style="display: none"><!-- style="display: none" -->

<div class="choiceSort" >
	<button id="IdUp" onclick="getMemberList(this)" value="IdUp">사번 높은 순</button> | <button id="IdDown" onclick="getMemberList(this)" value="IdDown">사번 낮은 순</button> | <button id="DeptUp" onclick="getMemberList(this)" value="DeptUp">직급 높은 순</button> | <button id="DeptDown" onclick="getMemberList(this)" value="DeptDown">직급 낮은 순</button> | <button id="RecentStDay" onclick="getMemberList(this)" value="RecentStDay">최근 입사 순</button>
</div>

<div class="selectSort">
<select id="memberStatus" name="memberStatus" style="height: 30px;" disabled="disabled">
	<option value="ALL">상태</option>
	<option value="D401">재직</option>
	<option value="D403">휴가</option>
	<option value="D405">퇴직</option>
</select>
<select id="searchCnt" name="searchCnt" style="height: 30px;">
	<option value="5">5명</option>
	<option value="10">10명</option>
	<option value="20">20명</option>
</select>
</div>
<button id="downloadButton" onclick="downloadButton()">다운로드</button>
</div>

<br><br>
<table border="1" id="memberTable">
	<thead>
		<tr>
			<th style="display: none"><input type="checkbox" id="checkboxAll" ></th>
			<th>사번</th>
			<th>이름</th>
			<th>성별</th>
			<th>부서</th>
			<th>직책</th>
			<th>직급</th>
			<th>전화번호</th>
			<th>입사일</th>
			<th>퇴사일</th>
			<th>상태</th>
			<th style="display: none">프로젝트아이디</th>
		</tr>
	</thead>
	<tbody>
		
	</tbody>
</table>

<div id="pagination">
	<ul class="pagination" style="list-style: none;"></ul>
</div>

<br><br><br>
</div>


</body>
<!-- <script src="/common/commonsMember.js"></script> -->
<script type="text/javascript">
$(document).ready(function() {
	$("#memberTable tbody").empty();
	$("#memberTable tbody").html("<tr><td colspan='11' style='text-align:center;'>결과가 없어요.</td></tr>");
	
	$('.choiceSort a').click(function(event) {
	    event.preventDefault(); // 링크의 기본 동작 방지

	    // 모든 링크에서 'selected' 클래스 제거
	    $('.choiceSort a').removeClass('selected');

	    // 클릭된 링크에 'selected' 클래스 추가
	    $(this).addClass('selected');
	});	
	
	/* $('#memberStatus').on('change', function() {
	    var memberStatus = $(this).val();
	    var pageNo = $("#pageNo").val();
		var searchCnt = $("#searchCnt").val();
		var choiceValue = $("#choiceValue").val();
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		var data = {
		    	"choiceValue" : choiceValue,
		        "pageNo" : pageNo,
		        "searchCnt" : searchCnt,
				"memberStatus" : memberStatus    		
		}
		    
		$.ajax({
			type : 'POST',
			url : '/member/memberList',
			beforeSend: function(xhr) {
		           xhr.setRequestHeader(header, token); // CSRF 토큰을 헤더에 설정
			},
		    contentType: 'application/json; charset=utf-8',
		    data: JSON.stringify(data),
		    success : function(resultMap) {
			var memberList = resultMap.memberList;
			var pageDto = resultMap.pageDto;
			$("#pageNo").val(pageNo);
			$("#choiceValue").val(choiceValue);
			$("#memberTable tbody").empty();
			
		  		if (memberList && memberList.length > 0) {
		  			for (let i = 0; i < memberList.length; i++) {
		          		var newRow = $("<tr>");
		          		newRow.append("<input type='hidden' name='${_csrf.parameterName}' value='${_csrf.token}'/>");
		           		newRow.append("<td><input type='checkbox' class='checkbox' name='checkbox' value='" + memberList[i].memberId + "' data-id='" + memberList[i].memberId + "'></td>");
		           		newRow.append("<td><a href='#' onclick='submitPost(\"" + memberList[i].memberId + "\", \"" + pageNo + "\"); return false;'>" + memberList[i].memberId + "</a></td>");
		           		newRow.append("<td>" + memberList[i].memberName + "</td>");
		           		newRow.append("<td>" + memberList[i].memberGn + "</td>");
		           		newRow.append("<td>" + memberList[i].memberDept + "</td>");
		           		newRow.append("<td>" + memberList[i].memberRo + "</td>");
		           		newRow.append("<td>" + memberList[i].memberPos + "</td>");
		           		newRow.append("<td>" + memberList[i].memberTel + "</td>");
		           		newRow.append("<td>" + memberList[i].memberStDay + "</td>");
		           		newRow.append("<td>" + (memberList[i].memberLaDay === null ? '(미정)' : memberList[i].memberLaDay) + "</td>");
		           		newRow.append("<td>" + memberList[i].memberSt + "</td>");
		           		$("#memberTable tbody").append(newRow);
	  				}
		  			
		  			var pagination = $("#pagination ul");
		  	        pagination.empty();
		   	        if (pageDto.prev) {
	   	            	pagination.append("<li class='pagination_button' style='float: left; margin-right: 10px'><a class='page-link' onclick='go(" + (pageDto.startNo - 1) + ")' href='#' style='float: left; margin-right: 10px'>Previous</a></li>");
	   	        	}

	   	        	for (var i = pageDto.startNo; i <= pageDto.endNo; i++) {
	   	            	pagination.append("<li class='page-item'><a class='page-link " + (pageDto.pageNo == i ? 'active' : '') + "' onclick='go(" + i + ")' href='#' style='float: left; margin-right: 10px'>" + i + "</a></li>");
	   	        	}
		   	        	if (pageDto.next) {
	   	        		pagination.append("<li class='pagination_button' style='float: left; margin-right: 10px'><a class='page-link' onclick='go(" + (pageDto.endNo + 1) + ")' href='#' style='float: left; margin-right: 10px'>Next</a></li>");
	   	        	}
	   			
	   			} else {
	   				alert("조회는 성공했는데, 결과값이 없는거 같아요.");
	   				$("#memberTable tbody").empty();
	   		    	$("#memberTable tbody").html("<tr><td colspan='11' style='text-align:center;'>결과가 없어요.</td></tr>");
	   			}
	     	},
	     	error : function(request, status, error) { // 결과 에러 콜백함수        
				alert("정렬 실패");
			}
		});
}); */

	// 'searchCount' select 요소에 대한 change 이벤트 리스너 추가
	$('#searchCnt').on('change', function() {
	    var searchCnt = $(this).val();
	    var pageNo = $("#pageNo").val();
		//var memberStatus = $("#memberStatus").val();
		var choiceValue = $("#choiceValue").val();
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		var cri = {
		    	"choiceValue" : choiceValue,
		        "pageNo" : pageNo,
		        "amount" : searchCnt
				//"memberStatus" : memberStatus    		
		    }
		    //alert("pageNo : " + pageNo);
			$.ajax({
				type : 'POST',
				url : '/member/memberList',
				beforeSend: function(xhr) {
		            xhr.setRequestHeader(header, token); // CSRF 토큰을 헤더에 설정
		        },
		        contentType: 'application/json; charset=utf-8',
		        data: JSON.stringify(cri),
		        success : function(resultMap) {
		        	var memberList = resultMap.memberList;
					var pageDto = resultMap.pageDto;
					$("#pageNo").val(pageNo);
					$("#choiceValue").val(choiceValue);
					$("#memberTable tbody").empty();
				
		   			if (memberList && memberList.length > 0) {
		   				for (let i = 0; i < memberList.length; i++) {
		            		var newRow = $("<tr>");
		            		newRow.append("<input type='hidden' name='${_csrf.parameterName}' value='${_csrf.token}'/>");
		            		//newRow.append("<td><input type='checkbox' class='checkbox' name='checkbox' value='" + memberList[i].memberId + "' data-id='" + memberList[i].memberId + "'></td>");
		            		newRow.append("<td><a href='#' onclick='submitPost(\"" + memberList[i].memberId + "\", \"" + pageNo + "\"); return false;'>" + memberList[i].memberId + "</a></td>");
		            		newRow.append("<td>" + memberList[i].memberName + "</td>");
		            		newRow.append("<td>" + memberList[i].memberGn + "</td>");
		            		newRow.append("<td>" + memberList[i].memberDept + "</td>");
		            		newRow.append("<td>" + memberList[i].memberRo + "</td>");
		            		newRow.append("<td>" + memberList[i].memberPos + "</td>");
		            		newRow.append("<td>" + memberList[i].memberTel + "</td>");
		            		newRow.append("<td>" + memberList[i].memberStDay + "</td>");
		            		newRow.append("<td>" + (memberList[i].memberLaDay === null ? '(미정)' : memberList[i].memberLaDay) + "</td>");
		            		newRow.append("<td>" + memberList[i].memberSt + "</td>");
		            		$("#memberTable tbody").append(newRow);
		   				}
		   			
		   				var pagination = $("#pagination ul");
		   	        	pagination.empty();

		   	        	if (pageDto.prev) {
		   	            	pagination.append("<li class='pagination_button' style='float: left; margin-right: 10px'><a class='page-link' onclick='go(" + (pageDto.startNo - 1) + ")' href='#' style='float: left; margin-right: 10px'>Previous</a></li>");
		   	        	}

		   	        	for (var i = pageDto.startNo; i <= pageDto.endNo; i++) {
		   	            	pagination.append("<li class='page-item'><a class='page-link " + (pageDto.pageNo == i ? 'active' : '') + "' onclick='go(" + i + ")' href='#' style='float: left; margin-right: 10px'>" + i + "</a></li>");
		   	        	}

		   	        	if (pageDto.next) {
		   	        		pagination.append("<li class='pagination_button' style='float: left; margin-right: 10px'><a class='page-link' onclick='go(" + (pageDto.endNo + 1) + ")' href='#' style='float: left; margin-right: 10px'>Next</a></li>");
		   	        	}
		   			
		   			} else {
		   				alert("조회는 성공했는데, 결과값이 없는거 같아요.");
		   				$("#memberTable tbody").empty();
		   		    	$("#memberTable tbody").html("<tr><td colspan='11' style='text-align:center;'>결과가 없어요.</td></tr>");
		   			}
		     	},
		     	error : function(request, status, error) { // 결과 에러 콜백함수        
					alert("정렬 실패");
				}
			});
	});
	
	//0. 페이지 기본 이벤트
	let member_Id = $("#member_Id_SE").val();
	$("#memberTable tbody").empty();
	$("#memberTable tbody").html("<tr><td colspan='11' style='text-align:center;'>결과가 없어요.</td></tr>");
	
});//document EndPoint


function getMemberList(element){
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	var choiceValue = element.value;
	var pageNo = $("#pageNo").val();
	var amount = $("#searchCnt").val();
	//var memberStatus = $("#memberStatus").val();
	var buttons = document.querySelectorAll('.choiceSort button');
	
	alert("choiceValue : " + choiceValue);
    // 모든 버튼의 굵기를 초기화합니다.
    buttons.forEach(function(button) {
        button.style.fontWeight = 'normal';
    });

    // 클릭된 버튼만 굵게 표시합니다.
    element.style.fontWeight = 'bold';
	
    var cri = {
    	"choiceValue" : choiceValue,
        "pageNo" : pageNo,  //1
        "amount" : amount  //5
		//"memberStatus" : memberStatus    		
    }
    //alert("pageNo : " + pageNo);
	$.ajax({
		type : 'POST',
		url : '/member/memberList',
		/* beforeSend: function(xhr) {
            xhr.setRequestHeader(header, token); // CSRF 토큰을 헤더에 설정
        }, */
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(cri),
        success : function(resultMap) {
        	var memberList = resultMap.memberList;
			var pageDto = resultMap.pageDto;
			$("#choiceValue").val(choiceValue);
			$("#memberTable tbody").empty();
		
   			if (memberList && memberList.length > 0) {
   				for (let i = 0; i < memberList.length; i++) {
            		var newRow = $("<tr>");
            		newRow.append("<input type='hidden' name='${_csrf.parameterName}' value='${_csrf.token}'/>");
            		//newRow.append("<td><input type='checkbox' class='checkbox' name='checkbox' value='" + memberList[i].memberId + "' data-id='" + memberList[i].memberId + "'></td>");
            		newRow.append("<td>" + memberList[i].memberId + "</td>");//newRow.append("<td><a href='#' onclick='submitPost(\"" + memberList[i].memberId + "\", \"" + pageNo + "\"); return false;'>" + memberList[i].memberId + "</a></td>");
            		newRow.append("<td>" + memberList[i].memberName + "</td>");
            		newRow.append("<td>" + memberList[i].memberGn + "</td>");
            		newRow.append("<td>" + memberList[i].memberDept + "</td>");
            		newRow.append("<td>" + memberList[i].memberRo + "</td>");
            		newRow.append("<td>" + memberList[i].memberPos + "</td>");
            		newRow.append("<td>" + memberList[i].memberTel + "</td>");
            		newRow.append("<td>" + memberList[i].memberStDay + "</td>");
            		newRow.append("<td>" + (memberList[i].memberLaDay === null ? '(미정)' : memberList[i].memberLaDay) + "</td>");
            		newRow.append("<td>" + memberList[i].memberSt + "</td>");
            		$("#memberTable tbody").append(newRow);
   				}
   			
   				var pagination = $("#pagination ul");
   	        	pagination.empty();

   	        	if (pageDto.prev) {
   	            	pagination.append("<li class='pagination_button' style='float: left; margin-right: 10px'><a class='page-link' onclick='go(" + (pageDto.startNo - 1) + ")' href='#' style='float: left; margin-right: 10px'>Previous</a></li>");
   	        	}

   	        	for (var i = pageDto.startNo; i <= pageDto.endNo; i++) {
   	            	pagination.append("<li class='page-item'><a class='page-link " + (pageDto.pageNo == i ? 'active' : '') + "' onclick='go(" + i + ")' href='#' style='float: left; margin-right: 10px'>" + i + "</a></li>");
   	        	}

   	        	if (pageDto.next) {
   	        		pagination.append("<li class='pagination_button' style='float: left; margin-right: 10px'><a class='page-link' onclick='go(" + (pageDto.endNo + 1) + ")' href='#' style='float: left; margin-right: 10px'>Next</a></li>");
   	        	}
   			
   			} else {
   				alert("조회는 성공했는데, 결과값이 없는거 같아요.");
   				$("#memberTable tbody").empty();
   		    	$("#memberTable tbody").html("<tr><td colspan='11' style='text-align:center;'>결과가 없어요.</td></tr>");
   			}
     	},
     	error : function(request, status, error) { // 결과 에러 콜백함수        
			alert("정렬 실패");
		}
	});	
}

function go(pageNo){
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	var choiceValue = $("#choiceValue").val();
	var amount = $("#searchCnt").val();
	//var memberStatus = $("#memberStatus").val();
	$("#pageNo").val(pageNo);
	var pageNo = $("#pageNo").val();
	var memberId = $("#memberId").val();
	
	var cri = {
    	"choiceValue" : choiceValue,
        "pageNo" : pageNo,
        "amount" : amount
		//"memberStatus" : memberStatus    		
    }
	
	$.ajax({
		type : 'POST',
		url: '/member/memberList',
		beforeSend: function(xhr) {
            xhr.setRequestHeader(header, token); // CSRF 토큰을 헤더에 설정
        },
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(cri),
		success : function(resultMap) { // 결과 성공 콜백함수
			$("#choiceValue").val(choiceValue);
			var memberList = resultMap.memberList;
			var pageDto = resultMap.pageDto;
			$("#memberTable tbody").empty();
			
       		if (memberList && memberList.length > 0) {
       			for (let i = 0; i < memberList.length; i++) {
       				var newRow = $("<tr>");
            		newRow.append("<input type='hidden' name='${_csrf.parameterName}' value='${_csrf.token}'/>");
            		//newRow.append("<td><input type='checkbox' class='checkbox' name='checkbox' value='" + memberList[i].memberId + "' data-id='" + memberList[i].memberId + "'></td>");
            		newRow.append("<td>" + memberList[i].memberId + "</td>"); //<a href='#' onclick='submitPost(\"" + memberList[i].memberId + "\", \"" + pageNo + "\"); return false;'>" "</a>
            		newRow.append("<td>" + memberList[i].memberName + "</td>");
            		newRow.append("<td>" + memberList[i].memberGn + "</td>");
            		newRow.append("<td>" + memberList[i].memberDept + "</td>");
            		newRow.append("<td>" + memberList[i].memberRo + "</td>");
            		newRow.append("<td>" + memberList[i].memberPos + "</td>");
            		newRow.append("<td>" + memberList[i].memberTel + "</td>");
            		newRow.append("<td>" + memberList[i].memberStDay + "</td>");
            		newRow.append("<td>" + (memberList[i].memberLaDay === null ? '(미정)' : memberList[i].memberLaDay) + "</td>");
            		newRow.append("<td>" + memberList[i].memberSt + "</td>");
            		$("#memberTable tbody").append(newRow);
       			}
       			var pagination = $("#pagination ul");
       	        pagination.empty();

       	        if (pageDto.prev) {
       	            pagination.append("<li class='pagination_button' style='float: left; margin-right: 10px'><a class='page-link' onclick='go(" + (pageDto.startNo - 1) + ")' href='#' style='float: left; margin-right: 10px'>Previous</a></li>");
       	        }

       	        for (var i = pageDto.startNo; i <= pageDto.endNo; i++) {
       	            pagination.append("<li class='page-item'><a class='page-link " + (pageDto.pageNo == i ? 'active' : '') + "' onclick='go(" + i + ")' href='#' style='float: left; margin-right: 10px'>" + i + "</a></li>");
       	        }

       	        if (pageDto.next) {
       	        	pagination.append("<li class='pagination_button' style='float: left; margin-right: 10px'><a class='page-link' onclick='go(" + (pageDto.endNo + 1) + ")' href='#' style='float: left; margin-right: 10px'>Next</a></li>");
       	        }
       			
       		}else{
       			alert("조회는 성공했는데, 결과값이 없는거 같아요.");
       			$("#memberTable tbody").empty();
       		    $("#memberTable tbody").html("<tr><td colspan='11' style='text-align:center;'>결과가 없어요.</td></tr>");
       		}
       		
		},
		error : function(request, status, error) { // 결과 에러 콜백함수        
			alert("작동 실패");
		}
	});	//ajax EndPoint
};//function go EndPoint

function submitPost(memberId, pageNo) {
	
    var selectedList = [];
    selectedList.push(memberId);
    alert("selectedListselectedList : " + selectedList);
    
    var form = $('<form></form>', {
        method: 'POST',
        action: '/member/memberRead'
    });

    // memberId와 pageNo 값을 input으로 추가
    selectedList.forEach(function(item) {
    	
        form.append($('<input>', {
            type: 'hidden',
            name: 'selectedList[]', // 서버에서 배열로 인식할 수 있도록 이름에 대괄호를 추가
            value: memberId
        }));
        
        form.append($('<input>', {
            type: 'hidden',
            name: 'pageNo',
            value: pageNo
        }));
        
    });     
        
    form.append($('<input>', {
        type: 'hidden',
        name: 'memberIdd',
        value: memberId
    }));    
        //필요 없긴 한데 다른 페이지에서 해당 컨트롤러에 있는 메서드를 사용할 때는 이게 필요해서...
	/* form.append($('<input>', {
            type: 'hidden',
            name: 'memberId',
            value: memberId
        })); */

    /*  form.append($('<input>', {
        type: 'hidden',
        name: 'selectedList[]',
        value: selectedList
    })); */
	
    form.append($('<input>', {
        type: 'hidden',
        name: '${_csrf.parameterName}',
        value: '${_csrf.token}'
    }));
    
    // 폼을 body에 추가하고 제출
    $('body').append(form);
    form.submit();
}

function downloadButton(){
	window.location.href ="/member/download";
}
</script>
</html>