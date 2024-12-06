<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>FAQ</title>
    <style>
        /* 전체 레이아웃 */
        body {
            margin: 0;
            padding: 20px;
        }
        .container {
            max-width: 1000px;
            margin: 0 auto;
            padding: 20px;
        }

        /* 네비게이션 스타일 */
        .division_nav ul {
            list-style: none;
            display: flex;
            justify-content: center;
            gap: 15px;
            margin: 20px 0;
        }
        .division_nav a {
            display: inline-block;
            padding: 8px 15px;
            border: 1px solid #ff6600;
            border-radius: 5px;
            color: #333;
            text-decoration: none;
            font-size: 12px;
            text-align: center;
        }
        .division_nav a.active {
            background-color: #ff6600;
            color: #fff;
            font-weight: bold;
        }
        .division_nav a:hover {
            background-color: #ff6600;
            color: #fff;
        }

        /* 테이블 스타일 */
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
            table-layout: fixed;
        }
        table th, table td {
            border-top: 1px solid #ccc;
            border-bottom: 1px solid #ccc;
            padding: 10px;
            text-align: center;
            font-size: 13px;
        }
        table th {
            background-color: #feebe1;
            font-weight: bold;
        }
		table th:nth-child(3), table td:nth-child(3) { 
		    width: 50%;
		    white-space: nowrap;
		    overflow: hidden; 
		    padding-left: 30px;
		    text-overflow: ellipsis; 
		}
        
        .faq-click {
            cursor: pointer;
        }
        .accordion-question{
        	text-align:left;
        }
        .accordion-content {
            display: none;
		    background-color: #f9f9f9;
		    
		    padding: 20px 20px; /* 위아래, 좌우 간격 */
		    line-height: 1.6; /* 줄 간격 */
            
        }
        .active-content {
            display: table-row;  
        }
        
		.faq-reply-content {
		    text-align: justify; /* 양쪽 정렬 */
		    white-space: pre-wrap; /* 줄바꿈 허용 */
		    
		}
.action-button {
    color: #adadad;
    text-decoration: none;
    font-size: 12px;
    border: none; /* 테두리 제거 */
    background: none; /* 배경색 제거 */
    margin: 5px 7px; /* 버튼 간 간격 */
    
    cursor: pointer; /* 커서 포인터 */
    padding: 0; /* 기본 버튼 패딩 제거 */
}

.action-button:hover {
    color: #ff3300; /* 호버 시 색상 변경 */
}

.action-buttons {
    display: flex; /* 가로로 나열 */
    
    justify-content: flex-end; /* 오른쪽 정렬 */
}

        /* 페이징 및 버튼 스타일 */
        .pagination-container {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin: 20px 0;
        }
        .pagination {
            display: flex;
            gap: 15px;
            margin: 0 auto;
        }
        .pagination a {
            text-decoration: none;
            color: #333;
            font-size: 12px;
        }
        .pagination a.active {
            color: #ff6600;
            font-weight: bold;
        }
        .write_button {
            padding: 8px 17px;
            cursor: pointer;
            font-size: 11px;
            border: 1px solid #ff6600;
            border-radius: 4px;
            background-color: #ffffff;
            color: #ff6600;
            text-decoration: none;
        }
        .write_button:hover {
            background-color: #ff6600;
            color: #ffffff;
        }


        
        /* 모달 스타일 */
        .modal {
            display: none;
            position: fixed;
            z-index: 1;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0, 0, 0, 0.4);
        }
        .modal-content {
            background-color: #fefefe;
            margin: 15% auto;
            padding: 20px;
            border: 1px solid #ccc;
            width: 30%;
            border-radius: 5px;
            text-align: center;
        }
         .modal-content h2 {
        margin-bottom: 10px; /* 제목과 입력창 간격 조절 */
    }

    #passwordInput {
        margin-top: 10px; /* 입력창 위치 조정 */
        margin-bottom: 20px; /* 입력창과 버튼 간격 조정 */
        padding: 10px;
        width: 80%;
        border-radius: 5px;
         border: 1px solid #ccc;
    }
        #passwordInput:focus {
        outline: none;
        border-radius: 5px; /* 기본 브라우저 포커스 제거 */
        border: 1px solid #ff6600; /* 포커스 시 테두리 색상 */
    }
    #passwordForm button {
        padding: 10px 20px; /* 버튼 내부 여백 */
        font-size: 11px; /* 글씨 크기 */
        border: 1px solid #ff6600;
        border-radius: 5px; /* 버튼 모서리 둥글게 */
        background-color: #ffffff; /* 배경색 */
        color:  #ff6600; /* 글씨 색 */
        cursor: pointer; /* 커서 포인터 */
    }

    #passwordForm button:hover {
      
            background-color: #ff6600;
            color: #ffffff;
    }
        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
            cursor: pointer;
        }
        .close:hover,
        .close:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }
    </style>
</head>
<body>
    <%@ include file="include/board_nav.jsp"%>

    <!-- 네비게이션 메뉴 -->
    <nav class="division_nav">
        <ul>
            <li><a href="faqList" class="${selectedDivision == null ? 'active' : ''}">전체</a></li>
	        <li><a href="faqList?faq_division=1" class="${selectedDivision == 1 ? 'active' : ''}">회원서비스</a></li>
	        <li><a href="faqList?faq_division=2" class="${selectedDivision == 2 ? 'active' : ''}">배송</a></li>
	        <li><a href="faqList?faq_division=3" class="${selectedDivision == 3 ? 'active' : ''}">주문/결제</a></li>
	        <li><a href="faqList?faq_division=4" class="${selectedDivision == 4 ? 'active' : ''}">반품/교환/취소</a></li>
	        <li><a href="faqList?faq_division=5" class="${selectedDivision == 5 ? 'active' : ''}">기타</a></li>
        </ul>
    </nav>

    <!-- FAQ 리스트 -->
    <div class="container">
        <table>
            <thead>
                <tr>
                    <th style="width:5%;">NO</th>
                    <th style="width:10%;">구분</th>
                    <th>내용</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="faq" items="${faqList}">
                    <!-- 질문 -->
                    <tr class="faq-click">
                        <td>${faq.faq_no}</td>
                       <td>
			                <c:choose>
			                    <c:when test="${faq.faq_division == 1}">회원서비스</c:when>
			                    <c:when test="${faq.faq_division == 2}">배송</c:when>
			                    <c:when test="${faq.faq_division == 3}">주문/결제</c:when>
			                    <c:when test="${faq.faq_division == 4}">반품/교환/취소</c:when>
			                    <c:otherwise>기타</c:otherwise>
			                </c:choose>
			            </td>
                        <td class="accordion-question">${faq.faq_question}</td>
                    </tr>
                    <tr class="accordion-content">
    <td colspan="3">
        <!-- 수정 및 삭제 버튼 -->
        <div class="action-buttons">
            <c:if test="${user_auth == 1}">
            	<form action="/faqUpdate">
            	<input type="hidden" name="faq_no" value="${faq.faq_no}">
            	
            	
            	<button type="submit"  class="action-button">수정</button>
            	</form>
               
                 <form action="/faqDelete" method="post" >
                            <input type="hidden" name="faq_no" value="${faq.faq_no}">
                            <button type="submit"class="action-button" onclick="return confirm('삭제하시겠습니까?');">삭제</button>
                 </form>
            </c:if>
        </div>
        <!-- FAQ 답변 -->
        <div class="faq-reply-content">${faq.faq_reply}</div>
    </td>
</tr>

					     
                </c:forEach>
            </tbody>
        </table>

        <!-- 페이징 및 글쓰기 버튼 -->
        <div class="pagination-container">
            <div class="pagination">
                <c:if test="${startPage > 1}">
                    <a href="faqList?pageNum=${startPage - 1}&pageListNum=${pageListNum - 1}">&lt;</a>
                </c:if>
                <c:forEach begin="${startPage}" end="${endPage}" var="page">
                    <a href="faqList?pageNum=${page}&pageListNum=${pageListNum}"
                       class="${currentPage == page ? 'active' : ''}">${page}</a>
                </c:forEach>
                <c:if test="${endPage < totalPage}">
                    <a href="faqList?pageNum=${endPage + 1}&pageListNum=${pageListNum + 1}">&gt;</a>
                </c:if>
            </div>
            <c:if test="${user_auth == 1}">
            	<a href="faqRegister" class="write_button">글쓰기</a> <!--  onclick="openModal()" -->
           	</c:if>
        </div>
    </div>
    
	   	 <!-- 모달 -->
	    <div id="passwordModal" class="modal">
	    <div class="modal-content">
	        <span class="close" onclick="closeModal()">&times;</span>
	        <h2>비밀번호 확인</h2>
	        <form id="passwordForm" onsubmit="return validatePassword()">
	            <input type="password" id="passwordInput" placeholder="비밀번호를 입력하세요">
	            <button type="submit">확인</button>
	        </form>
	    </div>
		</div>

    <!-- JavaScript for Accordion -->
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            const rows = document.querySelectorAll(".faq-click");

            rows.forEach(row => {
                row.addEventListener("click", function () {
                    const content = row.nextElementSibling;
                    if (content.classList.contains("active-content")) {
                        content.classList.remove("active-content");
                    } else {
                        document.querySelectorAll(".accordion-content").forEach(item => {
                            item.classList.remove("active-content");
                        });
                        content.classList.add("active-content");
                    }
                });
            });
        });
        
        const modal = document.getElementById("passwordModal");
        const password = "1234"; // 고정된 비밀번호

        function openModal() {
            modal.style.display = "block";
        }

        function closeModal() {
            modal.style.display = "none";
        }

        function validatePassword() {
            const input = document.getElementById("passwordInput").value;
            if (input === password) {
                closeModal();
                window.location.href = "faqRegister"; // 글쓰기 페이지로 이동
                return false; // 폼 제출 방지
            } else {
                alert("비밀번호가 일치하지 않습니다.");
                return false;
            }
        }
    </script>
</body>
</html>
