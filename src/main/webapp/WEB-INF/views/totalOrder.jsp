<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>전체 주문 내역</title>
<%@ include file="include/head.jsp"%>
<style>
.center-container {
	display: flex;
	justify-content: center;
	align-items: center;
	flex-direction: column; /* 세로 방향으로 정렬 */
}

.table-container {
	width: 1000px;
	margin: 20px; /* 표 간 간격 */
}
</style>

</head>
<body>
	<%@ include file="include/header.jsp"%>
	<%@ include file="include/mypageheader.jsp"%>
	<!-- 마이페이지 -->
	<div class="container-lg my-5">
		<div class="row">
			<!-- 왼쪽 내비게이션 -->
			<%@ include file="include/mypagenav.jsp"%>

			<!-- 오른쪽 콘텐츠 -->
			<div class="col-md-9">

				<!-- 조회 필터 -->
				<div class="table-container">
					<h4>주문 내역</h4>
<!-- 					<table class="table justify-content-center" style="text-align: center; border: 1px solid #ddd;">
						<tr>
							<th class="col-md-1 table-light">조회기간</th>
							<td class="col-md-6">
								<form style="display: flex; align-items: center; gap: 10px;">
									<input class="btn btn-outline-secondary" type="button" value="7일" onclick="setActiveButton(this)"> <input class="btn btn-outline-secondary" type="button" value="15일" onclick="setActiveButton(this)"> <input class="btn btn-outline-secondary" type="button" value="1개월" onclick="setActiveButton(this)"> <input class="btn btn-outline-secondary" type="button" value="3개월" onclick="setActiveButton(this)"> <input class="btn btn-outline-secondary" type="button" value="1년" onclick="setActiveButton(this)"> <input type="date" class="form-control" style="width: 150px;"> <span>~</span> <input type="date" class="form-control" style="width: 150px;">
									<button type="submit" class="btn btn-dark">조회</button>
								</form>
							</td>
						</tr>
					</table> -->
				</div>


				<!-- 전체 주문 내역 리스트 -->
				<div class="table-container">
					<table class="table justify-content-center" style="text-align: center">
						<tr>
							<th class="col-md-1 table-light">주문일자</th>
							<th class="col-md-1 table-light">주문번호</th>
							<th class="col-md-2 table-light">대표제품</th>
							<th class="col-md-1 table-light">결제금액</th>
							<th class="col-md-1 table-light">주문상태</th>
						</tr>
						<c:forEach var="order" items="${myOrders}">
							<tr>
								<td>${order.orderedAt}</td>
								<td>
									<a href="detailOrder?order_code=${order.orderCode}">${order.orderCode}</a>
								</td>
								<td>${order.firstProductName}</td>
								<td>${order.totalPrice}</td>
								<td>${order.paymentStatus}</td>
							</tr>
						</c:forEach>
					</table>

					<%-- <div class="pagination-container">
						<div class="pagination">
							<c:if test="${startPage > 1}">
								<a href="${basePath}?pageNum=${startPage - 1}&pageListNum=${pageListNum}&searchType=${searchType}&searchKeyword=${searchKeyword}&startDate=${startDate}&endDate=${endDate}">&lt;</a>
							</c:if>
							<c:forEach begin="${startPage}" end="${endPage}" var="page">
								<a href="${basePath}?pageNum=${page}&pageListNum=${pageListNum}&searchType=${searchType}&searchKeyword=${searchKeyword}&startDate=${startDate}&endDate=${endDate}" class="${currentPage == page ? 'active' : ''}">${page}</a>
							</c:forEach>
							<c:if test="${endPage < totalPage}">
								<a href="${basePath}?pageNum=${endPage + 1}&pageListNum=${pageListNum}&searchType=${searchType}&searchKeyword=${searchKeyword}&startDate=${startDate}&endDate=${endDate}">&gt;</a>
							</c:if>
						</div>
					</div> --%>
				</div>
				<!-- / 전체 주문 내역 리스트. 끝. -->


			</div>
		</div>
		<!-- 라디오 버튼 효과  -->
		<script>
function setActiveButton(button) {
    // Remove active class from all buttons
    const buttons = document.querySelectorAll('input[type="button"]');
    buttons.forEach(btn => btn.classList.remove('active'));
    
    // Add active class to the clicked button
    button.classList.add('active');
}
</script>
		<!-- / 라디오 버튼 효과. 끝. -->
</body>
</html>