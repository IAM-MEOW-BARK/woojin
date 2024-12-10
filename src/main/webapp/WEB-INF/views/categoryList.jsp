<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="true"%>
<!DOCTYPE html>
<html lang="ko">
<head>
 <title>
        <c:choose>
            <c:when test="${productCategory == 1}">🧡 사료/간식</c:when>
            <c:when test="${productCategory == 2}">💛 장난감/토이</c:when>
            <c:when test="${productCategory == 3}">💚 목욕/케어</c:when>
            <c:when test="${productCategory == 4}">💙 산책/훈련</c:when>
            <c:when test="${productCategory == 5}">💜 의류/잡화</c:when>
        </c:choose>
    </title>
<%@ include file="include/head.jsp"%>

<style>
		.section-title {
		margin-top:20px;
		margin-left: 20px;
		font-weight: 540; 
		}
		
		.product-item .tab-image {
		    display: block;
		    margin: 0 auto; 
		    height: 250px;
		    width: 250px;
		    object-fit: cover;
		    border-radius: 4px;
		}
		.product-item .product_name {
		    margin-top: 10px; 
		}
		
		.product-item .button-area {
		    width: 100%; 
		}
		
		.product_name {
			font-size: 11px;
			font-weight: 500;
			margin-bottom: 0px; 
		}
		.product_price {
			color: #727272;
			font-size: 11px;
			font-weight: 600; 
			margin-top: 0;
		}
		.border-line {
			padding: 10px 0px;
			border-bottom: 1px solid #E1E1E1;
		}
		.pagination-container {
           display: flex;
           justify-content: center; 
           align-items: center; 
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
	    a {
		    text-decoration: none; 
		    }
		/* 공통 컨트롤 박스 스타일 (수량, 가격 등) */
		.control-wrapper {
		    display: flex;
		    align-items: center;
		    gap: 15px; 
		    margin: 10px 0; 
		}
		
		/* 수량 조절 버튼 */
		.quantity-control {
		    display: flex;
		    justify-content: center;
		    align-items: center;
		    gap: 10px; 
		    margin-top: 10px;
		    margin-bottom: 10px; 
		}
		
		/* 장바구니와 하트 버튼 */
		.button-area {
		    display: flex;
		    justify-content: center;
		    align-items: center;
		    gap: 20px; 
		    margin-bottom: 70px;
		}
		
		/* 버튼 스타일 */
		.quantity-btn {
		    background-color: #ffffff;
		    border: 1px solid #ccc;
		    border-radius: 50%;
		    width: 20px;
		    height: 20px;
		    font-size: 10px;
		    font-weight: bold;
		    color: #333;
		    cursor: pointer;
		    display: flex;
		    align-items: center;
		    justify-content: center;
		}
		
		.quantity-btn:hover {
		    background-color: #ffffff;
		    border-color: #ff6600;
		    color: #ff6600;
		}
		/* 장바구니 버튼 */
		.cart-button {
		    padding: 6px 15px;
		    font-size: 12px;
		    border: 1px solid #ff6600;
		    border-radius: 4px;
		    background-color: #ffffff;
		    color: #ff6600;
		    display: inline-flex;
		    align-items: center;
		    gap: 5px;
		}
		.cart-button:hover {
		    background-color: #ff6600;
		    color: #ffffff;
		}
		
		.cart-button svg {
		    fill: #ff6600;
		}
		
		.cart-button:hover svg {
		    fill: #ffffff;
		}
		
		/* 하트 버튼 
		.heart-button {
		    display: inline-flex;
		    align-items: center;
		    gap: 5px;
		    font-size: 15px;
		    color: #d1d1d1;
		    cursor: pointer;
		    border: 1px solid #d1d1d1;
		    border-radius: 4px;
		}
		.heart-button:active  {
			fill: #dd3333;
		}
		*/
</style>
</head>
<body>

	<%@ include file="include/header.jsp"%>


	<!-- Main 캐러셀 리스트 -->
	<section class="pb-5">
		<div class="container-lg">
			<div class="row">
				<div class="col-md-12">
					<div class="section-header d-flex flex-wrap justify-content-between my-4">
						<h3 class="section-title">
        <c:choose>
            <c:when test="${productCategory == 1}">🧡 사료/간식</c:when>
            <c:when test="${productCategory == 2}">💛 장난감/토이</c:when>
            <c:when test="${productCategory == 3}">💚 목욕/케어</c:when>
            <c:when test="${productCategory == 4}">💙 산책/훈련</c:when>
            <c:when test="${productCategory == 5}">💜 의류/잡화</c:when>
        </c:choose>
    </h3>
				
					</div>
				</div>
			</div>

			<div class="row">
				<div class="col-md-12">
					<div class="product-grid row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-3 row-cols-xl-4 row-cols-xxl-4">

						<!-- 리스트에서 아이템 하나 -->
						
						<c:forEach var="product" items="${categoryList}">
							 
							<div class="col">
								<div class="product-item">
								    <figure>
								        <a href="productDetail?product_code=${product.product_code}" title="Product Title">
								            <img src="${pageContext.request.contextPath}/resources/upload/${product.thumbnail_img}" alt="Product Thumbnail" class="tab-image" />
								        </a>
								    </figure>
								     <!-- 상품 정보 -->
							        <div class="d-flex flex-column text-center">
							            <h3 class="product_name">${product.product_name}</h3>
							            <div class="product_price border-line">${product.product_price}원</div>
							            <!-- 수량 -->
							            <div class="quantity-control d-flex justify-content-center align-items-center">
							                 <!-- 고유 ID 설정 -->
						                    <button class="quantity-btn" type="button" onclick="del('${product.product_code}')">−</button>
						                    <span class="quantity-num" id="quantityNum_${product.product_code}">1</span>
						                    
						                    <button class="quantity-btn" type="button" onclick="add('${product.product_code}')">+</button>
							            </div>
							            <!-- 장바구니, 찜하기 -->
							            <div class="button-area d-flex justify-content-center align-items-center gap-3">
								            <form action="addCart" method="POST">
											    <!-- <input type="hidden" name="product_code" value="${product.product_code}" />  -->
 											    <input type="hidden" name="user_id" value="${user_id}" />
											    <input type="hidden" name="product_name" value="${product.product_name}" />
											    <input type="hidden" name="product_code" value="${product.product_code}" />
											    <input type="hidden" name="product_price" value="${product.product_price}" />
											    <input type="hidden" name="cart_quantity" id="cartQuantity_${product.product_code}" value="1" />					    
								               <!-- 장바구니 버튼 -->
								          		<button type="submit" class="cart-button">
								          			<svg width="18" height="18">
											            <use xlink:href="#cart"></use>
											        </svg>장바구니
										        </button>
										        <!-- 
											    <a href="cart" class="cart-button">
											        <svg width="18" height="18">
											            <use xlink:href="#cart"></use>
											        </svg> 장바구니
											    </a>
											    -->
											</form>   
										    <!-- 하트 버튼 -->
										    <!-- <span class="heart-button">♡</span> -->
										    <!-- <a href="#" class="heart-button p-2 fs-6">
										    	<svg width="18" height="18">
										              <use xlink:href="#heart"></use>
							              		</svg>
							              </a>
							              	 -->
										</div>
							        </div>
								</div>
							</div>
						</c:forEach> <!-- / 리스트에서 아이템 하나 -->
					</div>
					<!-- / product-grid -->
				</div>
			</div>
		</div>
	</section> <!-- / Main 캐러셀 리스트 -->

    <!-- 페이징 처리 -->
<div class="pagination-container">
    <div class="pagination">
        <!-- 이전 페이지 링크 -->
        <c:if test="${startPage > 1}">
            <a href="categoryList?product_category=${productCategory}&pageNum=${startPage - 1}&pageListNum=${pageListNum - 1}">&lt;</a>
        </c:if>

        <!-- 페이징 번호 -->
        <c:forEach begin="${startPage}" end="${endPage}" var="page">
            <a href="categoryList?product_category=${productCategory}&pageNum=${page}&pageListNum=${pageListNum}"
               class="${currentPage == page ? 'active' : ''}">${page}</a>
        </c:forEach>

        <!-- 다음 페이지 링크 -->
        <c:if test="${endPage < totalPage}">
            <a href="categoryList?product_category=${productCategory}&pageNum=${endPage + 1}&pageListNum=${pageListNum + 1}">&gt;</a>
        </c:if>
    </div>
</div>

	
	<script src="${pageContext.request.contextPath}/resources/bootstrap/js/jquery-1.11.0.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/swiper@9/swiper-bundle.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>
	<script src="${pageContext.request.contextPath}/resources/bootstrap/js/plugins.js"></script>
	
	<script>
	function add(productCode) {
	    const quantityElement = document.getElementById('quantityNum_${productCode}');
	    const cartQuantityInput = document.getElementById('cartQuantity_${productCode}');

	    if (quantityElement) {
	        let quantity = parseInt(quantityElement.textContent);
	        quantityElement.textContent = quantity + 1;

	        if (cartQuantityInput) {
	            cartQuantityInput.value = quantity + 1;
	        }
	    }
	}

	function del(productCode) {
	    const quantityElement = document.getElementById('quantityNum_${productCode}');
	    const cartQuantityInput = document.getElementById('cartQuantity_${productCode}');

	    if (quantityElement) {
	        let quantity = parseInt(quantityElement.textContent);
	        if (quantity > 1) {
	            quantityElement.textContent = quantity - 1;

	            if (cartQuantityInput) {
	                cartQuantityInput.value = quantity - 1;
	            }
	        }
	    }
	}
	</script>
</body>
</html>