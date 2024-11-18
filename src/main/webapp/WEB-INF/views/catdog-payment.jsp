<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
    </style>
</head>
<body>                
     <%-- <div class="card-body">
         <div class="d-flex justify-content-between align-items-center">
             <h5 class="card-title mb-0">
                 <i class="bi bi-geo-alt"></i>
                 <span th:text="${deliveryName}">써리빙타워</span>
                 <span th:text="${deliveryName}">써리빙타워</span>
                 <span class="badge bg-secondary ms-2">기본배송지</span>
             </h5>
             <button class="btn btn-outline-primary btn-sm">변경</button>
         </div>
         <hr>
         <p class="card-text mb-1">
             <strong th:text="${recipientName}">김우진</strong> / 
             <span th:text="${phoneNumber}">010-7545-3256</span>
         </p>
         <p class="card-text">
             [<span th:text="${zipCode}">08392</span>] 
             <span th:text="${address}">서울특별시 구로구 디지털로32다길 26-8 (구로동) 402호</span>
         </p>
         <div class="bg-light p-3 text-muted">
             <span th:text="${memo}">문 앞에 놓아주세요.</span>
         </div>
     </div> --%>
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
                            <p class="mb-1" id="deliveryContact"><strong>김우진</strong> / 010-7545-3256</p>
                            <p class="mb-0" id="deliveryAddress">[08392] 경기도 광명시 철산3동 498번지</p>
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
                        <div class="d-flex align-items-center mt-3">
                            <img src="${pageContext.request.contextPath}/resources/bootstrap/images/thumbnail_01.png" alt="상품 이미지" class="img-fluid" style="width: 100px; height: auto; margin-right: 15px;">
                            <div>
                                <h6 class="mb-1">양면 초경량 후리스 네이비</h6>
                                <span class="badge bg-secondary">무료 배송</span>
                                <p class="text-muted mb-1">지금 결제 시 <span class="fw-bold">내일 도착보장</span></p>
                                <p class="mt-2 mb-0">강아지 패딩 양면 겨울옷 초경량 후리스</p>
                            </div>
                        </div>
                        <div class="mt-3">
                            <p class="mb-1"><span class="fw-bold">옵션:</span> S</p>
                            <p class="mb-1"><span class="fw-bold">수량:</span> 1개</p>
                            <p class="fw-bold text-end">15,500원</p>
                        </div>
                        <hr>
                        <div class="d-flex justify-content-between">
                            <span class="fw-bold">총 주문금액</span>
                            <span class="fw-bold" style="color:#ff6600">15,500원</span>
                        </div>
                    </div>
                </div>

                <!-- 결제수단 -->
                <div class="card shadow-sm">
                    <div class="card-body">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <h5 class="card-title fw-bold">결제수단</h5>
                            <span class="fw-bold" style="color:#ff6600">15,500원</span>
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
                                <span><b>15,500원</b></span>
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
                                <span class="final-price" style="font-size:20px;"><b>15,500원</b></span>
                            </div>
                            <div class="d-flex justify-content-between mt-2">
                                <span class="price-detail">적립 예정 포인트</span>
                                <span>0p</span>
                            </div>
                        </div>
                        <button class="btn w-100 font-bold text-white" style="background-color: #ff6600;">결제하기</button>
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
                            <input type="text" class="form-control" id="recipient" name="recipient" value="김우진">
                        </div>
                        <div class="mb-3">
                            <label for="phone" class="form-label">전화번호</label>
                            <input type="text" class="form-control" id="phone" name="phone" value="010-7545-3256">
                        </div>
                        <div class="mb-3">
                            <label for="zipCode" class="form-label">우편번호</label>
                            <input type="text" class="form-control" id="zipCode" name="zipCode" value="08392" readonly>
                        </div>
                        <div class="mb-3">
                            <label for="address" class="form-label">주소</label>
                            <div class="input-group">
                                <input type="text" class="form-control" id="address" name="address" value="경기도 광명시 철산3동 498번지" readonly>
                                <button type="button" class="btn btn-outline-secondary" onclick="openDaumPostcode()">검색</button>
                            </div>
                        </div>
                        <div id="addressDetail" class="mb-3">
                            <label for="addressDetail" class="form-label">상세 주소</label>
                            <input type="text" class="form-control" id="addressDetailInput" name="addressDetail">
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                    <button type="button" class="btn btn-primary" id="saveButton">저장</button>
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

	    document.addEventListener('DOMContentLoaded', () => {
	        function saveChanges() {
	            // DOM 요소 가져오기
	            const recipientElement = document.getElementById('recipient');
	            const phoneElement = document.getElementById('phone');
	            const zipCodeElement = document.getElementById('zipCode');
	            const addressElement = document.getElementById('address');
	            const addressDetailElement = document.getElementById('addressDetailInput');

	            // 요소가 존재하지 않을 경우 에러 출력
	            if (!recipientElement || !phoneElement || !zipCodeElement || !addressElement || !addressDetailElement) {
	                console.error('필수 입력 요소를 찾을 수 없습니다.');
	                return;
	            }

	            // 값 가져오기
	            const recipient = recipientElement.value.trim();
	            const phone = phoneElement.value.trim();
	            const zipCode = zipCodeElement.value.trim();
	            const address = addressElement.value.trim();
	            const addressDetail = addressDetailElement.value.trim();

	            const fullAddress = `${address} ${addressDetail}`.trim();

	            // UI 업데이트
	            const deliveryContact = document.getElementById('deliveryContact');
	            const deliveryAddress = document.getElementById('deliveryAddress');

	            if (!deliveryContact || !deliveryAddress) {
	                console.error('UI 업데이트 요소를 찾을 수 없습니다.');
	                return;
	            }

	            deliveryContact.textContent = `${recipient} / ${phone}`;
	            deliveryAddress.textContent = `[${zipCode}] ${fullAddress}`;

	            // 모달 닫기
	            const modalElement = document.getElementById('editAddressModal');
	            const modalInstance = bootstrap.Modal.getInstance(modalElement);
	            modalInstance.hide();
	        }

	        // 버튼 클릭 이벤트 설정
	        const saveButton = document.querySelector('.btn-primary');
	        if (saveButton) {
	            saveButton.addEventListener('click', saveChanges);
	        } else {
	            console.error('저장 버튼을 찾을 수 없습니다.');
	        }
	    });
    </script>
</body>
</html>