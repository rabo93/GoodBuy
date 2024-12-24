<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>굿바이 - 중고거래, 이웃과 함께 더 쉽게!</title>

<link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/img/g_favicon.ico" type="image/x-icon">
<link rel="icon" href="${pageContext.request.contextPath}/resources/img/g_favicon.ico" type="image/x-icon">

<!-- default -->
<link rel="stylesheet" href="../../resources/css/common.css">
<link rel="stylesheet" href="../../resources/css/default.css">
<script src="../../resources/js/jquery-3.7.1.js"></script>

<!-- font-awesome -->
<link rel="stylesheet" href="../../resources/fontawesome/all.min.css" />
<script src="../../resources/fontawesome/all.min.js"></script>

<!-- ******************* 아래 CSS와 JS는 페이지별로 알맞게 Import 해주세요 ****************** -->
<!-- CSS for Page -->
<link rel="stylesheet" href="../../resources/css/product.css">
<link rel="stylesheet" href="../../resources/css/pay.css">
<!-- JS for Page -->
<script src="../../resources/js/product.js"></script>


</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/inc/header.jsp"></jsp:include>
	</header>
	<main>
		<section class="wrapper">
			<div class="page-inner">
				<!-- *********** 여기 안에 작업하세요. section.wrapper/div.page-inner 건들지말기 ******** -->
                <h2 class="page-title">굿페이 > 굿페이 충전</h2>
                
				 <div class="goodpay-container">
				 ?? 지금 출금이 아이티윌로 간거면 
				 
				 충전되어 있는 금액도 아이티윌로 들어간거겟네
				 
				 그럼 출금 결과랑 충전결과가 같이  떠야 한다. 
				 	<h1>핀테크 계좌 출금 이체결과</h1>
					<h3>${account_holder_name} 고객님의 정보</h3>
					<table border="1">
						<tr>
							<th>사용자번호</th> <%-- 세션의 token 객체에 저장되어 있음 --%>
							<td>ok ${token.user_seq_no}</td>
						</tr>
						<tr>
							<th>핀테크이용번호</th>
							<td>${withdrawResult.FINTECH_USE_NUM}</td>
						</tr>
						<tr>
							<th>상대방 계좌번호</th><!-- 사실 지금은 핀테크이용번호로 이체해서 상대방 계좌번호는 의미가 없다. -->
							<%-- 핀테크 이용번호로 출금했으므로 임의의 계좌번호가 출력됨 --%>
							<td>${withdrawResult.DPS_ACCOUNT_NUM_MASKED}</td>
						</tr>
						<tr>
							<th>출금금액</th>
							<td>￦ ${withdrawResult.TRAN_AMT}</td>
						</tr>
						<tr>
							<th>출금일시</th>
							<td>${withdrawResult.API_TRAN_DTM}</td>
			<!-- 				DB에서 받은 날짜를 Map으로 받으면 T가 나옴. 앞에서 배웠으니 처리하라... 배운거 맞나? -->
						</tr>
						<tr>
							<th colspan="2"><input type="button" value="돌아가기" onclick="history.back()"></th>
						</tr>
					</table>
			        
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