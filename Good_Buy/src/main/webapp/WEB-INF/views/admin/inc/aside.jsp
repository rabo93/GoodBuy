<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- Sidebar -->
<ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">
    <a class="sidebar-brand d-flex align-items-center justify-content-center" href="#">GoodBuy Admin</a>
    <hr class="sidebar-divider my-0">
    <li class="nav-item">
        <a class="nav-link" href="AdminMain"><i class="fa-solid fa-house"></i> <span>Main</span></a>
    </li>
    <hr class="sidebar-divider">
    <div class="sidebar-heading">System Setting</div>
    <li class="nav-item active">
        <a class="nav-link collapsed" href="AdminCommoncodeList" data-toggle="collapse" data-target="#menu01" aria-expanded="true" aria-controls="menu01">
            <i class="fas fa-fw fa-cog"></i> <span>공통코드 관리</span>
        </a>
        <div id="menu01" class="collapse show" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
            <div class="bg-white py-2 collapse-inner rounded">
                <a class="collapse-item active" href="AdminCommoncodeRegist">공통코드 등록</a>
                <a class="collapse-item" href="AdminCommoncodeList">공통코드 목록</a>
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