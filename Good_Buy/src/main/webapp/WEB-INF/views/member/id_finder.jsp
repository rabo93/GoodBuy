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
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/idpw_find.css">
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
				<h1 class="find-ttl">아이디 찾기</h1>
				<section id="form-controls">
					<section class="row">
						<label for="mem_phone">휴대폰 번호로 본인인증부터 해주세요.</label>
						<div class="box">
							<input type="text" name="mem_phone" id="mem_phone" placeholder="'-'없이 입력해주세요" required> 
							<input type="button" value="인증번호 요청" id="phoneChk">
							<input type="button" value="휴대폰번호 재인증" id="phoneReChk" style="display:none;">
<!-- 							<input type="button" value="휴대폰번호 재인증" id="phoneReChk"> -->
						</div>
						<div id="phoneCheckResult" class="result"></div>
					</section>
				</section>
				<section id="form-controls">
					<!-- 인증번호 요청 클릭시 섹션 보임 -->
					<section class="row" id="authSection" style="display:none;">
<!-- 					<section class="row" id="authSection" > -->
						<label for="auth_code">인증번호</label>
						<div class="box">
							<div class="auth-input">
								<input type="text" name="auth_code" id="auth_code" placeholder="인증번호입력" disabled required> 
								<span class="rest-time" id="rest_time">05:00</span>
							</div>
							<input type="button" class="before" value="인증하기" id="authChkBtn">
							<input type="button" class="after" value="인증완료" style="display:none;">
<!-- 							<input type="button" class="after" value="인증완료"> -->
						</div>
						<div id="authCheckResult" class="result"></div>
					</section>
			    	
			    </section>
			    	
               	<section id="form-controls">
					<button class="find" onclick="idFind()" style="display:none;">아이디 찾기</button>
<!-- 					<button id="id_find" onclick="idFind()">아이디 찾기</button> -->
               	</section>
               	
               	<section id="form-controls">
               		<div id="find_result" style="display:none;">
<!--                		<div id="find_result"> -->
	               		<p> 회원님의 아이디는 
	               			<span id="idResult"></span>
	               			입니다.
	               		</p>
	               		<br>
	               		<a href="./">메인으로 가기</a>
						<a href="MemberLogin">로그인</a>
               		</div>
               	</section>
				<!-- *********** // 여기 안에 작업하세요. section.wrapper/div.page-inner 건들지말기 ******** -->
			</div>
		</section>
	</main>
	<footer>
		<jsp:include page="/WEB-INF/views/inc/footer.jsp"></jsp:include>
	</footer>
	
	<script type="text/javascript">
		function idFind() {
			let mem_phone =  $("#mem_phone").val(); 
			console.log("인증한 휴대폰번호 : " + mem_phone);
			
			$.ajax({
				type: "Post",
				url: "MemberIdFind",
				data : { mem_phone : mem_phone },
				success : function(mem_id) {
					if(mem_id) {
						$("#find_result").show();
						$("#idResult").text(mem_id); // 아이디 표시
					} else {
						alert("해당 번호로 조회된 아이디가 없습니다.");
					}
					
				}
			});
		}
	</script>
</body>
</html>