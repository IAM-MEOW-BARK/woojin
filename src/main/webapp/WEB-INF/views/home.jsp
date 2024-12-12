<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page session="true"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>내가 바로 🐱냥냥멍멍🐶</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/bootstrap/css/style.css">
<style type="text/css">
.swiper {
	width: 100%;
	padding: 20px 0;
}

.swiper-slide {
	display: flex;
	justify-content: center;
	align-items: center;
}

.product-item .button-area {
  display: none;
  position: absolute;
  text-align: center;
  background: #fff;
  width: 100%;
  left: 0;
  bottom: -55px;
  z-index: 1;
  box-shadow: 0px 20px 44px rgba(0, 0, 0, 0.08);
  /* transition: box-shadow 0.3s ease-out; */
}
</style>

<%@ include file="include/head.jsp"%>

<!-- Swiper.js CSS -->
<link rel="stylesheet"
	href="https://unpkg.com/swiper/swiper-bundle.min.css" />

<!-- Swiper.js JavaScript -->
<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
</head>
<body>


	<%@ include file="include/header.jsp"%>

	<section
		style="display: flex; justify-content: center; align-items: center; background-color: #FFCF84; height: 300px; margin-bottom: 50px">

		<a href="noticeList"> <img
			src="${pageContext.request.contextPath}/resources/bootstrap/images/main-banner.png"
			alt="배너 이미지" style="max-width: 100%; height: 300px;" />
		</a>
	</section>

	<!-- 카테고리 -->
	<%-- 	<section class="py-5 overflow-hidden">
		<div class="container-lg">
			<div class="col-md-12">
				<div class="category-carousel swiper d-flex justify-content-center">
					<div
						class="swiper-wrapper gap-3 d-flex justify-content-center align-items-center">
						<!-- 첫 번째 -->
						<a href="category.html" class="nav-link swiper-slide text-center">
							<img
							src="${pageContext.request.contextPath}/resources/bootstrap/images/category-thumb-1.jpg"
							class="rounded-circle" alt="Category Thumbnail"
							style="margin: 0 auto; max-width: 100px;">
							<h4 class="fs-6 mt-3 fw-normal category-title">사료 / 간식</h4>
						</a>
						<!-- 두 번째 항목 -->
						<a href="category.html" class="nav-link swiper-slide text-center">
							<img
							src="${pageContext.request.contextPath}/resources/bootstrap/images/category-thumb-2.jpg"
							class="rounded-circle" alt="Category Thumbnail"
							style="margin: 0 auto; max-width: 100px;">
							<h4 class="fs-6 mt-3 fw-normal category-title">장난감 / 토이</h4>
						</a>
						<!-- 세 번째 항목 -->
						<a href="category.html" class="nav-link swiper-slide text-center">
							<img
							src="${pageContext.request.contextPath}/resources/bootstrap/images/category-thumb-3.jpg"
							class="rounded-circle" alt="Category Thumbnail"
							style="margin: 0 auto; max-width: 100px;">
							<h4 class="fs-6 mt-3 fw-normal category-title">목욕 / 케어</h4>
						</a>
						<!-- 네 번째 항목 -->
						<a href="category.html" class="nav-link swiper-slide text-center">
							<img
							src="${pageContext.request.contextPath}/resources/bootstrap/images/category-thumb-4.jpg"
							class="rounded-circle" alt="Category Thumbnail"
							style="margin: 0 auto; max-width: 100px;">
							<h4 class="fs-6 mt-3 fw-normal category-title">산책 / 훈련</h4>
						</a>
						<!-- 다섯 번째 항목 -->
						<a href="category.html" class="nav-link swiper-slide text-center">
							<img
							src="${pageContext.request.contextPath}/resources/bootstrap/images/category-thumb-5.jpg"
							class="rounded-circle" alt="Category Thumbnail"
							style="margin: 0 auto; max-width: 100px;">
							<h4 class="fs-6 mt-3 fw-normal category-title">의류 / 잡화</h4>
						</a>
					</div>
				</div>
			</div>
		</div>
	</section> --%>

	<!-- Main 캐러셀 리스트 1 -->

	<div class="container-lg">
		<div class="row">
			<div class="col-md-12">
				<div
					class="section-header d-flex flex-wrap justify-content-between my-4">
					<h2 class="section-title">사료 & 간식</h2>

					<!-- Main 캐러셀 조작 버튼 -->
					<div class="d-flex align-items-center">
						<a href="#" class="btn me-2" style="background: #ff6600; border:none; color: white;">전체 보기</a>
						<div class="swiper-buttons">
							<button class="swiper-prev btn" style="background: #ff6600; border:none; color: white;"
								data-target="carousel1">&lt;</button>
							<button class="swiper-next btn btn-primary" style="background: #ff6600; border:none; color: white;"
								data-target="carousel1">&gt;</button>
						</div>
					</div>
					<!-- / Main 캐러셀 조작 버튼. 끝. -->
				</div>
			</div>
		</div>

		<div class="row">
			<div class="col-md-12">
				<div class="swiper" id="carousel1">
					<div class="swiper-wrapper">

						<!-- 리스트에서 아이템 하나 -->
						<c:forEach var="product01" items="${list01}">
							<div class="swiper-slide" style="height: 350px;">
								<div class="product-item">
									<figure>
										<a href="productDetail?product_code=${product01.product_code}" title="${product01.product_name} 상세 페이지"> <img
											src="${pageContext.request.contextPath}/resources/upload/${product01.thumbnail_img}"
											alt="${product01.product_name}" class="tab-image"
											style="width: 200px; height: 150px;" />
										</a>
									</figure>
									<div class="d-flex flex-column text-center">
										<h3 class="fs-6 fw-normal">${product01.product_name}</h3>
										<div
											class="d-flex justify-content-center align-items-center gap-2">
											<fmt:formatNumber value="${product01.product_price}"
												pattern="#,###원" />
										</div>
										<div class="button-area p-3 pt-0">
											<form action="addCart" method="POST">
												<input type="hidden" name="user_id" value="${user_id}" />
												<input type="hidden" name="product_code" value="${product01.product_code}" />
												<input type="hidden" name="product_name" value="${product01.product_name}" />
												<input type="hidden" name="product_code" value="${product01.product_code}" />
												<input type="hidden" name="product_price" value="${product01.product_price}" />
												<input type="hidden" name="cart_quantity" id="cartQuantity_${product01.product_code}" value="1" />
												<button type="submit" class="btn rounded-1 p-2 fs-7 btn-cart" style="background: #ff6600; color: white;">
												<svg width="18" height="18">
												<use xlink:href="#cart"></use></svg> 장바구니</button>		
												</form>											
										</div>
									</div>
								</div>
							</div>
						</c:forEach>
						<!-- / 리스트에서 아이템 하나 -->
					</div>
					<!-- / product-grid -->
				</div>
			</div>
		</div>
	</div>

	<!-- / Main 캐러셀 리스트 1 -->

	<!-- Main 캐러셀 리스트 2 -->

	<div class="container-lg">
		<div class="row">
			<div class="col-md-12">
				<div
					class="section-header d-flex flex-wrap justify-content-between my-4">
					<h2 class="section-title">장난감 & 토이</h2>

					<!-- Main 캐러셀 조작 버튼 -->
					<div class="d-flex align-items-center">
						<a href="#" class="btn me-2" style="background: #ff6600; border:none; color: white;">전체 보기</a>
						<div class="swiper-buttons">
							<button class="swiper-prev btn" style="background: #ff6600; border:none; color: white;"
								data-target="carousel2">&lt;</button>
							<button class="swiper-next btn btn-primary" style="background: #ff6600; border:none; color: white;"
								data-target="carousel2">&gt;</button>
						</div>
					</div>
					<!-- / Main 캐러셀 조작 버튼. 끝. -->
				</div>
			</div>
		</div>

		<div class="row">
			<div class="col-md-12">
				<div class="swiper" id="carousel2">
					<div class="swiper-wrapper">

						<!-- 리스트에서 아이템 하나 -->
						<c:forEach var="product02" items="${list02}">
							<div class="swiper-slide" style="height: 350px;">
								<div class="product-item">
									<figure>
										<a href="productDetail?product_code=${product02.product_code}" title="${product02.product_name} 상세 페이지"> <img
											src="${pageContext.request.contextPath}/resources/upload/${product02.thumbnail_img}"
											alt="${product02.product_name}" class="tab-image"
											style="width: 200px; height: 150px;" />
										</a>
									</figure>
									<div class="d-flex flex-column text-center">
										<h3 class="fs-6 fw-normal">${product02.product_name}</h3>
										<div
											class="d-flex justify-content-center align-items-center gap-2">
											<fmt:formatNumber value="${product02.product_price}"
												pattern="#,###원" />
										</div>
										<div class="button-area p-3 pt-0">
											<form action="addCart" method="POST">
												<input type="hidden" name="user_id" value="${user_id}" />
												<input type="hidden" name="product_code" value="${product02.product_code}" />
												<input type="hidden" name="product_name" value="${product02.product_name}" />
												<input type="hidden" name="product_code" value="${product02.product_code}" />
												<input type="hidden" name="product_price" value="${product02.product_price}" />
												<input type="hidden" name="cart_quantity" id="cartQuantity_${product02.product_code}" value="1" />
												<button type="submit" class="btn rounded-1 p-2 fs-7 btn-cart" style="background: #ff6600; color: white;">
												<svg width="18" height="18">
												<use xlink:href="#cart"></use></svg> 장바구니</button>		
												</form>											
										</div>
									</div>
								</div>
							</div>
						</c:forEach>
						<!-- / 리스트에서 아이템 하나 -->
					</div>
					<!-- / product-grid -->
				</div>
			</div>
		</div>
	</div>

	<!-- / Main 캐러셀 리스트 2 -->

	<!-- Main 캐러셀 리스트 3 -->

	<div class="container-lg">
		<div class="row">
			<div class="col-md-12">
				<div
					class="section-header d-flex flex-wrap justify-content-between my-4">
					<h2 class="section-title">목욕 & 케어</h2>

					<!-- Main 캐러셀 조작 버튼 -->
					<div class="d-flex align-items-center">
						<a href="#" class="btn me-2" style="background: #ff6600; border:none; color: white;">전체 보기</a>
						<div class="swiper-buttons">
							<button class="swiper-prev btn" style="background: #ff6600; border:none; color: white;"
								data-target="carousel3">&lt;</button>
							<button class="swiper-next btn btn-primary" style="background: #ff6600; border:none; color: white;"
								data-target="carousel3">&gt;</button>
						</div>
					</div>
					<!-- / Main 캐러셀 조작 버튼. 끝. -->
				</div>
			</div>
		</div>

		<div class="row">
			<div class="col-md-12">
				<div class="swiper" id="carousel3">
					<div class="swiper-wrapper">

						<!-- 리스트에서 아이템 하나 -->
						<c:forEach var="product03" items="${list03}">
							<div class="swiper-slide" style="height: 350px;">
								<div class="product-item">
									<figure>
										<a href="productDetail?product_code=${product03.product_code}" title="${product03.product_name} 상세 페이지"> <img
											src="${pageContext.request.contextPath}/resources/upload/${product03.thumbnail_img}"
											alt="${product03.product_name}" class="tab-image"
											style="width: 200px; height: 150px;" />
										</a>
									</figure>
									<div class="d-flex flex-column text-center">
										<h3 class="fs-6 fw-normal">${product03.product_name}</h3>
										<div
											class="d-flex justify-content-center align-items-center gap-2">
											<fmt:formatNumber value="${product03.product_price}"
												pattern="#,###원" />
										</div>
										<div class="button-area p-3 pt-0">
											<form action="addCart" method="POST">
												<input type="hidden" name="user_id" value="${user_id}" />
												<input type="hidden" name="product_code" value="${product03.product_code}" />
												<input type="hidden" name="product_name" value="${product03.product_name}" />
												<input type="hidden" name="product_code" value="${product03.product_code}" />
												<input type="hidden" name="product_price" value="${product03.product_price}" />
												<input type="hidden" name="cart_quantity" id="cartQuantity_${product03.product_code}" value="1" />
												<button type="submit" class="btn rounded-1 p-2 fs-7 btn-cart" style="background: #ff6600; color: white;">
												<svg width="18" height="18">
												<use xlink:href="#cart"></use></svg> 장바구니</button>		
												</form>											
										</div>
									</div>
								</div>
							</div>
						</c:forEach>
						<!-- / 리스트에서 아이템 하나 -->
					</div>
					<!-- / product-grid -->
				</div>
			</div>
		</div>
	</div>

	<!-- / Main 캐러셀 리스트 3 -->

	<!-- Main 캐러셀 리스트 4 -->

	<div class="container-lg">
		<div class="row">
			<div class="col-md-12">
				<div
					class="section-header d-flex flex-wrap justify-content-between my-4">
					<h2 class="section-title">산책 & 훈련</h2>

					<!-- Main 캐러셀 조작 버튼 -->
					<div class="d-flex align-items-center">
						<a href="#" class="btn me-2" style="background: #ff6600; border:none; color: white;">전체 보기</a>
						<div class="swiper-buttons">
							<button class="swiper-prev btn" style="background: #ff6600; border:none; color: white;"
								data-target="carousel4">&lt;</button>
							<button class="swiper-next btn btn-primary" style="background: #ff6600; border:none; color: white;"
								data-target="carousel4">&gt;</button>
						</div>
					</div>
					<!-- / Main 캐러셀 조작 버튼. 끝. -->
				</div>
			</div>
		</div>

		<div class="row">
			<div class="col-md-12">
				<div class="swiper" id="carousel4">
					<div class="swiper-wrapper">

						<!-- 리스트에서 아이템 하나 -->
						<c:forEach var="product04" items="${list04}">
							<div class="swiper-slide" style="height: 350px;">
								<div class="product-item">
									<figure>
										<a href="productDetail?product_code=${product04.product_code}" title="${product04.product_name} 상세 페이지"> <img
											src="${pageContext.request.contextPath}/resources/upload/${product04.thumbnail_img}"
											alt="${product04.product_name}" class="tab-image"
											style="width: 200px; height: 150px;" />
										</a>
									</figure>
									<div class="d-flex flex-column text-center">
										<h3 class="fs-6 fw-normal">${product04.product_name}</h3>
										<div
											class="d-flex justify-content-center align-items-center gap-2">
											<fmt:formatNumber value="${product04.product_price}"
												pattern="#,###원" />
										</div>
										<div class="button-area p-3 pt-0">
											<form action="addCart" method="POST">
												<input type="hidden" name="user_id" value="${user_id}" />
												<input type="hidden" name="product_code" value="${product04.product_code}" />
												<input type="hidden" name="product_name" value="${product04.product_name}" />
												<input type="hidden" name="product_code" value="${product04.product_code}" />
												<input type="hidden" name="product_price" value="${product04.product_price}" />
												<input type="hidden" name="cart_quantity" id="cartQuantity_${product04.product_code}" value="1" />
												<button type="submit" class="btn rounded-1 p-2 fs-7 btn-cart" style="background: #ff6600; color: white;">
												<svg width="18" height="18">
												<use xlink:href="#cart"></use></svg> 장바구니</button>		
												</form>											
										</div>
									</div>
								</div>
							</div>
						</c:forEach>
						<!-- / 리스트에서 아이템 하나 -->
					</div>
					<!-- / product-grid -->
				</div>
			</div>
		</div>
	</div>

	<!-- / Main 캐러셀 리스트 4 -->

	<!-- Main 캐러셀 리스트 5 -->

	<div class="container-lg">
		<div class="row">
			<div class="col-md-12">
				<div
					class="section-header d-flex flex-wrap justify-content-between my-4">
					<h2 class="section-title">의류 & 잡화</h2>

					<!-- Main 캐러셀 조작 버튼 -->
					<div class="d-flex align-items-center">
						<a href="#" class="btn me-2" style="background: #ff6600; border:none; color: white;">전체 보기</a>
						<div class="swiper-buttons">
							<button class="swiper-prev btn" style="background: #ff6600; border:none; color: white;"
								data-target="carousel5">&lt;</button>
							<button class="swiper-next btn btn-primary" style="background: #ff6600; border:none; color: white;"
								data-target="carousel5">&gt;</button>
						</div>
					</div>
					<!-- / Main 캐러셀 조작 버튼. 끝. -->
				</div>
			</div>
		</div>

		<div class="row">
			<div class="col-md-12">
				<div class="swiper" id="carousel5">
					<div class="swiper-wrapper">

						<!-- 리스트에서 아이템 하나 -->
						<c:forEach var="product05" items="${list05}">
							<div class="swiper-slide" style="height: 350px;">
								<div class="product-item">
									<figure>
										<a href="productDetail?product_code=${product05.product_code}" title="${product05.product_name} 상세 페이지"> <img
											src="${pageContext.request.contextPath}/resources/upload/${product05.thumbnail_img}"
											alt="${product05.product_name}" class="tab-image"
											style="width: 200px; height: 150px;" />
										</a>
									</figure>
									<div class="d-flex flex-column text-center">
										<h3 class="fs-6 fw-normal">${product05.product_name}</h3>
										<div
											class="d-flex justify-content-center align-items-center gap-2">
											<fmt:formatNumber value="${product05.product_price}"
												pattern="#,###원" />
										</div>
										<div class="button-area p-3 pt-0">
											<form action="addCart" method="POST">
												<input type="hidden" name="user_id" value="${user_id}" />
												<input type="hidden" name="product_code" value="${product05.product_code}" />
												<input type="hidden" name="product_name" value="${product05.product_name}" />
												<input type="hidden" name="product_code" value="${product05.product_code}" />
												<input type="hidden" name="product_price" value="${product05.product_price}" />
												<input type="hidden" name="cart_quantity" id="cartQuantity_${product05.product_code}" value="1" />
												<button type="submit" class="btn rounded-1 p-2 fs-7 btn-cart" style="background: #ff6600; color: white;">
												<svg width="18" height="18">
												<use xlink:href="#cart"></use></svg> 장바구니</button>		
												</form>											
										</div>
									</div>
								</div>
							</div>
						</c:forEach>
						<!-- / 리스트에서 아이템 하나 -->
					</div>
					<!-- / product-grid -->
				</div>
			</div>
		</div>
	</div>

	<!-- / Main 캐러셀 리스트 5 -->

	<script
		src="${pageContext.request.contextPath}/resources/bootstrap/js/jquery-1.11.0.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/swiper@9/swiper-bundle.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe"
		crossorigin="anonymous"></script>
	<script
		src="${pageContext.request.contextPath}/resources/bootstrap/js/plugins.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/bootstrap/js/script.js"></script>

	<!-- 	<script>
		// Swiper.js 초기화
		const swiper = new Swiper('.swiper', {
			slidesPerView : 5, // 한 번에 보이는 슬라이드 개수
			spaceBetween : 20, // 슬라이드 간격
			navigation : {
				nextEl : '.swiper-next', // 오른쪽 화살표 버튼
				prevEl : '.swiper-prev', // 왼쪽 화살표 버튼
			},
			loop : true, // 무한 루프 여부 (필요에 따라 true로 변경)
		});
	</script> -->


	<!-- 	<script type="text/javascript">
	window.onload = function () {
	    // 각 캐러셀에 대해 Swiper 인스턴스를 초기화
	    const carousels = document.querySelectorAll('.swiper');

	    carousels.forEach((carousel, index) => {
	        const swiper = new Swiper(carousel, {
	            slidesPerView: 5, // 한 번에 보이는 슬라이드 개수
	            spaceBetween: 20, // 슬라이드 간격
	            navigation: {
	                nextEl: `.swiper-next[data-target="carousel${index + 1}"]`, // 오른쪽 화살표 버튼
	                prevEl: `.swiper-prev[data-target="carousel${index + 1}"]`, // 왼쪽 화살표 버튼
	                hideOnClick: false, // 버튼을 클릭해도 숨겨지지 않도록 설정
	            },
	            loop: true, // 무한 루프 여부 (필요에 따라 true로 변경)
	        });

	        // 이동 버튼에 데이터 속성 설정
	        const nextButton = document.querySelector(`.swiper-next[data-target="carousel${index + 1}"]`);
	        const prevButton = document.querySelector(`.swiper-prev[data-target="carousel${index + 1}"]`);

	        // 이동 버튼 클릭 시 Swiper 제어
	        nextButton.addEventListener('click', () => {
	            swiper.slideNext();
	        });

	        prevButton.addEventListener('click', () => {
	            swiper.slidePrev();
	        });
	    });
	};
</script> -->

	<script>
		//1 번째 캐러셀 (산책 & 훈련)
		const swiper1 = new Swiper('#carousel1', {
			slidesPerView : 5, // 한 번에 보이는 슬라이드 개수
			spaceBetween : 10, // 슬라이드 간격
			navigation : {
				nextEl : '.swiper-next[data-target="carousel1"]', // 오른쪽 화살표 버튼
				prevEl : '.swiper-prev[data-target="carousel1"]', // 왼쪽 화살표 버튼
			},
			loop : true, // 무한 루프 여부
		});
		// 2 번째 캐러셀 (산책 & 훈련)
		const swiper2 = new Swiper('#carousel2', {
			slidesPerView : 5, // 한 번에 보이는 슬라이드 개수
			spaceBetween : 10, // 슬라이드 간격
			navigation : {
				nextEl : '.swiper-next[data-target="carousel2"]', // 오른쪽 화살표 버튼
				prevEl : '.swiper-prev[data-target="carousel2"]', // 왼쪽 화살표 버튼
			},
			loop : true, // 무한 루프 여부
		});

		// 3 번째 캐러셀 (의류 & 잡화)
		const swiper3 = new Swiper('#carousel3', {
			slidesPerView : 5, // 한 번에 보이는 슬라이드 개수
			spaceBetween : 10, // 슬라이드 간격
			navigation : {
				nextEl : '.swiper-next[data-target="carousel3"]', // 오른쪽 화살표 버튼
				prevEl : '.swiper-prev[data-target="carousel3"]', // 왼쪽 화살표 버튼
			},
			loop : true, // 무한 루프 여부
		});
		// 4 번째 캐러셀 (산책 & 훈련)
		const swiper4 = new Swiper('#carousel4', {
			slidesPerView : 5, // 한 번에 보이는 슬라이드 개수
			spaceBetween : 10, // 슬라이드 간격
			navigation : {
				nextEl : '.swiper-next[data-target="carousel4"]', // 오른쪽 화살표 버튼
				prevEl : '.swiper-prev[data-target="carousel4"]', // 왼쪽 화살표 버튼
			},
			loop : true, // 무한 루프 여부
		});

		// 5 번째 캐러셀 (의류 & 잡화)
		const swiper5 = new Swiper('#carousel5', {
			slidesPerView : 5, // 한 번에 보이는 슬라이드 개수
			spaceBetween : 10, // 슬라이드 간격
			navigation : {
				nextEl : '.swiper-next[data-target="carousel5"]', // 오른쪽 화살표 버튼
				prevEl : '.swiper-prev[data-target="carousel5"]', // 왼쪽 화살표 버튼
			},
			loop : true, // 무한 루프 여부
		});
	</script>
	<script type="text/javascript">
	 window.onload = function() {
         <% if (request.getAttribute("paymentSuccess") != null) { %>
             alert("결제가 완료되었습니다.");
         <% } %>
     };
	</script>

</body>
</html>