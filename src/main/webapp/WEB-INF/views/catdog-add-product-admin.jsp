<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
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
			<strong>상품 등록</strong>
		</h6>
		<form action="searchProduct" method="post">
			<table class="table table-bordered">
				<tr>
					<th class="table-light">카테고리</th>
					<td><select name="searchType">
							<option value="snack" id="snack" name="snack">사료/간식</option>
							<option value="toy" id="toy" name="toy">장난감/토이</option>
							<option value="bath" id="bath" name="bath">목욕/케어</option>
							<option value="outdoor" id="outdoor" name="outdoor">산책/훈련</option>
							<option value="cloth" id="cloth" name="cloth">의류/잡화</option>
					</select></td>
				</tr>
				<tr>
					<th class="table-light">상품 코드</th>
					<td><input type="text" id="product-code" name="product-code">
						<button class="btn btn-secondary btn-sm">중복확인</button></td>
				</tr>
				<tr>
					<th class="table-light">상품 명</th>
					<td><input type="text" id="product-name" name="product-name">
					</td>
				</tr>
				<tr>
					<th class="table-light">상품 가격</th>
					<td><input type="text" id="product-price" name="product-price">
					</td>
				</tr>
				<tr>
					<th class="table-light">상품 옵션</th>
					<td>
						<div style="display: flex">
							<div style="width: 60px;">
								<span>사이즈 &nbsp;</span>
							</div>
							<div>
								<input type="checkbox" id="size-s" name="size-s"> <label>S
									&nbsp;</label> <input type="checkbox" id="size-m" name="size-m">
								<label>M &nbsp;</label> <input type="checkbox" id="size-l"
									name="size-l"> <label>L</label>
							</div>
						</div>
						<div style="display: flex">
							<div style="width: 60px;">
								<span>무게 &nbsp;</span>
							</div>
							<div>
								<input type="checkbox" id="weight-500" name="weight-500">
								<label>500g &nbsp;</label> <input type="checkbox"
									id="weight-1000" name="weight-1000"> <label>1kg
									&nbsp;</label> <input type="checkbox" id="weight-2000"
									name="weight-2000"> <label>2kg &nbsp;</label> <input
									type="checkbox" id="weight-3000" name="weight-3000"> <label>3kg
									&nbsp;</label> <input type="checkbox" id="weight-5000"
									name="weight-5000"> <label>5kg</label>
							</div>
						</div>
					</td>
				</tr>
				<tr>
					<th class="table-light">상품 이미지 등록</th>
					<td>
						<form>
							<div style="display: flex;">
								<div id="previewContainer"
									style="margin-top: 10px; width: 150px; height: 149px; border: 1px solid #9D9D9D; display: flex; justify-content: center; align-items: center;">
									<img id="cameraIcon" alt=""
										src="${pageContext.request.contextPath}/resources/bootstrap/images/camera.png">
									<img id="imagePreview" src="" alt="Preview"
										style="width: 148px; display: none;">
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
								<input type="file" id="imageUpload" accept="image/*"
									style="display: none;">
								
							</div>
						</form>
					</td>
				</tr>
				<tr>
					<th class="table-light">상품 상세 이미지</th>
					<td>
						<input type="text" id="product-detail-image" name="product-detail-image" placeholder="파일 경로가 여기에 표시됩니다">
						<input type="file" id="imageDetailUpload" accept="image/*">
					</td>
				</tr>
				<tr>
					<th class="table-light">상품 상세 설명</th>
					<td>
						<textarea id="classic"></textarea>
					</td>
				</tr>
			</table>
			<div style="text-align: center;">
				<button type="submit" class="btn"
					style="width: 100px; border-radius: 8px; background-color: #FF6600; color:#fff;">상품 등록</button>
				<button type="reset" class="btn btn-secondary"
					style="width: 100px; border-radius: 8px;">취소</button>
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
		    document.getElementById('imageDetailUpload').addEventListener('change', function(event) {
        const file = event.target.files[0]; // 업로드한 파일
        if (file) {
            // 파일 이름을 첫 번째 입력 필드에 표시
            document.getElementById('product-detail-image').value = file.name;
        }
    });
	</script>
</body>
</html>