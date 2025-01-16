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
<script src="${pageContext.request.contextPath}/resources/js/moment.js"></script>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/modal.css">
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
                                        <div class ="product-card-empty">구매내역이 없습니다.</div>
                                    </c:when>
                                    <c:otherwise>
                                    <ul class="myproduct-wrap">
                                        <c:forEach var="product" items="${order}">
                                            <li class="product-card">
                                            	<a href='ProductDetail?PRODUCT_ID=${product.PRODUCT_ID}'>
                                                	<img src="${pageContext.request.contextPath}/resources/upload/${product.product_pic1}" class="card-thumb" alt="thumbnail" height="180px" />
                                                </a>
                                                	<div class="card-info">
                                                    <div class="category">
                                                        <span>${product.PRODUCT_CATEGORY}</span>
                                                        <span class="type">
                                                        	<c:if test="${product.PRODUCT_TRADE_ADR1 != ''}">
																<span class="type">직거래</span>
															</c:if>
                                                        </span>
                                                    </div>
                                                    <div class="ttl">
                                                        <c:if test="${product.PRODUCT_STATUS == 1}">
                                                            [예약중]
                                                        </c:if>
                                                        <c:if test="${product.PRODUCT_STATUS == 3}">
                                                            [거래완료]
                                                        </c:if>
                                                        ${product.PRODUCT_TITLE}
                                                    </div>
                                                    <div class="price">
                                                        <fmt:formatNumber value="${product.PRODUCT_PRICE}" type="number" pattern="#,###" />원
                                                    </div>
                                                    <div class="card-row">
                                                        <span class="add">${product.PRODUCT_TRADE_ADR1}</span>
                                                        <span class="name">${product.MEM_NICK}</span>
                                                    </div>
                                                    	<input type="hidden" name="product_id" id="hiddenProductId">
<%--                                                     	<c:choose> --%>
<%--                                                     		<c:when test="${product.PRODUCT_STATUS == 1}"> --%>
<!--                                                     			<button class="successOrder">구매확정</button> -->
<%--                                                     		</c:when> --%>
<%--                                                     		<c:when test="${empty product.REVIEW_CNT || product.REVIEW_CNT == 0}"> --%>
<!-- 	                                                    		 <div class="review-write-btn"> -->
<!-- 		                                                    		 <button class="open-modal-btn" -->
<%-- 																        data-product-id="${product.PRODUCT_ID}" --%>
<%-- 																        data-title="${product.PRODUCT_TITLE}" --%>
<%-- 																        data-buyer="${product.MEM_NICK}"> --%>
<!-- 																        <i class="fa-regular fa-envelope"></i> 후기 작성하기 -->
<!-- 																     </button> -->
<!-- 															     </div> -->
<%--                                                     		</c:when> --%>
<%--                                                     		<c:otherwise><a class="review-done-btn" href='MyReviewHistory?product_id=${product.PRODUCT_ID}'><i class="fa-solid fa-envelope"></i> 작성완료</a></c:otherwise> --%>
<%--                                                     	</c:choose> --%>
														<c:if test="${product.PRODUCT_STATUS == 1}">
															<button class="successOrder" 
													            data-product-id="${product.PRODUCT_ID}" 
													            data-product-seller="${product.BUYER_ID}">구매확정 <i class="fa-regular fa-circle-check"></i></button>
											            </c:if>
                                                    	<c:choose>
														    <c:when test="${empty product.REVIEW_CNT || product.REVIEW_CNT == 0}">
														        <c:if test="${product.PRODUCT_STATUS == 3}">
														            <div class="review-write-btn">
														                <button class="open-modal-btn"
														                        data-product-id="${product.PRODUCT_ID}"
														                        data-title="${product.PRODUCT_TITLE}"
														                        data-buyer="${product.MEM_NICK}"
														                        
														                        >
														                    <i class="fa-regular fa-envelope"></i> 후기 작성하기
														                </button>
														            </div>
														        </c:if>
														    </c:when>
														    <c:otherwise>
														        <a class="review-done-btn" href='MyReviewHistory?product_id=${product.PRODUCT_ID}'>
														            <i class="fa-solid fa-envelope"></i> 작성완료
														        </a>
														    </c:otherwise>
														</c:choose>
                                                </div>
                                            </li>
                                        </c:forEach>
                                        </ul>
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
            <span id="buyerName"></span>님께 구매한 [<span id="productTitle"></span>]<br>후기 보내기 <i class="fa-regular fa-envelope"></i>
        </h2>
        <div class="review-radio">
            <label><input type="radio" name="score" value="2">최고예요🥳</label>
            <label><input type="radio" name="score" value="1">좋아요💕</label>
            <label><input type="radio" name="score" value="0">별로예요👿</label>
            <input type="hidden" id="modal_product_id">
        </div>
        <br><br>
        <h3>추가로 만족한 부분을 선택해 주세요 (복수 선택 가능)</h3>
        <div class="review-check">
            <label><input type="checkbox" name="reviewOptions" value="1"> 배송이 빨라요🚚</label>
            <label><input type="checkbox" name="reviewOptions" value="2"> 친절해요💖</label>
            <label><input type="checkbox" name="reviewOptions" value="3"> 물건상태가 좋아요✨</label>
            <label><input type="checkbox" name="reviewOptions" value="4"> 또 거래하고 싶어요💰</label>
        </div>
        <textarea class="" rows="4" cols="50" id="review_content" placeholder="후기를 작성해주세요."></textarea>
        <br>
        <div class="modal-ft">
            <button id="close-modal" class="reset">닫기</button>
            <button id="submit-review" class="active">작성완료</button>
        </div>
    </div>
</div>


    <script type="text/javascript">
    $(document).ready(function () {
    	$(".successOrder").click(function () {
    		var userOrder = confirm("구매를 확정하시겠습니까?\n청약철회가 불가능 합니다.");
    		if(userOrder){
    		 const product_id = $(this).data("product-id");
    		 const product_seller = $(this).data("product-seller");
    		 console.log(">>>>>>>>>>>"+product_id+ ">>>>"+product_seller + "<<<<");
    		 
    		 $.ajax({
 	        	type : "post",
 	        	url : "SuccessOrder",
 	        	data : {product_id : product_id,
 	        			product_seller : product_seller},
 	        	success : function (response) {
 	        		location.reload();
 					console.log("에이젝스로 넘어감");					
 				}
 	        })
    		}
		});
    	
        // 후기 작성하기 버튼 클릭 이벤트
        $(".open-modal-btn").click(function () {
            const productId = $(this).data("product-id");
            const productTitle = $(this).data("title");
            const buyerName = $(this).data("buyer");
            const seller = $(this).data("seller");
//             const review_cnt = $(this).data("review-cnt");

            // 모달에 데이터 주입
            $("#buyerName").text(buyerName);
            $("#seller").text(seller);
            $("#productTitle").text(productTitle);
            $("#modal_product_id").val(productId);
//             $("#modal_review_cnt").val(review_cnt);
            $("#review-modal").fadeIn(300);
        });

        // 모달 닫기
        $("#close-modal").click(function () {
            $("#review-modal").fadeOut(300);
        });
   	    // 클릭한 영역이 모달 내용이 아니라면 닫기
        $("#review-modal").click(function (e) {
            if ($(e.target).is("#review-modal")) {
                $("#review-modal").fadeOut(300);
            }
        });
   	    
   	    
   	    function resetOption() { //기본 옵션 버튼
			$(".review-check").html(
					`  
					<label><input type="checkbox" name="reviewOptions" value="1"> 배송이 빨라요🚚</label>
	                <label><input type="checkbox" name="reviewOptions" value="2"> 친절해요💖</label>
	                <label><input type="checkbox" name="reviewOptions" value="3"> 물건상태가 좋아요✨</label>
	                <label><input type="checkbox" name="reviewOptions" value="4"> 또 거래하고 싶어요💰</label>
					`);
		}
   	    
   	    function updateCheckBox(scoreValue) {
			const reviewCheck = $(".review-check");
			if (scoreValue == "0") { // 불만족 클릭시
				reviewCheck.html(`
		                <label><input type="checkbox" name="reviewOptions" value="5"> 배송이 느려요😵‍💫</label>
		                <label><input type="checkbox" name="reviewOptions" value="6"> 채팅 답장이 느려요😫</label>
		                <label><input type="checkbox" name="reviewOptions" value="7"> 물건 상태가 사진과 달라요💣</label>
		            	`)
			} else {
				resetOption();
			}
		}
   	    
   	    $("input[name='score']").on("change",function(){ // 체크박스를 라디오 버튼 선택에 따라 업데이트
   	    	const selectValue = $(this).val();
   	    	updateCheckBox(selectValue);
   	    });

        // 후기 제출 이벤트
        $("#submit-review").click(function () {
            const reviewText = $("#review_content").val();
            const seller = $("#seller").val();
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
            } else if (!score){
                alert("평점을 함께 남겨주세요!");
                return;
            }

            // 데이터 확인용 콘솔 출력
            console.log("리뷰 내용: " + reviewText);
            console.log("상품 ID: " + productId);
            console.log("상품 제목: " + productTitle);
            console.log("평점: " + score);
            console.log("판매자: " + seller);
            console.log(">>>추가평점: " + reviewOptions);
			  

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
                    seller: seller,
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
</body>
</html>
