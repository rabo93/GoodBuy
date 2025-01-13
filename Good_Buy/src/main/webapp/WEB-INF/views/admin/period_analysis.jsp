<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
<link rel="stylesheet" href="https://cdn.datatables.net/buttons/1.7.1/css/buttons.dataTables.min.css">

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
                                    <h5 class="m-0 font-weight-bold text-primary">기간별 통계</h5>
                                </div>
                                <div class="card-body">
                                	<div class="search-wrap border">
                                		<section class="d-flex search-inner">
										    <div class="col-4 px-4 search-box">
			                                	<div class="search-ttl">기간별</div>
												<div class="input-group align-items-center justify-content-center schDate-wrap">
													<input type="text" class="form-control rounded-sm mr-2" placeholder="조회 기간 선택" value="" name="schDate" id="schDate"  autocomplete="off"/>
													<button class="btn btn-primary" id="searchDateBtn" type="button"><i class="fa-solid fa-magnifying-glass"></i></button>
													<button class="btn btn-success ml-2" id="initDateBtn" type="button"><i class="fa-solid fa-rotate"></i></button>
												</div>
										    </div>
									   	</section>
									</div>
									<div class="table-responsive">
<!-- 		                                <table class="table table-bordered compact" id="periodList" width="100%" cellspacing="0"> -->
		                                <table class="table table-bordered compact" id="periodList" width="100%" cellspacing="0">
		                                    <thead>
		                                    	<tr>
		                                    		<th>날짜</th>
		                                    		<th>회원수</th>
		                                    		<th>거래수</th>
		                                    	</tr>
		                                    </thead>
		                                    <tbody></tbody>
		                                    <tfoot>
		                                    	<tr>
		                                    		<th>합계</th>
		                                    		<th></th>
		                                    		<th></th>
		                                    	</tr>
		                                    </tfoot>
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
	
	
	<script src="${pageContext.request.contextPath}/resources/adm/vendor/datatables/dataTables.buttons.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/adm/vendor/datatables/buttons.html5.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/adm/vendor/datatables/jszip.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/adm/vendor/datatables/buttons.print.min.js"></script>
    <!-- Page level custom scripts -->
<%--     <script src="${pageContext.request.contextPath}/resources/adm/js/period_analysis.js"></script> --%>
    <script src="${pageContext.request.contextPath}/resources/adm/js/period_analysis.js"></script>
	
	
	
</body>


</html>