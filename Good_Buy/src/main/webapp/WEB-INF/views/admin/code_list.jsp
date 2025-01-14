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
<!--                 	<h1 class="h3 mb-4 text-gray-800">공통코드 관리</h1> -->
					<div class="row">
                        <div class="col-lg-12">
                            <div class="card shadow mb-4">
                                <div class="card-header py-3">
                                    <h5 class="m-0 font-weight-bold text-primary">공통코드 목록</h5>
                                </div>
                                <div class="card-body">
                                	<div class="search-wrap border">
									   	<section class="d-flex search-inner">
										    <div class="col-6 search-box">
						                        <div class="input-group">
						                            <input type="text" id="searchKeyword" class="form-control bg-light border small" name="keyword_search" placeholder="코드ID, 코드명, 설명 검색" aria-label="Search" aria-describedby="basic-addon2">
						                            <div class="input-group-append">
						                                <button class="btn btn-primary" id="searchBtn" type="button">검색</button>
						                            </div>
						                        </div>
					                        </div>
					                        <div class="col-6 d-flex justify-right">
												<button class="btn btn-primary ml-auto"  data-toggle="modal" data-target="#addCommonCodes" type="button" id="btnAddRow"><i class="fa-regular fa-pen-to-square"></i>상세코드 추가</button>
												<button class="btn btn-danger ml-2" type="button" id="btnDeleteRow"><i class="fa-solid fa-trash-can"></i> 선택 삭제</button>
		                                    </div>
									   	</section>
									</div>
                                	<div class="table-responsive overflow-hidden">
		                                <table class="table table-bordered" id="codeList" width="100%" cellspacing="0">
		                                    <thead>
		                                    	<tr>
		                                    		<th width="30px">
		                                            	<div class="custom-control custom-checkbox small">
			                                            	<input type="checkbox" class="custom-control-input" id="checkAll">
			                                            	<label class="custom-control-label" for="checkAll"></label>
		                                            	</div>
		                                            </th>
		                                            <th>No.</th>
		                                            <th>공통코드ID</th>
		                                            <th>공통코드명</th>
		                                            <th>공통코드 설명</th>
		                                            <th>상세코드ID</th>
		                                            <th>상세코드명</th>
		                                            <th>상세코드 설명</th>
		                                            <th>사용여부</th>
		                                            <th>순서</th>
		                                            <th>관리</th>
		                                    	</tr>
		                                    </thead>
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
    
    <!-- 추가 모달 -->
    <div class="modal fade" id="addCommonCodes" tabindex="-1" aria-labelledby="addModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
		    <div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="addModalLabel">상세코드 추가</h5>
					<button type="button" class="close" data-dismiss="modal"><i class="fa-solid fa-xmark"></i></button>
				</div>
				<div class="modal-body">
					<form action="AdmCommoncodeAdd" method="post" id="addCommoncodeForm">
						<div class="mb-1">
							<label for="updatedCommoncodeId" class="col-form-label">공통코드ID</label>
							<select id="mainCodeList" class="form-control">
							</select>
						</div>
						<div class="mb-1">
							<label for="viewCommonCodeName" class="col-form-label">공통코드명</label>
							<input type="text" class="form-control" name="CODETYPE_NAME" id="viewCommonCodeName" readonly>
						</div>
						<div class="mb-1">
							<label for="viewCommonCodeDesc" class="col-form-label">공통코드 설명</label>
							<input type="text" class="form-control" name="CODETYPE_DESC" id="viewCommonCodeDesc" readonly>
						</div>
						<div class="mb-1">
							<label for="newCodeId" class="col-form-label">상세코드ID</label>
							<input type="text" class="form-control" name="CODE_ID" id="newCodeId" required>
							<span class="result" id="subCodeResult"></span>
						</div>
						<div class="mb-1">
							<label for="newCodeName" class="col-form-label">상세코드명</label>
							<input type="text" class="form-control" name="CODE_NAME" id="newCodeName" required>
						</div>
						<div class="mb-1">
							<label for="newCodeDesc" class="col-form-label">상세코드 설명</label>
							<input type="text" class="form-control" name="CODE_DESC" id="newCodeDesc" required>
						</div>
						<div class="row px-2">
							<div class="w-50">
								<label for="newCodeStatus" class="col-form-label">사용여부</label>
								<div class="form-check form-switch">
					        		<input type="hidden" id="newCodeStatus" name="CODE_STATUS">
									<input class="form-check-input" type="checkbox" role="switch" id="newSwitchCheckDefault">
									<label class="form-check-label text-center" style="width:70px" id="newFlexSwitchCheckDefaultLab" for="newFlexSwitchCheckDefault"></label>
								</div>
							</div>
							<div class="w-50">
								<label for="newCodeSeq" class="col-form-label">상세코드 순서</label>
								<input type="number" min="1" class="form-control" name="CODE_SEQ" id="newCodeSeq" placeholder="순서 입력" required>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer justify-content-center">
					<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
					<button type="submit" class="btn btn-primary" id="btnAddForm" form="addCommoncodeForm">추가하기</button>
				</div>
			</div>
		</div>
	</div>
    
    <!-- 수정 모달 -->
    <div class="modal fade" id="updateCommonCodes" tabindex="-1" aria-labelledby="updateModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
		    <div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="updateModalLabel">수정</h5>
					<button type="button" class="close" data-dismiss="modal"><i class="fa-solid fa-xmark"></i></button>
				</div>
				<div class="modal-body">
					<form action="AdmCommoncodeModify" method="post" id="modifyForm">
						<input type="hidden" id="oldCodetypeId" name="OLD_CODETYPE_ID">
						<input type="hidden" id="oldCodeId" name="OLD_CODE_ID">
						<div class="mb-1">
							<label for="updatedCommoncodeId" class="col-form-label">공통코드ID <small class="text-primary" style="font-weight:600;">공통코드ID는 수정할 수 없습니다.</small></label>
							<input type="text" class="form-control" name="CODETYPE_ID" id="updatedCommonCodeId" readonly>
						</div>
						<div class="mb-1">
							<label for="updatedCommonCodeName" class="col-form-label">공통코드명</label>
							<input type="text" class="form-control" name="CODETYPE_NAME" id="updatedCommonCodeName" required>
						</div>
						<div class="mb-1">
							<label for="updatedCommonCodeDesc" class="col-form-label">공통코드 설명</label>
							<input type="text" class="form-control" name="CODETYPE_DESC" id="updatedCommonCodeDesc" required>
						</div>
						<div class="mb-1">
							<label for="updatedCodeId" class="col-form-label">상세코드ID</label>
							<input type="text" class="form-control" name="CODE_ID" id="updatedCodeId" required>
						</div>
						<div class="mb-1">
							<label for="updatedCodeName" class="col-form-label">상세코드명</label>
							<input type="text" class="form-control" name="CODE_NAME" id="updatedCodeName" required>
						</div>
						<div class="mb-1">
							<label for="updatedCodeDesc" class="col-form-label">상세코드 설명</label>
							<input type="text" class="form-control" name="CODE_DESC" id="updatedCodeDesc" required>
						</div>
						<div class="row px-2">
							<div class="w-50">
								<label for="updatedCodeStatus" class="col-form-label">사용여부</label>
								<div class="form-check form-switch">
					        		<input type="hidden" id="updatedCodeStatus" name="CODE_STATUS">
									<input class="form-check-input" type="checkbox" role="switch" id="updateFlexSwitchCheckDefault">
									<label class="form-check-label text-center" style="width:70px" id="updateFlexSwitchCheckDefaultLab" for="updateFlexSwitchCheckDefault"></label>
								</div>
							</div>
							<div class="w-50">
								<label for="updatedCodeSeq" class="col-form-label">상세코드 순서</label>
								<input type="number" min="1" class="form-control" name="CODE_SEQ" id="updatedCodeSeq" placeholder="순서 입력" required>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer justify-content-center">
					<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
					<button type="submit" class="btn btn-primary" id="btnModifyForm" form="modifyForm">수정하기</button>
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
<%--     <script src="${pageContext.request.contextPath}/resources/adm/vendor/datatables/datatables.min.js"></script> --%>

    <!-- Page level custom scripts -->
    <script src="${pageContext.request.contextPath}/resources/adm/js/code_list.js"></script>

</body>


</html>