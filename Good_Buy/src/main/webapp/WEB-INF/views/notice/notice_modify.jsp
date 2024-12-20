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
					<h2>글 수정하기</h2>
				</div>
				<section class="tb-wrap">
					<form action="NoticeModify" method="post" enctype="multipart/form-data">
						<input type="hidden" name="notice_id" value="${param.notice_id}">
<%-- 						<input type="hidden" name="pageNum" value="${param.pageNum}"> --%>
						<table class="nt-table tb-02">
							<colgroup>
								<col width="20%">
								<col width="80%">
							</colgroup>
							<tr>
								<td>작성자</td>
								<td>
<%-- 									<input type="text" name="mem_id" value="${sessionScope.sId}" readonly required /> --%>
									<input type="text" name="mem_id" value="admin" readonly required />
								</td>
							</tr>
							<tr>
								<td>제목</td>
								<td>
									<input name="notice_subject" value="${notice.notice_subject}" required />
								</td>
							</tr>
							<tr>
								<td>내용</td>
								<td>
									<textarea name="notice_content" rows="15" cols="40" required>${notice.notice_content}</textarea>
								</td>
							</tr>
							<tr>
								<td>첨부파일</td>
								<td>
									<div class="board_file" id="file">
										<c:choose>
											<c:when test="${not empty notice.notice_file}">
												<input type="text" value="${originalFile}" readonly>
												<a href="${pageContext.request.contextPath}/resources/upload/${notice.notice_file}" download="${originalFile}"><i class="fa-solid fa-download"></i></a>
												<a href="javascript:deleteFile(${notice.notice_id}, '${notice.notice_file}')"><i class="fa-solid fa-trash"></i></a>
												<input type="file" name="file" hidden>
											</c:when>
											<c:otherwise>
												<input type="file" name="file">
											</c:otherwise>
										</c:choose>
									</div>
									<div>
									</div>
								</td>
							</tr>
						</table>
						<section class="btns">
							<input type="submit" value="수정">
							<input type="button" value="취소" onclick="location.href='NoticeMain'">
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
<script src="${pageContext.request.contextPath}/resources/js/notice.js"></script>
</html>