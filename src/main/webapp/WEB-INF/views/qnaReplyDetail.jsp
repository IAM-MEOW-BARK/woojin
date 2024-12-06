<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8" />
	<title>공지사항 게시글</title>
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

		.reply-label {
            display: inline-block;
            padding: 5px 10px;;
            background-color: #ff6600;
            color: white;
            border-radius: 4px;
            margin: 10px 5px;
            font-size: 11px;
        }
        .reply-content {
            margin-top: 5px;
            color: #333;
        }
        .button-container {
            text-align: center;
            margin-top: 20px;
        }
        .qnaList, .qnaUpdate, .qnaDelete {
            padding: 8px 17px;
            border: 1px solid #ff6600;
            background-color: #ffffff;
            border-radius: 4px;
            color: #ff6600;
            cursor: pointer;
            text-decoration: none;
            font-size: 11px;
        }
        .qnaUpdate, .qnaDelete {
        	border: 1px solid #727272;
            background-color: #ffffff;
            color: #727272;
        }
        .qnaList:hover, .qnaUpdate:hover, .qnaDelete:hover {
            border: 1px solid #ff6600;
            background-color: #ff6600;
            color: #ffffff;
        }
    </style>
</head>
<body>
	<%@ include file="include/board_nav.jsp"%>

    <div class="container">
        <!-- Q&A 상세 테이블 -->
        <table>
            <thead>
                <tr>
                    <th>상품명</th>
                    <td>${qnaDetail.product_name}</td>
                </tr>
            </thead>
            <tbody>
             	<tr>
                    <th>작성자</th>
                    <td>${qnaDetail.user_id}</td>
                </tr>
                <tr>
                    <th>작성일</th>
                    <td>${qnaDetail.qna_date}</td>
                </tr>
                <tr class="content-cell" style="height: 300px;" >
                    <th>내용</th>
	                    <td>${qnaDetail.qna_content}</td>
                </tr>
                
                <tr  class="reply-cell" style="height: 200px;">
                	<th>답변</th>
                	<td>${qnaDetail.qna_reply }</td>
                </tr>
            </tbody>
        </table>
        

        <!-- 전체보기 버튼 -->
        <div class="button-container">
            <a href="qnaList" class="qnaList">목록</a>
	       	<c:choose>
	       		<c:when test="${user_auth == 1}">
	       			<!-- 답변이 있는 경우에만 답변 수정/삭제 버튼 표시 -->
	           		<c:if test="${!empty qnaDetail.qna_reply}">
		       			<a href="qnaReplyUpdate?qna_no=${qnaDetail.qna_no}" class="qnaUpdate">답변수정</a>
		            	<a href="qnaReplyDelete?qna_no=${qnaDetail.qna_no}" class="qnaDelete" onclick="return confirm('답변을 삭제하시겠습니까?');">답변삭제</a>
		       		</c:if>
	       		</c:when>
       		</c:choose>
	       		
	       	
        </div>
    </div>    
</body>
</html>