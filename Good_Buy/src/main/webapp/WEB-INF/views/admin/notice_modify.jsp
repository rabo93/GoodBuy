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
                                    <h5 class="m-0 font-weight-bold text-primary">공지사항 수정</h5>
                                </div>
                                <div class="card-body">
                                    <form action="AdmNoticeModify" name="modifyForm" method="post" enctype="multipart/form-data">
                                    	<input type="hidden" name="notice_id" value="${param.notice_id}">
                                        <div class="mb-3">
                                            <label class="small mb-1" for="memId">작성자 ID</label>
                                            <input class="form-control" id="memId" name="mem_id" type="text" value="${notice.mem_id}" readonly required>
                                        </div>
                                        <div class="mb-3">
                                            <label class="small mb-1" for="noticeSubject">제목</label>
                                            <input class="form-control" id="noticeSubject" name="notice_subject" value="${notice.notice_subject}" required>
                                        </div>
                                        <div class="mb-3">
                                            <label class="small mb-1" for="noticeContent">내용</label>
                                            <textarea class="form-control" rows="15" cols="40" name="notice_content" id="noticeContent" required>${notice.notice_content}</textarea>
                                        </div>
                                        <div class="mb-3">
                                        	<label class="small mb-1" for="file">파일첨부</label>
                                        	<c:choose>
												<c:when test="${not empty notice.notice_file}">
													<input class="form-control" type="text" value="${originalFile}" readonly>
													<a href="${pageContext.request.contextPath}/resources/upload/${notice.notice_file}" download="${originalFile}"><i class="fa-solid fa-download"></i></a>
													<a href="javascript:deleteFile(${notice.notice_id}, '${notice.notice_file}')"><i class="fa-solid fa-trash"></i></a>
													<input type="file" name="file" hidden>
												</c:when>
												<c:otherwise>
													<input type="file" name="file" id="file" class="form-control">
												</c:otherwise>
											</c:choose>
                                        </div>
                                        <div class="row align-items-center justify-content-center">
	                                        <button type="button" onclick="location.href='AdmNoticeList'" class="btn btn-dark btn-lg d-block col-3">취소</button>
	                                        <button type="submit" id="btnSubmitForm" class="btn btn-primary btn-lg d-block col-3 ml-2">수정</button>
                                        </div>
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
    <script src="${pageContext.request.contextPath}/resources/adm/js/notice_modify.js"></script>
</body>


</html>