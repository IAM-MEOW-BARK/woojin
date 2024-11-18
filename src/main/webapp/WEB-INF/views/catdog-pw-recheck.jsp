<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="true"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 재확인</title>
<style type="text/css">
	.container-wrapper {
        width: 800px;
        margin: 0 auto;
        margin-top: 30px;        
      }
      span {
      	font-size:12px;
      	color: #747474;
      }      
</style>
</head>
<body>
<%@ include file="include/header.jsp"%>
<%@ include file="include/mypageheader.jsp" %>
<div class="container-wrapper">
	<h6>
		<b>비밀번호 재확인</b>
	</h6>
	<span>회원님의 개인정보 보호를 위해 비밀번호를 입력해주세요.</span><br />
	<span>내가바로 냥냥 멍멍은 회원님의 개인정보를 신중히 취급하며, 회원님의 동의 없이는 회원정보가 공개되지 않습니다.</span><br />
	<span>보다 다양한 혜택/서비스를 받으시려면 회원 정보를 최신으로 유지해주세요.</span>
<hr class="opacity-100" style="border: 1px solid black;">
<form action="" method="post">
	<div class="p-2">
		<span>비밀번호</span>
		<input type="password" name="password" id="password" style="margin-left:20px;"><br/>
		<div class="mt-2">
			<span id="errorMessage" style="display: none; color: red; font-size: 10px;">입력 비밀번호와 확인 비밀번호가 불일치 합니다.</span>
		</div>
	</div>
	<hr>
</form>
<div style="text-align: center; margin-top: 40px;">
	<button type="submit" id="checkButton" class="btn" style="width: 100px; border-radius: 8px; background-color: #FF6600; color:#fff;">확인</button>
</div>
</div>
<script type="text/javascript">	
	document.getElementById("checkButton").addEventListener("click", function () {
    const password = document.getElementById("password").value;    
    const errorMessage = document.getElementById("errorMessage");

    if (password !== 1234) {
        errorMessage.style.display = "block"; // 메시지 표시
    }
    
    if (password == 1234) {
        errorMessage.style.display = "none"; // 메시지 숨김
        alert("비밀번호가 일치합니다.");
    }
});
</script>
</body>
</html>