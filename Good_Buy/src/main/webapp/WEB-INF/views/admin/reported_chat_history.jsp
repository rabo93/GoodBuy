<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/img/g_favicon.ico" type="image/x-icon">
<link rel="icon" href="${pageContext.request.contextPath}/resources/img/g_favicon.ico" type="image/x-icon">
<title>굿바이 - 중고거래, 이웃과 함께 더 쉽게!</title>

<!-- default -->
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>

<!-- font-awesome -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/fontawesome/all.min.css" />
<script src="${pageContext.request.contextPath}/resources/fontawesome/all.min.js"></script>

<!-- CSS for Page -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&family=Nunito:wght@200..1000&display=swap" rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/adm/css/sb-admin-2.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/adm/css/adm.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/adm/vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/adm/vendor/datatables/datatables.min.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/adm/vendor/datepicker/daterangepicker.css" rel="stylesheet">

</head>
<body id="page-top">

    <!-- Page Wrapper -->
	<div id="wrapper">

		<!-- Sidebar -->
       	<jsp:include page="/WEB-INF/views/admin/inc/aside.jsp"></jsp:include>
		<!-- // Sidebar -->

        <!-- Content Wrapper -->
        <div id="content-wrapper" class="d-flex flex-column">

            <!-- Main Content -->
            <div id="content">
            
				<!-- Topbar -->
				<jsp:include page="/WEB-INF/views/admin/inc/top.jsp"></jsp:include>
				<!-- End of Topbar -->
               
                <!-- Begin Page Content -->
                <div class="container-fluid">
					<div class="row">
                        <div class="col-lg-12">
                            <div class="card shadow mb-4">
                                <div class="card-header py-3">
                                    <h5 class="m-0 font-weight-bold text-primary">신고된 채팅 내역</h5>
                                </div>
                                <div class="card-body">
                                	<div class="room_info mb-1">
                            			<c:if test="${chatDetail != null}">
	                                		<div>채팅방 번호 : <b>${param.room_id}</b>
                                				<b class="chat_cate">
                                					${chatDetail.STATUS}
                                				</b>
                                				<c:if test="${chatDetail.STATUS.equals('대화종료')}">
                                					<script>
                                						$(".chat_cate").addClass("cate02");
                                					</script>
                                				</c:if>
	                                		</div>
	                                		<div>채팅방 제목 : <b>${chatDetail.TITLE}</b></div>
                               			</c:if>
                                		<div>참여자 : <b>${chatHistory[0].SENDER_ID}</b>, <b>${chatHistory[0].RECEIVER_ID}</b></div>
                                	</div>
                                	<ul class="list-group mt-1" id="reported_chat_list">
                                		<c:forEach items="${chatHistory}" var="chat">
                                			<li class="list-group-item">
	                               				<div class="user_info">
	                               					<c:choose>
	                               						<c:when test="${chat.type.equals('TALK')}">
				                                			<span class="chat_type type01">TALK</span>
	                               						</c:when>
	                               						<c:when test="${chat.type.equals('FILE')}">
	                               							<span class="chat_type type02">FILE</span>
	                               						</c:when>
	                               					</c:choose>
	                               					<span class="id">${chat.SENDER_ID}</span>
	                               					<span class="time">${chat.SEND_TIME}</span>
		                               				<span class="read <c:if test="${chat.READ_STATE == 1}">no</c:if>"><i class="fa-solid fa-circle-check"></i></span>
	                               				</div>
	                               				<div class="message">
	                               					<c:choose>
	                               						<c:when test="${chat.TYPE.equals('TALK')}">
				                                			${chat.MESSAGE}
	                               						</c:when>
	                               						<c:when test="${chat.TYPE.equals('FILE')}">
	                               							<a href="${pageContext.request.contextPath}/resources/upload/chat/${fn:split(chat.MESSAGE, ':')[0]}" target="_blank">
	                               								<img src="${pageContext.request.contextPath}/resources/upload/chat/${fn:split(chat.MESSAGE, ':')[1]}">
	                               							</a>
	                               						</c:when>
	                               					</c:choose>
	                               				</div>
	                                		</li>
                                		</c:forEach>
                                	</ul>
                                </div>
                            </div>
                        </div>
                     </div>
                </div>
                <!-- /.container-fluid -->
            </div>
            <!-- End of Main Content -->
            <!-- Footer -->
            <footer class="sticky-footer bg-white">
                <jsp:include page="/WEB-INF/views/admin/inc/bottom.jsp"></jsp:include>
            </footer>
            <!-- End of Footer -->
        </div>
        <!-- End of Content Wrapper -->

    </div>
    <!-- End of Page Wrapper -->

    <!-- Scroll to Top Button-->
    <a class="scroll-to-top rounded" href="#page-top">
        <i class="fas fa-angle-up"></i>
    </a>
    
	
    <!-- Bootstrap core JavaScript-->
    <script src="${pageContext.request.contextPath}/resources/adm/vendor/jquery/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/adm/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-->
    <script src="${pageContext.request.contextPath}/resources/adm/vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Custom scripts for all pages-->
    <script src="${pageContext.request.contextPath}/resources/adm/js/sb-admin-2.min.js"></script>
    
    <!-- Page level plugins -->
    <script src="${pageContext.request.contextPath}/resources/adm/vendor/datatables/jquery.dataTables.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/adm/vendor/datatables/dataTables.bootstrap4.min.js"></script>
<%--     <script src="${pageContext.request.contextPath}/resources/adm/vendor/datatables/datatables.min.js"></script> --%> <%-- 반응형 --%>
    <script src="${pageContext.request.contextPath}/resources/adm/vendor/datepicker/moment.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/adm/vendor/datepicker/daterangepicker.js"></script>

    <!-- Page level custom scripts -->
    <script src="${pageContext.request.contextPath}/resources/adm/js/reported_chat_history.js"></script>

</body>


</html>