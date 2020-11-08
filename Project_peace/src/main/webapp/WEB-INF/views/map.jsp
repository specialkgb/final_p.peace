<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="rootPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link href="${rootPath}/static/css/main_section.css?ver=2020-10-12-003"
	rel="stylesheet" />
<link href="${rootPath}/static/css/nav.css?ver=2020-10-12-004"
	rel="stylesheet" />


<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<script src="https://kit.fontawesome.com/2d323a629b.js"
	crossorigin="anonymous"></script>
<script src="https://kit.fontawesome.com/4f95742a0c.js"
	crossorigin="anonymous"></script>

<link
	href="https://fonts.googleapis.com/css?family=Source+Sans+Pro&display=swap"
	rel="stylesheet" />

<script src="${rootPath}/static/js/nav.js?ver=2020-10-12-006" defer></script>


<script
      type="text/javascript"
      src="//dapi.kakao.com/v2/maps/sdk.js?appkey=f0d35e58925f4eb7244f03fc53353b7f&libraries=services"
    ></script>

<title>검색창입니다</title>
<style>
#popup {
	position: absolute;
	margin-left: 400px;
	margin-top: 200px;
	border: 2px solid #c4c4c4;
	background-color: #ccc;
	border-radius: 5px;
	width: 300px;
	height: 200px;
	z-index: 9999;
}

span#ncounter, span#counter {
	position: static;
}
</style>
</head>
<body onload="counter_init()">
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
	<script>
		//Layer Popup 설정 시작
		function open_window() {
			var popup = document.getElementById("popup");
			popup.style.display = "block"; //block을 생성해서 보이게한다.
			//popup.style.visibility = "visible"; --> 이미 생성된 영역의 visible 기능만 On 한 경우
		}

		function close_window() {
			var popup = document.getElementById("popup");
			popup.style.display = "none"; //해당 영역을 지워서 않보이게 한다.
			//popup.style.visibility = "hidden"; --> 해당 영역을 렌더링한 상태에서 visible 기능만 Off 한 경우
		}
		//Layer Popup 설정 끝

		//Timer 설정 시작
		var tid;
		var cnt = parseInt(10);//초기값(초단위) 우리는 3분으로 셋팅

		function counter_init() { //메인화면 세션 카운트 실행
			tid = setInterval("counter_run()", 1000);
		}

		function counter_run() { //메인화면 세션 카운트
			document.all.counter.innerText = time_format(cnt);
			cnt--;
			if (cnt < 0) {
				clearInterval(tid);
				/*세션연장 여부를 질의하는 팝업을 띄운다.*/
				open_window();

				/*팝업에서 다시 카운트 시작*/
				cnt = parseInt(10);//카운트 초기화(초단위)
				nCounter_init();
			}
		}

		function nCounter_init() { //팝업화면 추가 세션 카운트 실행
			tid = setInterval("nCounter_run()", 1000);
		}

		function nCounter_run() { //팝업화면 추가 세션 카운트
			document.all.ncounter.innerText = time_format(cnt);
			cnt--;
			if (cnt < 0) {
				/*추가 세션 카운트가 0이면 로그아웃 후 자동로그아웃 안내화면으로 이동*/
				logoutInfo();
			}
		}

		function counter_reset() { //메인화면 카운트 재시작 및 서버 세션 연장
			//(1) WAS session 연장을 위해 WAS의 dummy 페이지 호출
			// => WAS 호출로직 추가!

			//(2) 세견 카운트 초기화
			clearInterval(tid);
			cnt = parseInt(180);//초기값(초단위)
			counter_init();

			//(3) 팝업화면 추가 세션 카운트도 초기화
			document.all.ncounter.innerText = "";

		}

		function logoutInfo() { //로그아웃 후 자동로그아웃 안내화면으로 이동
			self.location = "${rootPath}/logout";
		}

		function logout() { //로그아웃 후 로그인화면으로 이동 
			self.location = "${rootPath}/logout";
		}
		//Timer 설정 끝

		function time_format(s) {
			var nHour = 0;
			var nMin = 0;
			var nSec = 0;
			if (s > 0) {
				nMin = parseInt(s / 60);
				nSec = s % 60;

				if (nMin > 60) {
					nHour = parseInt(nMin / 60);
					nMin = nMin % 60;
				}
			}
			if (nSec < 10)
				nSec = "0" + nSec;
			if (nMin < 10)
				nMin = "0" + nMin;

			return "" + nHour + ":" + nMin + ":" + nSec;
		}
	</script>

	<!-- Timer 설정 -->
	<div>
		<span id="counter"></span><input type="button" value="연장"
			onclick="counter_reset()">
	</div>
	<!-- Layer Popup 설정 시작 -->
	<!-- div id="popup" style="visibility:hidden" -->
	<div id="popup" style="display: none">
		<!-- 초기화면에서는 보여줄 필요가 없으니 아예 생성도 하지 않도록 한다. -->
		<div style="width: 300px; height: 170px" align="center">
			<!-- 팝업내용 -->
			<div>
				<span id="ncounter"></span> 후 자동 로그아웃 됩니다.
			</div>
			<br>
			<br>
			<div>
				<input type="button" value="연장하기"
					onclick="counter_reset(), close_window()"> <input
					type="button" value="로그아웃" onclick="logout()">
			</div>
		</div>
	</div>
	<!-- Layer Popup 설정 끝 -->
	
	<!-- map 영역 -->
	<div class="map_wrap" style="display: flex; justify-content: center">
      <div
        id="map"
        style="
          width: 60%;
          height: 100%;
          /* margin: 0 auto; */
          /* position: relative; */
          overflow: hidden;
        "
      ></div>

      <div id="menu_wrap" class="bg_white">
        <div class="option">
          <div>
            <form onsubmit="searchPlaces(); return false;">
              키워드 :
              <input
                type="text"
                placeholder="키워드 입력"
                id="keyword"
                size="15"
              />
              <button type="submit">검색</button>
            </form>
          </div>
        </div>
        <hr />
        <ul id="placesList"></ul>
        <div id="pagination"></div>
      </div>
    </div>

    <div
      id="btn_box"
      style="text-align: center; margin: 0 auto; padding: 5px 10px; width: 50%"
    >
      <button id="btn_start" type="button">출발</button>
      <button id="btn_arrive" type="button">도착</button>
      <button id="btn_rview" type="button">로드뷰정보</button>
    </div>
    <hr />

    <div
      id="roadview"
      style="width: 60%; height: 80%; margin: 0 auto; display: flex"
    ></div>
    
    <script src="${rootPath}/static/js/main_section.js?ver=2020-10-12-004"></script>
</body>
</html>