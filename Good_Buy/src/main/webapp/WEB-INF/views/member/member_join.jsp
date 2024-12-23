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
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/join.css">
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
				<div class="join-wrap">
					<h3>회원가입</h3>
					<div id="form-container">
						<div id="form-inner-container">
							<div id="sign-up-container">
								<form action="MemberJoin" id="joinForm" name="joinForm" method="post" enctype="multipart/form-data">
									<section class="row">
										<label for="mem_phone">휴대폰번호</label>
										<div class="box">
											<input type="text" name="mem_phone" id="mem_phone" placeholder="'-'없이 입력해주세요" required> 
											<input type="button" value="인증번호 요청" id="phoneChk">
										</div>
										<div id="phoneCheckResult" class="result"></div>
									</section>
									
									<section class="row">
										<label for="auth_code">인증번호</label>
										<div class="box">
											<div class="auth-input">
												<input type="text" name="auth_code" id="auth_code" placeholder="인증번호입력" disabled required> 
												<span class="rest-time">05:00</span>
											</div>
											<input type="button" class="before" value="인증완료" >
											<input type="button" class="after" value="인증완료" >
										</div>
										<div id="authCheckResult" class="result"></div>
									</section>
									
									<section class="row">
										<label for="mem_email1">이메일</label>
										<div class="box">
											<input type="text" name="mem_email1" id="mem_email1" placeholder="Email" required>
											@
											<input type="text" size="10" id="mem_email2" name="mem_email2">
											<select id="emaildmain" class="form-sel">
												<option value="">직접입력</option>
												<option value="naver.com">naver.com</option>
												<option value="gmail.com">gmail.com</option>
												<option value="daum.net">daum.net</option>
											</select> 
										</div>
										<div id="checkMail" class="result"></div>
									</section>
									
									<section class="row">
										<label for="mem_name">이름</label>
										<div class="box">
											<input type="text" name="mem_name" id="mem_name" placeholder="이름" onblur="checkNameResult()"> 
										</div>
										<div id="checkName" class="result"></div>
									</section>
									
									<section class="row">
										<label for="mem_nick">닉네임</label>
										<div class="box">
											<input type="text" name="mem_nick" id="mem_nick" placeholder="닉네임" onblur="ckNick()"> 
										</div>
										<div id="checkNic" class="result"></div>
									</section>
									
									<section class="row">
										<label for="mem_id">아이디</label>
										<div class="box">
											<input type="text" name="mem_id" id="mem_id" placeholder="아이디" onblur="checkId()" required> 
										</div>
										<div id="checkIdResult" class="result"></div>
									</section>
									
									<section class="row">
										<label for="mem_passwd1">비밀번호</label>
										<div class="box">
<!-- 											<input type="password" name="mem_passwd" id="mem_passwd1" placeholder="비밀번호 입력" onblur="checkPasswdLength1()" required>  -->
											<input type="password" name="mem_passwd" id="mem_passwd1" placeholder="비밀번호 입력" required> 
										</div>
										<div id="checkPasswd1" class="result"></div>
									</section>
									
									<section class="row">
										<label for="mem_passwd2">비밀번호확인</label>
										<div class="box">
											<input type="password" name="mem_passwd2" id="mem_passwd2" placeholder="비밀번호 확인" onkeyup="checkPasswdResult()" required> 
										</div>
										<div id="checkPasswd2" class="result"></div>
									</section>
									
									<section class="row">
										<label>성별</label>
										<div id="gender-container">
											<div class="gender-option">
												<input type="radio" name="mem_gender" id="male" value="M">
												<label for="male">남</label>
											</div>
											<div class="gender-option">
												<input type="radio" name="mem_gender" id="female" value="F">
												<label for="female">여</label>
											</div>
										</div>
									</section>

									<section class="row">
										<label for="mem_birthday">생년월일</label>
										<select id="year" class="form-sel">
											<option value="YEAR">연도</option>
										</select> 
										<select id="month" class="form-sel">
											<option value="MONTH">월</option>
										</select> 
										<select id="day" class="form-sel">
											<option value="DAY">일</option>
										</select> 
	<!-- 									<input type="date" min="1990-01-01" max="2000-12-31" name="mem_birthday">  -->
									</section>
									
									<section class="row">
										<label for="mem_ddress1">주소</label>
										<div class="box">
											<input type="text" placeholder="우편번호" id="mem_post_code" name="mem_post_code" size="6" readonly>
											<input type="button" value="우편번호 찾기" onclick="search_address()">
										</div>
										<input type="text" name="mem_address1" placeholder="기본주소"  id="mem_ddress1" size="25" readonly>
										<input type="text" name="mem_address2" placeholder="상세주소" id="mem_address2" size="25">
										<div id="checkAddr" class="result"></div>
									</section>
									
									<section class="row last-row">
										<label for="check_all">
											<input type="checkbox" id="terms_all" required> 전체 동의하기
										</label>
										<div>
											<label>
												<input type="checkbox" name="terms" id="terms1" class="terms"><a href="#">[필수]굿바이 이용약관 동의</a>
											</label>
											<label>
												<input type="checkbox" name="terms" id="terms2" class="terms"><a href="#">[필수]개인정보 수집 이용 동의</a>
											</label>
											<label>
												<input type="checkbox" name="terms" id="terms3" class="terms"><a href="#">[필수]휴대폰 본인확인 서비스</a>
											</label>
										</div>
									</section>
																		
									<button type="button" id="submitBtn" onclick="checkSubmit()">회원 가입하기</button>
								</form>
							</div>
						</div>
					</div>
				</div>
				<!-- *********** // 여기 안에 작업하세요. section.wrapper/div.page-inner 건들지말기 ******** -->
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
	<!-- *********** 문자 인증 API ************ -->
	<script type="text/javascript">
	$(function() {
		var code2 = "";
        $("#phoneChk").click(function(){
            let phone = $("#mem_phone").val(); // 버튼 클릭 시 입력값 가져오기
            let regex = /^[0-9]{11}$/; // 전화번호 유효성 검사
            console.log(phone);
			
            if (!regex.test(phone)) {
    			alert("휴대폰번호가 올바르지 않습니다.");
    			return;
    		}
            alert('인증번호 발송이 완료되었습니다.');

            $.ajax({
                type: "POST",
                url: "/send-one",
                data: {"userPhone": phone},
                cache: false,
                success: function(data) {
                	console.log("응답 데이터 (문자열): " + JSON.stringify(data));
                	
                	if(data == "error") {
                		alert("휴대폰번호가 올바르지 않습니다.");
                		$("#mem_phone").attr("autofocus", true);
                	} else { // 발송 성공시 
                		$("#auth_code").attr("disabled", false); // 인증코드 입력창 활성화
                		$("#mem_phone").attr("readonly", true);	// 휴대폰번호 입력창 읽기전용으로 변경
                    	$("#phoneCheckResult").text("인증번호 발송 성공").css("color", "var(--secondary)");
                		code2 = data;
                	}
                },
                error: function(xhr) {
                	console.log("에러 상태 코드: " + xhr.status); // 디버깅용 로그
                    console.log("에러 메시지: " + xhr.responseText);

                    if (xhr.status === 400) {
                        alert(xhr.responseText); // 응답 메시지를 alert로 표시
                    } else {
                        alert("서버 요청 중 오류가 발생했습니다.");
                    }
                }
            });
        });
    });
	</script>
</body>
</html>