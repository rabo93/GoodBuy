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
					<div class="row">
                        <div class="col-lg-12">
                            <div class="card shadow mb-4">
                                <div class="card-header py-3">
                                    <h5 class="m-0 font-weight-bold text-primary">회원 목록</h5>
                                </div>
                                <div class="card-body">
                                	<div class="table-responsive">
		                                <table class="table table-bordered compact" id="memberList" width="100%" cellspacing="0">
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
    <div class="modal fade" id="updateMemberInfo" tabindex="-1" aria-labelledby="updateModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
		    <div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="updateModalLabel">회원 정보 수정</h5>
					<button type="button" class="close" data-dismiss="modal"><i class="fa-solid fa-xmark"></i></button>
				</div>
				<div class="modal-body">
					<form action="AdmMemberModify" method="post" id="modifyForm">
						<input type="hidden" id="oldMemId" name="old_mem_id">
						<div class="mb-1">
							<label for="updatedCommoncodeId" class="col-form-label">회원ID <small class="text-primary" style="font-weight:600;">공통코드ID는 수정할 수 없습니다.</small></label>
							<input type="text" class="form-control" name="mem_id" id="memId" readonly>
						</div>
						<div class="mb-1">
							<label for="updatedCommonCodeName" class="col-form-label">이름</label>
							<input type="text" class="form-control" name="mem_name" id="memName" required>
						</div>
						<div class="mb-1">
							<label for="updatedCommonCodeDesc" class="col-form-label">닉네임</label>
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
									<label class="form-check-label text-center" style="width:56px" id="updateFlexSwitchCheckDefaultLab" for="updateFlexSwitchCheckDefault"></label>
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
<%--     <script src="${pageContext.request.contextPath}/resources/adm/vendor/datatables/datatables.min.js"></script> --%> <%-- 반응형 --%>

    <!-- Page level custom scripts -->
    <script src="${pageContext.request.contextPath}/resources/adm/js/member_list.js"></script>

</body>


</html>