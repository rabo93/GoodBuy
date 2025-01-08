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
<!--                 	<h1 class="h3 mb-4 text-gray-800">회원 관리</h1> -->
					<div class="row">
                        <div class="col-lg-12">
                            <div class="card shadow mb-4">
                                <div class="card-header py-3">
                                    <h5 class="m-0 font-weight-bold text-primary">회원 상세정보 수정</h5>
                                </div>
                                <div class="card-body">
                                    <form action="AdmMemberModify" name="memberModifyForm" method="post">
<!--                                         <button id="btnSubmitForm" class="btn btn-primary">삭제하기</button> -->
<!--                                         <button id="btnSubmitForm" class="btn btn-primary">수정하기</button> -->
                                    	<h6 class="font-weight-bold text-primary mb-4">기본정보</h6>
										<section class="row">
											<div class="col-8">
	                                    		<div class="mb-3">
		                                            <label class="small mb-1" for="mem_id">ID</label>
		                                            <input class="form-control" name="mem_id" value="${dbMember.mem_id}" type="text" readonly>
		                                        </div>
		                                        <div class="mb-3">
		                                            <label class="small mb-1" for="mem_name">이름</label>
		                                            <input class="form-control" name="mem_name" type="text" value="${dbMember.mem_name}" readonly>
		                                        </div>
		                                        <div class="mb-3">
		                                            <label class="small mb-1" for="mem_nick">닉네임</label>
		                                            <input class="form-control" name="mem_nick" type="text" value="${dbMember.mem_name}" readonly>
		                                        </div>
		                                        <div class="mb-3">
		                                            <label class="small mb-1" for="mem_nick">이메일</label>
		                                            <input class="form-control" name="mem_email" type="text" value="${dbMember.mem_email}" readonly> 
		                                        </div>
		                                        <div class="mb-3">
		                                            <label class="small mb-1" for="mem_nick">휴대폰번호</label>
		                                            <input class="form-control" name="mem_email" type="text" value="${dbMember.mem_phone}" readonly> 
		                                        </div>
		                                        <div class="mb-3">
		                                            <label class="small mb-1" for="mem_nick">주소</label>
		                                            <input class="form-control col-2 mb-1" name="mem_email" type="text" value="${dbMember.mem_post_code}" readonly> 
		                                            <input class="form-control mb-1" name="mem_email" type="text" value="${dbMember.mem_address1}" readonly> 
		                                            <input class="form-control" name="mem_email" type="text" value="${dbMember.mem_address2}" readonly> 
		                                        </div>
		                                        <div class="mb-3">
		                                            <label class="small mb-1" for="mem_nick">생년월일</label>
		                                            <input class="form-control" name="mem_birthday" type="text" value="${dbMember.mem_birthday}" readonly>
		                                        </div>
		                                        <div class="mb-3">
		                                            <label class="small mb-1" for="mem_gender">성별</label>
		                                            <input class="form-control" name="mem_gender" type="text" value="${dbMember.mem_gender}" readonly>
		                                        </div>
		                                        <div class="mb-3">
		                                            <label class="small mb-1" for="mem_nick">가입일자</label>
		                                            <input class="form-control" name="mem_gender" type="text" value="${dbMember.mem_reg_date}" readonly>
		                                        </div>
		                                        <div class="mb-3">
		                                            <label class="small mb-1" for="mem_nick">탈퇴일자</label>
		                                            <input class="form-control" name="mem_gender" type="text" value="${dbMember.mem_withdraw_date}" readonly>
		                                        </div>
		                                        <div class="mb-3">
		                                            <label class="small mb-1" for="mem_intro">자기소개</label>
		                                            <textarea class="form-control" rows="3" style="resize:none;" name="mem_intro" value="${dbMember.mem_intro}" readonly></textarea>
		                                        </div>
	                                    	</div>
	                                    	<div class="col-4">
	                                    		<div class="mb-3">
		                                            <label class="small mb-1" for="mem_profile">프로필사진</label>
		                                            <c:choose>
		                                            	<c:when test="${dbMember.mem_profile != null and fn:contains(dbMember.mem_profile, 'resources')}">
			                                           		<img src="${pageContext.request.contextPath}${dbMember.mem_profile}" alt="프로필사진" class="profile_img_box"> 
		                                            	</c:when>
		                                            	<c:when test="${dbMember.mem_profile != null and not fn:contains(dbMember.mem_profile, 'resources')}">
				                                            <img src="${dbMember.mem_profile}" alt="프로필사진" class="profile_img_box"> 
		                                            	</c:when>
		                                            	<c:otherwise>
				                                            <img src="${pageContext.request.contextPath}/resources/adm/img/no-thumb.jpg" alt="프로필사진" class="profile_img_box"> 
		                                            	</c:otherwise>
		                                            </c:choose>
		                                        </div>
		                                        <div class="mb-3">
		                                            <label class="small mb-1" for="mem_nick">SNS 연동상태</label>
		                                            <input class="form-control" name="mem_email" type="text" value="${snsStatus}" readonly> 
		                                        </div>
		                                        <div class="mb-3">
		                                            <label class="small mb-1" for="mem_nick">회원 인증상태</label>
		                                            <input class="form-control" name="mem_email" type="text" value="${authStatus}" readonly> 
		                                        </div>
	                                    		<div class="mb-3">
		                                            <label class="small mb-1" for="mem_nick">회원등급</label>
		                                            <input class="form-control" name="mem_email" type="text" value="${dbMember.mem_grade}" readonly> 
		                                        </div>
		                                        <div class="mb-3">
		                                            <label class="small mb-1" for="mem_nick">회원상태</label>
		                                            <input class="form-control" name="mem_email" type="text" value="${memStatus}" readonly> 
		                                        </div>
		                                        <div class="mb-3">
		                                            <label class="small mb-1" for="report_cnt">경고 누적 횟수 
		                                            </label>
		                                            <input class="form-control" name="report_cnt" type="text" value="${dbMember.report_cnt}" readonly> 
		                                        </div>
	                                    	</div>
										</section>
										
                                        <c:if test="${reportHistory != null}">
											<section class="row">
												<div class="col-12 mt-3">
						                            <div class="card shadow mb-4">
						                                <div class="card-header py-3">
						                                    <h6 class="m-0 font-weight-bold text-primary">신고 기록</h6>
						                                </div>
						                                <div class="card-body">
						                                	<div class="table-responsive">
								                                <table class="table table-bordered compact" width="100%" cellspacing="0">
								                                    <thead>
								                                    	<tr>
								                                    		<th width="50">No.</th>
								                                    		<th>신고자</th>
								                                    		<th>신고대상자</th>
								                                    		<th>신고일시</th>
								                                    		<th>신고사유</th>
								                                    		<th>조치상태</th>
								                                    		<th>조치사유</th>
								                                    		<th>조치자</th>
								                                    		<th>조치일시</th>
								                                    		<th>채팅방 번호</th>
								                                    	</tr>
								                                    </thead>
								                                    <tbody>
								                                    	<c:forEach var="history" items="${reportHistory}">
								                                    		<tr>
								                                    			<td>${history.REPORT_ID}</td>
								                                    			<td>${history.REPORTER_ID}</td>
								                                    			<td>${history.REPORTED_ID}</td>
								                                    			<td>${history.REPORT_DATE}</td>
								                                    			<td>${history.REASON}</td>
								                                    			<td>${history.STATUS}</td>
								                                    			<td>${history.ACTION_REASON}</td>
								                                    			<td>${history.ADMIN_ID}</td>
								                                    			<td>${history.ACTION_DATE}</td>
								                                    			<td>${history.ROOM_ID}</td>
								                                    		</tr>
								                                    	</c:forEach>
								                                    </tbody>
								                                </table>
								                          	</div>
						                                </div>
						                            </div>
												</div>
											</section>
										</c:if>
										
                                    </form>
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

    <!-- Logout Modal-->
<!--     <div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" -->
<!--         aria-hidden="true"> -->
<!--         <div class="modal-dialog" role="document"> -->
<!--             <div class="modal-content"> -->
<!--                 <div class="modal-header"> -->
<!--                     <h5 class="modal-title" id="exampleModalLabel">Ready to Leave?</h5> -->
<!--                     <button class="close" type="button" data-dismiss="modal" aria-label="Close"> -->
<!--                         <span aria-hidden="true">×</span> -->
<!--                     </button> -->
<!--                 </div> -->
<!--                 <div class="modal-body">Select "Logout" below if you are ready to end your current session.</div> -->
<!--                 <div class="modal-footer"> -->
<!--                     <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button> -->
<!--                     <a class="btn btn-primary" href="login.html">Logout</a> -->
<!--                 </div> -->
<!--             </div> -->
<!--         </div> -->
<!--     </div> -->

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
    <script src="${pageContext.request.contextPath}/resources/adm/vendor/datatables/datatables.min.js"></script>


</body>


</html>