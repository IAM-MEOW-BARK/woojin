<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <title>상품 상세페이지</title>
        <link href="${pageContext.request.contextPath}/resources/css/productStyle.css" rel="stylesheet">
    </head>
    
    <body>
       <%@ include file="include/header.jsp"%>
        
        <!-- 상품 상세페이지 상단 -->
        <section class="py-5">
            <div class="container px-4 px-lg-5 my-5">
               
               
                   <div class="row gx-4 gx-lg-5 align-items-center"  style="display: flex; ">
                    <!-- 상품 썸네일 -->
                    <div class="col-md-6">
                        <div class="product-image-container">
                            <img src="${pageContext.request.contextPath}/resources/upload/${productDetail.thumbnail_img}" 
                                 alt="Product Thumbnail" class="product-thumbnail" />
                        </div>
                    </div>
                       <!-- 상품 정보 -->
                       <div class="col-md-6" style="display: flex; flex-direction: column; justify-content: center margin-top:-10px;;">
                           <!-- 상품명 
                           <h1 class="display-7 fw-bolder">${productDetail.product_name}</h1>
                     -->
                      <h3 class="productName">${productDetail.product_name}</h3>
                     <!--  찜하기 버튼 -->
                          
                          
                          
                          
                          
                         
                           <!-- 상품 가격 -->
                           <div class="products-box-detail-price border-line">
                        <span class="products-box-detail-postInfo-title">가격</span>
                        <span class="products-box-detail-price-figure">
                           <fmt:formatNumber value="${productDetail.product_price}" pattern="#,###"/> 원
                         </span>
                     </div>
                     
                     <!-- 배송 정보 -->
                     <div class="products-box-detail-postInfo">
                        <span class="products-box-detail-postInfo-title">배송정보</span>
                        <span class="products-box-detail-postInfo-content">무료배송</span>
                        <div class="products-box-detail-realInfo-title">제주 3,000원 추가/도서산간 5,000원 추가</div>   
                        <div class="products-box-detail-realInfo-content" >지금 주문 시, ${deliveryDate} 도착 예정</div>
                        
                     </div>
                     
                     
                     <form action="addCart" method="POST">
                         <input type="hidden" name="user_id" value="${user_id}" />
                         <input type="hidden" name="product_code" value="${productDetail.product_code}" />
                        
                     
                     <!-- 수량 선택 -->
                     <div class="border-line control-wrapper">
                         <span class="products-box-detail-postInfo-title">수량</span>
                         <div class="quantity-control">
                            <button class="quantity-btn" type="button" onclick="updateQuantity('del')">−</button>
                             <!-- 수량 표시 -->
                              <span class="quantity-display" id="quantityDisplay">1</span> 
                              <input type="hidden" id="cartQuantity" name="cart_quantity" value="1">
                             <!--<input type="text" name="amounts" id="quantityDisplay" value="1" readonly> -->
                             
                            <button class="quantity-btn" type="button" onclick="updateQuantity('add')">+</button>
                             <span  id="totalPrice" class="total-price">
                                <fmt:formatNumber value="${productDetail.product_price}" pattern = "#,###"/>원</span>
                         </div>
                     </div>

                     <!-- 주문 금액 -->
                     <div class="products-box-detail-allPrice">
                         <span class="products-box-detail-allPrice-title">주문금액</span>
                         <span id="allTotalPrice" class="products-box-detail-allPrice-figure">
                         <fmt:formatNumber value="${productDetail.product_price}" pattern = "#,###"/>원</span>
                     </div>
                     
                     <!-- 장바구니 버튼 -->
                      <button type="submit" class="cart-button" >장바구니</button>
                      </form>
                       </div>
                   </div>
            </div>
        </section>
        
        <!-- 상품 상세 페이지 하단 -->
        <section class="py-5">
         <div class="wrap-detail-info" style="padding-top: 0px;">
            <!-- 상세정보 이동 탭 -->
            <div class="tab-detail-info">
               <ul class="tab">
                   <li id="tab-img-text"><a href="#detail-img-text-box" class="tab-link" onclick="setActiveTab(event)">상품정보</a></li>
                   <li id="tab-review"><a href="#detail-review-box" class="tab-link" onclick="setActiveTab(event)">리뷰</a></li>
                   <li id="tab-qna"><a href="#detail-qna-box" class="tab-link" onclick="setActiveTab(event)">Q&A</a></li>
                   <li id="tab-purchaseInfo"><a href="#detail-guideInfo-box" class="tab-link" onclick="setActiveTab(event)">취소/교환/반품 안내</a></li>
               </ul>
            </div>
            
            <!-- 상품 상세정보 시작 -->
               <div class="container px-4 px-lg-5 mt-5 ">
                   <div class="detail-header">상품정보</div>
                      <div id="detail-img-text-box" style="width:800px;">
                          <img src="${pageContext.request.contextPath}/resources/upload/${productDetail.product_img}" alt="product-img" class="card-img-top" />
                        </div>
                 <div id="detail-info-box">
                  <div class="detail-info-header">상품설명</div>
                  <div>${productDetail.product_info}</div>
               </div>
                  <!-- 리뷰 시작 -->
                  <div id="detail-review-box">
                     
                      <div class="detail-review-header">
                          리뷰 (${product_reviewTotal})
                          <a class="more-button" href="reviewList">더보기</a>
                      </div>
                      <div id="recent-reviews">
                      
                          <c:forEach var="review" items="${getReview}">
                             <a href="reviewDetail?review_no=${review.review_no}" class="review-item-link">
                                 <div class="review-item">
                                     <!-- 리뷰 이미지 -->
                                     <div class="review-image">
                                         <img src="${pageContext.request.contextPath}/resources/upload/${review.review_img}" alt="Review Image">
                                     </div>
                                     <!-- 리뷰 텍스트 -->
                                     <div class="review-text">
                                         <!-- 별점, 아이디, 등록일 -->
                                         <div class="review-info">
                                             <!-- 별점 -->
                                             <div class="stars">
                                                 <c:forEach begin="1" end="5" var="i">
                                                     <c:choose>
                                                         <c:when test="${i <= review.review_score}">
                                                             <span class="star-filled">★</span>
                                                         </c:when>
                                                         <c:otherwise>
                                                             <span class="star-empty">☆</span>
                                                         </c:otherwise>
                                                     </c:choose>
                                                 </c:forEach>
                                             </div>
                                             <!-- 아이디와 등록일 -->
                                             <span class="review-user">${review.user_id}</span>
                                             <span class="review-date">${review.review_date}</span>
                                         </div>
                                         <!-- 리뷰 내용 -->
                                         <p class="review-content">${review.review_content}</p>
                                     </div>
                                 </div>
                              </a>
                          </c:forEach>
                          <c:if test="${empty getReview}">
                              <p>리뷰가 없습니다.</p>
                          </c:if>
                      </div>
                  </div> <!-- 리뷰 끝 -->
               
                  <!-- QNA 시작 -->
                  <div id="detail-qna-box">
                      <div class="detail-qna-header">
                          Q&A (${product_qnaTotal})
                          <a class="more-button" href="qnaList">더보기</a>
                      </div>
                      <div id="recent-qnas">
                          <c:forEach var="qna" items="${getQna}">
                              <a href="qnaDetail?qna_no=${qna.qna_no}" class="qna-item-link">
                                  <div class="qna-item">
                                      <!-- Q&A 텍스트 -->
                                      <div class="qna-text">
                                          <div class="qna-info">
                                             
                                          
                                             <c:choose>
                                                <c:when test="${qna.qna_secret eq 1}">
                                                   
                                                   <span class="qna-lock">🔒</span>
                                                   <span class="qna-content">상품 문의합니다.</span>
                                                </c:when>
                                                <c:otherwise>
                                                   <span class="qna-lock"></span>
                                                   <span class="qna-content">${qna.qna_content}</span>
                                                </c:otherwise>
                                             </c:choose>
                                             
                                             <!-- Q&A 내용 
                                             <span class="qna-content">${qna.qna_content}</span>
                                             -->
                                             <!-- 사용자와 날짜 -->
                                              <span class="qna-user">${qna.user_id}</span>
                                              <span class="qna-date">${qna.qna_date}</span>
                                          
                                          <!-- 답변 상태 -->
                                          <div class="qna-reply">
                                              <c:choose>
                                                  <c:when test="${not empty qna.qna_reply}">
                                                      <span class="reply-status">답변 완료</span>
                                                  </c:when>
                                                  <c:otherwise>
                                                     <span class="reply-ready">답변 대기</span>
                                                  </c:otherwise>
                                              </c:choose>
                                          </div>
                                          </div>
                                      </div>
                                  </div>
                              </a>
                          </c:forEach>
                          <c:if test="${empty getQna}">
                              <p>Q&A가 없습니다.</p>
                          </c:if>
                      </div>
                  </div> <!-- QNA 끝 -->

               
               <!-- 취소/교환/반품 안내 -->
               <div id="detail-guideInfo-box">
                  <div class="detail-guideInfo-header">취소/교환/반품 안내</div>
                     <div class="accordion accordion-flush" id="accordionFlushExample">
                       <div class="accordion-item">
                         <h2 class="accordion-header" id="flush-headingOne">
                           <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseOne" aria-expanded="false" aria-controls="flush-collapseOne">
                             주문취소
                           </button>
                         </h2>
                         <div id="flush-collapseOne" class="accordion-collapse collapse" aria-labelledby="flush-headingOne" data-bs-parent="#accordionFlushExample">
                           <div class="accordion-body">
                              <ul class="guide">
                                 <li>주문취소는 '입금대기, 입금완료' 단계에서만 가능합니다.</li>
                                 <li>주문취소는 '마이페이지 > 주문ㆍ배송 > 주문취소 > 주문 상세 보기'를 통해 직접 취소하실 수 있습니다.</li>
                                 <li>입금완료 후 신속한 발송을 위하여 주문 상태가 빠르게 '발송준비중'으로 변경될 수 있으며, '발송준비중' 단계에서는 주문 취소가 불가능합니다.</li>
                                 <li>'발송준비중, 발송처리완료' 단계에서는 상품 수령 후 교환 또는 반품만 가능합니다.</li>
                              </ul>
                           </div>
                         </div>
                       </div>
                       <div class="accordion-item">
                         <h2 class="accordion-header" id="flush-headingTwo">
                           <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseTwo" aria-expanded="false" aria-controls="flush-collapseTwo">
                             교환 및 반품정보
                           </button>
                         </h2>
                         <div id="flush-collapseTwo" class="accordion-collapse collapse" aria-labelledby="flush-headingTwo" data-bs-parent="#accordionFlushExample">
                           <div class="accordion-body">
                              <ul class="guide">
                                 <li>교환/반품은 배송 완료일 기준으로 7일 이내 신청 가능합니다.</li>
                                 <li>교환/반품하려는 상품은 처음 배송한 택배사에서 수거하므로 다른 택배사 이용은 불가능합니다.</li>
                              </ul>
                           
                           </div>
                         </div>
                       </div>
                       <div class="accordion-item">
                         <h2 class="accordion-header" id="flush-headingThree">
                           <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseThree" aria-expanded="false" aria-controls="flush-collapseThree">
                             교환/반품 배송비
                           </button>
                         </h2>
                         <div id="flush-collapseThree" class="accordion-collapse collapse" aria-labelledby="flush-headingThree" data-bs-parent="#accordionFlushExample">
                           <div class="accordion-body">
                              <ul class="guide">
                                 <li>단순변심으로 인한 교환/반품은 고객님께서 배송비를 부담하셔야 합니다.</li>
                                 <li>상품의 불량 또는 파손, 오배송의 경우에는 '내가바로 냥냥멍멍'에서 배송비를 부담합니다.</li>
                                 <li>제주, 도서산간 지역은 추가 배송비가 발생할 수 있습니다.</li>
                              </ul>
                           </div>
                         </div>
                       </div>
                       
                       <div class="accordion-item">
                         <h2 class="accordion-header" id="flush-headingFour">
                           <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseFour" aria-expanded="false" aria-controls="flush-collapseFour">
                             교환/반품이 불가능한 경우
                           </button>
                         </h2>
                         <div id="flush-collapseFour" class="accordion-collapse collapse" aria-labelledby="flush-headingFour" data-bs-parent="#accordionFlushExample">
                           <div class="accordion-body">
                              <ul class="guide">
                                 <li>교환/반품 요청 기간이 지난 경우</li>
                                 <li>포장이 훼손되어 상품 가치가 감소한 경우</li>
                                 <li>상품을 설치하거나 사용한 경우</li>
                                 <li>시간의 경과에 의하여 재판매가 곤란할 정도로 상품의 가치가 현저히 감소한 경우</li>
                                 <li>구성품을 분실하였거나 고객님의 부주의로 인한 파손/고장/오염으로 재판매가 불가능한 경우</li>
                              </ul>
                           </div>
                         </div>
                       </div>                 
                     </div>
               </div> <!-- 취소/교환/반품 끝 -->               
            </div>
         </div>
        </section>
        
       

      <script>
      function updateQuantity(action) {
          const quantityInput = document.getElementById("cartQuantity");
          const quantityDisplay = document.getElementById("quantityDisplay");
          const sellPrice = ${productDetail.product_price};
          const totalPrice = document.getElementById("totalPrice");
          const allTotalPrice = document.getElementById("allTotalPrice");

          let quantity = parseInt(quantityInput.value);

          if (action === 'add') {
              quantity++;
          } else if (action === 'del' && quantity > 1) {
              quantity--;
          }

          // 업데이트된 수량 반영
          quantityInput.value = quantity;
          quantityDisplay.textContent = quantity;

          // 총 금액 계산 및 반영
          const totalAmount = quantity * sellPrice;
          totalPrice.textContent = totalAmount.toLocaleString('ko-KR') + "원";
          allTotalPrice.textContent = totalAmount.toLocaleString('ko-KR') + "원";
      }
</script>

 <!-- 아코디언 -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>

    </body>
</html>