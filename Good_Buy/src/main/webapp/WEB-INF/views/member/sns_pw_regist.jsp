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
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/sns_pw_regist.css">
<!-- JS for Page -->
<%-- <script src="${pageContext.request.contextPath}/resources/js/join.js"></script> --%>

</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/inc/header.jsp"></jsp:include>
	</header>
	<main>
		<section class="wrapper">
			<div class="page-inner">
			<!-- *********** 여기 안에 작업하세요. section.wrapper/div.page-inner 건들지말기 ******** -->
				<form action="PwRegist" id="registPw" method="post">
					<h1 class="find-ttl">SNS 연동 계정 비밀번호 등록 (최초 1회)</h1>
					<section class="row">
						<label for="mem_passwd1">비밀번호</label>
						<div class="box"> 
							<input type="password" name="mem_passwd" id="mem_passwd1" placeholder="비밀번호 입력" required> 
						</div>
						<div id="checkPasswd1" class="result"></div>
					</section>
					
					<section class="row">
						<label for="mem_passwd2">비밀번호 확인</label>
						<div class="box">
							<input type="password" name="mem_passwd2" id="mem_passwd2" placeholder="비밀번호 재입력" required> 
						</div>
						<div id="checkPasswd2" class="result"></div>
					</section>
								    	
	               	<section id="form-controls">
	               		<button id="submitBtn" type="submit" onclick="registPw(event)">비밀번호 등록</button>
	               	</section>
               	</form>
				<!-- *********** // 여기 안에 작업하세요. section.wrapper/div.page-inner 건들지말기 ******** -->
			</div>
		</section>
	</main>
	<footer>
		<jsp:include page="/WEB-INF/views/inc/footer.jsp"></jsp:include>
	</footer>
	
	<script type="text/javascript">
		function registPw(event){
			event.preventDefault(); // 조건 만족 전에 폼 제출 되는 것을 막음
			
			// 새 비밀번호와 확인 비밀번호의 유효성 검사
		    let Passwd1 = $("#mem_passwd1").val();
		    let Passwd2 = $("#mem_passwd2").val();
		    
			if(!Passwd1 || !Passwd2){
		        alert("비밀번호를 입력하고 확인해주세요.");
		        return false;
			}
			
			let regex = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$/;
			if(!regex.test(Passwd1)){
				$("#checkPasswd1").text("비밀번호는 최소 8자 이상, 숫자와 문자를 포함해야 합니다").css("color","var(--red)");
		        return false;
			}
			
			if (Passwd1 !== Passwd2) {
				$("#checkPasswd2").text("입력한 두 비밀번호가 일치하지 않습니다.").css("color","var(--red)");
	            return false;
	        }
			
			// 수정 폼 제출
			$("#registPw").submit();
		}
	</script>
	
</body>
</html>