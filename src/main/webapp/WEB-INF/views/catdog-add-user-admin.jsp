<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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

input[type="text, password"] {
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
			<strong>회원 추가</strong>
		</h6>
		<form action="catdog-user-list-admin" method="post">
			<table class="table table-bordered">
				<tr>
					<th class="table-light">이메일</th>
					<td><input type="text" id="email" name="email">
						<button type="button" class="btn btn-secondary btn-sm" onclick="emailCheck();">중복확인</button>
						 <label id="email-check-label" style="margin-left: 10px;"></label>
					</td>
				</tr>
				<tr>
					<th class="table-light">비밀번호</th>
					<td><input type="password" id="password" name="password" oninput="checkPasswordMatch()">
					</td>
				</tr>
				<tr>
					<th class="table-light">비밀번호 확인</th>
					<td><input type="password" id="password-check" name="password-check" oninput="checkPasswordMatch()">
					<label id="password-check-label" style="margin-left: 10px; color: red;"></label>
					</td>
				</tr>
				<tr>
					<th class="table-light" required>이름</th>
					<td><input type="text" id="user-name" name="user-name">
					</td>
				</tr>
				<tr>
					<th class="table-light" required>휴대전화</th>
					<td><input type="text" id="user-phone" name="user-phone" maxlength="11">
					</td>
				</tr>
				<tr>
					<th class="table-light">회원권한</th>
					<td>
						<select name="authorityType">
							<option value="normal-user">일반</option>
							<option value="admin">관리자</option>							
						</select> 
					</td>
				</tr>
			</table>
		</form>
		<div style="text-align: center;">
				<button type="submit" class="btn"
					style="width: 100px; border-radius: 8px; background-color: #FF6600; color:#fff;">회원 추가</button>
				<button type="reset" class="btn btn-secondary"
					style="width: 100px; border-radius: 8px;">취소</button>
			</div>
	</div>
	<script src="https://cdn.ckeditor.com/ckeditor5/29.1.0/classic/ckeditor.js"></script>
	<script type="text/javascript">	
		 /* 핸드폰 번호 분류 */
		 // 포커스가 벗어날 때 실행
		 const phoneInput = document.getElementById("user-phone");
		
        phoneInput.addEventListener("blur", () => {
            let value = phoneInput.value.replace(/\D/g, ""); // 숫자만 남기기
            if (value.length === 11) {
                phoneInput.value = value.replace(/(\d{3})(\d{4})(\d{4})/, "$1-$2-$3");
            } else if (value.length === 10) {
                phoneInput.value = value.replace(/(\d{3})(\d{3})(\d{4})/, "$1-$2-$3");
            } else {
                alert("유효한 전화번호를 입력하세요.");
                phoneInput.value = "";
            }
        });

        // 입력 시 숫자만 허용
        phoneInput.addEventListener("input", () => {
            phoneInput.value = phoneInput.value.replace(/\D/g, "");
        });
        
        // 비밀번호 확인
        function checkPasswordMatch() {
            const password = document.getElementById("password").value;
            const passwordCheck = document.getElementById("password-check").value;
            const passwordCheckLabel = document.getElementById("password-check-label");

            if (passwordCheck === "") {
                passwordCheckLabel.textContent = ""; // 비밀번호 확인 필드가 비어 있으면 메시지 없음
                return;
            }

            if (password === passwordCheck) {
                passwordCheckLabel.textContent = "비밀번호가 일치합니다.";
                passwordCheckLabel.style.color = "green";
            } else {
                passwordCheckLabel.textContent = "비밀번호가 일치하지 않습니다.";
                passwordCheckLabel.style.color = "red";
            }
        } 
        
	     // ajax
	     function emailCheck() {
		    $.ajax({
		        url: "${pageContext.request.contextPath}/member/emailCheck",
		        type: "POST",
		        dataType: "JSON",
		        data: { "user_id": $("#email").val() },
		        success: function (data) {
		            if (data == 1) {
		                alert("중복된 이메일입니다.");
		            } else if (data == 0) {
		                alert("사용 가능한 이메일입니다.");
		            }
		        },
		        error: function () {
		            alert("요청 처리 중 에러가 발생했습니다.");
		        }
		    });
		}
	</script>
</body>
</html>