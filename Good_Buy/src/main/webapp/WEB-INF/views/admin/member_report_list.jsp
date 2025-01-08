<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
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
                                    <h5 class="m-0 font-weight-bold text-primary">신고 회원 목록</h5>
                                </div>
                                <div class="card-body">
                                	<div class="search-wrap border">
                                		<section class="d-flex search-inner">
	                                		<div class="col-3 px-4 search-box">
			                                	<div class="search-ttl">상태별</div>
											    <div class="category-filter input-group">
											        <div class="form-check">
													    <input class="form-check-input" id="reset" type="radio" name="status"  value="" checked>
													    <label class="form-check-label" for="reset">전체</label>
													</div>
											        <div class="form-check ml-3">
													    <input class="form-check-input" id="status1" type="radio" name="status" value="접수">
													    <label class="form-check-label" for="status1">접수</label>
													</div>
													<div class="form-check ml-3">
													    <input class="form-check-input" id="status2" type="radio" name="status" value="처리완료">
													    <label class="form-check-label" for="status2">처리완료</label>
													</div>
													<div class="form-check ml-3">
													    <input class="form-check-input" id="status3" type="radio" name="status" value="기각">
													    <label class="form-check-label" for="status3">기각</label>
													</div>
											    </div>
										    </div>
										    <div class="col-4 px-4 search-box">
			                                	<div class="search-ttl">기간별</div>
												<div class="input-group align-items-center justify-content-center schDate-wrap">
													<input type="text" class="form-control rounded-sm mr-2" placeholder="날짜 선택" value="" name="schDate" id="schDate"  autocomplete="off"/>
													<button class="btn btn-primary" id="searchDateBtn" type="button"><i class="fa-solid fa-magnifying-glass"></i></button>
													<button class="btn btn-success ml-2" id="initDateBtn" type="button"><i class="fa-solid fa-rotate"></i></button>
												</div>
										    </div>
										    <div class="col-5 px-4 search-box">
						                        <div class="input-group">
						                            <input type="text" id="searchKeyword" class="form-control bg-light border small" name="keyword_search" placeholder="신고자ID, 신고상품, 신고사유, 처리상태 검색" aria-label="Search" aria-describedby="basic-addon2">
						                            <div class="input-group-append">
						                                <button class="btn btn-primary" id="searchBtn" type="button">검색</button>
						                            </div>
						                        </div>
					                        </div>
									   	</section>
									</div>
                                	<div class="table-responsive">
		                                <table class="table table-bordered compact" id="memberReport" width="100%" cellspacing="0">
		                                    <thead></thead>
		                                    <tbody></tbody>
		                                </table>
		                          	</div>
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
    
    <!-- 수정 모달 -->
    <div class="modal fade" id="updateReportInfo" tabindex="-1" aria-labelledby="updateModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
		    <div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="updateModalLabel">신고 회원 조치</h5>
					<button type="button" class="close" data-dismiss="modal"><i class="fa-solid fa-xmark"></i></button>
				</div>
				<div class="modal-body">
					<form action="AdmUserReportModify" id="userReportModifyForm" method="post">
						<input type="hidden" id="roomId" name="ROOM_ID">
						<input type="hidden" id="reportId" name="REPORT_ID">
						<input type="hidden" id="reporterId" name="REPORTER_ID">
						<input type="hidden" id="reportedId" name="REPORTED_ID">
						<input type="hidden" id="adminId" name="ADMIN_ID" value="${sessionScope.sId}">
						<div class="mb-3">
							<label class="small mb-1" for="reportStatus">조치 상태 변경</label>
							<select class="custom-select" id="reportStatus" name="STATUS">
								<option value="처리완료">처리완료</option>
								<option value="기각">기각</option>
							</select>
						</div>
						<div class="mb-3">
							<label class="small mb-1" for="actionReason">조치 사유</label>
							<textarea class="form-control" col="4" id="actionReason" name="ACTION_REASON" placeholder="조치사유를 입력하세요" required></textarea>
							<small class="text-primary text-right d-block font-weight-bold"><span id="lengthInfo">0</span> / 500자</small>
						</div>
                    </form>
				</div>
				<div class="modal-footer justify-content-center">
					<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
					<button type="submit" class="btn btn-primary" id="btnModifyForm" form="userReportModifyForm">수정하기</button>
				</div>
			</div>
		</div>
	</div>
	
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
    <script src="${pageContext.request.contextPath}/resources/adm/js/member_report_list.js"></script>

</body>


</html>