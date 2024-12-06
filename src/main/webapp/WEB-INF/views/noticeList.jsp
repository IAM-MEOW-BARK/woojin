<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<%@ include file="include/head.jsp"%>
<head>
    <meta charset="UTF-8">
    <title>Q&A</title>
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
		table th:nth-child(4), table td:nth-child(4) { 
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
		
		table th:nth-child(3), table td:nth-child(3) { 
		    width: 20%;
		}
		a{
			text-decoration: none; /* 공통적으로 필요한 경우 */
	        color: inherit;
		}
		.pagination-container {
            display: flex;
            justify-content: space-between; /* 양쪽 정렬 */
            align-items: center; /* 세로 정렬 */
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
         	margin-right: 10px;
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
	<%@ include file="include/header.jsp"%>
	<%@ include file="include/board_nav.jsp"%>
    <div class="container">
        <!-- 공지글 리스트 테이블 -->
        <table>
            <thead>
                <tr>
                    <th>NO</th>
                    <th>제목</th>
                    <th>등록일</th>
                    <th>조회수</th>
                </tr>
            </thead>
            <tbody>
				<c:forEach var="notice" items="${noticeList}">
					<tr>
						<td>${notice.notice_no}</td>
						<td><a href="noticeDetail?notice_no=${notice.notice_no}&pageNum=${currentPage}&pageListNum=${pageListNum}">${notice.notice_title}</a></td>
						<td>${notice.notice_date}</td>
						<td>${notice.notice_readcnt}</td>
					</tr>
				</c:forEach>
            </tbody>
        </table>
        
		<!-- 페이징 처리와 글쓰기 버튼 -->
        <div class="pagination-container">
            <!-- 페이징 처리 -->
            <div class="pagination">
                <c:if test="${startPage > 1}">
                    <a href="noticeList?pageNum=${startPage - 1}&pageListNum=${pageListNum-1}">&lt;</a>
                </c:if>
                <c:forEach begin="${startPage}" end="${endPage}" var="page">
                    <a href="noticeList?pageNum=${page}&pageListNum=${pageListNum}" class="${currentPage == page ? 'active' : ''}">${page}</a>
                </c:forEach>
                <c:if test="${endPage  < totalPage}">
                    <a href="noticeList?pageNum=${endPage + 1}&pageListNum=${pageListNum+1}">&gt;</a>
                </c:if>
            </div>
            <!-- 글쓰기 버튼 -->
            <c:if test="${user_auth == 1}">
            	<a class="write_button" href="noticeRegister">글쓰기</a>
           	</c:if> 
        </div>
    </div>
</body>
</html>