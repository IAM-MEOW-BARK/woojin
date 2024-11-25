<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="true"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="0" />
<title>Insert title here</title>
<style type="text/css">
body {
	display: flex;
	min-height: 100vh;
	margin: 0;
}

#sidebar {
	width: 260px; /* Sidebar의 고정 너비 */
	background-color: #0e2238;
}

.date-buttons button {
	border: 1px solid #bbb;
	background-color: white;
	padding: 3.5px 8px;
	margin-right: 5px;
	font-size: 14px;
	cursor: pointer;
	outline: none;
	color: #696767;
}

.date-buttons button:hover {
	background-color: #e6e6e6;
}

.date-buttons button:focus {
	border-color: #888;
	background-color: #ddd;
}

select, input[type="text"] {
	height: 30px; /* 원하는 높이로 설정 */
	width: 200px; /* 원하는 너비로 설정 */
	box-sizing: border-box; /* 패딩과 보더를 포함하여 크기 조정 */
}

th {
    text-align: center;
}

td {
	vertical-align: middle;
}

.pagination-container {
            display: flex;
            justify-content: space-between; /* 양쪽 정렬 */
            align-items: center; /* 세로 정렬 */
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
</style>
</head>
<body>
	<%@ include file="include/catdog-sidebar.jsp"%>
	<div class="main p-5">
		<h6>
			<strong>전체 상품 리스트</strong>
		</h6>
		<form action="searchProduct" method="post">
			<table class="table table-bordered">
				<tr>
					<th>검색어</th>
					<td><select name="searchType">
							<option value="productName">상품명</option>
							<option value="productCode">상품코드</option>
							<option value="categoriName">카테고리명</option>
					</select> <input type="text" name="searchKeyword" placeholder="검색어 입력">
					</td>
				</tr>
				<tr>
					<th>상품 가격</th>
					<td><input type="text" name="priceMin" placeholder="상품가격 입력">
						<span>원 이상 &nbsp;</span> <input type="text" name="priceMax"
						placeholder="상품가격 입력"> <span>원 이하</span></td>
				</tr>
				<tr>
					<th>기간</th>
					<td><select name="dateType">
							<option value="registerDate">등록일</option>
							<option value="updateDate">수정일</option>
					</select> <input type="date" id="endDate" name="endDate"> - <input
						type="date" id="startDate" name="startDate">
						<div class="date-buttons" style="display: inline-block;">
							<button type="button" onclick="setDate(-1)">1일</button>
							<button type="button" onclick="setDate(-3)">3일</button>
							<button type="button" onclick="setDate(-7)">일주일</button>
							<button type="button" onclick="setDate(-30)">한달</button>
						</div></td>
				</tr>
			</table>
			<div style="text-align: right;">
				<button type="submit" class="btn btn-primary btn-sm"
					style="width: 70px; border-radius: 8px;">검색</button>
				<button type="reset" class="btn btn-secondary btn-sm"
					style="width: 70px; border-radius: 8px;">초기화</button>
			</div>
		</form>
		<hr style="color: black">
		
		
		<div style="display: flex; justify-content: space-between;">
			<div>
				<form id="deleteForm" action="catdog/deleteProduct" method="post">
	            <input type="hidden" name="selectedCode" id="hiddenSelectedIds">
	            <button type="button" class="btn btn-danger btn-sm" style="border-radius: 8px;">상품 삭제</button>
        </form>
			</div>
			<div>
				<button type="submit" class="btn btn-sm"
					style="border-radius: 8px; background-color: #9A106C; color: white;">상품
					수정</button>
				<button type="submit" class="btn btn-sm"
					style="border-radius: 8px; background-color: #FF6600; color: white;">상품
					등록</button>
			</div>
		</div>
		<div class="wrapper mt-5" id="productListContainer">
			<table class="table product-list-table">
				<thead>
					<tr>
						<th class="table-light text-center">
							<input type="checkbox">
						</th>
						<th class="table-light text-center">상품코드</th>						
						<th class="table-light text-center">이미지</th>
						<th class="table-light text-center">카테고리</th>
						<th class="table-light text-center">상품명</th>
						<th class="table-light text-center">등록일</th>
						<th class="table-light text-center">수정일</th>
						<th class="table-light text-center">가격</th>
						<th class="table-light text-center">관리</th>
					</tr>
				</thead>
				<tbody>
					<tr>
					<c:forEach var="product" items="${productList}">
							 	<tr>
							 		 <td>
				                            <input type="checkbox" name="selectedCheckbox" value="${product.product_code}">
				                        </td>     			 	
								 	<td style="text-align: center;">${product.product_code}</td>
								 	<td class="text-center">
										<img alt="thumbnail_image" src="${pageContext.request.contextPath}/resources/upload/${product.thumbnail_img}"  style="width: 30px; height: auto;">
									</td>
								 	<td style="text-align: center;">
							            <c:choose>
							                <c:when test="${product.product_category == 1}">
							                    사료/간식
							                </c:when>
							                <c:when test="${product.product_category == 2}">
							                    장난감/토이
							                </c:when>
							                <c:when test="${product.product_category == 3}">
							                    목욕/케어
							                </c:when>
							                <c:when test="${product.product_category == 4}">
							                    산책/훈련
							                </c:when>
							                <c:when test="${product.product_category == 5}">
							                    의류/잡화
							                </c:when>
							            </c:choose>
							        </td>			
								 	<td>${product.product_name}</td>
								 	<td style="text-align: center;">${product.product_regdate}</td>
								 	<td style="text-align: center;">${product.product_update}</td>
								 	<td style="text-align: right;">${product.product_price}</td>
								 	<td style="text-align: center;">
								 		<button type="button" class="btn btn-secondary btn-sm" style="border-radius: 8px; color: white;'">
											수정</button>
								 	</td>
						 	</tr>
						</c:forEach>	
					
					
				</tbody>
			</table>
			<br>
			<div></div>
			<br>
		</div>
		
		 <div class="pagination-container">
            <div class="pagination">
                <c:if test="${startPage > 1}">
                    <a href="catdog-product-list-admin?pageNum=${startPage - 1}&pageListNum=${pageListNum - 1}">&lt;</a>
                </c:if>
                <c:forEach begin="${startPage}" end="${endPage}" var="page">
                    <a href="catdog-product-list-admin?pageNum=${page}&pageListNum=${pageListNum}"
                       class="${currentPage == page ? 'active' : ''}">${page}</a>
                </c:forEach>
                <c:if test="${endPage < totalPage}">
                    <a href="catdog-product-list-admin?pageNum=${endPage + 1}&pageListNum=${pageListNum + 1}">&gt;</a>
                </c:if>
            </div>
        </div>
		<!-- <div style="text-align: center;">
			<a href="#"><</a>
			<a href="#">&nbsp; 1 &nbsp; 2 &nbsp;</a>					
			<a href="#">></a>
		</div> -->
	</div>
	<script type="text/javascript">
		window.onload = function () {
	        if (!window.location.href.includes('refreshed')) {
	            // 페이지 URL에 'refreshed'가 없으면 추가하고 새로고침
	            console.log("갱신 되었습니다~");
	            window.location.href = window.location.href + (window.location.href.includes('?') ? '&' : '?') + 'refreshed=true';
	        }
	    };
	
		// 페이지 로드 시 시작 날짜를 오늘로 설정
		window.onload = function() {
			const today = new Date().toISOString().split('T')[0];
			document.getElementById("startDate").value = today;
		};

		// 종료 날짜 설정 함수
		function setDate(daysAgo) {
			const today = new Date();
			const targetDate = new Date(today);
			targetDate.setDate(today.getDate() + daysAgo);
			document.getElementById("endDate").value = targetDate.toISOString()
					.split('T')[0];
		}
	</script>
</body>
</html>