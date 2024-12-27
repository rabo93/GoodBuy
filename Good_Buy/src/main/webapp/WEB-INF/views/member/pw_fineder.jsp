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


</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/inc/header.jsp"></jsp:include>
	</header>
	
	
	<main>
		<section class="wrapper">
			<div class="page-inner">
				<!-- *********** 여기 안에 작업하세요. section.wrapper/div.page-inner 건들지말기 ******** -->
			    <form action="PasswdFinder" method="post" class="passwdFinderForm">
			        <h3 class="ttl">비밀번호 찾기</h3>
			        <label for="name">이름</label>
			        <input type="text" placeholder="이름을 입력해주세요" id="name" name="mem_name" required><br> 
			        
			        <label for="email">이메일</label>
			        <input type="text" placeholder="이메일 입력" id="email" name="mem_email" required>
			        
			        <div id="form-controls">
			            <button type="submit">임시비밀번호 전송</button><br>
			        </div>
			    </form>
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
	</script>
</body>
</html>

