<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<%@ include file="include/head.jsp" %>
<head>
<meta charset="UTF-8">
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

input[type="text"] {
	height: 30px; /* 원하는 높이로 설정 */
	width: 250px; /* 원하는 너비로 설정 */
	box-sizing: border-box; /* 패딩과 보더를 포함하여 크기 조정 */
}

th {
	text-align: center;
	font-size: 14px;
}

td {
	vertical-align: middle;
}

.ck-editor__editable {
	min-height: 200px;
}
</style>
</head>
<body>
	<%@ include file="include/catdog-sidebar.jsp"%>
	<div class="main p-5">
		<h6>
			<strong>상품 수정</strong>
		</h6>
		<form method="post" action="/catdog-product-modified" enctype="multipart/form-data">
			<table class="table table-bordered">
				<tr>
					<th class="table-light">카테고리</th>
					<td><select name="product_category">
							<option value="1" ${product.product_category == 1 ? 'selected' : ''}>사료/간식</option>
            <option value="2" ${product.product_category == 2 ? 'selected' : ''}>장난감/토이</option>
            <option value="3" ${product.product_category == 3 ? 'selected' : ''}>목욕/케어</option>
            <option value="4" ${product.product_category == 4 ? 'selected' : ''}>산책/훈련</option>
            <option value="5" ${product.product_category == 5 ? 'selected' : ''}>의류/잡화</option>
					</select></td>
				</tr>
				<tr>
					<th class="table-light">상품 코드</th>
					<td><input type="number" id="product_code" name="product_code" value="${product.product_code}" disabled="disabled">
					<input type="hidden" id="product_code" name="product_code" value="${product.product_code}">						
				</tr>
				<tr>
					<th class="table-light">상품 명</th>
					<td><input type="text" id="product_name" name="product_name" value="${product.product_name}">
					</td>
				</tr>
				<tr>
					<th class="table-light">상품 가격</th>
					<td><input type="number" id="product_price" name="product_price" value="${product.product_price}">
					</td>
				</tr>
				<tr>
					<th class="table-light">상품 이미지 등록</th>
					<td>
						<div style="display: flex;">
							<div id="previewContainer"
								style="margin-top: 10px; width: 150px; height: 149px; border: 1px solid #9D9D9D; display: flex; justify-content: center; align-items: center;">
								<c:choose>
                    <c:when test="${not empty product.thumbnail_img}">
                        <img id="imagePreview" src="${pageContext.request.contextPath}/resources/upload/${product.thumbnail_img}" alt="Preview"
                            style="width: 148px; display: block;">
                    </c:when>
                    <c:otherwise>
                        <img id="cameraIcon" alt="" src="${pageContext.request.contextPath}/resources/bootstrap/images/camera.png">
                    </c:otherwise>
                </c:choose>
							</div>
							<div style="margin-top: 30px; margin-left: 20px;">
								<p style="color: #0F5BE9;">＊ 쇼핑몰에 기본으로 보여지는 상품이미지를 등록합니다.</p>
								<p style="color: #0F5BE9;">＊ 권장이미지 : 150px * 150px / 2MB 이하
									/ gif, png, jpg(jpeg)</p>
							</div>
						</div>
						<div style="margin-top: 10px; margin-left: 40px;">
							<button type="button" id="customUploadButton"
								class="btn btn-secondary btn-sm">등록하기</button>
							<!-- 실제 파일 선택 input (숨김 처리) -->
							<input type="file" id="imageUpload"  name="thumbnail_imgFile" value="${product.thumbnail_imgFile}" accept="image/*"
								style="display: none;">
						</div>
					</td>
				</tr>
				<tr>
					<th class="table-light">상품 상세 이미지</th>
					<td>
						<!-- <input type="text" id="product_img" name="product_img" placeholder="파일 경로가 여기에 표시됩니다"> -->
						<!-- <input type="file" id="imageDetailUpload" accept="image/*"> -->
					</td>
				</tr>
				<tr>
					<th class="table-light">상품 상세 설명</th>
					<td>
						<textarea id="classic" name="product_info">${product.product_info}</textarea>
					</td>
				</tr>
			</table>
			<div style="text-align: center;">
				<button type="submit" class="btn"
					style="width: 100px; border-radius: 8px; background-color: #FF6600; color:#fff;">상품 수정</button>
				<button type="button" class="btn btn-secondary"
					style="width: 100px; border-radius: 8px;" onclick="window.location.href='/catdog-product-list-admin'">취소</button>
			</div>
		</form>
	</div>
	<script src="https://cdn.ckeditor.com/ckeditor5/29.1.0/classic/ckeditor.js"></script>
	<script type="text/javascript">
		/* CKEditor  */
		 ClassicEditor
        .create(document.querySelector('#classic'))
        .then(function(editor) {
        	editor.ui.view.editable.element.style.height = '200px';
        })
        .catch(error => {
            console.error(error);
        });
		
		/* 상품 상세 이미지 */
		document.getElementById('customUploadButton').addEventListener('click',
				function() {
					document.getElementById('imageUpload').click();
		});

		document.getElementById('imageUpload').addEventListener('change',
			function(event) {
				const file = event.target.files[0]; // 업로드한 파일
				if (file) {
					const reader = new FileReader();
					reader.onload = function(e) {
						const previewImage = document
								.getElementById('imagePreview');
						previewImage.src = e.target.result; // 이미지 경로 설정
						previewImage.style.display = 'block'; // 이미지 보이기
						document.getElementById('cameraIcon').style.display = 'none';
					};
					reader.readAsDataURL(file); // 파일 읽기
				}
		});
		
		/* 이미지 경로 불러오기 */
	/* 	    document.getElementById('imageDetailUpload').addEventListener('change', function(event) {
        const file = event.target.files[0]; // 업로드한 파일
        if (file) {
            // 파일 이름을 첫 번째 입력 필드에 표시
            document.getElementById('product-detail-image').value = file.name;
        }
    }); */
		
	// 폼 유효성 검사
    document.querySelector('form').addEventListener('submit', function(event) {
        const productName = document.getElementById('product_name').value.trim();
        if (!productName) {
            alert('상품 명은 필수 입력 항목입니다.');
            event.preventDefault(); // 폼 제출 중단
        }
    });
	
   /*  document.querySelector('#productForm').addEventListener('submit', function (event) {
        event.preventDefault(); // 기본 제출 중단

        const formData = new FormData(this);

        // URL 수정
        const requestUrl = '/catdog-add-product'; // 정확한 URL로 변경
        console.log('AJAX 요청 URL:', requestUrl);

        // 상품 등록 요청
        $.ajax({
            url: requestUrl, // 수정된 URL 사용
            method: 'POST',
            data: formData,
            processData: false,
            contentType: false,
            success: function () {
                alert('상품이 등록되었습니다.');
                refreshProductList(); // 상품 목록 갱신 호출
            },
            error: function (error) {
                alert('상품 등록 중 오류가 발생했습니다.');
                console.error('AJAX 요청 오류:', error);
            }
        });
    });

    // 상품 목록 갱신 함수
    function refreshProductList() {
        $.ajax({
            url: '/catdog-product-list-admin', // 상품 목록 API
            method: 'GET',
            success: function (html) {
                $('#productListContainer').html(
                    $(html).find('#productListContainer').html()
                ); // 목록 컨테이너 내용만 갱신
            },
            error: function (error) {
                alert('상품 목록 갱신 중 오류가 발생했습니다.');
                console.error(error);
            }
        });
    } */
	</script>
</body>
</html>