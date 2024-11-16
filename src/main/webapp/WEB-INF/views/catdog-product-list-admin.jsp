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
			<strong>전체 상품 리스트</strong>
		</h6>
		<form action="searchProduct" method="post">
			<table class="table table-bordered">
				<tr>
					<th>검색어</th>
					<td><select name="searchType">
							<option value="productName">상품명</option>
							<option value="productCode">상품코드</option>
							<option value="categoriName">카테고리명</option>
					</select> <input type="text" name="searchKeyword" placeholder="검색어 입력">
					</td>
				</tr>
				<tr>
					<th>상품 가격</th>
					<td><input type="text" name="priceMin" placeholder="상품가격 입력">
						<span>원 이상 &nbsp;</span> <input type="text" name="priceMax"
						placeholder="상품가격 입력"> <span>원 이하</span></td>
				</tr>
				<tr>
					<th>기간</th>
					<td><select name="dateType">
							<option value="registerDate">등록일</option>
							<option value="updateDate">수정일</option>
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
					style="border-radius: 8px;">상품 삭제</button>
			</div>
			<div>
				<button type="submit" class="btn btn-sm"
					style="border-radius: 8px; background-color: #9A106C; color: white;'">상품
					수정</button>
				<button type="submit" class="btn btn-sm"
					style="border-radius: 8px; background-color: #FF6600; color: white;">상품
					등록</button>
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
						<th class="table-light text-center">이미지</th>
						<th class="table-light text-center">상품코드</th>
						<th class="table-light text-center">카테고리</th>
						<th class="table-light text-center">상품명</th>
						<th class="table-light text-center">등록일</th>
						<th class="table-light text-center">수정일</th>
						<th class="table-light text-center">가격</th>
						<th class="table-light text-center">관리</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<%-- <c:forEach var="board" items="${list}">
			 	<tr>
			 		<td>
			 			<input type="checkbox">
			 		</td>
				 	<td>${product-list.no}</td>
				 	<td>${product-list.img}</td>
				 	<td>${product-list.code}</td>
				 	<td>${product-list.categori}</td>
				 	<td>${product-list.name}</td>
				 	<td>${product-list.created_at}</td>
				 	<td>${product-list.changed_at}</td>
				 	<td>${product-list.price}</td>
				 	<td>
				 		<button class="btn btn-secondary btn-sm">수정</button>
				 	</td>
			 	</tr>
			</c:forEach> --%>
					<tr>
						<td class="text-center">
							<input type="checkbox">
						</td>
						<td class="text-center">1</td>
						<td class="text-center">
								<img alt="product_image" src="${pageContext.request.contextPath}/resources/bootstrap/images/thumbnail_01.png" style="width: 30px; height: auto;">
						</td>
						<td class="text-center">AP-100001</td>
						<td class="text-center">의류/잡화</td>
						<td class="text-center">양면 초경량 후리스 네이비...</td>
						<td class="text-center">2021/01/06</td>
						<td class="text-center">2024/11/15</td>
						<td class="text-center">35,000</td>
						<td class="text-center">
							<button class="btn btn-secondary btn-sm">수정</button>
						</td>
					</tr>
					<tr>
						<td class="text-center">
							<input type="checkbox">
						</td>
						<td class="text-center">1</td>
						<td class="text-center">
								<img alt="product_image" src="${pageContext.request.contextPath}/resources/bootstrap/images/thumbnail_01.png" style="width: 30px; height: auto;">
						</td>
						<td class="text-center">AP-100001</td>
						<td class="text-center">의류/잡화</td>
						<td class="text-center">양면 초경량 후리스 네이비...</td>
						<td class="text-center">2021/01/06</td>
						<td class="text-center">2024/11/15</td>
						<td class="text-center">35,000</td>
						<td class="text-center">
							<button class="btn btn-secondary btn-sm">수정</button>
						</td>
					</tr>
					<tr>
						<td class="text-center">
							<input type="checkbox">
						</td>
						<td class="text-center">1</td>
						<td class="text-center">
								<img alt="product_image" src="${pageContext.request.contextPath}/resources/bootstrap/images/thumbnail_01.png" style="width: 30px; height: auto;">
						</td>
						<td class="text-center">AP-100001</td>
						<td class="text-center">의류/잡화</td>
						<td class="text-center">양면 초경량 후리스 네이비...</td>
						<td class="text-center">2021/01/06</td>
						<td class="text-center">2024/11/15</td>
						<td class="text-center">35,000</td>
						<td class="text-center">
							<button class="btn btn-secondary btn-sm">수정</button>
						</td>
					</tr>
					<tr>
						<td class="text-center">
							<input type="checkbox">
						</td>
						<td class="text-center">1</td>
						<td class="text-center">
								<img alt="product_image" src="${pageContext.request.contextPath}/resources/bootstrap/images/thumbnail_01.png" style="width: 30px; height: auto;">
						</td>
						<td class="text-center">AP-100001</td>
						<td class="text-center">의류/잡화</td>
						<td class="text-center">양면 초경량 후리스 네이비...</td>
						<td class="text-center">2021/01/06</td>
						<td class="text-center">2024/11/15</td>
						<td class="text-center">35,000</td>
						<td class="text-center">
							<button class="btn btn-secondary btn-sm">수정</button>
						</td>
					</tr>
					<tr>
						<td class="text-center">
							<input type="checkbox">
						</td>
						<td class="text-center">1</td>
						<td class="text-center">
								<img alt="product_image" src="${pageContext.request.contextPath}/resources/bootstrap/images/thumbnail_01.png" style="width: 30px; height: auto;">
						</td>
						<td class="text-center">AP-100001</td>
						<td class="text-center">의류/잡화</td>
						<td class="text-center">양면 초경량 후리스 네이비...</td>
						<td class="text-center">2021/01/06</td>
						<td class="text-center">2024/11/15</td>
						<td class="text-center">35,000</td>
						<td class="text-center">
							<button class="btn btn-secondary btn-sm">수정</button>
						</td>
					</tr>
					<tr>
						<td class="text-center">
							<input type="checkbox">
						</td>
						<td class="text-center">1</td>
						<td class="text-center">
								<img alt="product_image" src="${pageContext.request.contextPath}/resources/bootstrap/images/thumbnail_01.png" style="width: 30px; height: auto;">
						</td>
						<td class="text-center">AP-100001</td>
						<td class="text-center">의류/잡화</td>
						<td class="text-center">양면 초경량 후리스 네이비...</td>
						<td class="text-center">2021/01/06</td>
						<td class="text-center">2024/11/15</td>
						<td class="text-center">35,000</td>
						<td class="text-center">
							<button class="btn btn-secondary btn-sm">수정</button>
						</td>
					</tr>
					<tr>
						<td class="text-center">
							<input type="checkbox">
						</td>
						<td class="text-center">1</td>
						<td class="text-center">
								<img alt="product_image" src="${pageContext.request.contextPath}/resources/bootstrap/images/thumbnail_01.png" style="width: 30px; height: auto;">
						</td>
						<td class="text-center">AP-100001</td>
						<td class="text-center">의류/잡화</td>
						<td class="text-center">양면 초경량 후리스 네이비...</td>
						<td class="text-center">2021/01/06</td>
						<td class="text-center">2024/11/15</td>
						<td class="text-center">35,000</td>
						<td class="text-center">
							<button class="btn btn-secondary btn-sm">수정</button>
						</td>
					</tr>
					<tr>
						<td class="text-center">
							<input type="checkbox">
						</td>
						<td class="text-center">1</td>
						<td class="text-center">
								<img alt="product_image" src="${pageContext.request.contextPath}/resources/bootstrap/images/thumbnail_01.png" style="width: 30px; height: auto;">
						</td>
						<td class="text-center">AP-100001</td>
						<td class="text-center">의류/잡화</td>
						<td class="text-center">양면 초경량 후리스 네이비...</td>
						<td class="text-center">2021/01/06</td>
						<td class="text-center">2024/11/15</td>
						<td class="text-center">35,000</td>
						<td class="text-center">
							<button class="btn btn-secondary btn-sm">수정</button>
						</td>
					</tr>
					<tr>
						<td class="text-center">
							<input type="checkbox">
						</td>
						<td class="text-center">1</td>
						<td class="text-center">
								<img alt="product_image" src="${pageContext.request.contextPath}/resources/bootstrap/images/thumbnail_01.png" style="width: 30px; height: auto;">
						</td>
						<td class="text-center">AP-100001</td>
						<td class="text-center">의류/잡화</td>
						<td class="text-center">양면 초경량 후리스 네이비...</td>
						<td class="text-center">2021/01/06</td>
						<td class="text-center">2024/11/15</td>
						<td class="text-center">35,000</td>
						<td class="text-center">
							<button class="btn btn-secondary btn-sm">수정</button>
						</td>
					</tr>
					<tr>
						<td class="text-center">
							<input type="checkbox">
						</td>
						<td class="text-center">1</td>
						<td class="text-center">
								<img alt="product_image" src="${pageContext.request.contextPath}/resources/bootstrap/images/thumbnail_01.png" style="width: 30px; height: auto;">
						</td>
						<td class="text-center">AP-100001</td>
						<td class="text-center">의류/잡화</td>
						<td class="text-center">양면 초경량 후리스 네이비...</td>
						<td class="text-center">2021/01/06</td>
						<td class="text-center">2024/11/15</td>
						<td class="text-center">35,000</td>
						<td class="text-center">
							<button class="btn btn-secondary btn-sm">수정</button>
						</td>
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