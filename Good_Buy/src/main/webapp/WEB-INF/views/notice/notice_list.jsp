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
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/notice.css">
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>


<!-- font-awesome -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/fontawesome/all.min.css" />
<script src="${pageContext.request.contextPath}/resources/fontawesome/all.min.js"></script>

<!-- ******************* 아래 CSS와 JS는 페이지별로 알맞게 Import 해주세요 ****************** -->
<!-- CSS for Page -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css">

<!-- JS for Page -->
<script src="${pageContext.request.contextPath}/resources/js/slick.js"></script>

</head>
<body>
<header>
	<jsp:include page="/WEB-INF/views/inc/header.jsp"></jsp:include>
</header>
	<main>
		<section class="wrapper">
			<!-- *********** 여기 안에 작업하세요. section.wrapper 건들지말기 ******** -->
			<div id="nt_commandArea">
				<div class="nt-head">
					<h2>공지사항</h2>
				</div>
				<section>
<!-- 					<div class="nt-form"> -->
<!-- 						<form class="nt-search-form" method="get"> -->
<!-- 							<select name="searchType"> -->
<%-- 								<option value="subject" <c:if test="${param.searchType eq 'subject'}">selected</c:if>>제목</option> --%>
<%-- 								<option value="content" <c:if test="${param.searchType eq 'content'}">selected</c:if>>내용</option> --%>
<%-- 								<option value="subject_content" <c:if test="${param.searchType eq 'subject_content'}">selected</c:if>>제목&내용</option> --%>
<!-- 							</select> -->
<!-- 							<input type="text" name="searchKeyword" placeholder="검색어를 입력하세요"> -->
<!-- 							<input type="submit" value="검색"> -->
<!-- 						</form> -->
<!-- 					</div> -->
					<c:if test="${sessionScope.sGrade eq '관리자'}">
						<div class="nt-writebtn">
							<input type="button" value="글쓰기" onclick="location.href='NoticeWrite'">
						</div>
					</c:if>
					<div class="tb-wrap">
						<table class="nt-table tb-01">
							<colgroup>
								<col width="60%">
								<col width="20%">
								<col width="20%">
							</colgroup>
								<tr>
									<th class="nt-title">제목</th>
									<th>작성자</th>
									<th>날짜</th>
								</tr>
								<c:forEach items="${noticeList}" var="noticeBoard">
									<tr>
										<td class="nt_id" hidden>${noticeBoard.notice_id}</td>
										<td class="nt_subject">${noticeBoard.notice_subject}</td>
										<td>${noticeBoard.mem_id}</td>
										<td>${noticeBoard.notice_date}</td>
									</tr>
								</c:forEach>
						</table>
					</div>
				</section>
			</div>
			<!-- *********** // 여기 안에 작업하세요. section.wrapper 건들지말기 ******** -->
		</section>
	</main>
<footer>
	<jsp:include page="/WEB-INF/views/inc/footer.jsp"></jsp:include>
</footer>
</body>
<script src="${pageContext.request.contextPath}/resources/js/notice.js"></script>
<script type="text/javascript">
	if (performance.navigation.type === 1) {
		location.href= "NoticeMain";
	}
	
	//	무한스크롤
	let pageNum = "2";
	let lastScroll = 0;
	let isContinue = true;
	$(window).scroll(function(){
		let currentScroll = $(this).scrollTop();
		let documentHeight = $(document).height();
		let windowHeight = $(window).height();
		
		if(currentScroll > lastScroll) {
			if((currentScroll + windowHeight + 10) > documentHeight && isContinue) {
				load_list();
				isContinue = false;
			}
		}
		lastScroll = currentScroll

	});
	
	
	function load_list() {
		$.ajax({
			type : "GET",
			url : "NoticeListJson",
			data : {
				pageNum : pageNum
			},
			dataType : "json"
		}).done(function(data){
			for (let notice of data.noticeList) {
				let item = '<tr>'
					 		+ '<td class="nt_id" hidden>' + notice.notice_id + '</td>'
					 		+ '<td class="nt_subject">' + notice.notice_subject + '</td>'
					 		+ '<td>' + notice.mem_id + '</td>'
					 		+ '<td>' + notice.notice_date + '</td>'
				 		+ '</tr>';
				$(".nt-table").append(item);
			}
			
			if (pageNum < data.pageInfo.maxPage) {
				isContinue = true;
				pageNum++;
			}
			
		}).fail(function(){
			
		});
	}
	
	
	
	
	
	
	
	
	
	
	
	
</script>
</html>