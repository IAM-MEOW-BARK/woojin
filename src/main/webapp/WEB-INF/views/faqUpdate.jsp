<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>FAQ</title>
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
		#faq_division {
			height: 40px;
			border: 1px solid #ccc;
            border-radius: 4px;
		}
        .form-group {
            display: flex;
            align-items: center;
            margin-bottom: 20px;
        }
        .form-group label {
            width: 10%; 
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
        /* 버튼 */
        .form-button {
            display: flex;
            justify-content: center;
            gap: 10px;
            margin-top: 40px; 
       		gap: 20px; 
        }
        button {
            padding: 8px 17px;
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
        <h2>FAQ 수정하기</h2>
        
        <form action="/faqUpdate" method="post">
        	<div class="line"></div>
        	 
        	  <!-- FAQ 번호 (hidden) -->
            <input type="hidden" name="faq_no" value="${faqUpdate.faq_no}">
            
            
        	 <!-- 구분 -->
			<div class="form-group">
			    <label for="faq_division">구분</label>
			    <select id="faq_division" name="faq_division">
			        <option value="" disabled>구분을 선택하세요</option>
			        <option value="1" ${faqUpdate.faq_division == 1 ? 'selected' : ''}>회원서비스</option> <!-- 삼항연산자 -->
			        <option value="2" ${faqUpdate.faq_division == 2 ? 'selected' : ''}>배송</option>
			        <option value="3" ${faqUpdate.faq_division == 3 ? 'selected' : ''}>주문/결제</option>
			        <option value="4" ${faqUpdate.faq_division == 4 ? 'selected' : ''}>반품/교환/취소</option>
			        <option value="5" ${faqUpdate.faq_division == 5 ? 'selected' : ''}>기타</option>
			    </select>
			</div>
            
            <!-- 질문 -->
            <div class="form-group">
                <label for="faq_question">질문</label>
                <input type="text" id="faq_question" name="faq_question" value="${faqUpdate.faq_question}">
            </div>

            <!-- 답변 -->
            <div class="form-group">
                <label for="content">답변</label>
                <textarea id="faq_reply" name="faq_reply" rows="%" required>${faqUpdate.faq_reply }</textarea>
            </div>

            <div class="line"></div>

            <!-- 버튼 -->
            <div class="form-button">
                <button type="submit">등록</button>
                <button type="reset" onclick="history.back()">취소</button>
            </div>
        </form>
    </div>
</body>
</html>
