<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="true"%>
<!DOCTYPE html>
<html>
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

.pagination-container {
            display: flex;
            justify-content: space-between; /* 양쪽 정렬 */
            align-items: center; /* 세로 정렬 */
            margin: 20px 0;
        }
.pagination {
    display: flex;
    gap: 15px; 
    margin: 0 auto;
}
.pagination a {
    text-decoration: none;
    color: #333;
    font-size: 12px;
}
.pagination a.active {
    color: #ff6600; 
    font-weight: bold; 
}
</style>
</head>
<body>
	<%@ include file="include/catdog-sidebar.jsp"%>
	<div class="main p-5">
		<h6>
			<strong>전체 회원 리스트</strong>
		</h6>
		<form action="searchMember" method="post">
			<%-- <input type="hidden" name="pageNum" value="${currentPage}">
    		<input type="hidden" name="pageSize" value="${pageSize}"> --%>
			<table class="table table-bordered">
				<tr>
					<th>검색어</th>
					<td><select name="searchType">
							 <option value="email" ${searchType == 'email' ? 'selected' : ''}>이메일</option>
							 <option value="name" ${searchType == 'name' ? 'selected' : ''}>이름</option>
    <%-- <option value="socialType" ${searchType == 'socialType' ? 'selected' : ''}>소셜타입</option> --%>
    
    <%-- <option value="status" ${searchType == 'status' ? 'selected' : ''}>상태</option> --%>
					</select>
					<input type="text" name="searchKeyword" placeholder="검색어 입력">
					</td>
				</tr>
				<tr>
					<th>기간</th>
					<td>
					<select>
							<option value="registerDate">생성일</option>							
					</select>
					 <input type="date" id="endDate" name="endDate"> - 
					 <input	type="date" id="startDate" name="startDate">
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
		<div class="mt-5">
			<table class="table table-borderd user-list product-list-table">
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
						<th class="table-light text-center">상태</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<c:forEach var="member" items="${memberList}">
							 	<tr>
							 		 <td>
				                            <input type="checkbox" name="selectedCheckbox" value="${member.user_id}">
				                        </td>     			 	
								 	<td style="text-align: left;">${member.user_id}</td>
								 	<td>
							            <c:choose>
							                <c:when test="${member.social_id == 1}">
							                    카카오
							                </c:when>
							                <c:when test="${member.social_id == 2}">
							                    네이버
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
								 	<td>${member.phone_num}</td>
								 	<td>${member.user_created_at}</td>
								 	<td>${member.connected_at}</td>
								 	<td>
									 	<c:choose>
							                <c:when test="${member.user_status == 0}">
							                    정상
							                </c:when>
							                <c:when test="${member.user_status == 1}">
							                    탈퇴
							                </c:when>
							            </c:choose>
						            </td>
						 	</tr>
						</c:forEach>	
				</tbody>
			</table>
			<br>
			<div></div>
			<br>
		</div>
		<c:set var="basePath" value="${not empty searchKeyword or not empty searchType or not empty startDate or not empty endDate ? 'searchMember' : 'catdog-user-list-admin'}" />

<div class="pagination-container">
    <div class="pagination">
        <c:if test="${startPage > 1}">
            <a href="${basePath}?pageNum=${startPage - 1}&pageListNum=${pageListNum}&searchType=${searchType}&searchKeyword=${searchKeyword}&startDate=${startDate}&endDate=${endDate}">&lt;</a>
        </c:if>
        <c:forEach begin="${startPage}" end="${endPage}" var="page">
            <a href="${basePath}?pageNum=${page}&pageListNum=${pageListNum}&searchType=${searchType}&searchKeyword=${searchKeyword}&startDate=${startDate}&endDate=${endDate}"
               class="${currentPage == page ? 'active' : ''}">${page}</a>
        </c:forEach>
        <c:if test="${endPage < totalPage}">
            <a href="${basePath}?pageNum=${endPage + 1}&pageListNum=${pageListNum}&searchType=${searchType}&searchKeyword=${searchKeyword}&startDate=${startDate}&endDate=${endDate}">&gt;</a>
        </c:if>
    </div>
</div>
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