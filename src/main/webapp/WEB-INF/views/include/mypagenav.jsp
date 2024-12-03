<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지 네비게이션</title>
<style>

.list-group-item.active {
	background-color: #f0f0f0;
	font-weight: bold; /* 글씨 굵게 */
	border-color: #f0f0f0;
	color: #555555;
}
.bi {
	font-size: 1em;
	margin-left: 8px;
	margin-right: 15px;
}
</style>
</head>
<body>
	<nav class="col-md-2 mb-2">
		<div class="list-group">
			<!-- 현재 페이지가 'orderList'일 경우 활성화 클래스 추가 -->
			<c:set var="currentPage" value="${param.page}" />
			<a href="mypage" class="list-group-item list-group-item-action ${currentPage == 'mypage' ? 'active' : ''}">
			<i class="bi bi-person"></i>마이페이지 </a>
			<a href="totalOrder?page=totalOrder" class="list-group-item list-group-item-action ${currentPage == 'totalOrder' ? 'active' : ''}">
			<i class="bi bi-receipt"></i>
			주문 내역 </a>
			<a href="cart?user_id=${user_id}" class="list-group-item list-group-item-action ${currentPage == 'cart' ? 'active' : ''}">
			<i class="bi bi-cart"></i>
			장바구니 </a>
			<a href="totalWish?page=wish" class="list-group-item list-group-item-action ${currentPage == 'wish' ? 'active' : ''}">
			<i class="bi bi-heart"></i>
			찜 내역 </a>
			<a href="updateProfile?page=updateProfile" class="list-group-item list-group-item-action ${currentPage == 'updateProfile' ? 'active' : ''}">
			<i class="bi bi-pencil-square"></i>
			정보 수정 </a>
			<a href="questionList?page=questionList" class="list-group-item list-group-item-action ${currentPage == 'questionList' ? 'active' : ''}">
			<i class="bi bi-question-circle"></i>
			문의 내역 </a>
			<a href="returnExchange?page=returnExchange" class="list-group-item list-group-item-action ${currentPage == 'returnExchange' ? 'active' : ''}">
			<i class="bi bi-box-arrow-left"></i>
			반품/교환 </a>
		</div>
	</nav>
</body>
</html>