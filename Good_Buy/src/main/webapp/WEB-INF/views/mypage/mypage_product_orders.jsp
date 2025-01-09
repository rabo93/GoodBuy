<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/img/g_favicon.ico" type="image/x-icon">
<link rel="icon" href="${pageContext.request.contextPath}/resources/img/g_favicon.ico" type="image/x-icon">

<title>굿바이 - 중고거래, 이웃과 함께 더 쉽게!</title>

<!-- 기본 CSS 및 JS -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/default.css">
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/fontawesome/all.min.css" />
<script src="${pageContext.request.contextPath}/resources/fontawesome/all.min.js"></script>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage.css">
<script src="${pageContext.request.contextPath}/resources/js/slick.js"></script>
</head>

<body>
    <header>
        <jsp:include page="/WEB-INF/views/inc/header.jsp"></jsp:include>
    </header>
    
    <main>
        <section class="wrapper">
            <div class="page-inner">
                <h2 class="page-ttl">마이페이지</h2>
                
                <section class="my-wrap">
                    <aside class="my-menu">
                        <h3>거래 정보</h3>
                        <a href="MyStore">나의 상점</a>
                        <a href="GoodPay">굿페이</a>
                        <a href="MyOrder" class="active">구매내역</a>
                        <a href="MySales">판매내역</a>
                        <h3>나의 정보</h3>
                        <a href="MyInfo">계정정보</a>
                        <a href="MyWish">관심목록</a>
                        <a href="MyReview">나의 후기</a>
                        <a href="MyReviewHistory">내가 쓴 후기</a>
                        <a href="MySupport">1:1문의내역</a>
                    </aside>

                    <div class="my-container">
                        <div class="contents-ttl">
                            <h3>구매내역 <small>(총 <span>${orderCount}</span>건)</small></h3>
                            <div class="product-list">
                                <c:choose>
                                    <c:when test="${empty order}">
                                        <ul>
                                            <li>구매내역이 없습니다.</li>
                                        </ul>
                                    </c:when>
                                    <c:otherwise>
                                        <c:forEach var="product" items="${order}">
                                            <li class="product-card">
                                                <img src="${pageContext.request.contextPath}/resources/img/product_thumb.jpg"
                                                     class="card-thumb" alt="thumbnail" height="180px"/>
                                                <div class="card-info">
                                                    <div class="category">
                                                        <span>${product.product_category}</span>
                                                        <span class="type">직거래</span>
                                                    </div>
                                                    <div class="ttl">
                                                        <c:if test="${product.product_status == 3}">
                                                            [거래완료]
                                                        </c:if>
                                                        ${product.product_title}
                                                    </div>
                                                    <div class="price">
                                                        <fmt:formatNumber value="${product.product_price}" type="number" pattern="#,###" />원
                                                    </div>
                                                    <div class="card-row">
                                                        <span class="add">${product.product_trade_adr1}</span>
                                                        <span class="name">${product.mem_nick}</span>
                                                    </div>
                                                    
                                                    <!-- 후기 작성하기 버튼 (상품 정보 포함) -->
<!--                                                     	<input type="hidden" name="product_id" id="hiddenProductId"> -->
<!-- 	                                                    <button class="open-modal-btn" -->
<%-- 														        data-product-id="${product.product_id}" --%>
<%-- 														        data-title="${product.product_title}" --%>
<%-- 														        data-buyer="${product.mem_nick}" --%>
<%--  														        data-review-cnt="${product.review_cnt}" --%>
<%-- 														        type="button" ${product.review_cnt == 1 ? 'disabled' : ''}> --%>
<%-- 														    ${product.review_cnt == 1 ? '작성완료📩' : '후기 작성하기📮'} --%>
<!-- 														</button> -->
                                                    	<input type="hidden" name="product_id" id="hiddenProductId">
                                                    	<c:choose>
                                                    		<c:when test="${product.review_cnt == 0}">
	                                                    		 <button class="open-modal-btn"
															        data-product-id="${product.product_id}"
															        data-title="${product.product_title}"
															        data-buyer="${product.mem_nick}">
															        후기 작성하기📮
															     </button>
                                                    		</c:when>
                                                    		<c:otherwise><a class="review-done-btn" href='MyReviewHistory'><i class="fa-regular fa-envelope"></i> 작성완료</a></c:otherwise>
                                                    	</c:choose>
                                                </div>
                                            </li>
                                        </c:forEach>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                </section>
            </div>
        </section>
    </main>
    
    <footer>
        <jsp:include page="/WEB-INF/views/inc/footer.jsp"></jsp:include>
    </footer>

    <!-- 후기 작성 모달 (반복문 바깥에 모달 하나만 사용) -->
    <div id="review-modal" class="modal-overlay" style="display: none;">
        <div class="modal-content">
            <h2>
                <span id="buyerName"></span>님께 구매한 [<span id="productTitle"></span>]<br>후기 보내기📮
            </h2>
	        <br>
           	<label><input type="radio" name="score" value="2">최고예요🥳</label>
          	<label><input type="radio" name="score" value="1">좋아요💕</label>
           	<label><input type="radio" name="score" value="0">별로예요👿</label>
            <input type="hidden" id="modal_product_id"> <!-- id저장용 -->
<!--             <input type="hidden" id="modal_review_cnt"> 리뷰 갯수 저장용 -->
			<!-- 추가 리뷰 옵션 (중복 선택 가능) -->
	        <br><br>
	        <h3>추가로 만족한 부분을 선택해 주세요 (복수 선택 가능)</h3>
	        <label><input type="checkbox" name="reviewOptions" value="1"> 배송이 빨라요🚚</label>
	        <label><input type="checkbox" name="reviewOptions" value="2"> 친절해요💖</label><br>
	        <label><input type="checkbox" name="reviewOptions" value="3"> 물건상태가 좋아요✨</label>
	        <label><input type="checkbox" name="reviewOptions" value="4"> 또 거래하고 싶어요💰</label>
	        <br><br>
            <textarea rows="4" cols="50" id="review_content" placeholder="후기를 작성해주세요."></textarea>
            <br>
            <button id="close-modal">닫기</button>
            <button id="submit-review">작성완료</button>
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
            const score = $("input[name='score']:checked").val();
         // 여러 개의 체크된 옵션을 수집
            const reviewOptions = $("input[name='reviewOptions']:checked").map(function () {
                return this.value;  // 체크된 모든 값을 가져와 배열로 반환
            }).get().join(",");  // 콤마(,)로 구분된 문자열로 변환

// 			const review_cnt = $("#modal_review_cnt").val();

            if (!reviewText.trim()) {
                alert("후기를 작성해주세요!");
                return;
            }

            // 데이터 확인용 콘솔 출력
            console.log("리뷰 내용: " + reviewText);
            console.log("상품 ID: " + productId);
            console.log("상품 제목: " + productTitle);
            console.log("평점: " + score);
            console.log(">>>추가평점: " + reviewOptions);
// 			console.log(">>>>>>>>>>>>"+review_cnt);
			  

            // Ajax로 데이터 전송
            $.ajax({
                url: "MyReviewText",
                type: "POST",
                contentType: "application/json",
                data: JSON.stringify({
                    review: reviewText,
                    product_title: productTitle,
                    product_id: productId,
                    score: score,
                    reviewOptions:reviewOptions
//                     review_cnt : review_cnt
                }),
                success: function () {
                    alert("후기가 등록되었습니다!");
                    $("#review-modal").fadeOut(300);
                    $("#review_content").val("");
                    location.reload();

//                     버튼 비활성화 (또는 숨김 처리)
//                     $(".clicked-review-btn").prop("disabled", true).text("후기 작성 완료").removeClass("open-modal-btn");
                },
                error: function () {
                    alert("후기 등록에 실패했습니다.");
                }
            });
        });
    });

</script>

<script type="text/javascript">
	

</script>
</body>
</html>
