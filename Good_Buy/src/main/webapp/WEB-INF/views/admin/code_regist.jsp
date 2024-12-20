<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
                                    <h5 class="m-0 font-weight-bold text-primary">공통코드 등록</h5>
                                </div>
                                <div class="card-body">
                                    <form>
                                    	<h6 class="font-weight-bold text-primary mb-4">공통코드</h6>
                                        <div class="mb-3">
                                            <label class="small mb-1" for="">공통코드ID</label>
                                            <input class="form-control" id="" type="text" placeholder="공통코드 ID 입력" value="">
                                        </div>
                                        <div class="mb-3">
                                            <label class="small mb-1" for="">공통코드명</label>
                                            <input class="form-control" id="" type="text" placeholder="공통코드명 입력" value="">
                                        </div>
                                        <div class="mb-3">
                                            <label class="small mb-1" for="">설명</label>
                                            <input class="form-control" id="" type="text" placeholder="설명 입력" value="">
                                        </div>
                                        <hr class="mt-4 pt-2">
                                        <h6 class="m-0 font-weight-bold text-primary">상세코드</h6>
                                        <div class="d-flex justify-right">
	                                        <button class="btn btn-primary ml-auto mb-2" type="button"><i class="fa-solid fa-plus"></i> 행 추가</button>
	                                        <button class="btn btn-danger ml-2 mb-2" type="button"><i class="fa-solid fa-minus"></i> 선택 삭제</button>
                                        </div>
			                            <div class="table-responsive overflow-hidden">
			                                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
			                                    <thead>
			                                        <tr>
			                                            <th width="30px">
			                                            	<div class="custom-control custom-checkbox small">
				                                            	<input type="checkbox" class="custom-control-input" id="checkAll">
				                                            	<label class="custom-control-label" for="checkAll"></label>
			                                            	</div>
			                                            </th>
			                                            <th width="30px">No.</th>
			                                            <th class="col-2">상세코드 ID</th>
			                                            <th class="col-2">상세코드명</th>
			                                            <th>설명</th>
			                                            <th class="col-2">사용여부</th>
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
			                                            <td><input type="text" class="form-control" name="" placeholder="상세코드ID 입력"></td>
			                                            <td><input type="text" class="form-control" name="" placeholder="상세코드명 입력"></td>
			                                            <td><input type="text" class="form-control" name="" placeholder="설명 입력"></td>
			                                            <td>
			                                            	<div class="form-check form-switch">
																<input class="form-check-input" type="checkbox" role="switch" id="flexSwitchCheckDefault" checked>
																<label class="form-check-label" for="flexSwitchCheckDefault">사용함</label>
															</div>
			                                            </td>
			                                        </tr>
			                                        <tr>
			                                            <td>
			                                            	<div class="custom-control custom-checkbox small">
				                                            	<input type="checkbox" class="custom-control-input" id="customCheck">
				                                            	<label class="custom-control-label" for="customCheck"></label>
			                                            	</div>
			                                            </td>
			                                            <td>1</td>
			                                            <td><input type="text" class="form-control" name="" placeholder="상세코드ID 입력"></td>
			                                            <td><input type="text" class="form-control" name="" placeholder="상세코드명 입력"></td>
			                                            <td><input type="text" class="form-control" name="" placeholder="설명 입력"></td>
			                                            <td>
			                                            	<div class="form-check form-switch">
																<input class="form-check-input" type="checkbox" role="switch" id="flexSwitchCheckDefault">
																<label class="form-check-label" for="flexSwitchCheckDefault">사용안함</label>
															</div>
			                                            </td>
			                                        </tr>
			                                        <tr>
			                                            <td>
			                                            	<div class="custom-control custom-checkbox small">
				                                            	<input type="checkbox" class="custom-control-input" id="customCheck">
				                                            	<label class="custom-control-label" for="customCheck"></label>
			                                            	</div>
			                                            </td>
			                                            <td>1</td>
			                                            <td><input type="text" class="form-control" name="" placeholder="상세코드ID 입력"></td>
			                                            <td><input type="text" class="form-control" name="" placeholder="상세코드명 입력"></td>
			                                            <td><input type="text" class="form-control" name="" placeholder="설명 입력"></td>
			                                            <td>
			                                            	<div class="form-check form-switch">
																<input class="form-check-input" type="checkbox" role="switch" id="flexSwitchCheckDefault">
																<label class="form-check-label" for="flexSwitchCheckDefault">사용안함</label>
															</div>
			                                            </td>
			                                        </tr>
			                                        <tr>
			                                            <td>
			                                            	<div class="custom-control custom-checkbox small">
				                                            	<input type="checkbox" class="custom-control-input" id="customCheck">
				                                            	<label class="custom-control-label" for="customCheck"></label>
			                                            	</div>
			                                            </td>
			                                            <td>1</td>
			                                            <td><input type="text" class="form-control" name="" placeholder="상세코드ID 입력"></td>
			                                            <td><input type="text" class="form-control" name="" placeholder="상세코드명 입력"></td>
			                                            <td><input type="text" class="form-control" name="" placeholder="설명 입력"></td>
			                                            <td>
			                                            	<div class="form-check form-switch">
																<input class="form-check-input" type="checkbox" role="switch" id="flexSwitchCheckDefault">
																<label class="form-check-label" for="flexSwitchCheckDefault">사용안함</label>
															</div>
			                                            </td>
			                                        </tr>
			                                        <tr>
			                                            <td>
			                                            	<div class="custom-control custom-checkbox small">
				                                            	<input type="checkbox" class="custom-control-input" id="customCheck">
				                                            	<label class="custom-control-label" for="customCheck"></label>
			                                            	</div>
			                                            </td>
			                                            <td>1</td>
			                                            <td><input type="text" class="form-control" name="" placeholder="상세코드ID 입력"></td>
			                                            <td><input type="text" class="form-control" name="" placeholder="상세코드명 입력"></td>
			                                            <td><input type="text" class="form-control" name="" placeholder="설명 입력"></td>
			                                            <td>
			                                            	<div class="form-check form-switch">
																<input class="form-check-input" type="checkbox" role="switch" id="flexSwitchCheckDefault">
																<label class="form-check-label" for="flexSwitchCheckDefault">사용안함</label>
															</div>
			                                            </td>
			                                        </tr>
			                                        <tr>
			                                            <td>
			                                            	<div class="custom-control custom-checkbox small">
				                                            	<input type="checkbox" class="custom-control-input" id="customCheck">
				                                            	<label class="custom-control-label" for="customCheck"></label>
			                                            	</div>
			                                            </td>
			                                            <td>1</td>
			                                            <td><input type="text" class="form-control" name="" placeholder="상세코드ID 입력"></td>
			                                            <td><input type="text" class="form-control" name="" placeholder="상세코드명 입력"></td>
			                                            <td><input type="text" class="form-control" name="" placeholder="설명 입력"></td>
			                                            <td>
			                                            	<div class="form-check form-switch">
																<input class="form-check-input" type="checkbox" role="switch" id="flexSwitchCheckDefault">
																<label class="form-check-label" for="flexSwitchCheckDefault">사용안함</label>
															</div>
			                                            </td>
			                                        </tr>
			                                        <tr>
			                                            <td>
			                                            	<div class="custom-control custom-checkbox small">
				                                            	<input type="checkbox" class="custom-control-input" id="customCheck">
				                                            	<label class="custom-control-label" for="customCheck"></label>
			                                            	</div>
			                                            </td>
			                                            <td>1</td>
			                                            <td><input type="text" class="form-control" name="" placeholder="상세코드ID 입력"></td>
			                                            <td><input type="text" class="form-control" name="" placeholder="상세코드명 입력"></td>
			                                            <td><input type="text" class="form-control" name="" placeholder="설명 입력"></td>
			                                            <td>
			                                            	<div class="form-check form-switch">
																<input class="form-check-input" type="checkbox" role="switch" id="flexSwitchCheckDefault">
																<label class="form-check-label" for="flexSwitchCheckDefault">사용안함</label>
															</div>
			                                            </td>
			                                        </tr>
			                                        <tr>
			                                            <td>
			                                            	<div class="custom-control custom-checkbox small">
				                                            	<input type="checkbox" class="custom-control-input" id="customCheck">
				                                            	<label class="custom-control-label" for="customCheck"></label>
			                                            	</div>
			                                            </td>
			                                            <td>1</td>
			                                            <td><input type="text" class="form-control" name="" placeholder="상세코드ID 입력"></td>
			                                            <td><input type="text" class="form-control" name="" placeholder="상세코드명 입력"></td>
			                                            <td><input type="text" class="form-control" name="" placeholder="설명 입력"></td>
			                                            <td>
			                                            	<div class="form-check form-switch">
																<input class="form-check-input" type="checkbox" role="switch" id="flexSwitchCheckDefault">
																<label class="form-check-label" for="flexSwitchCheckDefault">사용안함</label>
															</div>
			                                            </td>
			                                        </tr>
			                                        <tr>
			                                            <td>
			                                            	<div class="custom-control custom-checkbox small">
				                                            	<input type="checkbox" class="custom-control-input" id="customCheck">
				                                            	<label class="custom-control-label" for="customCheck"></label>
			                                            	</div>
			                                            </td>
			                                            <td>1</td>
			                                            <td><input type="text" class="form-control" name="" placeholder="상세코드ID 입력"></td>
			                                            <td><input type="text" class="form-control" name="" placeholder="상세코드명 입력"></td>
			                                            <td><input type="text" class="form-control" name="" placeholder="설명 입력"></td>
			                                            <td>
			                                            	<div class="form-check form-switch">
																<input class="form-check-input" type="checkbox" role="switch" id="flexSwitchCheckDefault">
																<label class="form-check-label" for="flexSwitchCheckDefault">사용안함</label>
															</div>
			                                            </td>
			                                        </tr>
			                                        <tr>
			                                            <td>
			                                            	<div class="custom-control custom-checkbox small">
				                                            	<input type="checkbox" class="custom-control-input" id="customCheck">
				                                            	<label class="custom-control-label" for="customCheck"></label>
			                                            	</div>
			                                            </td>
			                                            <td>1</td>
			                                            <td><input type="text" class="form-control" name="" placeholder="상세코드ID 입력"></td>
			                                            <td><input type="text" class="form-control" name="" placeholder="상세코드명 입력"></td>
			                                            <td><input type="text" class="form-control" name="" placeholder="설명 입력"></td>
			                                            <td>
			                                            	<div class="form-check form-switch">
																<input class="form-check-input" type="checkbox" role="switch" id="flexSwitchCheckDefault">
																<label class="form-check-label" for="flexSwitchCheckDefault">사용안함</label>
															</div>
			                                            </td>
			                                        </tr>
			                                        <tr>
			                                            <td>
			                                            	<div class="custom-control custom-checkbox small">
				                                            	<input type="checkbox" class="custom-control-input" id="customCheck">
				                                            	<label class="custom-control-label" for="customCheck"></label>
			                                            	</div>
			                                            </td>
			                                            <td>1</td>
			                                            <td><input type="text" class="form-control" name="" placeholder="상세코드ID 입력"></td>
			                                            <td><input type="text" class="form-control" name="" placeholder="상세코드명 입력"></td>
			                                            <td><input type="text" class="form-control" name="" placeholder="설명 입력"></td>
			                                            <td>
			                                            	<div class="form-check form-switch">
																<input class="form-check-input" type="checkbox" role="switch" id="flexSwitchCheckDefault">
																<label class="form-check-label" for="flexSwitchCheckDefault">사용안함</label>
															</div>
			                                            </td>
			                                        </tr>
			                                        <tr>
			                                            <td>
			                                            	<div class="custom-control custom-checkbox small">
				                                            	<input type="checkbox" class="custom-control-input" id="customCheck">
				                                            	<label class="custom-control-label" for="customCheck"></label>
			                                            	</div>
			                                            </td>
			                                            <td>1</td>
			                                            <td><input type="text" class="form-control" name="" placeholder="상세코드ID 입력"></td>
			                                            <td><input type="text" class="form-control" name="" placeholder="상세코드명 입력"></td>
			                                            <td><input type="text" class="form-control" name="" placeholder="설명 입력"></td>
			                                            <td>
			                                            	<div class="form-check form-switch">
																<input class="form-check-input" type="checkbox" role="switch" id="flexSwitchCheckDefault">
																<label class="form-check-label" for="flexSwitchCheckDefault">사용안함</label>
															</div>
			                                            </td>
			                                        </tr>
			                                        <tr>
			                                            <td>
			                                            	<div class="custom-control custom-checkbox small">
				                                            	<input type="checkbox" class="custom-control-input" id="customCheck">
				                                            	<label class="custom-control-label" for="customCheck"></label>
			                                            	</div>
			                                            </td>
			                                            <td>1</td>
			                                            <td><input type="text" class="form-control" name="" placeholder="상세코드ID 입력"></td>
			                                            <td><input type="text" class="form-control" name="" placeholder="상세코드명 입력"></td>
			                                            <td><input type="text" class="form-control" name="" placeholder="설명 입력"></td>
			                                            <td>
			                                            	<div class="form-check form-switch">
																<input class="form-check-input" type="checkbox" role="switch" id="flexSwitchCheckDefault">
																<label class="form-check-label" for="flexSwitchCheckDefault">사용안함</label>
															</div>
			                                            </td>
			                                        </tr>
			                                        <tr>
			                                            <td>
			                                            	<div class="custom-control custom-checkbox small">
				                                            	<input type="checkbox" class="custom-control-input" id="customCheck">
				                                            	<label class="custom-control-label" for="customCheck"></label>
			                                            	</div>
			                                            </td>
			                                            <td>1</td>
			                                            <td><input type="text" class="form-control" name="" placeholder="상세코드ID 입력"></td>
			                                            <td><input type="text" class="form-control" name="" placeholder="상세코드명 입력"></td>
			                                            <td><input type="text" class="form-control" name="" placeholder="설명 입력"></td>
			                                            <td>
			                                            	<div class="form-check form-switch">
																<input class="form-check-input" type="checkbox" role="switch" id="flexSwitchCheckDefault">
																<label class="form-check-label" for="flexSwitchCheckDefault">사용안함</label>
															</div>
			                                            </td>
			                                        </tr>
			                                   </tbody>
			                                </table>
			                          	</div>
                                        <button class="btn btn-primary btn-lg d-block m-auto col-3" type="submit">등록하기</button>
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

    <!-- Page level custom scripts -->
<%--     <script src="${pageContext.request.contextPath}/resources/adm/js/code_regist.js"></script> --%>

</body>


</html>