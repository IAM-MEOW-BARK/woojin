<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="true"%>
<!DOCTYPE html>
<html>
<%@ include file="include/head.jsp" %>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
body {
	display: flex;
	min-height: 100vh;
	margin: 0;
}

#sidebar {
	width: 260px; /* Sidebar의 고정 너비 */
	background-color: #0e2238;
}

.date-buttons button {  

	border: 1px solid #bbb;
	background-color: white;
	padding: 3.5px 8px;
	margin-right: 5px;
	font-size: 14px;
	cursor: pointer;
	outline: none;
	color: #696767;
}

.date-buttons button:hover {
	background-color: #e6e6e6;
}

.date-buttons button:focus {
	border-color: #888;
	background-color: #ddd;
}

select, input[type="text"] {
	height: 30px; /* 원하는 높이로 설정 */
	width: 200px; /* 원하는 너비로 설정 */
	box-sizing: border-box; /* 패딩과 보더를 포함하여 크기 조정 */
}

th {
    text-align: center;
}

td {
	vertical-align: middle;
}

.user-list td{
	text-align:center;
}
</style>
</head>
<body>
	<%@ include file="include/catdog-sidebar.jsp"%>
	<div class="main p-5">
		<h6>
			<strong>전체 회원 리스트</strong>
		</h6>
		<form action="searchProduct" method="post">
			<table class="table table-bordered">
				<tr>
					<th>검색어</th>
					<td><select name="searchType">
							<option value="email">이메일</option>
							<option value="socialType">소셜타입</option>
							<option value="name">이름</option>
					</select> <input type="text" name="searchKeyword" placeholder="검색어 입력">
					</td>
				</tr>
				<tr>
					<th>기간</th>
					<td><select name="dateType">
							<option value="registerDate">생성일</option>							
					</select> <input type="date" id="endDate" name="endDate"> - <input
						type="date" id="startDate" name="startDate">
						<div class="date-buttons" style="display: inline-block;">
							<button type="button" onclick="setDate(-1)">1일</button>
							<button type="button" onclick="setDate(-3)">3일</button>
							<button type="button" onclick="setDate(-7)">일주일</button>
							<button type="button" onclick="setDate(-30)">한달</button>
						</div></td>
				</tr>
			</table>
			<div style="text-align: right;">
				<button type="submit" class="btn btn-primary btn-sm"
					style="width: 70px; border-radius: 8px;">검색</button>
				<button type="reset" class="btn btn-secondary btn-sm"
					style="width: 70px; border-radius: 8px;">초기화</button>
			</div>
		</form>
		<hr style="color: black">
		<div style="display: flex; justify-content: space-between;">
			<form id="deleteForm" action="catdog/deleteUsers" method="post">
	            <input type="hidden" name="selectedIds" id="hiddenSelectedIds">
	            <button type="button" class="btn btn-danger btn-sm" style="border-radius: 8px;" onclick="submitDeleteForm()">회원 삭제</button>
	        </form>
			<div>
				<button type="button" class="btn btn-sm"
					style="border-radius: 8px; background-color: #FF6600; color: white;" onclick="location.href='catdog-add-user-admin'">회원 등록</button>
			</div>
		</div>
		<div class="wrapper mt-5">
			<table class="table user-list product-list-table">
				<thead>
					<tr>
						<th class="table-light text-center">
                        	<input type="checkbox" id="selectAll">
                    	</th>						
						<th class="table-light text-center">이메일</th>
						<th class="table-light text-center">소셜타입</th>
						<th class="table-light text-center">이름</th>
						<th class="table-light text-center">권한</th>
						<th class="table-light text-center">휴대전화</th>
						<th class="table-light text-center">생성일</th>
						<th class="table-light text-center">최근 접속일</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<c:forEach var="member" items="${memberList}">
							<c:if test="${member.user_status == 0}">
							 	<tr>
							 		 <td>
				                            <input type="checkbox" name="selectedCheckbox" value="${member.user_id}">
				                        </td>     			 	
								 	<td style="text-align: left;">${member.user_id}</td>
								 	<td>
							            <c:choose>
							                <c:when test="${member.social_id == 1}">
							                    네이버
							                </c:when>
							                <c:when test="${member.social_id == 2}">
							                    카카오
							                </c:when>
							                <c:when test="${member.social_id == 3}">
							                    구글
							                </c:when>
							                <c:otherwise>
							                    -
							                </c:otherwise>
							            </c:choose>
							        </td>			
								 	<td>${member.name}</td>				 	
								 	<td>
									 	<c:choose>
							                <c:when test="${member.user_auth == 0}">
							                    일반
							                </c:when>
							                <c:when test="${member.user_auth == 1}">
							                    관리자
							                </c:when>
							            </c:choose>
						            </td>
								 	<td>0${member.phone_num}</td>
								 	<td>${member.user_created_at}</td>
								 	<td>${member.connected_at}</td>
						 	</tr>
						 	</c:if>
						</c:forEach>	
				</tbody>
			</table>
			<br>
			<div></div>
			<br>
		</div>
		<div style="text-align: center;">
			<a href="#"><</a>
			<a href="#">&nbsp; 1 &nbsp; 2 &nbsp;</a>					
			<a href="#">></a>
		</div>
		<%-- <c:if test="${pageListNUM>1}">
				<a
					href="list?pageListNUM=${pageListNUM-1}&pageNUM=${pageListNUM*10-10}">
					이전 </a>
			</c:if>

			<c:forEach var="i" begin="${startPage }" end="${endPage }">
				<a href="list?pageListNUM=${pageListNUM }&pageNUM=${i }"> ${i }
				</a>
			</c:forEach>

			<c:if test="${pageListNUM<(totalPage/10)}">
				<a
					href="list?pageListNUM=${pageListNUM+1}&pageNUM=${pageListNUM*10+1}">
					다음 </a>
			</c:if> --%>
	</div>
	<script type="text/javascript">
		// 페이지 로드 시 시작 날짜를 오늘로 설정
		window.onload = function() {
			const today = new Date().toISOString().split('T')[0];
			document.getElementById("startDate").value = today;
		};

		// 종료 날짜 설정 함수
		function setDate(daysAgo) {
			const today = new Date();
			const targetDate = new Date(today);
			targetDate.setDate(today.getDate() + daysAgo);
			document.getElementById("endDate").value = targetDate.toISOString()
					.split('T')[0];
		}
		
		// 전체 선택/ 해제
		document.getElementById('selectAll').addEventListener('click', function () {
		    const checkboxes = document.querySelectorAll('input[name="selectedCheckbox"]');
		    checkboxes.forEach(cb => cb.checked = this.checked);
		});
		
		// 삭제 폼 제출
	    function submitDeleteForm() {
	    	 if (!confirm('삭제 하시겠습니까?')) {
	    	        // 취소 버튼을 누르면 함수 종료
	    	        return;
    	    }
			
		    const selectedCheckboxes = document.querySelectorAll('input[name="selectedCheckbox"]:checked');
		    const selectedIds = Array.from(selectedCheckboxes).map(cb => cb.value).join(',');
		
		    if (!selectedIds) {
		        alert('삭제할 항목을 선택하세요.');
		        return;
		    }
		
		    document.getElementById('hiddenSelectedIds').value = selectedIds;
		    document.getElementById('deleteForm').submit();
		}
		
	   
	</script>
</body>
</html>