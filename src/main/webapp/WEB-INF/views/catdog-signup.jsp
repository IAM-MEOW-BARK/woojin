<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<%@ include file="include/head.jsp" %>
<head>
<style type="text/css">
	 .container-wrapper {
        width: 500px;
        margin: 0 auto;
        margin-top: 30px;        
      }
      
      .email-input, .password-input, .name-input, .phone-input {
      	width: 467px; height: 53px; font-size: 1rem; border: 2px solid #f0f0f1; border-radius: 5px; padding: 15px;
      }
      
      input:focus {outline: none;} /* outline 테두리 없애기 */
      
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
</style>
<meta charset="UTF-8">
<title>회원가입</title>
</head>
<body>

<div class="container-wrapper">
	<div style="display: flex; justify-content: center;  width:500px; height:220px; overflow:hidden; margin:0 auto;">
        <img
          src="${pageContext.request.contextPath}/resources/bootstrap/images/CATDOGLogo.svg"
          alt="로고"
          style="width:100%; height:100%; object-fit:cover;"
        />
    </div>
    <form name="signup-frm" method="post">
	      <div>        
	        <input type="email" id="user_id" name="user_id" class="email-input" placeholder="&nbsp;&nbsp;&nbsp;&nbsp;이메일" onblur="emailCheck()" onblur="validateEmail()" required>
	        <label id="email-check-label" style="margin-left: 10px;"></label>
	      </div>
	      <div style="margin-top: 10px;">	        
	         <input type="password" id="password" name="password" class="password-input"  placeholder="&nbsp;&nbsp;&nbsp;&nbsp;비밀번호" oninput="checkPasswordMatch()" required>
	      </div>
	      <div style="margin-top: 10px;">	        
	         <input type="password" id="password-check" name="password-check" class="password-input"  placeholder="&nbsp;&nbsp;&nbsp;&nbsp;비밀번호 확인" oninput="checkPasswordMatch()" required>
	         <label id="password-check-label" style="margin-left: 10px; color: red;"></label>
	      </div>
	      <div style="margin-top: 10px;">	        
	         <input type="text" name="name" class="name-input"  placeholder="&nbsp;&nbsp;&nbsp;&nbsp;이름" required>
	      </div>
	      <div style="margin-top: 10px;">	        
	         <input type="text" id="phone_num" name="phone_num" class="phone-input"  placeholder="&nbsp;&nbsp;&nbsp;&nbsp;전화번호" required>	         	         
	      </div>
	      <!-- 옵션 -->
	      <div class="option-group">
	      	<div>
	      		<input type="checkbox" id="all-ok" name="selectall" id="allCheck" value="selectall"  onclick='selectAll(this)'>
	      		<label for="all-ok">모두 동의합니다.</label>
	      	</div>
	      	<div>
	      		<input type="checkbox" id="14-ok" name="check" value="1" class="normal" onclick="checkSelectAll()" style="margin-left:20px;" onclick="checkSelectAll()">
	      		<label for="14-ok">(필수) 본인은 만 14세 이상입니다.</label>
	      	</div>
	      	<div>
	      		<input type="checkbox" id="term-ok" name="check" value="1" class="normal" onclick="checkSelectAll()" style="margin-left:20px;" onclick="checkSelectAll()">
	      		<label for="term-ok">(필수) 이용약관</label>
	      		<a href="#" target="_blank" style="color:#004b91;" onclick="showModal(event)">약관 보기</a>
	      	</div>
	      	<div>
	      		<input type="checkbox" id="private-ok" name="check" value="1" class="normal" onclick="checkSelectAll()" style="margin-left:20px;" onclick="checkSelectAll()">
	      		<label for="private-ok">(필수) 개인정보수집 및 이용동의</label>
	      		<a href="catdog-term" id="private_click" style="color:#004b91;">약관 보기</a>
	      	</div>
	      </div>
	      <div class="modal-overlay" id="modalOverlay">
		  	<div class="modal">
			    <!-- 모달 헤더 -->
			    <div class="modal-header">
			      (필수) 개인정보 수집 및 이용 동의
			    </div>
			    <!-- 모달 본문 -->
			    <div class="modal-body">
			      <p>수집하는 개인정보 항목 / 수집 및 이용목적 / 보유 및 이용기간</p>
			      <table class="modal-table">
			        <thead>
			          <tr>
			            <th>목적</th>
			            <th>수집항목</th>
			            <th>보유 및 이용기간</th>
			          </tr>
			        </thead>
			        <tbody>
			          <tr>
			            <td>상품 구매</td>
			            <td>이름, 휴대전화번호, 이메일, 주소, 예금등록번호, 은행계좌정보, 신용카드정보</td>
			            <td>회원탈퇴 시 지체없이 파기</td>
			          </tr>
			          <tr>
			            <td>맞춤형 서비스 제공 및 서비스 개선</td>
			            <td>* IP주소, 방문일시, 서비스 이용기록, 접속 로그<br>* SNS계정으로 간편 가입 시 수집 동의 된 정보 (네이버, 카카오, 애플)</td>
			            <td>전자상거래에서 소비자보호에 관한 법률 등 관련 법령 규정에 따라 개인정보를 일정기간 보존</td>
			          </tr>
			          <tr>
			            <td>게시판 작성</td>
			            <td>아이디</td>
			            <td>회원탈퇴 시 지체없이 파기</td>
			          </tr>
			        </tbody>
			      </table>
			      <div class="modal-footer">
			        - 개인정보 수집 및 이용에 대한 동의를 거부할 권리가 있으며, 동의 거부 시 회원가입이 제한됩니다.
			      </div>
			    </div>
			    <!-- 닫기 버튼 -->
			    <button class="modal-close-btn" onclick="closeModal()">닫기</button>
			  </div>
			</div>
	      	<div>
	      <div class="login-button" style="margin-top: 5px;">
	        <button type="submit">가입하기</button>
          </div>
          <!-- 소셜 회원가입  -->
       <div class="social-container" style="text-align: center;">
    	<p class="easyway-text">간편한 회원가입</p>
    	<div class="social-login">
    		<div>
    			<a href="#">
    				<img alt="카카오" src="${pageContext.request.contextPath}/resources/bootstrap/images/btn_kakao.svg" >
    			</a>
   			</div>
   			<%-- <div>
    			<a href="#">
    				<img alt="네이버" src="${pageContext.request.contextPath}/resources/bootstrap/images/btn_naver.svg">
    			</a>
   			</div>
   			<div>
    			<a href="#">
    				<img alt="구글" src="${pageContext.request.contextPath}/resources/bootstrap/images/btn_google.svg">
    			</a>
   			</div> --%>
    	</div>
    </div>
    </div>
    </form>
</div>
<script type="text/javascript">
/* 핸드폰 번호 분류 */
// 포커스가 벗어날 때 실행
const phoneInput = document.getElementById("phone_num");

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

//체크박스 모두 선택
function selectAll(selectAllCheckbox) {
    const checkboxes = document.querySelectorAll('input[name="check"]');
    checkboxes.forEach(checkbox => checkbox.checked = selectAllCheckbox.checked);
}

// 개별 체크박스 상태 확인
function checkSelectAll() {
    const allCheckbox = document.getElementById("all-ok");
    const checkboxes = document.querySelectorAll('input[name="check"]');
    const allChecked = Array.from(checkboxes).every(checkbox => checkbox.checked);
    allCheckbox.checked = allChecked;
}

// 폼 제출 시 체크박스 확인
document.querySelector('form[name="signup-frm"]').addEventListener('submit', function (event) {
    const checkboxes = document.querySelectorAll('input[name="check"]');
    const allChecked = Array.from(checkboxes).every(checkbox => checkbox.checked);
    if (!allChecked) {
        alert("모든 필수 항목에 동의해야 합니다.");
        event.preventDefault();
    }
});

//모달 열기 함수
function showModal(event) {
  event.preventDefault(); // 기본 링크 동작 막기
  document.getElementById('modalOverlay').style.display = 'flex';
}

// 모달 닫기 함수
function closeModal() {
  document.getElementById('modalOverlay').style.display = 'none';
}

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

// 이메일 검증


// 이메일 중복 체크
let isEmailChecked = false; // 중복 확인 상태 추적
function emailCheck() {
	const email = document.getElementById("user_id").value;
    const emailCheckLabel = document.getElementById("email-check-label");
    
    function validateEmail() {
        const email = document.getElementById("user_id").value;
        const emailCheckLabel = document.getElementById("email-check-label");

        // 이메일 정규식 패턴
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

        // 이메일 형식 검증
        if (!emailRegex.test(email)) {
            emailCheckLabel.textContent = "유효한 이메일 형식이 아닙니다.";
            emailCheckLabel.style.color = "red";
            return false;
        } else {
            emailCheckLabel.textContent = ""; // 형식이 유효하면 메시지 제거
            return true;
        }
    }

    // 이메일 형식 검증 실패 시 중복 체크 중단
    if (!validateEmail()) {
        isEmailChecked = false;
        return;
    }
    
    $.ajax({
        url: "${pageContext.request.contextPath}/member/emailCheck",
        type: "POST",
        dataType: "JSON",
        data: { "user_id": $("#user_id").val() },
        success: function (data) {
        	if (data == 1) {
                emailCheckLabel.textContent = "중복된 이메일입니다.";
                emailCheckLabel.style.color = "red";
                isEmailChecked = false;
            } else if (data == 0) {
                emailCheckLabel.textContent = "사용 가능한 이메일입니다.";
                emailCheckLabel.style.color = "green";
                isEmailChecked = true;
            }
        },
        error: function () {
            alert("요청 처리 중 에러가 발생했습니다.");
            isEmailChecked = false;
        }
    });
}

//폼 제출 시 이메일 유효성 확인
document.querySelector('form[name="signup-frm"]').addEventListener('submit', function (event) {
    if (!validateEmail()) {
        alert("올바른 이메일을 입력해주세요.");
        event.preventDefault();
    }
});
</script>
</body>
</html>