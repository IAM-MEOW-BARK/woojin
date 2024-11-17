
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="true"%>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<%@ include file="head.jsp" %>
<head>
<meta charset="UTF-8">
<meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>
<title>main</title>

</head>
<body>
		<header class="main-header">
			<div class="container-fluid">
				<div class="row py-3 border-bottom">
					<div class="col-sm-4 col-lg-2 text-center text-sm-start d-flex gap-3 justify-content-center justify-content-md-start">
						<div class="d-flex align-items-center my-3 my-sm-0">
							<a href="home"> <img src="${pageContext.request.contextPath}/resources/bootstrap/images/CATDOGLogo2.png" alt="logo" class="img-fluid" />
							</a>
						</div>
						<button class="navbar-toggler" type="button" data-bs-toggle="offcanvas" data-bs-target="#offcanvasNavbar" aria-controls="offcanvasNavbar">
							<svg width="24" height="24" viewBox="0 0 24 24">
            <use xlink:href="#menu"></use>
          </svg>
						</button>
					</div>
					<div class="col-lg-4">
						<ul class="navbar-nav list-unstyled d-flex flex-row gap-3 gap-lg-6 justify-content-center flex-wrap align-items-center mb-0 fw-bold text-uppercase text-dark">
							<li class="nav-item active"><a href="/cartegory?tag=food" class="nav-link">사료/간식</a></li>
							<li class="nav-item active"><a href="/cartegory?tag=toy" class="nav-link">장난감/토이</a></li>
							<li class="nav-item active"><a href="/cartegory?tag=bath" class="nav-link">목욕/케어</a></li>
							<li class="nav-item active"><a href="/cartegory?tag=walk" class="nav-link">산책/훈련</a></li>
							<li class="nav-item active"><a href="/cartegory?tag=cloth" class="nav-link">의류/잡화</a></li>
							<li class="nav-item active"><a href="/cartegory?tag=notice" class="nav-link">공지사항</a></li>
						</ul>
					</div>
					<div class="col-sm-8 col-lg-2 d-flex gap-5 align-items-center justify-content-center justify-content-sm-end">
						<ul class="d-flex justify-content-end list-unstyled m-0">
							<li><a href="#" class="p-2 mx-1 text-end"> <svg width="24" height="24">
                <use xlink:href="#user"></use>
              </svg><br> 로그인
							</a></li>
							<li><a href="/" class="p-2 mx-1 text-end" data-bs-toggle="offcanvas" data-bs-target="#offcanvasCart" aria-controls="offcanvasCart"> <svg width="24" height="24">
                <use xlink:href="#shopping-bag"></use>
              </svg><br> 장바구니
							</a></li>
							<li><a href="mypage" class="p-2 mx-1 text-end"> <svg width="24" height="24">
                <use xlink:href="#user"></use>
              </svg><br> 마이페이지
							</a></li>
						</ul>
					</div>
				</div>
			</div>
	</header>
