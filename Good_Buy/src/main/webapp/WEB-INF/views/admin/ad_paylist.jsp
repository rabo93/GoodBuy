<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>굿바이 - 중고거래, 이웃과 함께 더 쉽게!</title>

<!-- default -->
<script src="../../resources/js/jquery-3.7.1.js"></script>

<!-- font-awesome -->
<link rel="stylesheet" href="../../resources/fontawesome/all.min.css" />
<script src="../../resources/fontawesome/all.min.js"></script>

<!-- ******************* 아래 CSS와 JS는 페이지별로 알맞게 Import 해주세요 ****************** -->
<!-- CSS for Page -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&family=Nunito:wght@200..1000&display=swap" rel="stylesheet">
<link href="../../resources/adm/css/sb-admin-2.css" rel="stylesheet">
<link href="../../resources/adm/css/adm.css" rel="stylesheet">

</head>
<body id="page-top">

    <!-- Page Wrapper -->
    <div id="wrapper">

        <!-- Sidebar -->
        <ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">
            <a class="sidebar-brand d-flex align-items-center justify-content-center" href="#">GoodBuy Admin</a>
            <hr class="sidebar-divider my-0">
            <li class="nav-item">
                <a class="nav-link" href="#"><i class="fa-solid fa-house"></i> <span>Main</span></a>
            </li>
            <hr class="sidebar-divider">
            <div class="sidebar-heading">System Setting</div>
            <li class="nav-item">
                <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#menu01" aria-expanded="true" aria-controls="menu01">
                    <i class="fas fa-fw fa-cog"></i> <span>공통코드 관리</span>
                </a>
                <div id="menu01" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
                    <div class="bg-white py-2 collapse-inner rounded">
                        <a class="collapse-item" href="#">공통코드 등록</a>
                        <a class="collapse-item" href="#">공통코드 목록</a>
                    </div>
                </div>
            </li>
            <hr class="sidebar-divider">
            <div class="sidebar-heading">Site Setting</div>
            <li class="nav-item">
                <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#menu02" aria-expanded="true" aria-controls="menu02">
                	<i class="fa-solid fa-user"></i> <span>회원 관리</span>
                </a>
                <div id="menu02" class="collapse" aria-labelledby="headingUtilities" data-parent="#accordionSidebar">
                    <div class="bg-white py-2 collapse-inner rounded">
                    	<h6 class="collapse-header">User List</h6>
                        <a class="collapse-item" href="#">회원 목록</a>
                    </div>
                </div>
            </li>
            <li class="nav-item">
                <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#menu03" aria-expanded="true" aria-controls="menu03">
                	<i class="fa-solid fa-credit-card"></i> <span>결제 관리</span>
                </a>
                <div id="menu03" class="collapse" aria-labelledby="headingUtilities" data-parent="#accordionSidebar">
                    <div class="bg-white py-2 collapse-inner rounded">
                    	<h6 class="collapse-header">Payment Management</h6>
                        <a class="collapse-item" href="#">전체 구매내역</a>
                        <a class="collapse-item" href="#">전체 판매내역</a>
                        <a class="collapse-item" href="#">???</a>
                    </div>
                </div>
            </li>
            <li class="nav-item">
                <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#menu04" aria-expanded="true" aria-controls="menu04">
                	<i class="fa-solid fa-land-mine-on"></i> <span>신고 관리</span>
                </a>
                <div id="menu04" class="collapse" aria-labelledby="headingUtilities" data-parent="#accordionSidebar">
                    <div class="bg-white py-2 collapse-inner rounded">
                    	<h6 class="collapse-header">Report Management</h6>
                        <a class="collapse-item" href="#">신고 회원 관리</a>
                        <a class="collapse-item" href="#">신고 상품 관리</a>
                    </div>
                </div>
            </li>
            <li class="nav-item">
                <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#menu06" aria-expanded="true" aria-controls="menu06">
                	<i class="fa-solid fa-newspaper"></i> <span>고객지원 관리</span>
                </a>
                <div id="menu06" class="collapse" aria-labelledby="headingUtilities" data-parent="#accordionSidebar">
                    <div class="bg-white py-2 collapse-inner rounded">
                    	<h6 class="collapse-header">Customer Management</h6>
                        <a class="collapse-item" href="#">공지사항 관리</a>
                        <a class="collapse-item" href="#">1:1문의 관리</a>
                        <a class="collapse-item" href="#">FAQ 관리</a>
                    </div>
                </div>
            </li>
            <hr class="sidebar-divider">
            <div class="sidebar-heading">Marketing</div>
            <li class="nav-item">
                <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#menu05" aria-expanded="true" aria-controls="menu05">
                	<i class="fa-solid fa-rectangle-ad"></i> <span>광고 관리</span>
                </a>
                <div id="menu05" class="collapse" aria-labelledby="headingUtilities" data-parent="#accordionSidebar">
                    <div class="bg-white py-2 collapse-inner rounded">
                    	<h6 class="collapse-header">Advertisement</h6>
                        <a class="collapse-item" href="#">광고 회원 및 상품 목록</a>
                        <a class="collapse-item" href="#">광고 서비스 결제내역</a>
                    </div>
                </div>
            </li>
            <hr class="sidebar-divider">
            <div class="sidebar-heading">Chart</div>
            <li class="nav-item">
                <a class="nav-link" href="#">
                    <i class="fas fa-fw fa-chart-area"></i>
                    <span>통계</span>
                </a>
            </li>
            <hr class="sidebar-divider d-none d-md-block">
            <div class="text-center d-none d-md-inline">
                <button class="rounded-circle border-0" id="sidebarToggle"></button>
            </div>
        </ul>
        <!-- End of Sidebar -->

        <!-- Content Wrapper -->
        <div id="content-wrapper" class="d-flex flex-column">

            <!-- Main Content -->
            <div id="content">
			
                <!-- Topbar -->
                <nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">
                    <!-- Sidebar Toggle (Topbar) -->
                    <button id="sidebarToggleTop" class="btn btn-link d-md-none rounded-circle mr-3">
                        <i class="fa fa-bars"></i>
                    </button>
                    <!-- Topbar Navbar -->
                    <ul class="navbar-nav ml-auto">
                        <li class="nav-item dropdown no-arrow">
                            <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <span class="mr-2 d-none d-lg-inline text-gray-600 small">관리자</span>
                                <img class="img-profile rounded-circle" src="../../resources/adm/img/undraw_profile.svg">
                            </a>
                            <!-- Dropdown - User Information -->
                            <div class="dropdown-menu dropdown-menu-right shadow animated--grow-in"
                                aria-labelledby="userDropdown">
                                <a class="dropdown-item" href="#">
                                    <i class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i>
                                    Profile
                                </a>
                                <a class="dropdown-item" href="#">
                                    <i class="fas fa-cogs fa-sm fa-fw mr-2 text-gray-400"></i>
                                    Settings
                                </a>
                                <a class="dropdown-item" href="#">
                                    <i class="fas fa-list fa-sm fa-fw mr-2 text-gray-400"></i>
                                    Activity Log
                                </a>
                                <div class="dropdown-divider"></div>
                                <a class="dropdown-item" href="#" data-toggle="modal" data-target="#logoutModal">
                                    <i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
                                    Logout
                                </a>
                            </div>
                        </li>
                    </ul>
                </nav>
                <!-- End of Topbar -->

                <!-- Begin Page Content -->
                <div class="container-fluid">
                    <h1 class="h3 mb-4 text-gray-800">광고 서비스 결제 내역</h1>
					
                </div>
                <!-- /.container-fluid -->
				
				<div class="table-responsive overflow-hidden">
					<table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
						<colgroup>
							<col width="15%">
							<col width="15%">
							<col width="13%">
							<col width="12%">
							<col width="10%">
							<col width="10%">
							<col width="12%">
							<col width="13%">
						</colgroup>
                        <thead>
                           <tr>
								<th scope="col">결제번호</th>
								<th scope="col">결제일시</th>
								<th scope="col">회원ID</th>
								<th scope="col">결제수단</th>
								<th scope="col">상태</th>
								<th scope="col">결제금액</th>
								<th scope="col">환불처리</th>
								<th scope="col">상세정보</th>
							</tr>
                        </thead>
                        
                        <tbody>
                        	<c:choose>
								<c:when test="${empty paymentList}">
									<tr><td colspan="8" class="empty">결제내역이 존재하지 않습니다.</td></tr>
								</c:when>
								<c:otherwise>
									<c:forEach var="payment" items="${paymentList}" varStatus="status">
										<tr>
											<td>${payment.key}</td>
											<td><fmt:formatDate value="${payment.value[0].pay_date}" pattern="yy-MM-dd HH:mm:ss" /></td>
											<td>${payment.value[0].mem_id}</td>
											<td>
												<c:choose>
													<c:when test="${not empty payment.value[0].bank_name}">
														${payment.value[0].bank_name}
													</c:when>
													<c:when test="${not empty payment.value[0].card_name}">
														${payment.value[0].card_name}
													</c:when>
												</c:choose>
											</td>
											<td>
												<c:if test="${payment.value[0].pay_status == 1}">
													<span class="payment-status st01">결제완료</span>
												</c:if>
												<c:if test="${payment.value[0].pay_status == 2}">
													<span class="payment-status st02">결제취소</span>
												</c:if>
												<c:if test="${payment.value[0].pay_status == 3}">
													<span class="payment-status st03">입금대기</span>
												</c:if>
											</td>
											<td><fmt:formatNumber pattern="#,###">${payment.value[0].total_price}</fmt:formatNumber> 원</td>
											<td><button type="button" class="btn btn-lg btn-primary" onclick="cancelPay('${payment.value[0].imp_uid}', '${payment.value[0].total_price}')"  formmethod="post">결제취소</button></td>
											<td><button type="button" class="btn btn-lg btn-primary" onclick="showDetail(${status.index})">상세정보</button></td>
										</tr>
										<tr class="paymentDetailBox" id="paymentDetail${status.index}">
											<td colspan="8">
		                           				<c:forEach var="item" items="${payment.value}">	
	                             					<div class="payment-item">
														<span class="ttl">${item.class_title}</span>
														<span class="price"><fmt:formatNumber pattern="#,###">${item.class_price}</fmt:formatNumber> 원</span>
	                             					</div>
												</c:forEach>
												<c:if test="${payment.value[0].discount_type == 1}">
													<div class="discount-item">
														<span class="ttl">쿠폰 할인 사용</span>
														<span class="price">- ${payment.value[0].discount_percent} % </span>
													 </div>
												</c:if>
												<c:if test="${payment.value[0].discount_type == 2}">
													<div class="discount-item"> 
														<span class="ttl">쿠폰 할인 사용</span>
														<span class="price"> - <fmt:formatNumber pattern="#,###">${payment.value[0].discount_amount}</fmt:formatNumber> 원  </span>
													</div>
												</c:if>
												<div class="total-item">
													<span class="ttl">총 결제금액</span>
													<span class="price"> <fmt:formatNumber pattern="#,###">${payment.value[0].total_price}</fmt:formatNumber> 원</span>
                             					</div>
											</td>
		                             	</tr>
									</c:forEach>
								</c:otherwise>
								
								
							</c:choose>
                       </tbody>
                    </table>
              	</div>
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
            </div>
            <!-- End of Main Content -->

            <!-- Footer -->
            <footer class="sticky-footer bg-white">
                <div class="container my-auto">
                    <div class="copyright text-center my-auto">
                        <span>Copyright &copy; GoodBuy 2024</span>
                    </div>
                </div>
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
    <div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
        aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Ready to Leave?</h5>
                    <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body">Select "Logout" below if you are ready to end your current session.</div>
                <div class="modal-footer">
                    <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
                    <a class="btn btn-primary" href="login.html">Logout</a>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap core JavaScript-->
    <script src="../../resources/adm/vendor/jquery/jquery.min.js"></script>
    <script src="../../resources/adm/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-->
    <script src="../../resources/adm/vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Custom scripts for all pages-->
    <script src="../../resources/adm/js/sb-admin-2.min.js"></script>

</body>


</html>