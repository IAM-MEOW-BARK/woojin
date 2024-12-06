<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

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

.product-quantity-control input {
	width: 40px;
	text-align: center;
	padding: 2px;
}

.product-quantity-control button {
	width: 30px;
	padding: 2px;
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
				<!-- 장바구니 -->

				<div class="table-container">
					<h4>장바구니</h4>
					<table class="table justify-content-center align-middle"
						style="text-align: center">
						<tr>
							<th><input type="checkbox" id="selectAll" name="cart"
								value="selectall" checked /></th>
							<th colspan="2">상품명</th>
							<th>수량</th>
							<th>가격</th>
							<th>삭제</th>
						</tr>
						<c:forEach var="item" items="${cartInfo}">
							<tr data-product-code="${item.product_code}"
								data-product-price="${item.product_price}"
								data-user-id="${user_id}">
								<td class="cart_info_td"><input type="hidden"
									class="hidden_product_code_input" value="${itme.product_code }">
									<input type="hidden" class="hidden_product_name_input"
									value="${itme.product_name }"> <input type="hidden"
									class="hidden_product_price_input"
									value="${itme.product_price }"> <input type="hidden"
									class="hidden_cart_quantity_input"
									value="${itme.cart_quantity }"> <input type="hidden"
									class="hidden_totalPrice_input"
									value="${itme.product_price * cart_quantity }"> <input
									type="checkbox" class="individual_cart_checkbox"
									name="selectedItems" value="${item.product_code}" checked /> <input
									type="hidden" name="product_code" value="${item.product_code}">
									<input type="hidden" name="product_price"
									value="${item.product_price}"> <input type="hidden"
									name="cart_quantity" value="${item.cart_quantity}"> <input
									type="hidden" name="product_name" value="${item.product_name}"></td>
								<td><img
									src="${pageContext.request.contextPath}/resources/upload/${item.thumbnail_img}"
									alt="${item.product_name}" style="width: 30px; height: 30px;">
								</td>
								<td style="text-align: left;">${item.product_name}</td>
								<td>
									<div class="product-quantity-control">
										<button class="btn btn-outline-secondary minus_btn">-</button>
										<input type="text" class="form-control d-inline quantity"
											id="cart_quantity" value="${item.cart_quantity}" readonly>
										<button class="btn btn-outline-secondary plus_btn">+</button>
										<a class="update_quantity_btn"
											data-product_code="${item.product_code}"><button class="btn">변경</button></a>
									</div>
								</td>
								<td class="price" data-price="${item.product_price}"><fmt:formatNumber
										value="${item.product_price}" pattern="#,### 원" /> <br>
									<b><fmt:formatNumber
											value="${item.product_price * item.cart_quantity}"
											pattern="#,### 원" /></b></td>
								<td>
									<button class="btn btn-outline-secondary delete_btn">삭제</button>
								</td>
							</tr>

						</c:forEach>
					</table>
				</div>
				<form action="/cart/update" method="post" id="quantity_update_form">
					<input type="hidden" name="user_id" value="${user_id}"> <input
						type="hidden" name="product_quantity"
						class="update_product_quantity"> <input type="hidden"
						name="product_code" class="update_product_code">
				</form>
				<div class="table-container d-flex justify-content-end">
					<table>
						<tr>
							<td style="text-align: right; padding-right: 20px">총 금액:
							<fmt:formatNumber value="${cartCost}" type="number" groupingUsed="true"/>원
							</td>
							<td>
							<form method="post" action="/cart">
							<input type="hidden" name="user_id_fk"
								value="${user_id}">
								<button class="btn order_btn" type="submit"
									style="background: #ff6600; color: #ffffff">구매하기</button></form></td>
						</tr>
					</table>
				</div>
			</div>
		</div>
	</div>

	<!-- / 장바구니. 끝. -->

	<script type="text/javascript">
		$(document).ready(
				function() {
					// 수량 증가 버튼 클릭
					$(".plus_btn").on("click", function() {
						console.log("수량 증가 버튼 클릭됨");
						let $quantityInput = $(this).siblings(".quantity");
						let quantity = parseInt($quantityInput.val(), 10);
						$quantityInput.val(++quantity); // 값 증가
						updateTotalPrice($(this)); // 가격 업데이트

					});

					// 수량 감소 버튼 클릭
					$(".minus_btn").on("click", function() {
						console.log("수량 감소 버튼 클릭됨");
						let $quantityInput = $(this).siblings(".quantity");
						let quantity = parseInt($quantityInput.val(), 10);
						if (quantity > 1) {
							$quantityInput.val(--quantity); // 값 감소
							updateTotalPrice($(this)); // 가격 업데이트
						}
					});

					// 수량 변경 서버에 반영
					$(".update_quantity_btn").on(
							"click",
							function() {
								const productCode = $(this)
										.data("product_code");
								const cartQuantity = $(this).siblings(
										".quantity").val();

								$.ajax({
									type : "POST",
									url : "/cart/update",
									data : {
										user_id : $("input[name='user_id']")
												.val(),
										product_code : productCode,
										cart_quantity : cartQuantity,
									},
									success : function(response) {
										alert("수량이 변경되었습니다.");
										location.reload();
									},
									error : function() {
										alert("수량 변경 중 오류가 발생했습니다.");
									},
								});
							});
					// 수정 끝

					// 총 가격 업데이트 함수
					function updateTotalPrice($button) {
						let $row = $button.closest("tr");
						let pricePerItem = parseInt($row.find(".price").data(
								"price"), 10);
						let quantity = parseInt($row.find(".quantity").val(),
								10);
						let totalPrice = pricePerItem * quantity;

						$row.find(".price b").text(
								totalPrice.toLocaleString() + " 원"); // 가격 업데이트
					}

				});
		
		$(document).on("click", ".delete_btn", function (e) {
		    e.preventDefault(); // 기본 동작 중단

		    const $row = $(this).closest("tr");
		    const productCode = $row.data("product-code");
		    const userId = $("input[name='user_id']").val(); // 숨겨진 user_id 가져오기

		    if (!confirm("선택한 항목을 삭제하시겠습니까?")) {
		        return;
		    }

		    $.ajax({
		        type: "POST",
		        url: "/cart/delete",
		        data: {
		            user_id: userId,
		            product_code: productCode,
		        },
		        success: function (response) {
		            alert("항목이 삭제되었습니다.");
		            location.reload(); // 페이지 새로고침
		        },
		        error: function () {
		            alert("항목 삭제 중 오류가 발생했습니다.");
		        },
		    });
		});
	</script>
</body>
</html>