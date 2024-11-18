<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>로그인 페이지</title>
    <style>
      .container-wrapper {
        width: 500px;
        margin: 0 auto;
        margin-top: 30px;        
      }
      
      .email-input, .password-input {
      	width: 467px; height: 35px; font-size: 1rem; border: 2px solid #f0f0f1; border-radius: 5px; padding: 15px;
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
	
	.signup-button button {
		width: 500px;
		height:60px;
		border: 1px solid #ff6600;
		background: #ffffff;
		color:#ff6600;
		font-size: 1rem;
		border-radius: 15px;
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
    </style>
  </head>
  <body>
    <div class="container-wrapper">
      <div style="display: flex; justify-content: center;  width:500px; height:300px; overflow:hidden; margin:0 auto;">
        <img
          src="${pageContext.request.contextPath}/resources/bootstrap/images/CATDOGLogo.svg"
          alt="로고"
          style="width:100%; height:100%; object-fit:cover;"
        />
      </div>
      <form method="post">
	      <div>        
	        <input type="email" name="user_id"  class="email-input" placeholder="&nbsp;&nbsp;&nbsp;&nbsp;아이디 또는 이메일을 입력해주세요">
	      </div>
	      <div style="margin-top: 10px;">	        
	         <input type="password" name="password" class="password-input"  placeholder="&nbsp;&nbsp;&nbsp;&nbsp;비밀번호를 입력해주세요">
	      </div>
	      <div class="login-button" style="margin-top: 20px;">
	        <button type="submit">로그인</button>
	        </div>
	      <div class="signup-button" style="margin-top: 20px;">
	        <button type="button" onclick="location.href=`catdog-signup`">회원가입</button>
	      </div>
      </form>
    </div>
    <div style="display: flex; justify-content: center; margin-top:15px;">
   		<a href="catdog-find-id" style="color: #7b7577">아이디 찾기&nbsp;</a> <span style="color: #7b7577">|</span> <a href="catdog-find-pw" style="color: #8b8b96">&nbsp;비밀번호 찾기</a>
    </div>
    <div class="social-container" style="text-align: center;">
    	<p class="easyway-text">간편하게 로그인/회원가입</p>
    	<div class="social-login">
    		<div>
    			<a href="#">
    				<img alt="카카오" src="${pageContext.request.contextPath}/resources/bootstrap/images/btn_kakao.svg" >
    			</a>
   			</div>
   			<div>
    			<a href="#">
    				<img alt="네이버" src="${pageContext.request.contextPath}/resources/bootstrap/images/btn_naver.svg">
    			</a>
   			</div>
   			<div>
    			<a href="#">
    				<img alt="구글" src="${pageContext.request.contextPath}/resources/bootstrap/images/btn_google.svg">
    			</a>
   			</div>
    	</div>
    </div>
  </body>
</html>
