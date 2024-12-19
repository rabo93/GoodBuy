<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
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

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css">
<!-- JS for Page -->

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
				    <h1 class="login-ttl">로그인하기</h1>
				    <div class="login-box2">
				    	<form action="MemberLogin" method="post">
				    		<div class="lab-box">
				    			<label for="mem_id" >아이디</label>
				    			<input type="text" name="mem_id" id="mem_id" placeholder="아이디 입력" value="${cookie.userId.value}">
				    		</div>	
				    		<div class="lab-box pw">
				    			<label for="mem_passwd">비밀번호</label>
				    			<input type="password" name="mem_passwd" id="mem_passwd" placeholder="비밀번호 입력">
				    			<!-- 클릭시 비밀번호 입력 보이기 -->
				    			<i class="fa-solid fa-eye"></i>
				    			<!-- 클릭시 비밀번호 입력 안보이기 -->
				    			<i class="fa-solid fa-eye-slash"></i>
				    		</div>
			               	<div class="checkbox-container">
			              	 	<label for="rememberId">
				              	 	<input type="checkbox" name="rememberId" id="rememberId" checked>
				              	 	아이디 기억하기
			              	 	</label>
			              	 	<a href="IDPWFind">ID/PW 찾기</a>
			               	</div>
			               	<div id="form-controls">
								<button type="submit">로그인</button>
			               	</div>
			               <div class="signup-link">
			                   <span> 아직 굿바이 회원이 아니신가요? <a href="MemberJoin">회원가입하기</a></span>
			               </div>
			           </form>
			       </div>
			    </div>
				<!-- *********** // 여기 안에 작업하세요. section.wrapper/div.page-inner 건들지말기 ******** -->
			</div>
		</section>
	</main>
	<footer>
		<jsp:include page="/WEB-INF/views/inc/footer.jsp"></jsp:include>
	</footer>
</body>
</html>