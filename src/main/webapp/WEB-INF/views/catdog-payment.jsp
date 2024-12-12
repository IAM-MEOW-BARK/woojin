<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="ko">
<%@ include file="include/head.jsp" %>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>배송지 정보</title>
    <style type="text/css">
    	/* 라디오 버튼 커스터마이징  */
    	.form-check-input:checked {
            background-color: #ff6600;
            border-color: #ff6600;
        }
        
        .form-check-input {
            border-radius: 50%; /* 둥근 스타일 적용 (옵션) */
        }
        
        .container {
 	   		max-width: 1000px !important; /* 원하는 크기로 설정 */
		}
		
		input:focus {outline: none;}
    </style>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>                
     <!-- 좌측 -->
     <div class="container mt-5">
        <div class="row">
            <!-- 좌측: 배송 정보, 상품 내역, 결제수단 -->
            <div class="col-lg-8">
                <!-- 배송 정보 -->
                <div class="card shadow-sm mb-4">
                    <div class="card-body">
                        <h5 class="card-title fw-bold">배송지</h5>
                        <div class="mt-3">                        
                            <span class="badge bg-secondary mb-2">기본배송지</span>
                            <div>
                            	<input type="text" id="deliveryContact" style="border: none; font-weight: bold" value="${orderInfo.name}" readonly>
                            </div>
                            <div>
                            	<input type="text" id="deliveryContact" style="border: none" size="11" value="${orderInfo.phoneNum}" readonly>
                            </div>
                            <div>
                            	<input type="text" id="zipcode" style="border: none;" size="70" value="${orderInfo.zipcode}" readonly>
                            </div>
                            <div>
                            	<input type="text" id="deliveryAddress" style="border: none;" size="70" value="${orderInfo.address} ${orderInfo.detailAddress}" readonly>
                            </div>
                        </div>
                        <hr>
                        <div class="d-flex">
                            <button class="btn btn-outline-secondary btn-sm ms-auto" data-bs-toggle="modal" data-bs-target="#editAddressModal">
                                변경
                            </button>
                        </div>
                    </div>
                </div>

                <!-- 상품 내역 -->
                <div class="card shadow-sm mb-4">
                    <div class="card-body">
                        <h5 class="card-title fw-bold">주문 상품</h5>
                        <c:forEach var="item" items="${orderItems}">
	                        <div class="d-flex align-items-center mt-3">
	                            <img src="${pageContext.request.contextPath}/resources/upload/${item.thumbnail_img}" alt="상품 이미지" class="img-fluid" style="width: 100px; height: auto; margin-right: 15px;">
	                            <div>
	                                <h6 class="mb-1">${item.product_name}</h6>
	                                <span class="badge bg-secondary">무료 배송</span>
	                                <p class="text-muted mb-1">지금 결제 시 <span class="fw-bold">내일 도착보장</span></p>
	                            </div>
	                        </div>
	                        <div class="mt-3">
	                            <p class="mb-1"><span class="fw-bold">수량:</span> ${item.order_quantity}개</p>
	                            <p class="fw-bold text-end">
	                            	<fmt:formatNumber value="${item.product_price}" type="number" groupingUsed="true" />원 <br>
	                            	<b><fmt:formatNumber value="${item.total_price}" type="number" groupingUsed="true" />원</b>
	                            </p>
	                        </div>
						    <hr>
						</c:forEach>
						<div class="d-flex justify-content-between">
						    <span class="fw-bold">총 주문금액</span>
						    <span class="fw-bold" style="color:#ff6600">
						    	<fmt:formatNumber value="${totalCost}" type="number" groupingUsed="true" />원
						    </span>
						</div>
                    </div>
                </div>
                <!-- 결제수단 -->
                <div class="card shadow-sm" style=" margin-bottom: 20px;">
                    <div class="card-body">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <h5 class="card-title fw-bold">결제수단</h5>
                            
                            <span class="fw-bold" style="color:#ff6600"><fmt:formatNumber value="${totalCost}" type="number" groupingUsed="true" />원</span>
                        </div>
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="paymentMethod" id="cardPayment" checked>
                            <label class="form-check-label" for="cardPayment">카드 결제</label>
                        </div>
                    </div>
                </div>
            </div>
            <!-- 우측: 결제 요약 -->
            <div class="col-lg-4">
                <div class="card shadow-sm">
                    <div class="card-body">
                        <div class="mb-3">
                            <div class="d-flex justify-content-between">
                                <span class="price-detail">상품 금액</span>
                                <span>
									<b>
	                               		<fmt:formatNumber value="${totalCost}" type="number" groupingUsed="true" />원
	                               	</b>
								</span>
                            </div>
                            <div class="d-flex justify-content-between">
                                <span class="price-detail">배송비</span>
                                <span>0원</span>
                            </div>
                            <div class="d-flex justify-content-between">
                                <span class="price-detail">상품 할인</span>
                                <span>- 0원</span>
                            </div>
                            <div class="d-flex justify-content-between">
                                <span class="price-detail">쿠폰 할인</span>
                                <span>0원</span>
                            </div>
                            <div class="d-flex justify-content-between">
                                <span class="price-detail">포인트 사용</span>
                                <span>0원</span>
                            </div>
                            <hr>
                            <div class="d-flex justify-content-between">
                                <span class="final-price"><b>최종 결제 금액</b></span>
                                <span class="final-price" style="font-size:20px;">
                                	<b>
                                		<fmt:formatNumber value="${totalCost}" type="number" groupingUsed="true" />원
                                	</b>
                               	</span>
                            </div>
                            <div class="d-flex justify-content-between mt-2">
                                <span class="price-detail">적립 예정 포인트</span>
                                <span>0p</span>
                            </div>
                        </div>
                        <form action="/processPayment" method="post">
						    <input type="hidden"  id="deliveryContact" name="name" value="${orderInfo.name}">
						    <input type="hidden"  id="deliveryContact" name="phone_num" value="${orderInfo.phoneNum}">
						    <input type="hidden"  id="zipcode" name="zipcode" value="${orderInfo.zipcode}">
						    <input type="hidden"  id="deliveryAddress" name="address" value="${orderInfo.address}">
						    <input type="hidden"  id="deliveryAddress" name="detailAddress" value="${orderInfo.detailAddress}">
						
						    <button type="submit" class="btn w-100 font-bold text-white" style="background-color: #ff6600;">결제하기</button>
						</form>
                        <!-- <button class="btn w-100 font-bold text-white" style="background-color: #ff6600;">결제하기</button> -->
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- 배송지 모달 -->
    <div class="modal fade" id="editAddressModal" tabindex="-1" aria-labelledby="editAddressModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="editAddressModalLabel"><b>배송지 정보 수정</b></h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form id="editAddressForm">
                        <div class="mb-3">
                            <label for="recipient" class="form-label">수령인</label>
                            <input type="text" class="form-control" id="recipient" name="recipient" value="${orderInfo.name}">
                        </div>
                        <div class="mb-3">
                            <label for="phone" class="form-label">전화번호</label>
                            <input type="text" class="form-control" id="phone" name="phone" value="${orderInfo.phoneNum}">
                        </div>
                        <div class="mb-3">
                            <label for="zipCode" class="form-label">우편번호</label>
                            <input type="text" class="form-control" id="zipCode" name="zipCode" value="${orderInfo.zipcode}" readonly>
                        </div>
                        <div class="mb-3">
                            <label for="address" class="form-label">주소</label>
                            <div class="input-group">
                                <input type="text" class="form-control" id="address" name="address" value="${orderInfo.address}" readonly>
                                <button type="button" class="btn btn-outline-secondary" onclick="openDaumPostcode()">검색</button>
                            </div>
                        </div>
                        <div id="addressDetail" class="mb-3">
                            <label for="addressDetail" class="form-label">상세 주소</label>
                            <input type="text" class="form-control" id="detailAddress" name="detailAddress" value="${orderInfo.detailAddress}">
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                    <button type="button" class="btn btn-primary" id="saveButton" onclick="saveChanges()">저장</button>
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript">
	   

	    // 주소 검색 API 호출
	    function openDaumPostcode() {
	        new daum.Postcode({
	            oncomplete: function(data) {
	                // 선택된 주소를 처리하는 로직
	                document.getElementById('zipCode').value = data.zonecode; // 우편번호
	                document.getElementById('address').value = data.address; // 기본 주소
	            }
	        }).open();
	    }

	    function saveChanges() {
	        // DOM 요소 가져오기
	        var recipientElement = document.getElementById('recipient');
	        var phoneElement = document.getElementById('phone');
	        var zipCodeElement = document.getElementById('zipCode');
	        var addressElement = document.getElementById('address');
	        var addressDetailElement = document.getElementById('detailAddress');

	        // 값 가져오기
	        var recipient = recipientElement.value.trim();
	        var phone = phoneElement.value.trim();
	        var zipCode = zipCodeElement.value.trim();
	        var address = addressElement.value.trim();
	        var addressDetail = addressDetailElement.value.trim();

	        // 업데이트 대상 DOM 요소 (UI 업데이트)
	        var deliveryContact = document.getElementById('deliveryContact');
	        var deliveryAddress = document.getElementById('deliveryAddress');
	        var zipcode = document.getElementById('zipcode');

	        deliveryContact.value = recipient;
	        deliveryAddress.value = address + " " + addressDetail;
	        zipcode.value = zipCode;

	        // <form> 필드 업데이트
	        var formRecipient = document.querySelector('form input[name="name"]');
	        var formPhone = document.querySelector('form input[name="phoneNum"]');
	        var formZipCode = document.querySelector('form input[name="zipcode"]');
	        var formAddress = document.querySelector('form input[name="address"]');
	        var formDetailAddress = document.querySelector('form input[name="detailAddress"]');

	        if (formRecipient) formRecipient.value = recipient;
	        if (formPhone) formPhone.value = phone;
	        if (formZipCode) formZipCode.value = zipCode;
	        if (formAddress) formAddress.value = address;
	        if (formDetailAddress) formDetailAddress.value = addressDetail;

	        console.log('Form fields updated:', {
	            name: formRecipient ? formRecipient.value : null,
	            phoneNum: formPhone ? formPhone.value : null,
	            zipcode: formZipCode ? formZipCode.value : null,
	            address: formAddress ? formAddress.value : null,
	            detailAddress: formDetailAddress ? formDetailAddress.value : null,
	        });

	        // 모달 닫기
	        const modalElement = document.getElementById('editAddressModal');
	        if (modalElement) {
	            const modalInstance = bootstrap.Modal.getInstance(modalElement);
	            if (modalInstance) {
	                modalInstance.hide();
	            } else {
	                console.error('모달 인스턴스를 찾을 수 없습니다.');
	            }
	        }
	    }

	
	   
	   document.getElementById("paymentForm").addEventListener("submit", function (event) {
	        // Alert 메시지 표시
	        alert("결제가 성공적으로 완료되었습니다.");

	        // 여기서 리디렉트는 서버에서 처리되므로 추가 동작은 필요 없습니다.
	        // 이벤트를 막지 않고 정상적으로 서버에 요청을 보냄
	    });
    </script>
</body>
</html>