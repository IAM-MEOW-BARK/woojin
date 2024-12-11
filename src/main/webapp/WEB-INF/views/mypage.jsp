<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@ page session="true"%>
<!DOCTYPE html>
<html>
<head>
<title>마이 냥멍 페이지</title>
<script  src="https://code.jquery.com/jquery-latest.js"></script>
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

/* 모달 백그라운드 */
.modal-overlay {
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background: rgba(0, 0, 0, 0.5);
	display: none; /* 처음에는 숨김 */
	justify-content: center;
	align-items: center;
	z-index: 999;
}

/* 모달 창 */
.modal {
	width: 600px;
	background: white;
	border-radius: 8px;
	overflow: hidden;
	font-family: Arial, sans-serif;
}

/* 모달 헤더 */
.modal-header {
	padding: 16px;
	font-weight: bold;
	border-bottom: 1px solid #ddd;
}

/* 모달 본문 */
.modal-body {
	padding: 16px;
}

/* 테이블 스타일 */
.modal-table {
	width: 100%;
	border-collapse: collapse;
	font-size: 14px;
}

.modal-table th, .modal-table td {
	padding: 8px;
	border: 1px solid #ddd;
	text-align: center;
}

/* 안내 문구 */
.modal-footer {
	padding: 16px;
	font-size: 12px;
	color: #555;
}

/* 닫기 버튼 */
.modal-close-btn {
	display: block;
	width: 100%;
	padding: 12px;
	background-color: #007bff;
	color: white;
	font-weight: bold;
	text-align: center;
	text-decoration: none;
	cursor: pointer;
	border: none;
}

.modal-close-btn:hover {
	background-color: #0056b3;
}
</style>

</head>
<body>

    <c:if test="${not empty successMessage}">
        <script>
            alert("${successMessage}");
        </script>
    </c:if>

	<%@ include file="include/header.jsp"%>
	<%@ include file="include/mypageheader.jsp"%>
	<!-- 마이페이지 -->
	<div class="container-lg my-5">
		<div class="row">
			<!-- 왼쪽 내비게이션 -->
			<%@ include file="include/mypagenav.jsp"%>

			<!-- 오른쪽 콘텐츠 -->
			<div class="col-md-9">
				<!-- 최근 주문 내역 -->
				<div class="table-container mb-5">
					<h4>최근 주문 내역</h4>
					<table class="table table-bordered text-center">
						<thead class="table-light">
							<tr>
								<th>주문일자</th>
								<th>주문번호</th>
								<th>대표제품</th>
								<th>결제금액</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="order" items="${recentOrders}">
								<tr>
									<td>${order.orderedAt}</td>
									<td>
										<a href="detailOrder?order_code=${order.orderCode}">${order.orderCode}</a>
									</td>
									<td>${order.firstProductName}</td>
									<td>
									<fmt:formatNumber value="${order.totalPrice}" pattern="#,###원" />
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					<button class="btn btn-outline-secondary" onclick="location.href='totalOrder'">전체 주문 내역</button>
				</div>

				<!-- 최근 찜 내역 -->
<%-- 				<div class="table-container">
					<h4>최근 찜 내역</h4>
					<table class="table table-bordered text-center">
						<thead class="table-light">
							<tr>
								<th><input type="checkbox" name="wish" value="selectall" onclick="selectAll(this)" /></th>
								<th colspan="2">제품</th>
								<th>가격</th>
								<th>장바구니 이동</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="wish" items="{wishlist}">
								<tr>
									<td>
										<input type="checkbox" name="wish" value="{wish.item}" />
									</td>
									<td>
										<a href="detail?bno={wish.제품번호}">{wish.제품이미지}</a>
									</td>
									<td>{wish.제품이름}</td>
									<td>{wish.제품금액}</td>
									<td>
										<button class="btn btn-outline-secondary" onclick="openCartPop()">장바구니로 이동</button>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					<button class="btn btn-outline-secondary" onclick="deleteWish">선택 상품 삭제</button>
					<button class="btn btn-outline-secondary" onclick="location.href='totalWish'">전체 찜 내역</button>
				</div> --%>
			</div>
		</div>
	</div>

	<script>
function selectAll(selectAll) {
    const checkboxes = document.querySelectorAll('input[type="checkbox"]');
    checkboxes.forEach((checkbox) => {
        checkbox.checked = selectAll.checked;
    });
};

function openCartPop () {
	  const options = 'width=600, height=600, top=300, left=600, scrollbars=yes, location= no, toolbars= no, status= no, resizable=no'
	  window.open('cartPop','_blank',options)
	};
</script>

</body>
</html>