document.addEventListener("DOMContentLoaded", function(){
	const orderList = $('#productList').DataTable({
		lengthChange : true, // 건수
		searching : false, // 검색
		info : true, // 정보
		ordering : true, // 정렬
		paging : true,
		responsive: true, // 반응형
		pageLength: 25,
		destroy: true,
		scrollX: true, 
		autoWidth: false,
		ajax : {
			url: "AdmProductList",
			type: "POST",
			dataType : "JSON",
			data: function(d) {
                d.status = $('input[name="status"]:checked').val(); //상태별
                d.searchDate = $("#schDate").val(); //기간별
                d.searchValue = $('input[name="keyword_search"]').val(); //키워드 검색
            },
			dataSrc: function (res) {
				console.log(res.productList);
				const data = res.productList;
				const start = $('#productList').DataTable().page.info().start; 
				
				// PK가 아닌 테이블 컬럼 번호 계산(페이징 포함)
				for (let i = 0; i < data.length; i++) {
					data[i].listIndex = start + i + 1;
				}
				return data;
			},
		},
		dom: '<"top"<"left-length"l><"right-buttons"fB>>rt<"bottom"ip>',
        buttons: [
			{
                extend: 'copy',
                text: '복사',
            },
            {
                extend: 'excel',
                text: '엑셀 저장',
                exportOptions: {
		            columns: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
		        },
            },
		],
		order: [[9, 'desc']], // 최초 조회 시 거래일시 최신순으로 기본 설정
		columnDefs: [
			 { targets: [0, 4, 7], orderable: false }, 
		],
		columns: [
            { title: "No.", data: "listIndex", className : "dt-center", width: '30px', },
            { 
				title: "판매자", 
				data: "MEM_ID",
				defaultContent: "",
	            width: '100px',
				className : "dt-center",
	            render: function (data, type, row) {
					if (!data) {
						return "";
					}
					return `<a href="AdmMemberDetailForm?mem_id=${data}" target="_blank" title="새 창 열기">${data.replace(/(.{16})/g, '$1<br>')}</a>`;
           		}
			},
            { title: "ID", data: "PRODUCT_ID", defaultContent: "", className : "dt-center", width: '50px',},
            {
				 title: "상품명", 
				 data: "PRODUCT_TITLE", 
				 defaultContent: "", 
				 className : "dt-center",  
				 width: '200px', 
				 render : function(data, type, row) {
					return `<a href="ProductDetail?PRODUCT_ID=${row.PRODUCT_ID}" target="_blank" title="새 창 열기">${data}</a>`;
				}
            
            },
            {
				 title: "상품상세", 
				 data: "PRODUCT_INTRO", 
				 defaultContent: "", 
				 className : "dt-center",  
				 width: '220px',
            },
            { title: "가격(원)", data: "PRODUCT_PRICE", defaultContent: "", className : "dt-center", width: '90px', },
            { title: "배송비(원)", data: "PRODUCT_SHIPPING_FEE", defaultContent: "", className : "dt-center", width: '90px',},
            { title: "가격제안", data: "PRODUCT_DISCOUNT_STATUS", defaultContent: "", className : "dt-center", width: '70px',},
            { title: "카테고리", data: "PRODUCT_CATEGORY", defaultContent: "", className : "dt-center", width: '100px',},
            { title: "등록일자", data: "PRODUCT_REG_DATE", defaultContent: "", className : "dt-center", width: '180px',},
            { 
				title: "상품상태", data : "PRODUCT_STATUS", defaultContent: "", width: '100px', className : "dt-center",  width: '100px',
				render : function(data, type, row) {
					if(!data && data != 0) return "";
					switch (data) {
				        case 0: return "<span class='status status-00'>판매중</span>";
				        case 1: return "<span class='status status-01'>거래중</span>";
				        case 2: return "<span class='status status-04'>예약중</span>";
				        case 3: return "<span class='status status-03'>거래완료</span>";
				        case 4: return "<span class='status status-02'>신고처리</span>";
				        default: return "";
				    }
				}
            },
        ],
		serverSide : true, // 서버사이드 처리
		processing : true,  // 서버와 통신 시 응답을 받기 전이라는 ui를 띄울 것인지 여부
		language : {
			emptyTable: "데이터가 없습니다.",
			lengthMenu: "_MENU_ 건씩 보기",
			info: "현재 _START_ - _END_ / 총 _TOTAL_건",
			infoEmpty: "데이터 없음",
			search: "검색",
			infoFiltered: "( _MAX_건의 데이터에서 필터링됨 )",
			loadingRecords: "로딩중...",
			processing: "잠시만 기다려 주세요...",
			zeroRecords: "일치하는 데이터가 없습니다.",
            paginate: {
                first:    '처음',
                previous: '이전',
                next:     '다음',
                last:     '마지막'
            },
        },
	});
	
	// 기존 검색 숨기기
	$("#productList_filter").attr("hidden", "hidden");
	
	 // 필터 변경 시 데이터 테이블 다시 로드
    $('input[name="status"]').on('change', () => orderList.draw());

    // 검색 버튼 클릭 시 테이블 다시 로드
    $('#searchBtn').on('click', () => orderList.draw());
    
    // 엔터키 입력으로 검색
    $('#searchKeyword').on('keypress', (e) => {
        if (e.which == 13)  orderList.draw();
    });
    
	// 기간별 검색 필터링 제이쿼리
    $('#schDate').daterangepicker({
//        startDate: moment().subtract(29, 'days'),
//        startDate: false,
//        endDate: moment(),
        maxDate: moment(),
        locale: {
			start: '시작일시',
			end: '종료일시',
		    separator: " ~ ", // 시작일시와 종료일시 구분자
		    format: 'YYYY-MM-DD', // 일시 노출 포맷
		    applyLabel: "확인", // 확인 버튼 텍스트
		    cancelLabel: "취소", // 취소 버튼 텍스트
		    daysOfWeek: ["일", "월", "화", "수", "목", "금", "토"],
		    monthNames: ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"],
			customRangeLabel: '기간 지정',
		 },
		autoUpdateInput: false,
	    timePicker: false, // 시간 노출 여부
	    showDropdowns: true, // 년월 수동 설정 여부
	    autoApply: false, // 확인/취소 버튼 사용여부
		ranges: {
            '이번 달': [moment().startOf('month'), moment().endOf('month')], // 이번 달 전체
            '지난 달': [moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')], // 지난 달 전체
            '지난 7일': [moment().subtract(6, 'days'), moment()], // 최근 7일
            '지난 14일': [moment().subtract(13, 'days'), moment()], // 최근 14일
            '지난 30일': [moment().subtract(29, 'days'), moment()], // 최근 30일
            '지난 3개월': [moment().subtract(3, 'months').startOf('month'), moment().endOf('month')], // 최근 3개월
        },
    }).on('show.daterangepicker', function (ev, picker) {
        picker.container.addClass('goodbuyCustomPicker');                            
    });
    
    // 날짜 선택 후에도 placeholder 유지
    $('#schDate').on('apply.daterangepicker', function(ev, picker) {
        $(this).val(`${picker.startDate.format('YYYY-MM-DD')} ~ ${picker.endDate.format('YYYY-MM-DD')}`);
    });
    
	// 날짜 검색 초기화
	$("#initDateBtn").on('click', function() {
		$('#schDate').val('');
		orderList.draw();
	});
	
    // 기간별 검색 후 테이블 다시 로드
    $("#searchDateBtn").on('click', function() {
		orderList.draw();
	});

});
