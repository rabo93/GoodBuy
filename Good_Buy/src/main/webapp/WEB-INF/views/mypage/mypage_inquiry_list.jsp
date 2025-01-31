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
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/notice.css">
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
                        <a href="MySupport" class="active">1:1문의내역</a>
                    </aside>
					<div class="my-container">
						<div class="contents-ttl">1:1 문의</div>
						<div class="contents">
							<!-- contents -->
							<section class="inq-wrap">
							<div class="nt-form">
							<%--검색 필터 --%>
								<form action="" class="nt-search-form" method="get">
								<input type="text" id="nt-searchKeyword" name="searchKeyword" value="${param.searchKeyword}" placeholder="검색어를 입력하세요">
								<input type="submit" value="검색">
								</form>
							</div>
								<div class="inq-tops">
									<button class="btn-inq" onclick="location.href='MySupportWrite'">문의 남기기</button>
								</div>
								<div class="tb-wrap">
									<table class="tb-01 tb-inq">
										<colgroup>
		<%-- 									<col width="10%"> --%>
											<col width="15%">
											<col width="50%">
											<col width="15%">
											<col width="20%">
										</colgroup>
										<thead>
											<tr>
		<!-- 										<th>번호</th> -->
												<th>분류</th>
												<th>제목</th>
												<th>작성자</th>
												<th>날짜</th>
											</tr>
										</thead>
										<tbody>
											<c:set var="pageNum" value="1" />
											<c:if test="${not empty param.pageNum}">
												<c:set var="pageNum" value="${param.pageNum}" />
											</c:if>
											<c:choose>
												<c:when test="${empty supportList}">
													<tr>
														<td class="empty" colspan="4">작성한 문의내역이 없습니다.</td>
													</tr>
												</c:when>
												<c:otherwise>
													<c:forEach var="support" items="${supportList}">
														<tr>
															<td class="board_num" style="display:none;">${support.support_id}</td>
															<td>
																<c:if test="${support.support_category == 1}">
																	이용문의
																</c:if>
																<c:if test="${support.support_category == 2}">
																	결제문의
																</c:if>
																<c:if test="${support.support_category == 3}">
																	기타
																</c:if>
															</td>
															<td class="subject">
																${support.support_subject}
																<c:if test="${support.reply_date != null}">
		<!-- 															<span class="inq-reply">답변완료<i class="fa-solid fa-reply"></i></span> -->
																		<button class="inq-reply" disabled>답변완료 <i class="fa-solid fa-reply"></i></button>
																</c:if>
															</td>
															<td>${support.mem_id}</td>
															<td><fmt:formatDate value="${support.support_date}" pattern="yy-MM-dd" /></td>
														</tr>
														
													</c:forEach>
												</c:otherwise>
											</c:choose>
		<!-- 									<tr class="reply"> -->
		<!-- 										<td>└</td> -->
		<!-- 										<td>답변</td> -->
		<!-- 										<td class="subject">안녕하세요. 런온 입니다.</td> -->
		<!-- 										<td>관리자</td> -->
		<!-- 										<td>2024-11-06</td> -->
		<!-- 									</tr> -->
										</tbody>
									</table>
									<div class="no-data" style="display:none;">데이터가 존재하지 않습니다.</div>
								</div>
								<section id="pageList">
									<button 
										onclick="location.href='MySupport?pageNum=${pageInfo.startPage - pageInfo.pageListLimit}'"
										<c:if test="${pageInfo.startPage == 1}">disabled</c:if>
									><i class="fa-solid fa-angles-left"></i></button>
									<button 
										onclick="location.href='MySupport?pageNum=${pageNum - 1}'"
										<c:if test="${pageNum == 1}">disabled</c:if>
									><i class="fa-solid fa-angle-left"></i></button>
									<c:forEach var="i" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
										<c:choose>
											<c:when test="${i eq pageNum}">
												<strong>${i}</strong>
											</c:when>
											<c:otherwise>
												<a href="MySupport?pageNum=${i}">${i}</a>
											</c:otherwise>
										</c:choose>
									</c:forEach>
									<button 
										onclick="location.href='MySupport?pageNum=${pageNum + 1}'"
										<c:if test="${pageNum == pageInfo.maxPage}">disabled</c:if>
									><i class="fa-solid fa-angle-right"></i></button>
									<button
										onclick="location.href='MySupport?pageNum=${pageInfo.startPage + pageInfo.pageListLimit}'"
										<c:if test="${pageInfo.endPage == pageInfo.maxPage}">disabled</c:if>
									><i class="fa-solid fa-angles-right"></i></button>
								</section>
							</section>
							<!-- // contents -->
						</div>
					</div>
				</section>
			</div>
		</section>
	</main>
	<footer>
		<jsp:include page="/WEB-INF/views/inc/footer.jsp"></jsp:include>
	</footer>

	<script type="text/javascript">
			$(".subject").on("click", function(event) {
				let parent = $(event.target).parent();
				let board_num = $(parent).find(".board_num");
				console.log(board_num.text());
				location.href = "MySupportDetail?support_id=" + board_num.text()+"&pageNum=" + ${pageNum};
			});
	</script>
	<script>
	$(document).ready(function () {
	    // 필터 버튼 클릭 이벤트
	    $(".filter-btn").click(function () {
	    	$(".filter-btn").removeClass('active');
	    	$(this).addClass('active');
	        const status = $(this).data("status");  // 클릭된 버튼의 data-status 값

	        // 상품 카드 필터링
	        $(".product-card").each(function () {
	            const productStatus = $(this).data("status");  // 각 상품 카드에서 data-status 값 가져오기
	            
	            // 콘솔 디버깅 (확인용)
	            console.log("Button Status:", status);
	            console.log("Product Status:", productStatus);

	            // 상태가 일치하거나 '전체(all)'인 경우 보여주기
	            if (status == 'all' || status == productStatus) {
	                $(this).show();
// 	                $(this).fadeIn();
	            } else {
// 	                $(this).hide();
	                $(this).fadeOut();
	            }
	        });
	    });
	    
	    
	 	// 모바일 마이페이지 활성화 메뉴로 자동 스크롤 포커싱
	    menuFocusing();
	    
	});
	
	// 모바일 마이페이지 활성화 메뉴로 자동 스크롤 포커싱
	function menuFocusing(){
		let menuIdx = 0;
	    const myMenu = document.querySelector(".my-menu");
	    const myMenuItems = document.querySelectorAll(".my-menu > a");
		
		myMenuItems.forEach((elem, idx) => {
	    	if(elem.classList.contains("active")) menuIdx = idx;
	    });
		
		myMenu.scrollTo({
			left : myMenuItems[menuIdx].getBoundingClientRect().left - myMenuItems[menuIdx].getBoundingClientRect().width, 
			behavior : 'smooth'
		});
	}
	
	

    </script>




</body>
</html>