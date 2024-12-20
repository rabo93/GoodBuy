<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
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
			<div id="nt_write_container">
				<div class="nt-head">
					<h2>공지사항 글쓰기</h2>
				</div>
				<section class="tb-wrap">
					<form action="NoticeWrite" name="writeForm" method="post" enctype="multipart/form-data">
						<table class="nt-table tb-02">
							<colgroup>
								<col width="20%">
								<col width="80%">
							</colgroup>
							<tr>
								<th>글쓴이</th>
								<td>
<%-- 									<input type="text" name="mem_id" value="${sessionScope.sId}" readonly> --%>
									<input type="text" name="mem_id" value="admin" readonly>
								</td>
							</tr>
							<tr>
								<th>제목</th>
								<td>
									<input type="text" name="notice_subject">
								</td>
							</tr>
							<tr>
								<th>내용</th>
								<td>
									<textarea rows="15" cols="40" name="notice_content"></textarea>
								</td>
							</tr>
							<tr>
								<th>파일첨부</th>
								<td>
									<input type="file" name="file">
								</td>
							</tr>
						</table>
						<section class="btns">
							<input type="submit" value="등록">
							<input type="button" value="취소" onclick="history.back()">
						</section>
					</form>
				</section>
			</div>
			<!-- *********** // 여기 안에 작업하세요. section.wrapper 건들지말기 ******** -->
		</section>
	</main>
	<footer>
		<jsp:include page="/WEB-INF/views/inc/footer.jsp"></jsp:include>
	</footer>
</body>
</html>