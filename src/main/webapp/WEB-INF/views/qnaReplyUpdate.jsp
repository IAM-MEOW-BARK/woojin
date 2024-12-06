<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>상품 문의</title>
    <style type="text/css">
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
		.line {
		    border-top: 1px solid #ccc; 
		    margin: 20px 0;           
		}
        .form-group {
            display: flex;
            align-items: center;
            margin-bottom: 20px;
        }
        .form-group label {
            width: 10%; /* 레이블 넓이 */
            font-weight: 500;
            color: #333;
        }
        .form-group input,
        .form-group textarea {
            width: 80%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 14px;
        }
		
        .form-group input[type="password"] {
        	width: 15%;
        }
        .form-group input:focus,
		.form-group textarea:focus {
		    border: 1.5px solid #ff6600;
		    outline: none;
		}
        textarea {
            height: 300px;
        }
        #qna_reply {
        	height: 100px;
        }
        .radio-group {
            display: flex;
            gap: 65px;
            align-items: center;
        }
		.radio-group label {
		    display: inline-flex; 
		    align-items: center;
		    gap: 5px; 
		    white-space: nowrap;
		}
        .form-buttons {
            display: flex;
            justify-content: center;
            gap: 10px;
            margin-top: 40px; 
       		gap: 20px; 
        }
        button {
            padding: 8px 17px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 11px;
        }
        button[type="submit"] {
        	border: 1px solid #ff6600;
            background-color: #ffffff;
            color: #ff6600;
        }
        button[type="reset"] {
            border: 1px solid #727272;
            background-color: #ffffff;
            color: #727272;
        }
        button[type="submit"]:hover,
        button[type="reset"]:hover {
        	border: 1px solid #ff6600;
            background-color: #ff6600;
            color: #ffffff;
        }  
    </style>
</head>
<body>
	<%@ include file="include/board_nav.jsp"%>
    <div class="container">
        <h2>답변수정</h2>
        
        <form action="qnaReplyUpdate" method="post">
        <!-- 숨겨진 필드 (qna_no 전달) -->
 		<input type="hidden" name="qna_no" value="${qnaReplyUpdate.qna_no}">
            <div class="line"></div>
             
            <!-- 상품코드 -->
            <div class="form-group">
                <label for="name">상품명</label>
                <input type="text" id="product_name" name="product_name" value="${qnaReplyUpdate.product_name}" disabled>
            </div>

            <!-- 내용 -->
            <div class="form-group">
                <label for="content">내용</label>
                <textarea id="qna_content" name="qna_content" disabled>${qnaReplyUpdate.qna_content}</textarea>
            </div>
            
            <!-- 답변 -->
            <div class="form-group">
                <label for="content">답변</label>
                <textarea id="qna_reply" name="qna_reply">${qnaReplyUpdate.qna_reply }</textarea>
            </div>
            
           
            <div class="line"></div>

            <!-- 버튼 -->
            <div class="form-buttons">
                <button type="submit">등록</button>
                <button type="reset" onclick="history.back()">취소</button>
            </div>
        </form>
    </div>

   
   
</body>

</html>
