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
                        <a href="">나의 광고</a>
                    </aside>

                    <div class="my-container">
                        <div class="contents-ttl">1:1문의 게시판</div>
                        
                        <!-- 문의 수정 섹션 -->
                        <section class="inq-wrap">
                            <form action="RequestModifyForm" method="post" enctype="multipart/form-data" class="inq-frm">
                                <input type="hidden" name="mem_id" value="${sessionScope.sId}">

                                <div class="row">
                                    <select name="support_category">
                                        <option value="1" <c:if test="${support.support_category == 1}">selected</c:if>>이용문의</option>
                                        <option value="2" <c:if test="${support.support_category == 2}">selected</c:if>>결제문의</option>
                                        <option value="3" <c:if test="${support.support_category == 3}">selected</c:if>>기타</option>
                                    </select>
                                </div>

                                <div class="row">
                                    <input type="text" name="support_subject" required="required" value="${support.support_subject}">
                                </div>

                                <div class="row">
                                    <textarea name="support_content" rows="15" cols="40" required="required">${support.support_content}</textarea>
                                    <input type="hidden" name="support_id" value="${support.support_id}">
                                </div>

                                <!-- 파일 첨부 -->
                                <div class="row attach">
                                    <c:choose>
                                        <c:when test="${not empty support.support_file1}">
                                            <i class="fa-solid fa-paperclip"></i>
                                            ${originalFileName}
                                            <a href="${pageContext.request.contextPath}/resources/upload/${fileName}" download="${originalFileName}" class="dw">
                                                <i class="fa-solid fa-download"></i>
                                            </a>
                                            <a href="javascript:deleteFile(${support.support_id}, '${fileName}')" class="del">
                                                <i class="fa-solid fa-trash-can"></i>
                                            </a>
                                            <input type="file" name="file1" hidden>
                                        </c:when>
                                        <c:otherwise>
                                            <input type="file" name="file1">
                                        </c:otherwise>
                                    </c:choose>
                                </div>

                                <div class="btns">
                                    <button type="button" onclick="history.back()">취소</button>
                                    <button type="submit">수정하기</button>
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
        // 수정 화면에서 첨부파일 삭제
        function deleteFile(support_id, file) {
            console.log(support_id + ", " + file);
            if(confirm("삭제하시겠습니까?")) {
                $.ajax({
                    type : "post",
                    url : "MySupportDeleteFile",
                    data : {
                        support_id : support_id,
                        file : file
                    }
                }).done(function(result){
                    console.log(result);
                    if(result.trim() == "true"){
                        let fileElem = $("input[name=file1]");
                        $(fileElem).parent().html(fileElem);
                        $(fileElem).prop("hidden", false);
                        return;
                    }
                    alert("파일 삭제 실패!\n다시 시도해주시기 바랍니다.");
                }).fail(function(){
                    alert("오류 발생");
                });
            }
        }
    </script>
</body>
</html>