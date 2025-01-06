<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage.css">

<!-- JS for Page -->
<script src="${pageContext.request.contextPath}/resources/js/slick.js"></script>

</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/inc/header.jsp"></jsp:include>
	</header>
	<main>
		<!-- 계정설정 -->
		<section class="wrapper">
			<div class="page-inner">
				<!-- *********** 여기 안에 작업하세요. section.wrapper/div.page-inner 건들지말기 ******** -->
				<!-- -->
				<h2 class="page-ttl">마이페이지</h2>
				<section class="my-wrap">
				<aside class="my-menu">
					<h3>거래 정보</h3>
					<a href="MyStore">나의 상점</a>
					<a href="GoodPay">굿페이</a>
					<a href="MyOrder">구매내역</a>
					<a href="MySales">판매내역</a>
					<h3>나의 정보</h3>
					<a href="MyInfo">계정정보</a>
					<a href="MyWish">관심목록</a>
					<a href="MyReview">나의 후기</a>
					<a href="MyReviewHistory">내가 쓴 후기</a>
					<a href="MySupport"  class="active">1:1문의내용</a>
					<a href="">나의 광고</a>
				</aside>
				<div class="my-container">
					<div class="contents-ttl">1:1문의 게시판</div>
				
				<!-- *********** // 여기 안에 작업하세요. section.wrapper/div.page-inner 건들지말기 ******** -->
				<!-- contents -->
					<section class="inq-wrap">
						<div class="com">
							<label>분류</label>
							<span>
								<c:if test="${support.support_category == 1}">이용문의</c:if>
								<c:if test="${support.support_category == 2}">결제문의</c:if>
								<c:if test="${support.support_category == 3}">기타</c:if>
							</span>
						</div>
	                    <div class="com">
		                    <label>제목</label>
							<span>${support.support_subject}</span>
	                    </div>
	                    <div class="com">
	                    	<label>작성일자</label>
							<span>
								${support.support_date}
							</span>
	                    </div>
	                    <div class="com">
	                    	<label>내용</label>
							<span class="contents">
								${support.support_content}
							</span>
	                    </div>
	                    <!-- 파일 첨부 -->
						<c:if test="${not empty support.support_file1}">
		                    <div class="com attach">
		                    	<label>첨부파일</label>
		                    	<span>
									<div>${support.support_file1}
		 								<a href="${pageContext.request.contextPath}/resources/upload/${fileName}" download="${originalFileName}">
		 									<input type="button" value="다운로드">
		 								</a>
	 								</div>
		                    	</span>
		                    </div>
						</c:if>
						<c:if test="${support.support_answer_date != null}">
							<div class="reply-hr"></div>
							<div class="com reply">
								<label>답변제목</label>
								<span class="subject">
									${support.support_answer_subject}
								</span>
							</div>
							<div class="com reply">
								<label>답변내용</label>
								<span class="contents">
									${support.support_answer_content}
								</span>
							</div>
						</c:if>
	                    <div class="btns">
		                    <c:if test="${not empty sessionScope.sId}">
		                    	<c:if test="${sessionScole.sId eq 'admin'}">
									<button type="button">답글</button>
		                    	</c:if>
								<c:if test="${sessionScope.sId eq support.mem_id or sessionScope.sId eq 'admin'}">
									<button onclick="requestModify(${support.support_id})">수정</button>
									<button onclick="confirmDelete(${support.support_id})">삭제</button>
								</c:if>
							</c:if>
							<button onclick="location.href='MySupport?pageNum=${param.pageNum}'">목록으로</button>
	                    </div>
					</section>
					<!-- // contents -->
					</div>
				</section>
		</div>
		</section>
	</main>
	<footer>
		<jsp:include page="/WEB-INF/views/inc/footer.jsp"></jsp:include>
	</footer>
	<script type="text/javascript">
		function confirmDelete(supportId) {
			if(confirm ("정말 삭제하시겠습니까?")){
				$.ajax({
					url : "ConfirmDelete",
					type : "POST",
					data : {
						support_id : supportId
					},
					success : function (response) {
						alert("문의사항이 삭제 되었습니다.");
						location.href="MySupport";
					},
					error : function () {
						alert("삭제실패 \\n다시 시도해주세요!");
					}
				})
			}
		}
	</script>
	
	<script type="text/javascript">
	    function requestModify(supportId) {
	        location.href = "RequestModify?support_id=" + supportId;
	    }
	</script>
	
</body>
</html>