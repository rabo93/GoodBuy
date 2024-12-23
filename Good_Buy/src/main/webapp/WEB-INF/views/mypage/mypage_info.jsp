<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
<%-- <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css"> --%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage.css">

<!-- JS for Page -->
<%-- <script src="${pageContext.request.contextPath}/resources/js/slick.js"></script> --%>
<script src="${pageContext.request.contextPath}/resources/js/join.js"></script>


</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/inc/header.jsp"></jsp:include>
	</header>
	<main>
		<!-- 왼쪽 메뉴바 -->
		<h2 class="page-ttl">마이페이지</h2>
		<section class="my-wrap">
			<aside class="my-menu">
				<h3>거래 정보</h3>
				<a href="MyStore">나의 상점</a>
				<a href="GoodPay">굿페이</a>
				<a href="MyOrder">구매내역</a>
				<a href="MySales">판매내역</a>
				<h3>나의 정보</h3>
				<a href="MyInfo" class="active">계정정보</a>
				<a href="MyWish">관심목록</a>
				<a href="MyReview">나의 후기</a>
				<a href="MySupport">1:1문의내역</a>
				<a href="">나의 광고</a>
			</aside>
			<div class="my-container">
				<div class="contents-ttl">회원 정보 수정</div>
				<div class="contents">
					<!-- contents -->
						<section class="info-set-wrap">
						<form action="MyInfo" id="myInfo" name="myInfo" method="post" enctype="multipart/form-data" class="my-frm">
							<div class="set">
								<label>프로필 사진</label>
								<div>
									<img src="${pageContext.request.contextPath}/resources/img/user_thumb.png" id="profile_preview" height="60px"><br>
									<input type="file" class="btn-frm" name="profile_upload" id="profile_upload" value="프로필사진 변경" ><br>
								</div>
							</div>
							
							<div class="set">
								<label>아이디</label>
								<div>
									<input type="text" name="mem_id" id="mem_id" value="${member.mem_id}" readonly><br>
								</div>
							</div>

							<div class="set">
								<label for="mem_nick">닉네임</label>
								<div>
									<input type="text" name="mem_nick" id="mem_nick" placeholder="${member.mem_nick}" onblur="ckNick()"><br>
								</div>
								<div id="checkNic" class="result"></div>
							</div>
							
							<div class="set">
								<label>기존 비밀번호</label>
								<div>
									<input type="password" name="old_passwd" id="old_passwd">
								</div>
							</div>
							
							<div class="set">
								<label>비밀번호 변경</label>
								<div>
									<input type="password" name="mem_passwd" id="mem_passwd1" placeholder="새비밀번호 입력" onblur="checkPasswdLength1()"><br>
<!-- 									<input type="password" id="mem_passwd1" name="mem_passwd" onblur="checkPasswdLength1()" placeholder="변경할 비밀번호 8 ~ 16글자 사이 입력"> -->
								</div>
								<div id="checkPasswd1" class="result"></div>
							</div>
							
							<div class="set">
								<label>비밀번호 변경 확인</label>
								<div>
									<input type="password" name="mem_passwd2" id="mem_passwd2" placeholder="새비밀번호 재입력" onkeyup="checkPasswdResult()"> 
								</div>
								<div id="checkPasswd2" class="result"></div>
							</div>
							
							<div class="set">
								<label>이메일</label>
								<div>
									<input type="text" name="mem_eail" id="mem_email" value="${member.mem_email}" readonly><br>
								</div>
							</div>
							
							<div class="set">
								<label for="mem_phone">휴대폰번호</label>
								<div class="box">
									<input type="text" name="mem_phone" id="mem_phone" placeholder="'-'없이 입력해주세요"  value="${member.mem_phone}" onblur="phoneCheck()"> 
									<input type="button" value="인증번호 요청" >
								</div>
							</div>
							<!-- 인증번호 요청 클릭시 생성하기 -->
							<div class="set">
								<label for="auth_code">인증번호</label>
								<div class="box">
									<div class="auth-input">
										<input type="text" name="auth_code" id="auth_code" placeholder="인증번호 입력" > 
										<span class="rest-time">05:00</span>
									</div>
									<input type="button" class="before" value="인증완료">
									<input type="button" class="after" value="인증완료">
								</div>
								<div id="authCheckResult" class="result"></div>
							</div>
							<div class="set">
								<label for="mem_ddress1">주소</label>
								<div class="box">
									<input type="text" placeholder="우편번호" id="mem_post_code" name="mem_post_code" size="6" value="${member.mem_post_code}">
									<input type="button" value="우편번호 찾기" onclick="search_address()">
								</div>
								<input type="text" name="mem_address1" placeholder="기본주소"  id="mem_ddress1" size="25" value="${member.mem_address1}">
								<input type="text" name="mem_address2" placeholder="상세주소" id="mem_address2" size="25" value="${member.mem_address2}">
								<div id="checkAddr" class="result"></div>
							</div>
							<div class="btns">
								<input type="submit" value="수정완료" onclick="myInfoModify()"> 
							</div>						
						</form>
						<a href="MemberWithdraw" class="withdraw-link">회원탈퇴</a>
					</section>
					<!-- // contents -->
				</div>
			</div>
		</section>
	</main>
	<footer>
		<jsp:include page="/WEB-INF/views/inc/footer.jsp"></jsp:include>
	</footer>
	<!-- ************ 다음주소 API ************ -->
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script type="text/javascript">
		function search_address() {
			new daum.Postcode({
				oncomplete : function(data) {
					console.log(data);
					document.joinForm.mem_post_code.value = data.zonecode;

					let address = data.address;
					if (data.buildingName != "") {
						address += " (" + data.buildingName + ")";
					}
					
					document.joinForm.mem_address1.value = address;
					document.joinForm.mem_address2.focus();
				}
			}).open();
		}
	</script>
	<script type="text/javascript">	
		$("#profile_upload").on("change", function(event) {
		
		    var file = event.target.files[0];
		
		    var reader = new FileReader(); 
		    reader.onload = function(e) {
		
		        $("#profile_preview").attr("src", e.target.result);
		    }
		
		    reader.readAsDataURL(file);
		});
	</script>
	<script type="text/javascript">
	    $("#profile_img").change(function (event) {
	        let file = event.target.files[0]; // 사용자가 업로드한 파일 가져오기
	        let reader = new FileReader();
	
	        reader.onload = function (event2) {
	            console.log("파일 : " + event2.target.result); // 파일 내용 확인용 로그
	            $("#preview_profile").attr("src", event2.target.result); // 미리보기 이미지 변경
	        };
	
	        // 파일을 URL로 읽어오기
	        if (file) {
	            reader.readAsDataURL(file);
	        }
	    });
	</script>
</body>
</html>