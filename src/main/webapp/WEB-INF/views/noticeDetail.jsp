<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8" />
	<title>공지사항</title>
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
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
            table-layout: fixed;
        }
        table th, table td {
            border: 1px solid #ccc;
            padding: 10px;
            font-size: 13px;
        }
        table th {
            background-color: #feebe1;
            font-weight: bold;
            text-align: center;
            width: 5%;
        }
        table td {
        	padding-left: 20px;
            white-space: normal;
            word-wrap: break-word;
            line-height: 1.6;
            text-align: left;
        }       
        tbody {
	        height: 500px;
	    }
        /* 버튼 스타일 */
        .button-container {
            text-align: center;
            margin-top: 20px;
        }
        .noticeList, .noticeUpdate, .noticeDelete {
            padding: 8px 17px;
            border: 1px solid #ff6600;
            background-color: #ffffff;
            border-radius: 4px;
            color: #ff6600;
            cursor: pointer;
            text-decoration: none;
            font-size: 11px;
        }       
        .noticeUpdate, .noticeDelete {
        	border: 1px solid #727272;
            background-color: #ffffff;
            color: #727272;
        }
        .noticeList:hover, .noticeUpdate:hover, .noticeDelete:hover {
         	border: 1px solid #ff6600;
            background-color: #ff6600;
            color: #ffffff;
            text-decoration: none;
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
        	margin-bottom: 10px;
   		}
	    #passwordInput {
	        margin-top: 10px;
	        margin-bottom: 20px; 
	        padding: 10px;
	        width: 80%;
	        border-radius: 5px;
	         border: 1px solid #ccc;
	    }
        #passwordInput:focus {
        outline: none;
        border-radius: 5px; 
        border: 1px solid #ff6600; 
   		}
	    #passwordForm button {
	        padding: 10px 20px; 
	        font-size: 11px; 
	        border: 1px solid #ff6600;
	        border-radius: 5px; 
	        background-color: #ffffff; 
	        color:  #ff6600; 
	        cursor: pointer; 
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

    <div class="container">
        <!-- 공지사항 상세 테이블 -->
        <table>
            <thead>
                <tr>
                    <th>제목</th>
                    <td>${noticeDetail.notice_title}</td>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <th>내용</th>
                    <td>${noticeDetail.notice_content}</td>
                </tr>
            </tbody>
        </table>

        <!-- 전체보기 버튼 -->
        <div class="button-container">
        	<a href="backToList?notice_no=${noticeDetail.notice_no}">backToList</a>
            <a href="noticeList?pageNum=${pageNum}&pageListNum=${pageListNum}" class="noticeList">목록</a>
            
             <!-- user_auth가 1일 때, 수정/삭제 버튼 -->
            <c:if test="${user_auth == 1}">
	            <a href="noticeUpdate?notice_no=${noticeDetail.notice_no}" class="noticeUpdate">수정</a>
	            <a href="noticeDelete?notice_no=${noticeDetail.notice_no}" class="noticeDelete" onclick="return confirm('삭제하시겠습니까?');">삭제</a> 
            </c:if>
        </div>
    </div>

    <!-- 비밀번호 확인 모달 -->
    <div id="passwordModal" class="modal">
    <div class="modal-content">
        <span class="close" onclick="closeModal()">&times;</span>
        <h2>비밀번호 확인</h2>
        <form id="passwordForm" onsubmit="return validatePassword()">
            <input type="password" id="passwordInput" placeholder="비밀번호를 입력하세요" />
            <button type="submit">확인</button>
        </form>
    </div>
	</div>

<script>
    const modal = document.getElementById("passwordModal");
    const password = "1234"; // 고정된 비밀번호

    // 모달 열기
    function openModal() {
        modal.style.display = "block";
    }
    // 모달 닫기
    function closeModal() {
        modal.style.display = "none";
    }
    // 비밀번호 검증 및 삭제 처리
    function validatePassword() {
        const inputPassword = document.getElementById("passwordInput").value;
        if (inputPassword === password) {
            closeModal();

            // 서버에 삭제 요청
            const noticeNo = "${noticeDetail.notice_no}";
            fetch(`noticeDelete?notice_no=${noticeNo}`, {
                method: "POST",
            })
                .then((response) => {
                    if (response.ok) {
                        alert("삭제되었습니다.");
                        window.location.href = "noticeList"; // 목록으로 이동
                    } else {
                        alert("삭제에 실패했습니다.");
                    }
                })
                .catch((error) => {
                    console.error("Error:", error);
                    alert("오류가 발생했습니다.");
                });
        } else {
            alert("비밀번호가 일치하지 않습니다.");
        }
        return false; // 폼 제출 방지
    }

    // 모달 외부 클릭 시 닫기
    window.onclick = function (event) {
        if (event.target === modal) {
            closeModal();
        }
    };
</script>
</body>
</html>