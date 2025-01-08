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
<script src="https://cdnjs.cloudflare.com/ajax/libs/jsencrypt/3.3.2/jsencrypt.min.js"></script>



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
<%-- 				    			<input type="text" name="mem_id" id="mem_id" placeholder="아이디 입력" value="${cookie.userId.value}"> --%>
				    			<input type="text" id="id" placeholder="아이디 입력" value="${cookie.userId.value}">
				    		</div>	
				    		<div class="lab-box pw">
				    			<label for="mem_passwd">비밀번호</label>
<%-- 				    			<input type="password" name="mem_passwd" id="mem_passwd" placeholder="비밀번호 입력"> --%>
				    			<input type="password"  id="passwd" placeholder="비밀번호 입력">
				    			<button type="button" class="passwd-view">
					    			<i class="fa-solid fa-eye"></i>
				    			</button>
				    		</div>
			               	<div class="checkbox-container">
			              	 	<label for="rememberId">
				              	 	<input type="checkbox" name="rememberId" id="rememberId" checked>
				              	 	아이디 기억하기
			              	 	</label>
			              	 	<div class="find-links">
							        <a href="IDFind">아이디 찾기</a>
							        <span> | </span>
							        <a href="PWFind">비밀번호 찾기</a>
							    </div>
			               	</div>
			               	<div id="form-controls">
								<button type="submit">로그인</button>
			               	</div>
			               <div class="signup-link">
			                   <span> 아직 굿바이 회원이 아니신가요? <a href="MemberJoin">회원가입하기</a></span>
			               </div>
			               
			               <%-- 아이디/패스워드를 각각 암호화하여 폼으로 전송할 경우 암호문을 저장할 요소 생성 --%>
							<input type="hidden" id="encryptedId" name="mem_id">
							<input type="hidden" id="encryptedPasswd" name="mem_passwd">
			               
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
	<script>
		const pwBtn = document.querySelector(".passwd-view");
		const pwInput = document.querySelector("#mem_passwd");
		pwBtn.addEventListener("click", function(){
			pwBtn.innerHTML = '<i class="fa-solid fa-eye"></i>';
			pwBtn.classList.toggle("view");
			if (pwBtn.classList.contains("view")){
				pwBtn.innerHTML = '<i class="fa-solid fa-eye-slash"></i>';
			}
			
			if (pwInput.type === "password") {
				pwInput.type = "text"; // 비밀번호 표시
		 	 } else {
		 		pwInput.type = "password"; // 비밀번호 숨김
		  	}
		});
		//--------------------------------------------------------------------
		$(function() {
			const publicKey = '${publicKey}'; // 공개키 저장
			
			$("form").submit((e) => { // form 태그 submit 이벤트 핸들링
// 				e.preventDefault(); // 테스트 시 폼 제출 방지
				// 입력받은 아이디 및 패스워드 변수에 저장
				const id = $("#id").val();
				const passwd = $("#passwd").val();
				// ------------------------------------------
				// JSEncrypt 객체 생성
				const jsEncrypt = new JSEncrypt();
				// JSencrypt 객체에 공개키 전달
				jsEncrypt.setPublicKey(publicKey);
				
				// JSEncrypt 객체의 encrypt() 메서드 호출하여 데이터 암호화
				// => 암호화할 데이터(id, passwd)는 JSON 형식 문자열로 변환하여 전달
				// => 또는 각각 id, passwd 를 따로 암호화하여 전송해도 무관함
				let encryptedId = jsEncrypt.encrypt(id); 
				let encryptedPasswd = jsEncrypt.encrypt(passwd); 
				$("#encryptedId").val(encryptedId);
				$("#encryptedPasswd").val(encryptedPasswd);
				
				// ------------------------------------------
				// 암호화할 데이터(id, passwd)를 JSON 형식 문자열로 변환하여 폼에 추가
				let encryptedData = jsEncrypt.encrypt(JSON.stringify({id, passwd}));
				console.log("encryptedData" + encryptedData);
				$("form").prepend("<input type='hidden' name='encryptedData' value='" + encryptedData + "'>");
				
			});
		});
		
	</script>
</body>
</html>