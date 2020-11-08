<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="rootPath" value="${pageContext.request.contextPath}" />
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="stylesheet"
	href="${rootPath}/static/css/nav.css?ver=2020-10-12-055660" />

<link
	href="https://fonts.googleapis.com/css?family=Source+Sans+Pro&display=swap"
	rel="stylesheet" />
<script src="https://kit.fontawesome.com/2d323a629b.js"
	crossorigin="anonymous"></script>
<script type="text/javascript"
	src="https://code.jquery.com/jquery-3.2.0.min.js"></script>

<title>마이페이지 입니다</title>
</head>
<style>
@charset "UTF-8";

* {
	box-sizing: border-box;
	margin: 0;
	padding: 0;
}

html, body {
	height: 100%;
	width: 100%;
}

label {
	display: inline-block;
	width: 20%;
	text-align: right;
	margin: 8px 140px;
	padding: 8px;
	color: black;
	font-weight: bold;
}

input {
	display: inline-block;
	text-align: center;
	width: 30%;
	margin: auto;
	padding: 8px;
	border-radius: 5px;
	border: 1px solid navy;
}

#btn_box {
	text-align: right;
	width: 50%;
	margin: 10px 90px;
}

#btn_box button {
	padding: 8px 12px;
	border: none;
	border-radius: 5px;
	color: black;
	cursor: pointer;
	text-align: right;
	margin: 15px 5px;
}

#btn_box button:first-child {
	background-color: skyblue;
	color: black;
}

#btn_box button:last-child {
	background-color: black;
	color: white;
}

#btn_box button:first-child:hover {
	background-color: lightseagreen;
	color: black;
}

#btn_box button:last-child:hover {
	background-color: gray;
	color: white;
}

body {
	display: flex;
	flex-direction: column;
}

.banner-area {
	width: 100%;
	height: 400px;
	position: absolute;
	top: 50px;
	background-image: url(static/images/Ybook.jpg);
	background-size: cover;
	background-position: center center;
}

.banner-area h3 {
	padding-top: 8%;
	font-size: 30px;
	text-transform: uppercase;
	color: black;
	text-align: center;
}

.banner-area h6 {
	text-align: center;
	font-size: 20px;
}

.content-area {
	width: 100%;
	position: relative;
	top: 400px;
	background: #ddd;
	height: 400px;
}

.content-area h4 {
	letter-spacing: 4px;
	padding-top: 30px;
	font-size: 20px;
	margin: 0;
	text-align: center;
}

.content-area p {
	padding: 2% 0;
	line-height: 30px;
}
</style>
<body>

	<nav class="navbar">
		<div class="navbar__logo">
			<i class="fab fa-accusoft"></i> <a href="">SHORT NAVI</a>
		</div>



		<ul class="navbar__menu">
			<li><a href="${rootPath}/">Home</a></li>
			<li><a href="${rootPath}/mypage">회원정보수정</a></li>
			<li><a href="${rootPath}/logout">Logout</a></li>

			<li><a href="${rootPath}/myinfo">${LOGIN.n_userid}님 환영합니다!</a></li>

		</ul>

		<ul class="navbar__icons">
			<li><i class="fab fa-twitter"></i></li>
			<li><i class="fab fa-facebook-f"></i></li>
			<li><i class="fab fa-google"></i></li>
		</ul>

		<a href="#" class="navbar__toggleBtn"> <i class="fas fa-bars"></i>
		</a>
	</nav>

	<header>
		<div class="banner-area">
			<h3>회원정보 수정✅</h3>
			<h6>비밀번호와 이메일을 수정해 주세요</h6>
		</div>
		<div class="content-area">
			<div class="wrapper">


				<h4>Content</h4>
				<form method="POST" enctype="multipart/form-data">
					<div>
						<label></label><input name="seq" value="${LOGIN.seq}"
							type="hidden" />
					</div>

					<div>
						<label>아이디</label><input name="n_userid" value="${LOGIN.n_userid}"
							readonly="readonly" />
					</div>
					<div>
						<label>변경할 password*</label><input name="n_password"
							value="${LOGIN.n_password}" />
					</div>

					<div>
						<label>이메일*</label><input name="n_email" value="${LOGIN.n_email}" />
					</div>
					<div>
						<label>가입일</label><input name="n_date" value="${LOGIN.n_date}"
							name="p_dcode" readonly="readonly">
					</div>


					<div></div>
					<div id="btn_box">
						<button id="btn-update">수정 완료</button>
						<button type="button" id="btn-delete"
							onclick="location.href='${rootPath}/memberDelete/'">회원
							탈퇴</button>

					</div>
			</form>
			</div>
		</div>
	</header>
</body>
</html>