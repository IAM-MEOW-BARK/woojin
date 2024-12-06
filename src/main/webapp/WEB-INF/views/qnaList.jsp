<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Q&A</title>
    <style>
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
		table th:nth-child(1), table td:nth-child(1),
		table th:nth-child(5), table td:nth-child(5) { 
		    width: 10%; 
		}
		table th:nth-child(2), table td:nth-child(2) { 
		    width: 50%;
		    white-space: nowrap;
		    overflow: hidden; 
		    text-overflow: ellipsis; 
		    text-align: left;
		}
		table th:nth-child(2) {
			text-align: center;
			}
		table th:nth-child(3), table td:nth-child(3),
		table th:nth-child(4), table td:nth-child(4) { 
		    width: 15%;
		}
		a {
			text-decoration: none; 
	        color: inherit;
		}
		.qna-replyWrite {
		
            color: #727272;
            cursor: pointer;
		}
		.qna-reply {
			color: #ff6600
		}
		.qna-replyDetail {
			text-align: left;
			margin-left: 20px;
			
		}
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
         	margin-right: 20px;
            cursor: pointer;
            font-size: 11px;
            border: 1px solid #ff6600;
            border-radius: 4px;
            background-color: #ffffff;
            color: #ff6600;
        }
         .write_button:hover {
            background-color: #ff6600;
            color: #ffffff;
        }  
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
        <!-- 공지 리스트 테이블 -->
        <table>
            <thead>
                <tr>
                    <th>NO</th>
                    <th>내용</th>
                    <th>작성자</th>
                    <th>등록일</th>
                    <th>답변상태</th>
                </tr>
            </thead>
            <tbody>
				<c:forEach var="qna" items="${qnaList}">
				    <tr>
				        <td>${qna.qna_no}</td>
				        <td>
				            <c:choose>
				                <c:when test="${qna.qna_secret == 1}">
				                    <c:choose>
				                        <c:when test="${user_auth == 1}">
				                            <!-- 관리자는 비밀번호 없이 접근 가능 -->
				                            <a href="qnaDetail?qna_no=${qna.qna_no}">
				                                &#128274;&nbsp; ${qna.qna_content}
				                            </a>
				                        </c:when>
				                        <c:otherwise>
				                            <!-- 일반회원은 비밀번호 입력 필요 -->
				                            <a href="javascript:void(0);" onclick="openPasswordModal('${qna.qna_no}')">
				                                &#128274;&nbsp; 문의합니다
				                            </a>
				                        </c:otherwise>
				                    </c:choose>
				                </c:when>
				                <c:otherwise>
				                    <!-- 공개글 -->
				                    <a href="qnaDetail?qna_no=${qna.qna_no}">${qna.qna_content}</a>
                				</c:otherwise>
            			</c:choose>
				        </td>
				        <td>${qna.user_id}</td>
				        <td>${qna.qna_date}</td>
				        <c:choose>
				        	
				            <c:when test="${user_auth == 1 && empty qna.qna_reply}">
				                <td class="qna-replyWrite">
				                    <a href="qnaReply?qna_no=${qna.qna_no}">답변하기</a>
				                </td>
				            </c:when>
				           
				            <c:when test="${!empty qna.qna_reply}">
				                <td class="qna-reply">답변완료</td>
				            </c:when>
				            <c:otherwise>
				                <td style="color:gray;">답변대기</td> 
				            </c:otherwise>
				        </c:choose>
    				</tr>
    				<tr>
    					<!-- 0,유 - reply / 1,유 - i / 무x
	   						<c:if test="${!empty qna.qna_reply}">
	   							<td style="color: transparent;">${qna.qna_no }</td>
	   							<td class="qna-replyDetail" colspan="4">
	 								
	   								↳ <a href="qnaReplyDetail?qna_no=${qna.qna_no}">[RE] ${qna.qna_reply }</a>
	   							</td>
	   						</c:if>
	   					 -->
	   					
		   					 <c:choose>
		   					 	
		   					 	<c:when test="${qna.qna_secret == 1 && !empty qna.qna_reply }">
		   					 		<td style="color:transparent;">${qna.qna_no }</td>
		   					 		<td class="qna-replyDetail" colspan="4">
	   								↳ <a href="qnaReplyDetail?qna_no=${qna.qna_no}">&#128274;&nbsp; 답변입니다.</a>
	   								</td>
		   					 	</c:when>
		   					 	<c:when test="${qna.qna_secret == 0 && !empty qna.qna_reply }">
		   					 		<td style="color:transparent;">${qna.qna_no }</td>
		   					 		<td class="qna-replyDetail" colspan="4">
	   								↳ <a href="qnaReplyDetail?qna_no=${qna.qna_no}">[RE] ${qna.qna_reply }</a>
	   								</td>
		   					 	</c:when>
		   					 </c:choose>	
		   						
    				</tr>
				</c:forEach>
            </tbody>
        </table>
        
		<!-- 페이징 처리와 글쓰기 버튼 -->
        <div class="pagination-container">
            <!-- 페이징 처리 -->
            <div class="pagination">
                <c:if test="${startPage > 1}">
                    <a href="qnaList?pageNum=${startPage - 1}&pageListNum=${pageListNum-1}">&lt;</a>
                </c:if>
                <c:forEach begin="${startPage}" end="${endPage}" var="page">
                    <a href="qnaList?pageNum=${page}&pageListNum=${pageListNum}" 
                       class="${currentPage == page ? 'active' : ''}">${page}</a>
                </c:forEach>
                <c:if test="${endPage  < totalPage}">
                    <a href="qnaList?pageNum=${endPage + 1}&pageListNum=${pageListNum+1}">&gt;</a>
                </c:if>
            </div>
            
            <!-- 일반회원 글쓰기 버튼 -->
            <c:if test="${user_auth == 0}">
			    <a class="write_button" href="qnaRegister">글쓰기</a>
			</c:if>
        </div>
    </div>
    
    <!-- 비밀번호 입력 모달 -->
    <div id="passwordModal" class="modal">
        <div class="modal-content">
            <span class="close" onclick="closePasswordModal()">&times;</span>
            <h2>비밀번호를 입력하세요</h2>
            <form id="passwordForm" onsubmit="submitPassword(event)">
                <input type="password" id="passwordInput" placeholder="비밀번호 입력">
                <input type="hidden" id="qnaId">
                <button type="submit">확인</button>
            </form>
        </div>
    </div>

    <script>
        function openPasswordModal(qnaId) {
            const modal = document.getElementById("passwordModal");
            document.getElementById("qnaId").value = qnaId;
            modal.style.display = "block";
        }

        function closePasswordModal() {
            const modal = document.getElementById("passwordModal");
            modal.style.display = "none";
        }

        function submitPassword(event) {
            event.preventDefault();

            const qnaId = document.getElementById("qnaId").value;
            const password = document.getElementById("passwordInput").value;

            if (!qnaId.trim()) {
                alert("Q&A 번호가 올바르지 않습니다.");
                return;
            }
            if (!password.trim()) {
                alert("비밀번호를 입력해주세요.");
                return;
            }

        // 서버로 요청 전송
       window.location.href = "qnaDetail?qna_no=${qnaId}&qna_pwd=${password}";
    }

	document.addEventListener("DOMContentLoaded", function () {
	    // qna-reply 셀 가져오기
	    const replyCells = document.querySelectorAll("td.qna-reply");
	
	    replyCells.forEach(cell => {
	        if (!cell.textContent.trim()) {
	            // 내용이 비어 있으면 셀 비우기
	            cell.textContent = ""; 
	        } else {
	            // 내용이 있으면 "답변완료" 표시
	            cell.textContent = "답변완료";
	        }
	    });
	});
</script>
</body>
</html>
