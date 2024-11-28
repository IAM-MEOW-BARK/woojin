<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html>

<head>
<style type="text/css">
	 .container-wrapper {
	 	heightL auto;
	 	min-height: 100%;
	 	padding-bottom: 270px;
        width: 500px;
        margin: 0 auto;
       	transform: translateY(6rem);
       	
      }
      
      footer {
      	width: 100%;
      	height: 270px;
      	position: relative;
      	transform: translateY(0%);
      	display: flex;
      	align-items: center;
      	justify-content: center;azimuth: 
      }
      
      .email-input, .password-input, .name-input, .phone-input {
      	width: 467px; height: 20px; font-size: 1rem; border: 2px solid #f0f0f1; border-radius: 5px; padding: 15px; box-sizing: content-box;
      }
      
      .email-input:focus {
		border-color: #ff6600;
	}
	a {
		text-decoration-line: none;
	}
	
	button {
		cursor: pointer;
	}
	
	.login-button button {
	    width: 500px;
	    height: 60px;
	    border: none;
	    background: #ff6600;
	    color: #ffffff;
	    font-size: 1rem;
	    border-radius: 15px;
	    margin-top: 20px;
	}
	
	.login-button button:hover {
		background-color: #FF4D00;
		transition-duration :0.5s;
	}
	
	.option-group {
	    position: relative;
	    margin-top: 10px;
	}
	
	.social-container {
		margin-top: 40px;
	}
	
	.easyway-text {
		font-size: 12px;
		color: #8b8b96;
	}
	
	.easyway-text::before,
	.easyway-text::after {
	  content: "";
	  flex: 1;
	  border-bottom: 1px solid #ccc !important;
	  margin: 0 10px;
	}	
	
	.social-login div {
		display: inline-block;
		margin-top:10px;
	}
	
	.social-login div a:nth-child(1){
		margin: 0 10px 0 10px;
	}
	
	.social-login div a img {
		width: 40px; height: 40px;
	}
	
	.option-group div input,label {
		cursor: pointer;
	}
	
	 /* 모달 백그라운드 */
    .modal-overlay {
      position: fixed;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      background: rgba(0, 0, 0, 0.5);
      display: none; /* 처음에는 숨김 */
      justify-content: center;
      align-items: center;
      z-index: 999;
    }
    
    /* 모달 창 */
    .modal {
      width: 600px;
      background: white;
      border-radius: 8px;
      overflow: hidden;
      font-family: Arial, sans-serif;
    }

    /* 모달 헤더 */
    .modal-header {
      padding: 16px;
      font-weight: bold;
      border-bottom: 1px solid #ddd;
    }

    /* 모달 본문 */
    .modal-body {
      padding: 16px;
    }

    /* 테이블 스타일 */
    .modal-table {
      width: 100%;
      border-collapse: collapse;
      font-size: 14px;
    }

    .modal-table th, .modal-table td {
      padding: 8px;
      border: 1px solid #ddd;
      text-align: center;
    }

    /* 안내 문구 */
    .modal-footer {
      padding: 16px;
      font-size: 12px;
      color: #555;
    }

    /* 닫기 버튼 */
    .modal-close-btn {
      display: block;
      width: 100%;
      padding: 12px;
      background-color: #007bff;
      color: white;
      font-weight: bold;
      text-align: center;
      text-decoration: none;
      cursor: pointer;
      border: none;
    }

    .modal-close-btn:hover {
      background-color: #0056b3;
    }
    
   	button {
		cursor: pointer;
	}
	
	.login-button button {
	    width: 500px;
	    height: 60px;
	    border: none;
	    background: #ff6600;
	    color: #ffffff;
	    font-size: 1rem;
	    border-radius: 15px;
	    margin-top: 20px;
	}
	
	.login-button button:hover {
		background-color: #FF4D00;
		transition-duration :0.5s;
	}
	
	.signup-button button {
		width: 500px;
		height:60px;
		border: 1px solid #ff6600;
		background: #ffffff;
		color:#ff6600;
		font-size: 1rem;
		border-radius: 15px;
	}
</style>
<meta charset="UTF-8">
<title>회원가입</title>
</head>
<body>
<%@ include file="include/header.jsp"%>
<div class="container-wrapper">
	<div style="display: flex; justify-content: center;  width:500px; height:220px; overflow:hidden; margin:0 auto;">
        <img
          src="${pageContext.request.contextPath}/resources/bootstrap/images/CATDOGLogo.svg"
          alt="로고"
          style="width:100%; height:100%; object-fit:cover;"
        />
    </div>
    <h4>
    	<b>아이디 찾기</b>
	</h4>
    <c:if test="${empty user_id}">
        <form method="post" action="/catdog-findId">
            <div style="margin-top: 10px;">
                <input type="text" name="name" class="name-input" placeholder="&nbsp;&nbsp;&nbsp;&nbsp;이름" required>
            </div>
            <div style="margin-top: 10px;">
                <input type="text" name="phone_num" class="phone-input" id="phone-input" placeholder="&nbsp;&nbsp;&nbsp;&nbsp;전화번호" required>
            </div>
            <div class="login-button" style="margin-top: 5px;">
                <button type="submit">확인</button>
            </div>
        </form>
    </c:if>
    
    <c:if test="${not empty user_id}">
        <div style="margin-top: 20px;">
            <p>회원님의 아이디는 <strong>${user_id}</strong>입니다.</p>
            <!-- <a href="/catdog-login" style="color: blue;">로그인하기</a> -->
        </div>
        <div class="login-button" style="margin-top: 20px;">
	        <button type="button" onclick="location.href=`catdog-login`">로그인</button>
        </div>
         <div class="signup-button" style="margin-top: 20px;">
	        <button type="button" onclick="location.href=`catdog-find-pw`">비밀번호 찾기</button>
	      </div>
    </c:if>

    <!-- 아이디 없음 -->
    <c:if test="${not empty error}">
        <div style="margin-top: 20px; color: red;">
            <p>아이디가 존재하지 않습니다.</p>
        </div>
    </c:if>
</div>
<footer class="footer">
	<%@ include file="include/footer.jsp"%>
</footer>
<script type="text/javascript">
/* 핸드폰 번호 분류 */
// 포커스가 벗어날 때 실행
const phoneInput = document.getElementById("phone-input");

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
</script>
</body>
</html>