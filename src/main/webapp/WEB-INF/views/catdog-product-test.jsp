<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
			<input type="hidden" name="pageNum" value="${currentPage}">
    		<input type="hidden" name="pageSize" value="${pageSize}">
			<table class="table table-bordered">
				<tr>
					<th>검색어</th>
					<td><select name="searchType">
							<option value="product_name">상품명</option>
							<option value="product_code">상품코드</option>
							<option value="product_category">카테고리 번호</option>
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
					<td>
					<select>
							<option value="registerDate">생성일</option>							
					</select>
					 <input type="date" id="endDate" name="endDate"> - 
					 <input	type="date" id="startDate" name="startDate">
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
	            <button type="button" class="btn btn-danger btn-sm" style="border-radius: 8px;" onclick="submitDeleteForm()">상품 삭제</button>
        </form>
		</div>
		<div class="wrapper mt-5" id="productListContainer">
			<c:forEach var="productTest" items="${productTestList}">
		 		<div style="width: 1000px; height:auto;">
					<img alt="product_img" src="${pageContext.request.contextPath}/resources/upload/${productTest.product_img}">
				</div>
			</c:forEach>
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
	</div>
</body>
</html>