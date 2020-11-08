<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="rootPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<!-- 부가적인 테마 -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

<script
	src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<meta charset="UTF-8">
<title>회원 탈퇴 창입니다</title>
</head>
<script type="text/javascript">
	$(document).ready(function() {
		// 취소
		$(".cancle").on("click", function() {

			location.href = "${rootPath}/mypage";

		})

		$("#submit").on("click", function() {
			if ($("#n_password").val() == "") {
				alert("비밀번호를 입력해주세요.");
				$("#n_password").focus();
				return false;
			}
		});

	})
</script>

<style>
section#container {
	display: inline-block;
	width: 30%;
	text-align: center;
	margin: 0 490px;
	padding: 4rem 4rem;
	color: black;
	font-weight: bold;
	background-color: #ddd;
}

.banner-area {
	width: 100%;
	height: 400px;
	position: relative;
	background-image: url(../static/images/감사.jpg);
	background-size: cover;
	background-position: center center;
}

.banner-area h5 {
	padding-top: 25%;
	font-size: 20px;
	text-transform: lowercase;
	color: black;
	text-align: center;
}

button#out, button#cancle {
	padding: 5px 10px;
	margin: 10px;
}

button#out:hover, button#cancle:hover {
	box-shadow: 1px 1px 1px 1px rgba(0, 0, 0, 0.6);
	cursor: pointer;
}

p {
	text-align: center;
	font-size: 20px
}
</style>
<body>
	<div class="wrap">
		<header id="header"></header>
		<div class="password-check">
			<div class="margin-wrap">
			
			<hr>
				<p class="p">계정 탈퇴를 하시려면 현재 비밀번호를 입력해 주세요</p>
				<hr>
				<section id="container">
					<form action="${rootPath}/memberDelete" method="post">
						<div class="form-holder">
							<div class="form-group">
								<label class="control-label" for="n_userid">아이디</label> <input
									class="form-control" type="text" id="n_userid" name="n_userid"
									value="${LOGIN.n_userid}" readonly="readonly" />
							</div>
							<div class="form-group">
								<label class="control-label" for="n_password">패스워드</label> <input
									class="form-control" type="password" id="n_password"
									name="n_password" />
							</div>
							<div class="form-group has-feedback">
								<button class="btn btn-success" type="submit" id="out">회원탈퇴</button>
								<button class="cancle btn btn-danger" type="button" id="cancle" onclick="location.href='${rootPath}/mypage/'">
									취소
								</button>
								<div>
									<c:if test="${msg == false}">
									비밀번호가 맞지 않습니다.
									</c:if>
								</div>
							</div>
						</div>
					</form>
				</section>
			</div>
		</div>
	</div>
</body>
</html>