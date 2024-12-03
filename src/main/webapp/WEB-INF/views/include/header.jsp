<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="true"%>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>
<title>main header</title>
<!-- 아이콘 부트스트랩 -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">

<style type="text/css">
.bi {
	font-size: 1.5em;
	line-height: 30%;
}
</style>
</head>
<body>
	<%@ include file="svgicon.jsp"%>
	<header class="main-header">
		<div class="container-fluid">
			<div class="row py-3 border-bottom d-flex justify-content-evenly">
				<!-- 로고 -->
				<div class="col-sm-4 col-lg-2 text-center text-sm-start d-flex gap-3 justify-content-center">
					<div class="d-flex align-items-center my-3 my-sm-0">
						<a href="home"> <img src="${pageContext.request.contextPath}/resources/bootstrap/images/logo.png" alt="logo" class="img-fluid" />
						</a>
					</div>
				</div>
				<!-- 카테고리 -->
				<div class="col-lg-6 d-flex justify-content-center align-items-center">
					<ul class="navbar-nav list-unstyled d-flex flex-row gap-3 gap-lg-6 justify-content-center flex-wrap align-items-center mb-0 fw-bold text-uppercase text-dark">
						<li class="nav-item active"><a href="/cartegory?tag=food" class="nav-link">🧡사료/간식</a></li>
						<li class="nav-item active"><a href="/cartegory?tag=toy" class="nav-link">💛장난감/토이</a></li>
						<li class="nav-item active"><a href="/cartegory?tag=bath" class="nav-link">💚목욕/케어</a></li>
						<li class="nav-item active"><a href="/cartegory?tag=walk" class="nav-link">💙산책/훈련</a></li>
						<li class="nav-item active"><a href="/cartegory?tag=cloth" class="nav-link">💜의류/잡화</a></li>
						<li class="nav-item active"><a href="/cartegory?tag=notice" class="nav-link">공지사항</a></li>
					</ul>
				</div>
				<!-- 로그인/장바구니/마이페이지 -->
				<div class="col-sm-8 col-lg-2 d-flex gap-5 align-items-center justify-content-center justify-content-sm-end">
					<ul class="d-flex justify-content-end list-unstyled m-0">
						<li><c:if test="${user == null}">
								<a href="catdog-login" class="p-2 mx-1 d-flex flex-column align-items-center text-center">
								<i class="bi bi-box-arrow-in-right"></i> <span>로그인</span>
								</a>
							</c:if> <c:if test="${user != null}">
								<a href="catdog-logout" class="p-2 mx-1 d-flex flex-column align-items-center text-center">
								<i class="bi bi-box-arrow-right"></i> <span>로그아웃</span>
								</a>
							</c:if></li>
							<c:if test="${user != null}">
						<li><a href="cart?page=cart" class="p-2 mx-1 d-flex flex-column align-items-center text-center">
						<i class="bi bi-cart"></i> <span>장바구니</span>
						</a>
						</li>
							<li>
							<a href="mypage" class="p-2 mx-1 d-flex flex-column align-items-center text-center">
							<i class="bi bi-person-circle"></i>
							<span>마이페이지</span>
							</a></li>
						</c:if>
					</ul>
				</div>
			</div>
		</div>
	</header>