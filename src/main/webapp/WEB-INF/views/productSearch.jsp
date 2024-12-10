<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>상품 검색</title>
    <style>
        .product-list {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            max-width: 1000px;
            margin: 20px auto;
        }
        .product-item {
            width: 200px;
            border: 1px solid #ccc;
            border-radius: 5px;
            padding: 10px;
            text-align: center;
        }
        .product-item img {
            max-width: 100%;
            height: auto;
            border-radius: 5px;
        }
        .product-item p {
            margin: 10px 0;
        }
        .search-container {
            max-width: 600px;
            margin: 0 auto 20px auto;
            text-align: center;
        }
    </style>
</head>
<body>
<!-- 검색 폼 -->
    <div class="search-container">
        <form action="productSearch" method="get">
            <input type="text" name="keyword" value="${keyword}" placeholder="상품명을 입력하세요" style="padding: 10px; width: 70%;">
            <button type="submit" style="padding: 10px 20px;">검색</button>
        </form>
    </div>

    <!-- 검색 결과 -->
    <div class="product-list">
        <c:forEach var="product" items="${productSearch}">
            <div class="product-item" onclick="selectProduct('${product.product_name}', '${product.product_code}')">
    <img src="${pageContext.request.contextPath}/resources/upload/${product.thumbnail_img}" alt="${product.product_name}">
    <p>${product.product_name}</p>
</div>

        </c:forEach>
    </div>
            
   <script>
   function selectProduct(productName, productCode) {
	    // 부모 창의 product_name 필드에 값을 설정
	    opener.document.getElementById('product_name').value = productName;

	    // 부모 창의 hidden 필드 product_code_fk에도 값을 설정
	    opener.document.getElementById('product_code_fk').value = productCode;

	    // 팝업 닫기
	    window.close();
	}

    </script>
</body>
</html>