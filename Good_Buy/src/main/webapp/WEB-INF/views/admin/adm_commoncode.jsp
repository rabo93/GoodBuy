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
            <li class="nav-item active">
                <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#menu01" aria-expanded="true" aria-controls="menu01">
                    <i class="fas fa-fw fa-cog"></i> <span>공통코드 관리</span>
                </a>
                <div id="menu01" class="collapse show" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
                    <div class="bg-white py-2 collapse-inner rounded">
                        <a class="collapse-item active" href="#">공통코드 등록</a>
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
                	<h1 class="m-0 h3 text-gray-900">공통코드 관리</h1>
                	
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
    
    <!-- Page level plugins -->
    <script src="../../resources/adm/vendor/datatables/jquery.dataTables.min.js"></script>
    <script src="../../resources/adm/vendor/datatables/dataTables.bootstrap4.min.js"></script>

    <!-- Page level custom scripts -->
    <script src="../../resources/adm/js/demo/datatables-demo.js"></script>

</body>


</html>