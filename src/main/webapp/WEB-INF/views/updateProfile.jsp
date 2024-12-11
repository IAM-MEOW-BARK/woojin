<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 정보 수정</title>
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

.hide {
	display: none;
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
				<form action="/updateProfile" method="post">
					<div class="table-container">
						<h4>내 정보 수정</h4>
						<table class="table" style="text-align: center;">
							<tr>
								<th class="table-light col-lg-1">이름</th>
								<td class="col-lg-5">
									<div style="text-align: center; max-width: 15em;">
										<input class="form-control" type="text" value="${name}" name="name" readonly>
									</div>
								</td>
							</tr>
							<tr>
								<th class="table-light">아이디</th>
								<td>
									<div style="text-align: center; max-width: 15em;">
										<input class="form-control" type="text" value="${user_id}" name="user_id" readonly>
									</div>
								</td>
							</tr>
							<tr>
								<th class="table-light">새 비밀번호</th>
								<td>
									<div style="text-align: center;">
										<input class="form-control" type="password" name="password" id="pass1" autocomplete="new-password" style="max-width: 15em;">
									</div>
								</td>
							</tr>
							<tr>
								<th class="table-light">새 비밀번호 확인</th>
								<td>
									<div style="text-align: center; display: flex;">
										<input class="form-control" type="password" id="pass2" autocomplete="new-password" style="max-width: 15em;"> <font id="checkPw" style="font-size: medium; margin-left: 1.5em;"></font>
									</div>
								</td>
							</tr>
							<tr>
								<th class="table-light">휴대전화 번호</th>
								<td>
									<div style="text-align: center; max-width: 15em;">
										<input class="form-control" type="text" value="${phone_num}" name="phone_num">
									</div>
								</td>
							</tr>
							<tr>
								<th class="table-light align-middle" style="text-align: center;">주소</th>
								<td>
									<div style="display: flex; align-items: center; gap: 10px; max-width: 18em;">
										<input class="form-control" type="text" id="zipCode" name="zipcode" value="${zipcode}" readonly>
										<button type="button" class="btn" style="background-color: #ff6600; color: #ffffff; white-space: nowrap; padding: 5px 10px; margin-bottom: 5px;" onclick="checkPost()">우편번호 검색</button>
									</div>
									<div style="text-align: center; max-width: 30em; margin: 5px;">
										<input class="form-control" type="text" id="address" name="address" size="50" value="${address}" readonly>
									</div>
									<div style="text-align: center; max-width: 30em; margin: 5px;">
										<input class="form-control" type="text" id="detailAddress" name="detailaddress" size="50" value="${detailaddress}">
									</div>
								</td>
							</tr>
						</table>
						<div class="d-flex justify-content-end">
							<a href="deleteUser"><span>회원 탈퇴</span></a>
						</div>
					</div>
					<div class="d-flex justify-content-center">
						<button type="button" class="btn btn-outline-secondary" onclick="location.href='mypage'" style="margin: 10px">취소</button>
						<input type="submit" class="btn" style="background-color: #ff6600; color: #ffffff; margin: 10px;" value="수정">
					</div>
				</form>
			</div>

		</div>
	</div>
	<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script>
		function checkPost() {
			new daum.Postcode(
					{
						oncomplete : function(data) {
							// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

							// 각 주소의 노출 규칙에 따라 주소를 조합한다.
							// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
							var addr = ''; // 주소 변수
							var extraAddr = ''; // 참고항목 변수

							//사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
							if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
								addr = data.roadAddress;
							} else { // 사용자가 지번 주소를 선택했을 경우(J)
								addr = data.jibunAddress;
							}

							// 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
							if (data.userSelectedType === 'R') {
								// 법정동명이 있을 경우 추가한다. (법정리는 제외)
								// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
								if (data.bname !== ''
										&& /[동|로|가]$/g.test(data.bname)) {
									extraAddr += data.bname;
								}
								// 건물명이 있고, 공동주택일 경우 추가한다.
								if (data.buildingName !== ''
										&& data.apartment === 'Y') {
									extraAddr += (extraAddr !== '' ? ', '
											+ data.buildingName
											: data.buildingName);
								}
								// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
								if (extraAddr !== '') {
									extraAddr = '(' + extraAddr + ')';
								}
								// 조합된 참고항목을 해당 필드에 넣는다.
								document.getElementById("detailAddress").value = extraAddr;

							} else {
								document.getElementById("detailAddress").value = '';
							}

							// 우편번호와 주소 정보를 해당 필드에 넣는다.
							document.getElementById('zipCode').value = data.zonecode;
							document.getElementById("address").value = addr;
							/* document.getElementById('postcode').value = data.zonecode;
							document.getElementById("address").value = addr; */
							// 커서를 상세주소 필드로 이동한다.
							document.getElementById("detailAddress").focus();
						}
					}).open();
		}
	</script>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

	<script type="text/javascript">
		function validateForm(event) {
			let pass1 = document.getElementById("pass1").value;
			let pass2 = document.getElementById("pass2").value;

			if (pass1 !== pass2) {
				alert("비밀번호가 일치하지 않습니다.");
				document.getElementById("pass2").value = "";
				document.getElementById("pass2").focus();
				return false; // 폼 제출 방지
			}

			return true; // 폼 제출 허용
		}

		// 폼의 submit 이벤트에 validateForm 연결
		document.querySelector("form").addEventListener("submit",
				function(event) {
					if (!validateForm()) {
						event.preventDefault(); // 폼 제출 중단
					}
				});
	</script>

	<script type="text/javascript">
		$(document).on('keyup', '#pass2', function() {
			let pass1 = $("#pass1").val();
			let pass2 = $("#pass2").val();
			console.log("Keyup event triggered");
			console.log("pass1:", pass1);
			console.log("pass2:", pass2);

			if (pass1 !== "" && pass2 !== "") {
				if (pass1 === pass2) {
					$("#checkPw").html('✅ 일치');
					$("#checkPw").css('color', 'green');
				} else {
					$("#checkPw").html('❌일치하지 않습니다.');
					$("#checkPw").css('color', 'red');
				}
			} else {
				$("#checkPw").html(''); // 비워둘 때는 메시지도 초기화
			}
		});
	</script>
</body>
</html>