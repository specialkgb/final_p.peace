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
<link rel="stylesheet" href="${rootPath}/static/css/nav.css?ver=076" />

<link
	href="https://fonts.googleapis.com/css?family=Source+Sans+Pro&display=swap"
	rel="stylesheet" />
<script src="https://kit.fontawesome.com/2d323a629b.js"
	crossorigin="anonymous"></script>
<script src="${rootPath}/static/js/modal.js?ver=2020-11-05-0001" defer></script>
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
	height: 50%;
	width: 100%;
}

body {
	display: flex;
	flex-direction: column;
}

label {
	display: inline-block;
	width: 20%;
	text-align: right;
	margin: 0 140px;
	padding: 20px 20px;
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
	margin: 5px auto;
	padding-top: -50%; 
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

.banner-area {
	width: 100%;
	height: 100%;
	position: relative;
	top: 0;
	background-size: cover;
	background-position: center;
}

.banner-area h5 {
	padding-top: 8%;
	font-size: 27px;
	text-transform: uppercase;
	color: black;
	text-align: center;
}

.content-area {
	width: 100%;
	position: relative;
	top: 0px;
	bottom: 0px;
	background: white;
	height: 50px;
}

.content-area h5 {
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

.wrapper {
	flex: 1;
	background-color: #ddd;
	width: 50%;
	margin: 10px auto;
}

.col {
	color: black;
}

footer {
	background: linear-gradient(to left, pink, black);
	color: white;
	margin-top:0;
	text-align: center;
	padding: 0.7rem;
	font-size: 20px;
}

.button {
	display: flex;
	justify-content: center;
	border: none;
	width: 100%;
}

#modal-button {
	cursor: pointer;
	background-color: #04c584;
	border: none;
	width: 100%;
}

#modal-button:hover {
	background-color: #e9e9e9;
}

#modal {
	width: 100%;
	height: 100%;
	background-color: rgba(0, 0, 0, 0.4);
	position: fixed;
	top: 0;
	left: 0;
	display: none;
}

#modal-window {

	border-radius: 5px;
	flex-flow: column;
	position: fixed;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	z-index: 10;
	width: 50%;
	height: 70%;
	background-color: #fff;
}

div#modal-title {
	width: 100%;
	margin: 20px auto;
	text-align: center;
}

div.modal-body {
	display: flex;
	width: 80%;
	margin: 0 auto;
	padding: 10px 16px;
}

div.modal-list {
	display: flex;
	width: 50%;
	flex-flow: column;
	margin: 10px auto;
	padding: 3px 6px;
	justify-content: center;
	text-align: center;
	align-items: center;
}

div.modal-body img {
	margin: 10px;
	width: 100px;
}

div.modal-list:nth-child(1) {
	border-right: 1px solid #aaa;
	margin: 0;
}

div.modal-body:nth-child(2) {
	border-bottom: 1px solid #aaa;
}

.modalbutton {
	width: 100%;
}

.modal-close {
	float: right;
}

.modal-close:hover {
	color: red;
}

.image {
	width: 80px;
	height: 80px;
	display: inline;
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

			<h5>내 정보 확인하기</h5>

			<div class="wrapper">

				<div>
					<label>아이디</label><a class="col" href="#" name="n_userid"
						value="${LOGIN.n_userid}" readonly="readonly" />${LOGIN.n_userid}</a>
				</div>
				<div>
					<label>password</label><a class="col" href="#" name="n_password"
						value="${LOGIN.n_password}" readonly="readonly" />${LOGIN.n_password}</div>

				<div>
					<label>이메일</label><a class="col" href="#" name="n_email"
						value="${LOGIN.n_email}" readonly="readonly" />${LOGIN.n_email}</div>
				<div>
					<label>가입일</label><a class="col" href="#" name="n_date"
						value="${LOGIN.n_date}" name="p_dcode" readonly="readonly">${LOGIN.n_date}
				</div>


			</div>




		</div>

		<div class="content-area">

			<div id="btn_box">

				<button type="button" id="btn-delete"
					onclick="location.href='${rootPath}/map'">맵으로 가기</button>

			</div>
			<div class="modal-wrap">



				<div class="modalbutton">
					<button id="modal-button">
						<footer>

							<address>CopyRight &copy; Short Navi를 만든 사람들</address>

						</footer>
					</button>
				</div>
				<div id="modal">
					<div id="modal-window">
						<div id="modal-title">
							<span style="font-size: 20px">CONTACT US</span> <span id="modal-close">&times;</span>
						</div>
						<div class="modal-body">
							<div class="modal-list">
								<span>기건우</span> <img class="image" src=${rootPath}/static/images/도라에몽.jpg>
 <span>specialkgb@naver.com</span>
							</div>
							<div class="modal-list">
								<span>신햇살</span><img class="image" src=${rootPath}/static/images/피카츄.png>
 <span>sinsin09022@gmail.com</span>
							</div>
						</div>
						<div class="modal-body">
							<div class="modal-list">
								<span>신민석</span> <img class="image" src=${rootPath}/static/images/짱구.png>
 <span>Smskit726@naver.com</span>
							</div>
							<div class="modal-list">
								<span>주선영</span> <img class="image" src=${rootPath}/static/images/스펀지밥.jpg>
<span>ssyy0622@gmail.com</span>
							</div>
						</div>
					</div>
				</div>

			</div>
		</div>

	</header>
</body>
</html>