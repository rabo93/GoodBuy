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
<script src="https://cdnjs.cloudflare.com/ajax/libs/jsencrypt/3.3.2/jsencrypt.min.js"></script>
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
					<div id="memo">각 항목 옆 * 표시는 필수 기입 항목 표시 입니다.</div>
					<div id="form-container">
						<div id="form-inner-container">
							<div id="sign-up-container">
								<form action="MemberJoin" id="joinForm" name="joinForm" method="post" enctype="multipart/form-data">
									<section class="row">
										<label for="mem_phone">휴대폰번호</label> <span class="required"> * </span>
										<div class="box">
											<input type="text" name="mem_phone" id="mem_phone" placeholder="'-'없이 입력해주세요" onchange="ckPhone()" required> 
											<input type="button" value="인증번호 요청" id="phoneChk">
											<input type="button" value="휴대폰번호 재인증" id="phoneReChk" style="display:none;">
										</div>
										<div id="phoneCheckResult" class="result"></div>
									</section>
									
									<!-- 인증번호 요청 클릭시 섹션 보임 -->
									<section class="row" id="authSection" style="display:none;">
										<label for="auth_code">인증번호</label>
										<div class="box">
											<div class="auth-input">
												<input type="text" name="auth_code" id="auth_code" placeholder="인증번호입력" disabled required> 
												<span class="rest-time" id="rest_time">05:00</span>
											</div>
											<input type="button" class="before" value="인증하기" id="authChkBtn">
											<input type="button" class="after" value="인증완료" style="display:none;" required>
											<!-- 히든속성으로 인증전 기본값 2, 인증완료되면 1값으로 넘기기 -->
											<input type="hidden" id="auth_status" name="auth_status" value="2">
										</div>
										<div id="authCheckResult" class="result"></div>
									</section>
									
									
									<section class="row">
										<label for="mem_name">이름</label> <span class="required"> * </span>
										<div class="box">
											<input type="text" name="mem_name" id="mem_name" placeholder="이름" onblur="checkNameResult()" required> 
										</div>
										<div id="checkName" class="result"></div>
									</section>
									
									<section class="row">
										<label for="mem_nick">닉네임</label> <span class="required"> * </span>
										<div class="box">
											<input type="text" name="mem_nick" id="mem_nick" placeholder="닉네임" onblur="ckNick()" required> 
										</div>
										<div id="checkNic" class="result"></div>
									</section>
									
									<section class="row">
										<label for="mem_id">아이디</label> <span class="required"> * </span>
										<div class="box">
											<input type="text" name="mem_id" id="mem_id" placeholder="아이디" onblur="checkId()" required> 
										</div>
										<div id="checkIdResult" class="result"></div>
									</section>
									
									<section class="row">
										<label for="mem_passwd1">비밀번호</label> <span class="required"> * </span>
										<div class="box"> 
											<input type="password" name="mem_passwd" id="mem_passwd1" placeholder="비밀번호 입력" onblur="checkPasswdLength1()" required> 
<!-- 											<input type="password" name="mem_passwd" id="mem_passwd1" placeholder="비밀번호 입력" required>  -->
										</div>
										<div id="checkPasswd1" class="result"></div>
									</section>
									
									<section class="row">
										<label for="mem_passwd2">비밀번호 확인</label> <span class="required"> * </span>
										<div class="box">
											<input type="password" name="mem_passwd2" id="mem_passwd2" placeholder="비밀번호 재입력" required> 
										</div>
										<div id="checkPasswd2" class="result"></div>
									</section>
									
									<section class="row">
										<label for="mem_email1">이메일</label> <span class="required"> * </span>
										<div class="box">
											<input type="text" name="mem_email1" id="mem_email1" placeholder="Email" required>
											@
											<input type="text" size="10" id="mem_email2" name="mem_email2" required>
											<select id="emaildmain" class="form-sel">
												<option value="">직접입력</option>
												<option value="naver.com">naver.com</option>
												<option value="gmail.com">gmail.com</option>
												<option value="daum.net">daum.net</option>
											</select> 
										</div>
										<!-- 메일 xxx@xxx.xxx -->
										<input type="hidden" id="mem_email" name="mem_email" value="" required>
										<div id="checkMail" class="result"></div>
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
										<label for="mem_birthday">생년월일 <span class="required"> * </span> </label> 
										<select id="year" class="form-sel">
											<option value="YEAR">연도</option>
										</select>
										<select id="month" class="form-sel">
											<option value="MONTH">월</option>
										</select>
										<select id="day" class="form-sel" required>
											<option value="DAY">일</option>
										</select>
										<!-- 생년월일(yyyy-MM-dd) -->
										<input type="hidden" id="mem_birthday" name="mem_birthday" value="" required>
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
										<label for="terms_all">
											<input type="checkbox" id="terms_all" required> <span class="terms-text">전체 동의하기</span>
										</label>
										<span class="required"> * </span>
										<div>
											<label>
												<input type="checkbox" name="terms" id="terms1" class="terms"><a href="Policy" class="terms-text">[필수] 굿바이 이용약관 동의</a>
											</label>
											<label>
												<input type="checkbox" name="terms" id="terms2" class="terms"><a href="Privacy" class="terms-text">[필수] 개인정보 수집 이용 동의</a>
											</label>
											<label>
												<input type="checkbox" name="terms" id="terms3" class="terms"><a href="Privacy" class="terms-text">[필수] 휴대폰 본인확인 서비스</a>
											</label>
										</div>
									</section>
									<!-- sns연동은 hidden값으로 연동안함(2) 넘기기 -->
									<input type="hidden" id="sns_status" name="sns_status" value="2">
									<button id="submitBtn" onclick="checkSubmit()">회원 가입하기</button>
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
</body>
</html>