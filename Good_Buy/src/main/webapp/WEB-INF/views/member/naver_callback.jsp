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
		var naver_id_login = new naver_id_login("v2NPkz3kuDJkYM_nAyMT", "NaverCallback");
	  // 접근 토큰 값 출력
		alert(naver_id_login.oauthParams.access_token);
	  // 네이버 사용자 프로필 조회
		naver_id_login.get_naver_userprofile("naverSignInCallback()");
		console.log('콜백실행')  
		 
	  // 네이버 사용자 프로필 조회 이후 프로필 정보를 처리할 callback function
		function naverSignInCallback() {
			nickname = naver_id_login.getProfileData('nickname');
			name = naver_id_login.getProfileData('name');
			email = naver_id_login.getProfileData('email');
			id = naver_id_login.getProfileData('id');
			
			$.ajax({
				type: 'POST',
				url: 'NaverLogin', 
				data: {
					'mem_id': id,
					'mem_name': name,
					'email': email,
					'mem_nick': nickname
					}, // data
				dataType: 'text',
				success: function(result) {
					if(result == 1) {
						console.log('성공')
						closePopupAndRedirect(); 
					} else  {
						window.close();
					}
				}, 
				error: function(result) {
					window.close();
				} 
			}) 
		 }
		
		function closePopupAndRedirect(){
			window.opener.postMessage('NaverLoginSuccess', '*'); 
			window.close(); 
		}
    </script>
</body>
</html>