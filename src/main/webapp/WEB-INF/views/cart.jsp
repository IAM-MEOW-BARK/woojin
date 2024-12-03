<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니</title>

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
				<form method="post" action="/cart">
					<div class="table-container">
						<h4>장바구니</h4>
						<table class="table justify-content-center align-middle" style="text-align: center">
							<tr>
								<th><input type="checkbox" name="cart" value="selectall" checked /></th>
								<th colspan="2">상품명</th>
								<th>수량</th>
								<th>가격</th>
								<th>삭제</th>
							</tr>
							<c:forEach var="item" items="${cartInfo}">
								<tr>
									<td class="cart_info_td">
										<input type="checkbox" name="item" value="${item.product_code}" checked />
									</td>
									<td>
										<img src="${pageContext.request.contextPath}/resources/upload/${item.thumbnail_img}" alt="${item.product_name}" style="width: 30px; height: 30px;">
									</td>
									<td style="text-align: left;">${item.product_name}</td>
									<td>
										<div class="product-quantity-control">
											<button class="btn btn-outline-secondary btn-decrease">-</button>
											<input type="text" class="form-control d-inline quantity" value="${item.cart_quantity}" readonly>
											<button class="btn btn-outline-secondary btn-increase">+</button>
										</div>
									</td>
									<td class="price" data-price="${item.product_price}">
										<fmt:formatNumber value="${item.product_price}" type="number" groupingUsed="true" />
										원
									</td>
									<td>
										<button class="btn btn-outline-secondary delete_btn">삭제</button>
									</td>
								</tr>
								<input type="hidden" name="product_code" value="${item.product_code}">
								<input type="hidden" name="product_price" value="${item.product_price}">
								<input type="hidden" name="cart_quantity" value="${item.cart_quantity}">
								<input type="hidden" name="product_name" value="${item.product_name}">
							</c:forEach>
						</table>
					</div>
					<div class="table-container d-flex justify-content-end">
						<table>
							<tr>
								<td style="text-align: right; padding-right: 20px">
									총 금액: <span id="finalPriceTag">0</span>
								</td>
								<td>
									<input type="hidden" name="user_id_fk" value="${user_id}">
									<button class="btn order_btn" type="submit" style="background: #ff6600; color: #ffffff">구매하기</button>
								</td>
							</tr>
						</table>
					</div>
				</form>
			</div>
		</div>
	</div>

	<!-- / 장바구니. 끝. -->

	<script type="text/javascript">
        document.addEventListener("DOMContentLoaded", function () {
            // 초기 개별 상품 총 가격 설정
            document.querySelectorAll("table tr").forEach((row) => {
                const priceElement = row.querySelector(".price");
                if (priceElement) {
                    const productPrice = parseInt(priceElement.dataset.price);
                    const quantity = parseInt(row.querySelector(".quantity").value);
                    priceElement.innerText = (productPrice * quantity).toLocaleString() + " 원";
                }
            });

            // 마스터 체크박스 동작
            document.querySelector('input[name="cart"]').addEventListener("click", function () {
                const isChecked = this.checked;
                document.querySelectorAll('input[name="item"]').forEach((checkbox) => {
                    checkbox.checked = isChecked;
                });
                updateFinalPrice();
            });

            // 개별 체크박스 동작
            document.querySelectorAll('input[name="item"]').forEach((checkbox) => {
                checkbox.addEventListener("change", function () {
                    const allChecked = Array.from(document.querySelectorAll('input[name="item"]')).every(cb => cb.checked);
                    document.querySelector('input[name="cart"]').checked = allChecked;
                    updateFinalPrice();
                });
            });

            // 수량 변경 버튼 동작
            document.querySelector("table").addEventListener("click", function (e) {
                const button = e.target;
                if (button.classList.contains("btn-increase") || button.classList.contains("btn-decrease")) {
                    const row = button.closest("tr");
                    const quantityInput = row.querySelector(".quantity");
                    const priceElement = row.querySelector(".price");
                    const productPrice = parseInt(priceElement.dataset.price);
                    let quantity = parseInt(quantityInput.value);

                    // 수량 증가/감소 처리
                    quantity = button.classList.contains("btn-increase") ? quantity + 1 : Math.max(1, quantity - 1);
                    quantityInput.value = quantity;
                    priceElement.innerText = (productPrice * quantity).toLocaleString() + " 원";
                    updateFinalPrice();
                }
            });

            // 총 금액 계산
            function updateFinalPrice() {
                let total = 0;
                document.querySelectorAll("table tr").forEach((row) => {
                    const checkbox = row.querySelector('input[name="item"]');
                    if (checkbox && checkbox.checked) {
                        const priceElement = row.querySelector(".price");
                        const productPrice = parseInt(priceElement.innerText.replace(/[^0-9]/g, ""));
                        total += productPrice;
                    }
                });
                document.querySelector("#finalPriceTag").innerText = total.toLocaleString() + " 원";
            }

            // 초기 총 금액 계산
            updateFinalPrice();
        });
        
        
        /* 주문 페이지 이동 */	
        $(".order_btn").on("click", function(){
        	
        	let form_contents ='';
        	let orderNumber = 0;
        	
        	$(".cart_info_td").each(function(index, element){
        		
        		if($(element).find(".individual_cart_checkbox").is(":checked") === true){	//체크여부
        			
        			let product_code = $(element).find(".individual_bookId_input").val();
        			let cart_quantity = $(element).find(".individual_bookCount_input").val();
        			
        			let product_code_input = "<input name='orders[" + orderNumber + "].bookId' type='hidden' value='" + bookId + "'>";
        			form_contents += product_code_input;
        			
        			let cart_quantity_input = "<input name='orders[" + orderNumber + "].bookCount' type='hidden' value='" + bookCount + "'>";
        			form_contents += cart_quantity_input;
        			
        			orderNumber += 1;
        			
        		}
        	});	

        	$(".order_form").html(form_contents);
        	$(".order_form").submit();
        	
        });
    </script>
</body>
</html>