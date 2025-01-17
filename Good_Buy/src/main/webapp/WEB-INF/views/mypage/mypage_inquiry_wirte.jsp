<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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

    <!-- 기본 CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/default.css">
    <script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>

    <!-- Font Awesome -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/fontawesome/all.min.css" />
    <script src="${pageContext.request.contextPath}/resources/fontawesome/all.min.js"></script>

    <!-- 페이지별 CSS 및 JS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage.css">
    <script src="${pageContext.request.contextPath}/resources/js/slick.js"></script>
</head>
<body>
    <header>
        <jsp:include page="/WEB-INF/views/inc/header.jsp"></jsp:include>
    </header>

    <main>
        <!-- 계정설정 섹션 -->
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
                        <a href="MySupport" class="active">1:1문의내용</a>
                    </aside>

                    <div class="my-container">
                        <div class="contents-ttl">1:1문의 게시판</div>
                        
                        <!-- 문의 작성 섹션 -->
                        <section class="inq-wrap">
                            <form action="MySupportWrite" method="post" enctype="multipart/form-data" class="inq-frm">
                                <input type="hidden" name="mem_id" value="${sessionScope.sId}">

                                <div class="row">
                                    <select name="support_category">
                                        <option value="1">이용문의</option>
                                        <option value="2">결제문의</option>
                                        <option value="3">기타</option>
                                    </select>
                                </div>

                                <div class="row">
                                    <input type="text" placeholder="제목을 입력하세요" name="support_subject" required="required">
                                </div>

                                <div class="row">
                                    <textarea name="support_content" rows="15" cols="40" required="required" placeholder="문의할 내용을 입력하세요"></textarea>
                                </div>

                                <!-- 파일 첨부 -->
                                <div class="row">
                                    <input type="file" name="file1">
                                </div>

                                <div class="btns">
                                    <button type="button" onclick="history.back()">취소</button>
                                    <button type="submit">등록하기</button>
                                </div>
                            </form>
                        </section>
                    </div>
                </section>
            </div>
        </section>
    </main>

    <footer>
        <jsp:include page="/WEB-INF/views/inc/footer.jsp"></jsp:include>
    </footer>
    
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
