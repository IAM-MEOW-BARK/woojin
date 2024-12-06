<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <title>Insert title here</title>
    <style type="text/css">
        /* 네비게이션 메뉴 스타일 */
        nav.topmenu {
            display: flex;
            justify-content: center;
            padding: 11px;
            font-weight: 400;
        }

        nav.topmenu ul {
            list-style: none;
            display: flex;
            padding: 0;
            margin: 0;
        }

        nav.topmenu li {
            margin: 0 10px;
            font-size: 13px;
        }

        nav.topmenu a {
            text-decoration: none;
            color: black;
        }

        nav.topmenu a:hover {
            color: #fea66b; 
        }

        nav.topmenu a.active {
            color: #ff6600; 
            font-weight: bold; 
        }

        nav.topmenu li:not(:last-child)::after {
            content: "ㅣ";
            margin-left: 16px;
            color: #ccc;
        }
    </style>
</head>
<body>
    <!-- 네비게이션 메뉴 -->
    <nav class="topmenu">
        <ul class="nav">
            <li class="notice"><a href="noticeList" class="menu-link">공지사항</a></li>
            <li class="review"><a href="reviewList" class="menu-link">리뷰게시판</a></li>
            <li class="qna"><a href="qnaList" class="menu-link">Q/A</a></li>
            <li class="faq"><a href="faqList" class="menu-link">자주묻는질문</a></li>
        </ul>
    </nav>

    <script>
        const currentPath = window.location.pathname.split('/').pop(); 
        const links = document.querySelectorAll('.menu-link');

        links.forEach(link => {
            const linkPath = link.getAttribute('href');
            if (linkPath === currentPath) {
                link.classList.add('active');
            } else {
                link.classList.remove('active'); 
            }
        });
    </script>
</body>
</html>
