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
				<a href="MyReviewHistory"  class="active">내가 쓴 후기</a>
				<a href="MySupport">1:1문의내역</a>
				<a href="">나의 광고</a>
			</aside>
			<div class="my-container">
				<div class="contents-ttl">내가 쓴 후기</div>
				<div class="contents">
					<!-- contents -->
					<section class="my-rev-wrap">
						<div class="my-rev-li">
						<c:choose>
								<c:when test="${empty review}">
									<div class="empty">작성된 후기가 없습니다.</div>
								</c:when>
								<c:otherwise>	
<!-- 									<div class="review-rating"> -->
<%-- 						                <span class="rating-score">${course[0].review_score}</span><br> --%>
<!-- 						                <span class="stars"><i class="fa-solid fa-star"></i></span> -->
<!-- 						            </div> -->
						            <c:forEach var="review" items="${review}" varStatus="status">
						            	<div class="review-box">
										    <div class="r_header">
										        <div class="profile-icon"></div>
										        <div class="user-info">
										            <img src="${pageContext.request.contextPath}/resources/img/user_thumb.png" id="profile_preview" height="60px"><br>
										            <div class="date">[${review.sellerNick} 상점]에서 구매한 [${review.product_title}]</div>
										            <div class="name">${review.buyerNick} | ${review.review_date}</div>
<%-- 										            <div class="product">${review.product_title}</div> --%>
										        </div>
										        <div>
									            	<c:if test="${review.review_score == '2'}">
										            	<input type="button" id="score" name="score" value="최고예요👍">
										            </c:if>
										            <c:if test="${review.review_score == '1'}">
										            	<input type="button" id="score"  name="score" value="좋아요💕">
										            </c:if>
										            <c:if test="${review.review_score == '0'}">
										           		<input type="button" id="score"  name="score" value="별로예요🥲">
									           	 	</c:if>
									            </div>
										    </div>
								            <div class=rating>
<!-- 												<i class="fa-solid fa-star" ></i> -->
<%-- 												<span><b>${review.review_score}</b></span> --%>
											</div>
										    <div class="review-text">${review.review_content}</div>
										    <input type="hidden" name="product_id" id="hiddenProductId">
											<button class="open-modal-btn"
										        data-product-id="${review.product_id}"
										        data-title="${review.product_title}"
										        data-buyer="${review.sellerNick}">
										        수정
										    </button>
										<button onclick="deleteReview(${review.review_id})">삭제</button>
										</div>
						            </c:forEach>
								</c:otherwise>
							</c:choose>	
						</div>
					</section>
					<!-- // contents -->
				</div>
			</div>
		</section>
	</main>
	<footer>
		<jsp:include page="/WEB-INF/views/inc/footer.jsp"></jsp:include>
	</footer>
	 <!-- 후기 수정 모달 (반복문 바깥에 모달 하나만 사용) -->
    <div id="review-modal" class="modal-overlay" style="display: none;">
        <div class="modal-content">
            <h2>
                <span id="buyerName"></span>님께 구매한 [<span id="productTitle"></span>]<br>후기 수정하기📮
            </h2>
            <input type="hidden" id="modal_product_id"> <!-- id저장용 -->
<!--             <input type="hidden" id="modal_review_cnt"> 리뷰 갯수 저장용 -->
            <textarea rows="4" cols="50" id="review_content" placeholder="후기를 작성해주세요."></textarea>
            <br>
            <button id="close-modal">닫기</button>
            <button id="submit-review">수정완료</button>
        </div>
    </div>
    
    <script type="text/javascript">
    $(document).ready(function () {
        // 후기 작성하기 버튼 클릭 이벤트
        $(".open-modal-btn").click(function () {
            const productId = $(this).data("product-id");
            const productTitle = $(this).data("title");
            const buyerName = $(this).data("buyer");
//             const review_cnt = $(this).data("review-cnt");

            // 모달에 데이터 주입
            $("#buyerName").text(buyerName);
            $("#productTitle").text(productTitle);
            $("#modal_product_id").val(productId);
//             $("#modal_review_cnt").val(review_cnt);


            $("#review-modal").fadeIn(300);
        });

        // 모달 닫기
        $("#close-modal").click(function () {
            $("#review-modal").fadeOut(300);
        });

        // 후기 제출 이벤트
        $("#submit-review").click(function () {
            const reviewText = $("#review_content").val();
            const productId = $("#modal_product_id").val();
            const productTitle = $("#productTitle").text();
// 			const review_cnt = $("#modal_review_cnt").val();

            if (!reviewText.trim()) {
                alert("후기를 작성해주세요!");
                return;
            }

            // 데이터 확인용 콘솔 출력
            console.log("리뷰 내용: " + reviewText);
            console.log("상품 ID: " + productId);
            console.log("상품 제목: " + productTitle);
// 			console.log(">>>>>>>>>>>>"+review_cnt);
			  

            // Ajax로 데이터 전송
            $.ajax({
                url: "MyReviewEdit",
                type: "POST",
                contentType: "application/json",
                data: JSON.stringify({
                    review: reviewText,
                    product_title: productTitle,
                    product_id: productId,
//                     review_cnt : review_cnt
                }),
                success: function () {
                    alert("후기가 수정되었습니다!");
                    $("#review-modal").fadeOut(300);
                    $("#review_content").val("");
                    location.reload();
                },
                error: function () {
                    alert("후기 등록에 실패했습니다.");
                }
            });
        });
    });

</script>

<script>
	function deleteReview(reviewId) {
	    if (confirm("정말 삭제하시겠습니까?")) {
	        $.ajax({
	            type: "POST",
	            url: "DeleteReview",
	            data: { reviewId: reviewId },
	            success: function(response) {
	                alert("삭제되었습니다.");
	                location.reload();
	            },
	            error: function() {
	                alert("삭제 실패!");
	            }
	        });
	    }
	}
</script>
	
</body>
</html>