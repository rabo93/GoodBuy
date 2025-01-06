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
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/product.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/pay.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage.css">
<!-- JS for Page -->
<script src="${pageContext.request.contextPath}/resources/js/product.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/pay.js"></script>
</head>


<body>
	<main>
		<section class="wrapper">
			<div class="page-inner">
				<!-- *********** 여기 안에 작업하세요. section.wrapper/div.page-inner 건들지말기 ******** -->
                
                
                
                
		        
		        
		        
		        	<div class="my-container">
						<div class="contents-ttl">
							<h3>굿페이 > 굿페이 송금</h3>

							<div class="goodpay-container">
								<!-- 여기서부터 작업해야 함!!! -->
								<h1>핀테크 계좌 송금결과</h1>
								<h3>1)출금이체결과</h3>
								<table id="info_table">
									<tr>
										<th>출금계좌번호</th> <%-- 세션의 token 객체에 저장되어 있음 --%>
										<th>${transferResult.withdrawResult.account_num_masked}</th>
									</tr>
									<tr>
										<th>핀테크이용번호</th>
										<td>${transferResult.withdrawResult.fintech_use_num}</td>
									</tr>
									<tr>
										<th>출금금액</th>
										<td>￦ ${transferResult.withdrawResult.tran_amt}</td>
									</tr>
									<tr>
										<th>출금일시</th>
										<td>${transferResult.withdrawResult.api_tran_dtm}</td>
						<!-- 				DB에서 받은 날짜를 Map으로 받으면 T가 나옴. 앞에서 배웠으니 처리하라... 배운거 맞나? -->
									</tr>
									<tr>
										<th colspan="2"><input type="button" value="돌아가기" onclick="history.back()"></th>
									</tr>
								</table>
								
								<hr>
								<h3>2)입금이체결과</h3>
								<table id="info_table">
									<tr>
										<th>예금주명</th>
										<th>${transferResult.depositResult.res_list[0].account_holder_name}</th>
									</tr>
									<tr>
										<th>입금계좌번호</th>
										<th>${transferResult.depositResult.res_list[0].account_num_masked}</th>
									</tr>
									<tr>
										<th>입금은행명</th> 
										<th>${transferResult.depositResult.res_list[0].bank_name}</th>
									</tr>
									<tr>
										<th>핀테크이용번호</th>
										<td>${transferResult.depositResult.res_list[0].fintech_use_num}</td>
									</tr>
									<tr>
										<th>입금금액</th>
										<td>￦ ${transferResult.depositResult.res_list[0].tran_amt}</td>
									</tr>
									<tr>
										<th>입금일시</th>
										<td>${transferResult.depositResult.api_tran_dtm}</td>
						<!-- 				DB에서 받은 날짜를 Map으로 받으면 T가 나옴. 앞에서 배웠으니 처리하라... 배운거 맞나? -->
									</tr>
									<tr>
										<th colspan="2"><input type="button" value="돌아가기" onclick="history.back()"></th>
									</tr>
								</table>							 	
						    </div>
                		</div>
                	</div>
				<!-- *********** // 여기 안에 작업하세요. section.wrapper/div.page-inner 건들지말기 ******** -->
			</div>
		</section>
	</main>
</body>
</html>
