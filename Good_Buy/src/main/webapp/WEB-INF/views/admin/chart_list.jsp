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
                                <div class="card-body">
                                
                                	<div class="row mb-4">
				                        <div class="col-xl-6 col-md-6">
				                            <div class="card shadow h-100 py-2">
				                                <div class="card-body">
				                                    <div class="row no-gutters align-items-center">
				                                        <div class="col mr-2">
				                                            <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">
				                                                전체 이용자수</div>
				                                            <div class="h5 mb-0 font-weight-bold text-gray-800" id="allUserCount"></div>
				                                        </div>
				                                        <div class="col-auto">
				                                        	<i class="fa-solid fa-users fa-2x text-gray-300"></i>
				                                        </div>
				                                    </div>
				                                </div>
				                            </div>
				                        </div>
				                        <div class="col-xl-6 col-md-6">
				                            <div class="card shadow h-100 py-2">
				                                <div class="card-body">
				                                    <div class="row no-gutters align-items-center">
				                                        <div class="col mr-2">
				                                            <div class="text-xs font-weight-bold text-warning text-uppercase mb-1">
				                                                전체 메세지 건 수</div>
				                                            <div class="h5 mb-0 font-weight-bold text-gray-800" id="allChatCount"></div>
				                                        </div>
				                                        <div class="col-auto">
				                                        	<i class="fa-regular fa-comments fa-2x text-gray-300"></i>
				                                        </div>
				                                    </div>
				                                </div>
				                            </div>
				                        </div>
				                    </div>
								   	
                               		<!-- Area Chart -->
			                        <div class="col-xl-12 col-lg-12 p-0">
			                            <div class="card shadow mb-4">
			                                <!-- Card Header -->
			                                <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
			                                    <h6 class="m-0 font-weight-bold text-primary">소통</h6>
			                                </div>
			                                <!-- Card Body -->
			                                <div class="card-body">
			                                	<div class="search-wrap border">
			                                		<section class="d-flex search-inner">
													    <div class="col-12 px-12 search-box">
						                                	<div class="search-ttl">기간별</div>
															<div class="input-group align-items-center justify-content-center schDate-wrap">
																<input type="text" class="form-control rounded-sm mr-2" placeholder="날짜 선택" value="" name="schDate" id="schDate"  autocomplete="off"/>
																<button class="btn btn-primary" id="searchDateBtn" type="button"><i class="fa-solid fa-magnifying-glass"></i></button>
																<button class="btn btn-success ml-2" id="initDateBtn" type="button"><i class="fa-solid fa-rotate"></i></button>
															</div>
													    </div>
												   	</section>
												</div>
			                                    <div class="chart-area">
			                                        <canvas id="chatAreaChart"></canvas>
			                                    </div>
			                                </div>
			                            </div>
			                        </div>
			                        <!-- // Area chart -->
                                	
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
    <script src="${pageContext.request.contextPath}/resources/adm/vendor/datepicker/moment.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/adm/vendor/datepicker/daterangepicker.js"></script>
    <script src="${pageContext.request.contextPath}/resources/adm/vendor/chart.js/Chart.min.js"></script>
    
    <!-- Page level custom scripts -->
    <script src="${pageContext.request.contextPath}/resources/adm/js/chart_list.js"></script>

</body>


</html>