<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/img/g_favicon.ico" type="image/x-icon">
<link rel="icon" href="${pageContext.request.contextPath}/resources/img/g_favicon.ico" type="image/x-icon">
<title>굿바이 - 중고거래, 이웃과 함께 더 쉽게!</title>

<!-- default -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/default.css">
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>

<!-- font-awesome -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/fontawesome/all.min.css" />
<script src="${pageContext.request.contextPath}/resources/fontawesome/all.min.js"></script>

<!-- ******************* 아래 CSS와 JS는 페이지별로 알맞게 Import 해주세요 ****************** -->
<!-- CSS for Page -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/login.css">
<!-- JS for Page -->
<!-- 카카오 스크립트 -->
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>


</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/inc/header.jsp"></jsp:include>
	</header>
	<main>
		<section class="wrapper">
			<div class="page-inner">
				<!-- *********** 여기 안에 작업하세요. section.wrapper/div.page-inner 건들지말기 ******** -->
				<div class="login-wrap">
				    <h1 class="login-ttl">LOGIN</h1>
				    <div class="login-box">
		    			<a href="MemberLogin">ID/PW로 로그인</a>
<!-- 		    			<a href="https://kauth.kakao.com/oauth/authorize?client_id=6a7a7bde7898c6d7f7c08a7a14bad8e9&redirect_uri=http://c3d2407t1p2.itwillbs.com/kakaologin&response_type=code" class="sns-login" > -->
		    			<a href="https://kauth.kakao.com/oauth/authorize?client_id=6a7a7bde7898c6d7f7c08a7a14bad8e9&redirect_uri=http://localhost:8081/kakaologin&response_type=code" class="sns-login" >
						   <i class="fa-solid fa-comment"></i>카카오톡으로 간편로그인
						</a>
						<div id="naver_id_login" ></div>
<%-- 		    			<a href="NaverLogin" class="sns-login"><img alt="네이버로그인" src="${pageContext.request.contextPath}/resources/img/naver-icon.png" > 네이버로 로그인</a> --%>
			       </div>
		       </div>
		       <!-- *********** // 여기 안에 작업하세요. section.wrapper/div.page-inner 건들지말기 ******** -->
			</div>
		</section>
	</main>
	<footer>
		<jsp:include page="/WEB-INF/views/inc/footer.jsp"></jsp:include>
	</footer>
	<script th:inline="javascript">
		<!-- 카카오 로그인 연동 -->
		function kakaoLogin() {
			$.ajax({
				url:'/memberLoginForm/getKakaoAuthUrl',
				type:'post',
				async: false,
				dataType: 'text',
				success: function (res) {
					location.href = res;
			 	}
			});
		}
	</script>
	<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
	<script type="text/javascript">
        var naver_id_login = new naver_id_login("v2NPkz3kuDJkYM_nAyMT", "http://c3d2407t1p2.itwillbs.com/NaverCallback");
        var state = naver_id_login.getUniqState();
        naver_id_login.setButton("green", 3, 48);
        naver_id_login.setDomain("c3d2407t1p2.itwillbs.com");
        naver_id_login.setState(state);
        naver_id_login.setPopup();
        naver_id_login.init_naver_id_login();
        
        window.addEventListener('message', function (event) {
        	if (event.data === 'NaverLoginSuccess') {
	        	window.location.href = '/'; 
	         }
         });
    </script>
</body>
</html>