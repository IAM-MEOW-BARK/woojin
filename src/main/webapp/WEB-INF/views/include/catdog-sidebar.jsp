<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Sidebar With Bootstrap</title>
<link href="https://cdn.lineicons.com/4.0/lineicons.css"
	rel="stylesheet" />
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ"
	crossorigin="anonymous">
<style type="text/css">
@import
	url('https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap')
	;

::after, ::before {
	box-sizing: border-box;
	margin: 0;
	padding: 0;
}

a {
	text-decoration: none;
}

li {
	list-style: none;
}

h1 {
	font-weight: 600;
	font-size: 1.5rem;
}

body {
	font-family: 'Poppins', sans-serif;
}

.wrapper {
	display: flex;
}

.main {
	min-height: 100vh;
	width: 80%;
	overflow: hidden;
	transition: all 0.35s ease-in-out;
	margin: 0 auto;	
}

#sidebar {
	width: 70px;
	min-width: 70px;
	z-index: 1000;
	transition: all .25s ease-in-out;
	background-color: #0e2238;
	display: flex;
	flex-direction: column;
}

#sidebar.expand {
	width: 260px;
	min-width: 260px;
}

.toggle-btn {
	background-color: transparent;
	cursor: pointer;
	border: 0;
	padding: 1rem 1.5rem;
}

.toggle-btn i {
	font-size: 1.5rem;
	color: #FFF;
}

.sidebar-logo {
	margin: auto 0;
}

.sidebar-logo a {
	color: #FFF;
	font-size: 1.15rem;
	font-weight: 600;
}

#sidebar:not(.expand) .sidebar-logo, #sidebar:not(.expand) a.sidebar-link span
	{
	display: none;
}

.sidebar-nav {
	padding: 2rem 0;
	flex: 1 1 auto;
}

a.sidebar-link {
	padding: .625rem 1.625rem;
	color: #FFF;
	display: block;
	font-size: 0.9rem;
	white-space: nowrap;
	border-left: 3px solid transparent;
}

.sidebar-link i {
	font-size: 1.1rem;
	margin-right: .75rem;
}

a.sidebar-link:hover {
	background-color: rgba(255, 255, 255, .075);
	border-left: 3px solid #3b7ddd;
}

.sidebar-item {
	position: relative;
}

#sidebar:not(.expand) .sidebar-item .sidebar-dropdown {
	position: absolute;
	top: 0;
	left: 70px;
	background-color: #0e2238;
	padding: 0;
	min-width: 15rem;
	display: none;
}

#sidebar:not(.expand) .sidebar-item:hover .has-dropdown+.sidebar-dropdown
	{
	display: block;
	max-height: 15em;
	width: 100%;
	opacity: 1;
}

#sidebar.expand .sidebar-link[data-bs-toggle="collapse"]::after {
	border: solid;
	border-width: 0 .075rem .075rem 0;
	content: "";
	display: inline-block;
	padding: 2px;
	position: absolute;
	right: 1.5rem;
	top: 1.4rem;
	transform: rotate(-135deg);
	transition: all .2s ease-out;
}

#sidebar.expand .sidebar-link[data-bs-toggle="collapse"].collapsed::after
	{
	transform: rotate(45deg);
	transition: all .2s ease-out;
}
</style>
</head>
<body>
	<div class="wrapper">
		<aside id="sidebar">
			<div class="d-flex">
				<button class="toggle-btn" type="button">
					<i class="lni lni-grid-alt"></i>
				</button>
				<div class="sidebar-logo">
					<a href="#">관리자 페이지</a>
				</div>
			</div>
			<ul class="sidebar-nav">
				<li class="sidebar-item"><a href="#"
					class="sidebar-link collapsed has-dropdown"
					data-bs-toggle="collapse" data-bs-target="#product"
					aria-expanded="false" aria-controls="product"> <i
						class="lni lni-layout"></i> <span>상품관리</span>
				</a>
					<ul id="product" class="sidebar-dropdown list-unstyled collapse"
						data-bs-parent="#sidebar">
						<li class="sidebar-item"><a href="catdog-product-list-admin" class="sidebar-link">전체
								상품 리스트</a></li>
						<li class="sidebar-item"><a href="catdog-add-product-admin" class="sidebar-link">상품
								등록</a></li>
						<li class="sidebar-item"><a href="#" class="sidebar-link">상품
								수정</a></li>
					</ul></li>
				<li class="sidebar-item"><a href="#"
					class="sidebar-link collapsed has-dropdown"
					data-bs-toggle="collapse" data-bs-target="#user"
					aria-expanded="false" aria-controls="user"> <i
						class="lni lni-user"></i> <span>사용자 관리</span>
				</a>
					<ul id="user" class="sidebar-dropdown list-unstyled collapse"
						data-bs-parent="#sidebar">
						<li class="sidebar-item"><a href="catdog-user-list-admin" class="sidebar-link">전체
								회원 리스트</a></li>
						<li class="sidebar-item"><a href="catdog-add-user-admin" class="sidebar-link">회원
								추가</a></li>
					</ul></li>
			</ul>
			<div class="sidebar-footer">
				<a href="#" class="sidebar-link"> <i class="lni lni-exit"></i> <span>Logout</span>
				</a>
			</div>
		</aside>
	</div>
	<script type="text/javascript">
		const hamBurger = document.querySelector(".toggle-btn");

		hamBurger.addEventListener("click", function() {
			document.querySelector("#sidebar").classList.toggle("expand");
		});
	</script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe"
		crossorigin="anonymous"></script>
</body>

</html>