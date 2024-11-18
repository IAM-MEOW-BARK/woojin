<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="true"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>내가 바로 🐱냥냥멍멍🐶</title>
<%@ include file="include/head.jsp"%>
</head>
<body>
	<div class="preloader-wrapper">
		<div class="preloader"></div>
	</div>

	<div class="offcanvas offcanvas-end" data-bs-scroll="true" tabindex="-1" id="offcanvasCart">
		<div class="offcanvas-header justify-content-center">
			<button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
		</div>

		<!-- 우측 장바구니 슬라이더  -->

		<div class="offcanvas-body">
			<div class="order-md-last">
				<h4 class="d-flex justify-content-between align-items-center mb-3">
					<span class="text-primary">Your cart</span> <span class="badge bg-primary rounded-pill">3</span>
				</h4>
				<ul class="list-group mb-3">
					<li class="list-group-item d-flex justify-content-between lh-sm">
						<div>
							<h6 class="my-0">Growers cider</h6>
							<small class="text-body-secondary">Brief description</small>
						</div> <span class="text-body-secondary">$12</span>
					</li>
					<li class="list-group-item d-flex justify-content-between lh-sm">
						<div>
							<h6 class="my-0">Fresh grapes</h6>
							<small class="text-body-secondary">Brief description</small>
						</div> <span class="text-body-secondary">$8</span>
					</li>
					<li class="list-group-item d-flex justify-content-between lh-sm">
						<div>
							<h6 class="my-0">Heinz tomato ketchup</h6>
							<small class="text-body-secondary">Brief description</small>
						</div> <span class="text-body-secondary">$5</span>
					</li>
					<li class="list-group-item d-flex justify-content-between"><span>Total (USD)</span> <strong>$20</strong></li>
				</ul>

				<button class="w-100 btn btn-primary btn-lg" type="submit">Continue to checkout</button>
			</div>
		</div>
	</div>

	<!-- / 우측 장바구니 슬라이더. 끝.  -->

	<div class="offcanvas offcanvas-start" tabindex="-1" id="offcanvasNavbar">
		<div class="offcanvas-header justify-content-between">
			<h4 class="fw-normal text-uppercase fs-6">Menu</h4>
			<button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
		</div>

		<div class="offcanvas-body">
			<ul class="navbar-nav justify-content-end menu-list list-unstyled d-flex gap-md-3 mb-0">
				<li class="nav-item border-dashed active"><a href="index.html" class="nav-link d-flex align-items-center gap-3 text-dark p-2"> <svg width="24" height="24" viewBox="0 0 24 24">
                <use xlink:href="#fruits"></use>
              </svg> <span>Fruits and vegetables</span>
				</a></li>
				<li class="nav-item border-dashed"><a href="index.html" class="nav-link d-flex align-items-center gap-3 text-dark p-2"> <svg width="24" height="24" viewBox="0 0 24 24">
                <use xlink:href="#dairy"></use>
              </svg> <span>Dairy and Eggs</span>
				</a></li>
			</ul>
		</div>
	</div>

	<%@ include file="include/header.jsp"%>

	<section style="display: flex; justify-content: center; align-items: center; background-color: #FFCF84; height: 300px;">
		<img src="https://www.meconomynews.com/news/photo/201910/33860_35342_3044.jpg" alt="배너 이미지" style="max-width: 100%; height: 300px;" />
	</section>

	<!-- 카테고리 -->

	<section class="py-5 overflow-hidden">
		<div class="container-lg">
			<div class="row">
				<div class="col-md-12">
					<div class="section-header d-flex flex-wrap justify-content-between mb-5">
						<h2 class="section-title">Category</h2>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-md-12">
					<div class="category-carousel swiper">
						<div class="swiper-wrapper">
							<a href="category.html" class="nav-link swiper-slide text-center"> <img src="${pageContext.request.contextPath}/resources/bootstrap/images/category-thumb-1.jpg" class="rounded-circle" alt="Category Thumbnail">
								<h4 class="fs-6 mt-3 fw-normal category-title">사료 / 간식</h4>
							</a> <a href="category.html" class="nav-link swiper-slide text-center"> <img src="${pageContext.request.contextPath}/resources/bootstrap/images/category-thumb-2.jpg" class="rounded-circle" alt="Category Thumbnail">
								<h4 class="fs-6 mt-3 fw-normal category-title">장난감 / 토이</h4>
							</a> <a href="category.html" class="nav-link swiper-slide text-center"> <img src="${pageContext.request.contextPath}/resources/bootstrap/images/category-thumb-3.jpg" class="rounded-circle" alt="Category Thumbnail">
								<h4 class="fs-6 mt-3 fw-normal category-title">목욕 / 케어</h4>
							</a> <a href="category.html" class="nav-link swiper-slide text-center"> <img src="${pageContext.request.contextPath}/resources/bootstrap/images/category-thumb-4.jpg" class="rounded-circle" alt="Category Thumbnail">
								<h4 class="fs-6 mt-3 fw-normal category-title">산책 / 훈련</h4>
							</a> <a href="category.html" class="nav-link swiper-slide text-center"> <img src="${pageContext.request.contextPath}/resources/bootstrap/images/category-thumb-4.jpg" class="rounded-circle" alt="Category Thumbnail">
								<h4 class="fs-6 mt-3 fw-normal category-title">의류 / 잡화</h4>
							</a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>

	<!-- / 카테고리 -->

	<!-- Main 캐러셀 리스트 -->
	<section class="pb-5">
		<div class="container-lg">
			<div class="row">
				<div class="col-md-12">
					<div class="section-header d-flex flex-wrap justify-content-between my-4">
						<h2 class="section-title">사료 & 간식</h2>

						<!-- Main 캐러셀 조작 버튼 -->
						<div class="d-flex align-items-center">
							<a href="#" class="btn btn-primary me-2">전체 보기</a>
							<div class="swiper-buttons">
								<button class="swiper-prev products-carousel-prev btn btn-primary">&lt;</button>
								<button class="swiper-next products-carousel-next btn btn-primary">&gt;</button>
							</div>
						</div>
						<!-- / Main 캐러셀 조작 버튼 -->
					</div>
				</div>
			</div>

			<div class="row">
				<div class="col-md-12">
					<div class="product-grid row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-3 row-cols-xl-4 row-cols-xxl-5">

						<!-- 리스트에서 아이템 하나 -->
						<c:forEach var="product" items="${productList}">
							<div class="col">
								<div class="product-item">
									<figure>
										<a href="index.html" title="Product Title"> <img src="${pageContext.request.contextPath}/resources/bootstrap/images/product-thumb-1.png" alt="Product Thumbnail" class="tab-image" />
										</a>
									</figure>
									<div class="d-flex flex-column text-center">
										<h3 class="fs-6 fw-normal">${product.product_name}</h3>
										<div class="d-flex justify-content-center align-items-center gap-2">
											<span class="text-dark fw-semibold">${product.product_price}</span>
										</div>
										<div class="button-area p-3 pt-0">
											<div class="row g-1 mt-2">
												<div class="col-3">
													<input type="number" name="quantity" class="form-control border-dark-subtle input-number quantity" value="1" />
												</div>
												<div class="col-7">
													<a href="#" class="btn btn-primary rounded-1 p-2 fs-7 btn-cart"> <svg width="18" height="18">
                          <use xlink:href="#cart"></use>
                          </svg> 장바구니
													</a>
												</div>
												<div class="col-2">
													<a href="#" class="btn btn-outline-dark rounded-1 p-2 fs-6"> <svg width="18" height="18">
                          <use xlink:href="#heart"></use>
                          </svg>
													</a>
												</div>
											</div>
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
	</section>

	<!-- / Main 캐러셀 리스트 -->

	<!-- Main 캐러셀 리스트 -->
	<section class="pb-5">
		<div class="container-lg">
			<div class="row">
				<div class="col-md-12">
					<div class="section-header d-flex flex-wrap justify-content-between my-4">
						<h2 class="section-title">샘플</h2>

						<!-- Main 캐러셀 조작 버튼 -->
						<div class="d-flex align-items-center">
							<a href="#" class="btn btn-primary me-2">전체 보기</a>
							<div class="swiper-buttons">
								<button class="swiper-prev products-carousel-prev btn btn-primary">&lt;</button>
								<button class="swiper-next products-carousel-next btn btn-primary">&gt;</button>
							</div>
						</div>
						<!-- / Main 캐러셀 조작 버튼 -->
					</div>
				</div>
			</div>

			<div class="row">
				<div class="col-md-12">
					<div class="product-grid row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-3 row-cols-xl-4 row-cols-xxl-5">

						<!-- 리스트에서 아이템 하나 -->
						<div class="col">
							<div class="product-item">
								<figure>
									<a href="index.html" title="Product Title"> <img src="${pageContext.request.contextPath}/resources/bootstrap/images/product-thumb-1.png" alt="Product Thumbnail" class="tab-image" />
									</a>
								</figure>
								<div class="d-flex flex-column text-center">
									<h3 class="fs-6 fw-normal">맛있는 제품명</h3>
									<div class="d-flex justify-content-center align-items-center gap-2">
										<span class="text-dark fw-semibold">00,000원</span>
									</div>
									<div class="button-area p-3 pt-0">
										<div class="row g-1 mt-2">
											<div class="col-3">
												<input type="number" name="quantity" class="form-control border-dark-subtle input-number quantity" value="1" />
											</div>
											<div class="col-7">
												<a href="#" class="btn btn-primary rounded-1 p-2 fs-7 btn-cart"> <svg width="18" height="18">
                          <use xlink:href="#cart"></use>
                          </svg> 장바구니
												</a>
											</div>
											<div class="col-2">
												<a href="#" class="btn btn-outline-dark rounded-1 p-2 fs-6"> <svg width="18" height="18">
                          <use xlink:href="#heart"></use>
                          </svg>
												</a>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						<!-- / 리스트에서 아이템 하나 -->
					</div>
					<!-- / product-grid -->
				</div>
			</div>
		</div>
	</section>

	<!-- / Main 캐러셀 리스트 -->


	<!-- 푸터일 것 같음 -->

	<footer class="py-5">
		<div class="container-lg">
			<div class="row">
				<div class="col-lg-3 col-md-6 col-sm-6">
					<div class="footer-menu">
						<img src="${pageContext.request.contextPath}/resources/bootstrap/images/logo.svg" width="240" height="70" alt="logo" />
						<div class="social-links mt-3">
							<ul class="d-flex list-unstyled gap-2">
								<li><a href="#" class="btn btn-outline-light"> <svg width="16" height="16">
                        <use xlink:href="#facebook"></use>
                      </svg>
								</a></li>
								<li><a href="#" class="btn btn-outline-light"> <svg width="16" height="16">
                        <use xlink:href="#twitter"></use>
                      </svg>
								</a></li>
								<li><a href="#" class="btn btn-outline-light"> <svg width="16" height="16">
                        <use xlink:href="#youtube"></use>
                      </svg>
								</a></li>
								<li><a href="#" class="btn btn-outline-light"> <svg width="16" height="16">
                        <use xlink:href="#instagram"></use>
                      </svg>
								</a></li>
								<li><a href="#" class="btn btn-outline-light"> <svg width="16" height="16">
                        <use xlink:href="#amazon"></use>
                      </svg>
								</a></li>
							</ul>
						</div>
					</div>
				</div>

				<div class="col-md-2 col-sm-6">
					<div class="footer-menu">
						<h5 class="widget-title">Organic</h5>
						<ul class="menu-list list-unstyled">
							<li class="menu-item"><a href="#" class="nav-link">About us</a></li>
							<li class="menu-item"><a href="#" class="nav-link">Conditions </a></li>
							<li class="menu-item"><a href="#" class="nav-link">Our Journals</a></li>
							<li class="menu-item"><a href="#" class="nav-link">Careers</a></li>
							<li class="menu-item"><a href="#" class="nav-link">Affiliate Programme</a></li>
							<li class="menu-item"><a href="#" class="nav-link">Ultras Press</a></li>
						</ul>
					</div>
				</div>
				<div class="col-md-2 col-sm-6">
					<div class="footer-menu">
						<h5 class="widget-title">Quick Links</h5>
						<ul class="menu-list list-unstyled">
							<li class="menu-item"><a href="#" class="nav-link">Offers</a></li>
							<li class="menu-item"><a href="#" class="nav-link">Discount Coupons</a></li>
							<li class="menu-item"><a href="#" class="nav-link">Stores</a></li>
							<li class="menu-item"><a href="#" class="nav-link">Track Order</a></li>
							<li class="menu-item"><a href="#" class="nav-link">Shop</a></li>
							<li class="menu-item"><a href="#" class="nav-link">Info</a></li>
						</ul>
					</div>
				</div>
				<div class="col-md-2 col-sm-6">
					<div class="footer-menu">
						<h5 class="widget-title">Customer Service</h5>
						<ul class="menu-list list-unstyled">
							<li class="menu-item"><a href="#" class="nav-link">FAQ</a></li>
							<li class="menu-item"><a href="#" class="nav-link">Contact</a></li>
							<li class="menu-item"><a href="#" class="nav-link">Privacy Policy</a></li>
							<li class="menu-item"><a href="#" class="nav-link">Returns & Refunds</a></li>
							<li class="menu-item"><a href="#" class="nav-link">Cookie Guidelines</a></li>
							<li class="menu-item"><a href="#" class="nav-link">Delivery Information</a></li>
						</ul>
					</div>
				</div>
				<div class="col-lg-3 col-md-6 col-sm-6">
					<div class="footer-menu">
						<h5 class="widget-title">Subscribe Us</h5>
						<p>Subscribe to our newsletter to get updates about our grand offers.</p>
						<form class="d-flex mt-3 gap-0" action="index.html">
							<input class="form-control rounded-start rounded-0 bg-light" type="email" placeholder="Email Address" aria-label="Email Address" />
							<button class="btn btn-dark rounded-end rounded-0" type="submit">Subscribe</button>
						</form>
					</div>
				</div>
			</div>
		</div>
	</footer>
	<div id="footer-bottom">
		<div class="container-lg">
			<div class="row">
				<div class="col-md-6 copyright">
					<p>Â© 2024 Organic. All rights reserved.</p>
				</div>
				<div class="col-md-6 credit-link text-start text-md-end">
					<p>
						HTML Template by <a href="https://templatesjungle.com/">TemplatesJungle</a> Distributed By <a href="https://themewagon.com">ThemeWagon</a>
					</p>
				</div>
			</div>
		</div>
	</div>
	<script src="${pageContext.request.contextPath}/resources/bootstrap/js/jquery-1.11.0.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/swiper@9/swiper-bundle.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>
	<script src="${pageContext.request.contextPath}/resources/bootstrap/js/plugins.js"></script>
	<script src="${pageContext.request.contextPath}/resources/bootstrap/js/script.js"></script>
</body>
</html>