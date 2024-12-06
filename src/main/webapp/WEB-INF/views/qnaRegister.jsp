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
		#product_name {
			width: 70%;
			padding: 10px;
			margin-right: 7px;
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
        <h2>문의하기</h2>
        
        <form action="qnaRegister" method="post">
        	<!--
        		<input type="hidden" name="user_id" value="${qnaRegister.user_id}">
        	 -->
            <div class="line"></div>
            <!-- 상품코드 -->
            <div class="form-group">
                <label for="code">상품명</label>
               <!-- 상품명 (사용자에게 보이는 필드) -->
				<input type="text" id="product_name" placeholder="상품을 검색하세요." readonly>
				<!-- 실제로 서버로 전송될 상품 코드 -->
				<input type="hidden" id="product_code_fk" name="product_code_fk">
                <button type="button" onclick="openSearchPopup()">상품검색</button>
            </div>
            <!-- 내용 -->
            <div class="form-group">
                <label for="content">내용</label>
                <textarea id="qna_content" name="qna_content" placeholder="내용을 입력하세요."></textarea>
            </div>
            <!-- 공개/비공개 -->
            <div class="form-group">
                <label>비밀글 여부</label>
                <div class="radio-group">
                    <label><input type="radio" name="qna_secret" value="0" checked> 공개글</label>
                    <label><input type="radio" name="qna_secret" value="1"> 비밀글</label>
                </div>
            </div>
            <!-- 비밀번호 -->
            <div class="form-group">
                <label for="password">비밀번호</label>
                <input type="password" id="qna_pwd" name="qna_pwd" placeholder="비밀번호를 입력하세요." disabled>
            </div>
            <div class="line"></div>
            <!-- 버튼 -->
            <div class="form-buttons">
                <button type="submit">등록</button>
                <button type="reset" onclick="history.back()">취소</button>
            </div>
        </form>
    </div>

    <script>
	    function openSearchPopup() {
	        window.open('productSearch?keyword=', '상품 검색', 'width=800,height=600,scrollbars=yes');
	    }
	
        const publicRadio = document.querySelector('input[name="qna_secret"][value="0"]');
        const privateRadio = document.querySelector('input[name="qna_secret"][value="1"]');
        const passwordInput = document.getElementById('qna_pwd');

        // 라디오 버튼 클릭 시 이벤트 처리
        publicRadio.addEventListener('change', () => {
            if (publicRadio.checked) {
                passwordInput.disabled = true; // 비활성화
                passwordInput.value = ""; // 입력값 초기화
            }
        });

        privateRadio.addEventListener('change', () => {
            if (privateRadio.checked) {
                passwordInput.disabled = false; // 활성화
            }
        });
    </script>
</body>

</html>