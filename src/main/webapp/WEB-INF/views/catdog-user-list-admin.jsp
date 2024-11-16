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
			<div>
				<button type="submit" class="btn btn-danger btn-sm"
					style="border-radius: 8px;">회원 삭제</button>
			</div>
			<div>
				<button type="submit" class="btn btn-sm"
					style="border-radius: 8px; background-color: #FF6600; color: white;">회원 등록</button>
			</div>
		</div>
		<div class="wrapper mt-5">
			<table class="table product-list-table">
				<thead>
					<tr>
						<th class="table-light text-center">
							<input type="checkbox">
						</th>
						<th class="table-light text-center" style="height:20px;">NO</th>
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
						<%-- <c:forEach var="board" items="${list}">
			 	<tr>
			 		<td>
			 			<input type="checkbox">
			 		</td>
				 	<td>${user-list.no}</td>
				 	<td>${user-list.email}</td>
				 	<td>${user-list.socialType}</td>
				 	<td>${user-list.name}</td>
				 	<td>${user-list.authority}</td>
				 	<td>${user-list.phoneNum}</td>
				 	<td>${user-list.created_at}</td>
				 	<td>${user-list.recently_visited_at}</td>
			 	</tr>
			</c:forEach> --%>
					<tr>
						<td class="text-center">
							<input type="checkbox">
						</td>
						<td class="text-center">10</td>
						<td class="text-center">test@naver.com</td>
						<td class="text-center">-</td>
						<td class="text-center">햄우진</td>
						<td class="text-center">관리자</td>
						<td class="text-center">010-1234-5678</td>
						<td class="text-center">2021/01/06</td>
						<td class="text-center">2024/11/16</td>
					</tr>
					<tr>
						<td class="text-center">
							<input type="checkbox">
						</td>
						<td class="text-center">9</td>
						<td class="text-center">test@naver.com</td>
						<td class="text-center">-</td>
						<td class="text-center">박나현</td>
						<td class="text-center">일반</td>
						<td class="text-center">010-1234-5678</td>
						<td class="text-center">2021/01/06</td>
						<td class="text-center">2024/11/16</td>
					</tr>
					<tr>
						<td class="text-center">
							<input type="checkbox">
						</td>
						<td class="text-center">8</td>
						<td class="text-center">GO_test@gmail.com</td>
						<td class="text-center">구글</td>
						<td class="text-center">최지혜</td>
						<td class="text-center">일반</td>
						<td class="text-center">010-1234-5678</td>
						<td class="text-center">2021/01/06</td>
						<td class="text-center">2024/11/16</td>
					</tr>
					<tr>
						<td class="text-center">
							<input type="checkbox">
						</td>
						<td class="text-center">7</td>
						<td class="text-center">test@naver.com</td>
						<td class="text-center">-</td>
						<td class="text-center">허준혁</td>
						<td class="text-center">일반</td>
						<td class="text-center">010-1234-5678</td>
						<td class="text-center">2021/01/06</td>
						<td class="text-center">2024/11/16</td>
					</tr>
					<tr>
						<td class="text-center">
							<input type="checkbox">
						</td>
						<td class="text-center">6</td>
						<td class="text-center">test@naver.com</td>
						<td class="text-center">-</td>
						<td class="text-center">김은혜</td>
						<td class="text-center">일반</td>
						<td class="text-center">010-1234-5678</td>
						<td class="text-center">2021/01/06</td>
						<td class="text-center">2024/11/16</td>
					</tr>
					<tr>
						<td class="text-center">
							<input type="checkbox">
						</td>
						<td class="text-center">5</td>
						<td class="text-center">test@naver.com</td>
						<td class="text-center">-</td>
						<td class="text-center">김윤호</td>
						<td class="text-center">일반</td>
						<td class="text-center">010-1234-5678</td>
						<td class="text-center">2021/01/06</td>
						<td class="text-center">2024/11/16</td>
					</tr>
					<tr>
						<td class="text-center">
							<input type="checkbox">
						</td>
						<td class="text-center">4</td>
						<td class="text-center">test@naver.com</td>
						<td class="text-center">-</td>
						<td class="text-center">이세라</td>
						<td class="text-center">일반</td>
						<td class="text-center">010-1234-5678</td>
						<td class="text-center">2021/01/06</td>
						<td class="text-center">2024/11/16</td>
					</tr>
					<tr>
						<td class="text-center">
							<input type="checkbox">
						</td>
						<td class="text-center">3</td>
						<td class="text-center">test@naver.com</td>
						<td class="text-center">-</td>
						<td class="text-center">김현주</td>
						<td class="text-center">일반</td>
						<td class="text-center">010-1234-5678</td>
						<td class="text-center">2021/01/06</td>
						<td class="text-center">2024/11/16</td>
					</tr>
					<tr>
						<td class="text-center">
							<input type="checkbox">
						</td>
						<td class="text-center">2</td>
						<td class="text-center">test@naver.com</td>
						<td class="text-center">-</td>
						<td class="text-center">김성덕</td>
						<td class="text-center">관리자</td>
						<td class="text-center">010-1234-5678</td>
						<td class="text-center">2021/01/06</td>
						<td class="text-center">2024/11/16</td>
					</tr>
					<tr>
						<td class="text-center">
							<input type="checkbox">
						</td>
						<td class="text-center">1</td>
						<td class="text-center">test@naver.com</td>
						<td class="text-center">-</td>
						<td class="text-center">김민성</td>
						<td class="text-center">일반</td>
						<td class="text-center">010-1234-5678</td>
						<td class="text-center">2021/01/06</td>
						<td class="text-center">2024/11/16</td>
					</tr>
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
	</script>
</body>
</html>