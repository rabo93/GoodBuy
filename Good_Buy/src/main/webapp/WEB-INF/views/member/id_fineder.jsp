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
<link rel="stylesheet" href="../../resources/css/common.css">
<link rel="stylesheet" href="../../resources/css/default.css">
<script src="../../resources/js/jquery-3.7.1.js"></script>

<!-- font-awesome -->
<link rel="stylesheet" href="../../resources/fontawesome/all.min.css" />
<script src="../../resources/fontawesome/all.min.js"></script>

<!-- ******************* 아래 CSS와 JS는 페이지별로 알맞게 Import 해주세요 ****************** -->
<!-- CSS for Page -->
<link rel="stylesheet" href="../../resources/css/login.css">
<!-- JS for Page -->
<script src="${pageContext.request.contextPath}/resources/js/join.js"></script>

</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/inc/header.jsp"></jsp:include>
	</header>
	<main>
		<section class="wrapper">
			<div class="page-inner">
			<!-- *********** 여기 안에 작업하세요. section.wrapper/div.page-inner 건들지말기 ******** -->
				<h1 class="login-ttl">아이디 찾기</h1>
					<section class="row">
						<label for="mem_phone">휴대폰 번호로 인증</label>
						<div class="box">
							<input type="text" name="mem_phone" id="mem_phone" placeholder="'-'없이 입력해주세요" required> 
							<input type="button" value="인증번호 요청" id="phoneChk">
							<input type="button" value="휴대폰번호 재인증" id="phoneReChk" style="display:none;">
						</div>
						<div id="phoneCheckResult" class="result"></div>
					</section>
					
					<!-- 인증번호 요청 클릭시 섹션 보임 -->
					<section class="row" id="authSection">
<!-- 					<section class="row" id="authSection" style="display:none;"> -->
						<label for="auth_code">인증번호</label>
						<div class="box">
							<div class="auth-input">
								<input type="text" name="auth_code" id="auth_code" placeholder="인증번호입력" disabled required> 
								<span class="rest-time" id="rest_time">05:00</span>
							</div>
							<input type="button" class="before" value="인증하기" id="authChkBtn">
							<input type="button" class="after" value="인증완료" style="display:none;">
						</div>
						<div id="authCheckResult" class="result"></div>
					</section>
			    		
	               	<section id="form-controls">
						<button id="id_find">아이디 찾기</button>
	               	</section>
				<!-- *********** // 여기 안에 작업하세요. section.wrapper/div.page-inner 건들지말기 ******** -->
			</div>
		</section>
	</main>
	<footer>
		<jsp:include page="/WEB-INF/views/inc/footer.jsp"></jsp:include>
	</footer>
	
	<script type="text/javascript">
		let 	
	
	</script>
</body>
</html>