<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 정보 확인</title>
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
				<form action="/checkPW" method="post">
					<div class="table-container">
						<h4>비밀번호 재확인</h4>
						<p>
							비밀번호를 입력해주세요.<br> 냥냥멍멍몰은 회원님의 개인정보를 신중히 취급하며, 회원님의 동의 없이는
							회원정보가 공개되지 않습니다.<br> 보다 다양한 혜택/서비스를 받으시려면 회원 정보를 최신으로
							유지해주세요.
						</p>
						<table class="table" style="text-align: center;">
							<tr>
								<th class="table-light">비밀번호</th>
								<td>
									<div style="text-align: center; max-width: 15em;">
										<input type="text" name="user_id" value="${user_id}" style="display: none;">
										<input class="form-control" type="password" name="password">
										<c:if test="${not empty errorMessage}">
											<p class="error">${errorMessage}</p>
										</c:if>
									</div>
								</td>
							</tr>
						</table>
					</div>
					<div class="d-flex justify-content-center">
						<input type="submit" class="btn"
							style="background-color: #ff6600; color: #ffffff; margin: 10px;"
							value="확인">
					</div>
				</form>
			</div>
		</div>
	</div>
</body>
</html>