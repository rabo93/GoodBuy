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
                                    <h5 class="m-0 font-weight-bold text-primary">FAQ 관리</h5>
                                </div>
                                <div class="card-body">
                                	<div class="search-wrap border">
									   	<section class="d-flex search-inner">
									   		<!-- 분류 단추 -->
									   		<div class="col-5 pl-4 search-box">
			                                	<div class="search-ttl">FAQ유형별</div>
											    <div class="category-filter input-group">
											        <div class="form-check">
													    <input class="form-check-input" id="reset" type="radio" name="faq_cate"  value="0" checked>
													    <label class="form-check-label" for="reset">전체</label>
													</div>
											        <div class="form-check ml-3">
													    <input class="form-check-input" id="faqCate1" type="radio" name="faq_cate" value="1">
													    <label class="form-check-label" for="faqCate1">운영정책</label>
													</div>
													<div class="form-check ml-3">
													    <input class="form-check-input" id="faqCate2" type="radio" name="faq_cate" value="2">
													    <label class="form-check-label" for="faqCate2">회원/계정</label>
													</div>
													<div class="form-check ml-3">
													    <input class="form-check-input" id="faqCate3" type="radio" name="faq_cate" value="3">
													    <label class="form-check-label" for="faqCate3">결제/페이</label>
													</div>
													<div class="form-check ml-3">
													    <input class="form-check-input" id="faqCate4" type="radio" name="faq_cate" value="4">
													    <label class="form-check-label" for="faqCate4">광고서비스</label>
													</div>
													<div class="form-check ml-3">
													    <input class="form-check-input" id="faqCate5" type="radio" name="faq_cate" value="5">
													    <label class="form-check-label" for="faqCate5">기타</label>
													</div>
											    </div>
										    </div>
										    <div class="col-3 pl-4 search-box">
			                                	<div class="search-ttl">사용여부별</div>
											    <div class="category-filter input-group">
											    	<div class="form-check">
													    <input class="form-check-input" id="listStatusAll" type="radio" name="list_status" value="0" checked>
													    <label class="form-check-label" for="listStatusAll">전체</label>
													</div>
											        <div class="form-check ml-3">
													    <input class="form-check-input" id="listStatus1" type="radio" name="list_status" value="1">
													    <label class="form-check-label" for="listStatus1">사용함</label>
													</div>
													<div class="form-check ml-3">
													    <input class="form-check-input" id="listStatus2" type="radio" name="list_status" value="2">
													    <label class="form-check-label" for="listStatus2">사용안함</label>
													</div>
											    </div>
										    </div>
										    <div class="col-4 search-box">
						                        <div class="input-group">
						                            <input type="text" id="searchKeyword" class="form-control bg-light border small" name="keyword_search" placeholder="제목 또는 내용 검색" aria-label="Search" aria-describedby="basic-addon2">
						                            <div class="input-group-append">
						                                <button class="btn btn-primary" id="searchBtn" type="button">검색</button>
						                            </div>
						                        </div>
					                        </div>
									   	</section>
									   	
									</div>
									<!-- 작성하기/선택삭제 -->
			                        <div class="w-100 d-flex justify-right">
										<button class="btn btn-primary ml-auto" type="button" id="btnAddRow" onclick="window.open('FaqMain')"><i class="fa-regular fa-pen-to-square"></i> 작성하기</button>
										<button class="btn btn-danger ml-2" type="button" id="btnDeleteRow"><i class="fa-solid fa-trash-can"></i> 선택 삭제</button>
                                    </div>
                                    <!-- 테이블 -->
                                	<div class="table-responsive">
		                                <table class="table table-bordered compact" id="faqList" width="100%" cellspacing="0">
		                                    <thead>
		                                    	<tr>
		                                    		<th width="30px">
		                                            	<div class="custom-control custom-checkbox small">
			                                            	<input type="checkbox" class="custom-control-input" id="checkAll">
			                                            	<label class="custom-control-label" for="checkAll"></label>
		                                            	</div>
		                                            </th>
		                                            <th>No.</th>
		                                            <th>제목</th>
		                                            <th>내용</th>
		                                            <th>FAQ 유형</th>
		                                            <th>사용여부</th>
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
    
    <!-- 수정 모달 -->
    <div class="modal fade" id="updateFaq" tabindex="-1" aria-labelledby="updateModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
		    <div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="updateModalLabel">FAQ 수정</h5>
					<button type="button" class="close" data-dismiss="modal"><i class="fa-solid fa-xmark"></i></button>
				</div>
				<div class="modal-body">
					<form action="AdmFaqModify" method="post" id="modifyForm">
						<!-- faq 아이디 -->
						<input type="hidden" id="faqId" name="faq_id">
						<div class="mb-1">
							<label for="updatedFaqSubject" class="col-form-label">제목</label>
							<input type="text" class="form-control" name="faq_subject" id="updatedFaqSubject" required>
						</div>
						
						<div class="mb-3">
							<label class="small mb-1" for="updatedFaqContent">내용</label>
							<textarea class="form-control" col="4" id="updatedFaqContent" name="faq_content"  placeholder="내용을 입력하세요." required></textarea>
							<small class="text-primary text-right d-block font-weight-bold"><span id="lengthInfo">0</span> / 500자</small>
						</div>
						<div class="mb-1">
							<label class="small mb-1" for="updatedFaqCate">FAQ 유형</label>
							<select class="custom-select" id="updatedFaqCate" name="faq_cate" >
								<option value="1">운영정책</option>
								<option value="2">회원/계정</option>
								<option value="3">결제/페이</option>
								<option value="4">광고서비스</option>
								<option value="5">기타</option>
							</select>
						</div>
						
						<div class="row px-2">
							<div class="w-50">
								<label for="updatedListStatus" class="col-form-label">사용여부</label>
								<div class="form-check form-switch">
					        		<input type="hidden" id="updatedListStatus" name="list_status">
									<input class="form-check-input" type="checkbox" role="switch" id="updateFlexSwitchCheckDefault">
									<label class="form-check-label text-center" style="width:70px" id="updateFlexSwitchCheckDefaultLab" for="updateFlexSwitchCheckDefault"></label>
								</div>
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
    <script src="${pageContext.request.contextPath}/resources/adm/vendor/datatables/datatables.min.js"></script>

    <!-- Page level custom scripts -->
    <script src="${pageContext.request.contextPath}/resources/adm/js/faq_list.js"></script>

</body>


</html>