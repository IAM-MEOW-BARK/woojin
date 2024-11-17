<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<%@ include file="head.jsp" %>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>내가바로 냥냥 멍멍 푸터</title>
</head>
<body>
  <footer class="footer bg-light py-4">
    <div class="container">
      <div class="row">
        <!-- Left Section -->
        <div class="col-md-8 d-flex align-items-center">
          <img src="${pageContext.request.contextPath}/resources/bootstrap/images/CATDOGLogo.svg" alt="Logo" style="width: 200px; margin-right: 10px;" />
          <div>
            <p class="mb-1">내가 바로 냥냥 멍멍</p>
            <p class="small text-muted">
              상호명: 내가 바로 냥냥 멍멍 | 대표: 김우진, 박나현, 최지혜 | 사업자등록번호: 108-18-12345<br />
              통신판매업 신고번호: 2024-수원인계-1234 | 대표번호: 031-123-5678<br />
              주소 : 경기 수원시 팔달구 권광로 146 벽산그랜드코아 401호<br />
              개인정보관리자 : 김박최 <br />
              메일 : abc@mbcacademy.com
            </p>
            <p class="small text-muted">© 2024 [펫모바]. All rights reserved.</p>
          </div>
        </div>
        <!-- Right Section -->
        <div class="col-md-4 text-md-end mt-5">
          <h5 class="fw-bold">CUSTOMER CENTER</h5>
          <p class="mb-0">📞 02-812-8530</p>
          <p class="small text-muted">운영시간: 09:00~18:00 <br /> 점심시간: 12:00~13:00</p>
        </div>
      </div>
    </div>
  </footer>
</body>
</html>