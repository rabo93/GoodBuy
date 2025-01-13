<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<!--                     <h1 class="h3 mb-4 text-gray-800">공통코드 관리</h1> -->
					<div class="row">
                        <div class="col-lg-12">
                            <div class="card shadow mb-4">
                                <div class="card-header py-3">
                                    <h5 class="m-0 font-weight-bold text-primary">공통코드 목록</h5>
                                </div>
                                <div class="card-body">
                                	<div class="table-responsive overflow-hidden">
		                                <table class="table table-bordered" id="codeList" width="100%" cellspacing="0">
		                                    <thead>
		                                        <tr>
		                                            <th data-orderable="false"  width="30px">
		                                            	<div class="custom-control custom-checkbox small">
			                                            	<input type="checkbox" class="custom-control-input" id="checkAll">
			                                            	<label class="custom-control-label" for="checkAll"></label>
		                                            	</div>
		                                            </th>
		                                            <th width="30px">No.</th>
		                                            <th class="col-2">공통코드ID</th>
		                                            <th class="col-2">공통코드명</th>
		                                            <th>설명</th>
		                                            <th class="col-2">사용여부</th>
		                                            <th class="col-2">관리</th>
		                                        </tr>
		                                    </thead>
		                                    <tbody>
		                                        <tr>
		                                            <td>
		                                            	<div class="custom-control custom-checkbox small">
			                                            	<input type="checkbox" class="custom-control-input" id="customCheck">
			                                            	<label class="custom-control-label" for="customCheck"></label>
		                                            	</div>
		                                            </td>
		                                            <td>1</td>
		                                            <td>CODE01</td>
		                                            <td>공통코드명1</td>
		                                            <td>최신순 정렬 필터링</td>
		                                            <td>
		                                            	<div class="form-check form-switch">
															<input class="form-check-input" type="checkbox" role="switch" id="flexSwitchCheckDefault" checked>
															<label class="form-check-label" for="flexSwitchCheckDefault">사용함</label>
														</div>
		                                            </td>
		                                            <td class="text-center">
		                                            	<button class="btn btn-primary">수정</button>
		                                            	<button class="btn btn-primary">삭제</button>
		                                            </td>
		                                        </tr>
		                                        <tr>
		                                            <td>
		                                            	<div class="custom-control custom-checkbox small">
			                                            	<input type="checkbox" class="custom-control-input" id="customCheck2">
			                                            	<label class="custom-control-label" for="customCheck2"></label>
		                                            	</div>
		                                            </td>
		                                            <td>2</td>
		                                            <td>CODE02</td>
		                                            <td>공통코드명2</td>
		                                            <td>최신순 정렬 필터링</td>
		                                            <td>
		                                            	<div class="form-check form-switch">
															<input class="form-check-input" type="checkbox" role="switch" id="flexSwitchCheckDefault" checked>
															<label class="form-check-label" for="flexSwitchCheckDefault">사용함</label>
														</div>
		                                            </td>
		                                            <td class="text-center">
		                                            	<button class="btn btn-primary">수정</button>
		                                            	<button class="btn btn-primary">삭제</button>
		                                            </td>
		                                        </tr>
		                                   </tbody>
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

    <!-- Page level custom scripts -->
<%--     <script src="${pageContext.request.contextPath}/resources/adm/js/code_modify.js"></script> --%>

</body>


</html>