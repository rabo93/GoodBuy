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

<!-- CSS for Page -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/login.css">

</head>
<body>
	<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
	<script type="text/javascript">
		var naver_id_login = new naver_id_login("v2NPkz3kuDJkYM_nAyMT", "http://localhost:8081/NaverCallback");
	  // 접근 토큰 값 출력
// 		alert(naver_id_login.oauthParams.access_token);
	  // 네이버 사용자 프로필 조회
		naver_id_login.get_naver_userprofile("naverSignInCallback()");
		console.log('콜백실행')  
		 
	  // 네이버 사용자 프로필 조회 이후 프로필 정보를 처리할 callback function
		function naverSignInCallback() {
			console.log(naver_id_login);
			console.log(naver_id_login.getProfileData('email'));
			console.log(naver_id_login.getProfileData('profileImage'));
			
			const nickname = naver_id_login.getProfileData('nickname');
			const name = naver_id_login.getProfileData('name');
			const email = naver_id_login.getProfileData('email');
			const id = naver_id_login.getProfileData('id');
			const gender = naver_id_login.getProfileData('gender');
			const img = naver_id_login.getProfileData('profile_image');
            
			$.ajax({
				type: 'POST',
				url: 'NaverLogin', 
				data: {
					'mem_id': id,
					'mem_name': name,
					'mem_email': email,
					'mem_nick': nickname,
					'mem_gender' : gender,
					'mem_profile' : img
					}, // data
				dataType: 'text',
				success: function(result) {
					console.log("result :" + result);
					
					if(result == 1) {
						console.log("신규회원 가입 성공!");
						closePopupAndRedirect(); 
					} else if(result == 2)  {
						console.log("기존회원 로그인 성공!");
						closePopupAndRedirect(); 
					} else {
						console.error("가입 실패");
						alert("로그인에 실패했습니다. 다시 시도해주세요.");
						window.close();
					}
				}, error: function(xhr, status, error) {
			        console.error('AJAX 요청 실패:', error);
			        alert('서버와의 통신 중 오류가 발생했습니다. 잠시 후 다시 시도해주세요.');
			        window.close();
			    }
			}) 
		 }
		
		function closePopupAndRedirect(){
			window.opener.postMessage('NaverLoginSuccess', '*'); 
			window.close(); 
		}
		
		window.addEventListener("load", function () {
		    const urlParams = new URLSearchParams(window.location.search);
		    const error = urlParams.get('error');

		    if (error === 'access_denied') {
		        window.close();
		    }
		});
    </script>
</body>
</html>