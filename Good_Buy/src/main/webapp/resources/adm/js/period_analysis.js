document.addEventListener("DOMContentLoaded", function () {
	// 이번 달 범위 계산(초기 설정)
	const today = moment(); // 오늘 날짜
	const firstDayOfMonth = today.clone().startOf('month'); // 이번 달 첫날 = today.startOf('month');
	const lastDayOfMonth = today.clone().endOf('month'); // 이번 달 마지막 날
	const defaultRange = `${firstDayOfMonth.format('YYYY-MM-DD')} ~ ${lastDayOfMonth.format('YYYY-MM-DD')}`;
	$('#schDate').val(defaultRange); //2025-01-01 ~ 2025-01-31
	
    const periodList = $('#periodList').DataTable({
        lengthChange: false,	//건수(비활성화) 
        searching: false,		//검색(비활성화) 
        info: true,				//정보
        ordering: true,			//정렬
        paging: true,  			//페이징
        responsive: true,		//반응형
        destroy: true,			
        scrollX: true,
        autoWidth: false,		//컬럼사이즈 조정 자동설정(비활성화)
		ajax : {
			url: "PeriodListForm",
			type: "POST",
			dataType : "JSON",
			data: function(d) {
				// 'schDate'의 값을 'searchDate'로 전달
				d.searchDate = $("#schDate").val();
				console.log(d.searchDate);
            },
			dataSrc: function (res) {
				console.log("res:" + JSON.stringify(res));
				const data = res.periodList;
				return data;
			},
		},
		order: [[0, 'asc']], // 최초 조회시 날짜 순으로 기본 설정
        columnDefs: [
		],
        columns: [
			// defaultContent 는 기본값 설정, 데이터 없는 컬럼일 경우 오류나기 때className : "dt-center",문에 널스트링 처리 해주어야 함
            { title: "날짜", data: "date", className : "dt-center", defaultContent: ""},
            { title: "회원수", data: "memberTotal", defaultContent: "0" },
            { title: "거래수", data: "orderTotal", defaultContent: "0" },
//            { title: "방문자수", data: "visit", defaultContent: "0" },
        ],
        initComplete: function () {
			// 데이터 초기화 완료 후 총합 계산
//			updateFooter(this.api());
		},
		serverSide : true, 	// 서버사이드 처리
		processing : true,  // 서버와 통신 시 응답을 받기 전이라는 ui를 띄울 것인지 여부
        language: {
            emptyTable: "데이터가 없습니다.",
            info: "현재 _START_ - _END_ / 총 _TOTAL_건",
            loadingRecords: "로딩중...",
			processing: "잠시만 기다려 주세요...",
			zeroRecords: "일치하는 데이터가 없습니다.",
        },
        footerCallback: function (row, data, start, end, display) {
			var api = this.api();
	
	        var totalJoin = api
	            .column(1, { page: 'current' })
	            .data()
	            .reduce(function (a, b) {
	                return parseFloat(a) + parseFloat(b);
	            }, 0);
	
//	        var totalVisit = api
//	            .column(2, { page: 'current' })
//	            .data()
//	            .reduce(function (a, b) {
//	                return parseFloat(a) + parseFloat(b);
//	            }, 0);
	
			var totalTrade = api
	            .column(2, { page: 'current' })
	            .data()
	            .reduce(function (a, b) {
	                return parseFloat(a) + parseFloat(b);
	            }, 0);
	            
	        $(api.column(1).footer()).html(totalJoin.toFixed(1));
//	        $(api.column(2).footer()).html(totalVisit.toFixed(2));
	        $(api.column(2).footer()).html(totalTrade.toFixed(2));
	        
	    }
    });
	//------------------------------------------------------------------
    // 기간별 검색 필터링 제이쿼리
    $('#schDate').daterangepicker({
		startDate: firstDayOfMonth, // 이번 달 첫날
		endDate: lastDayOfMonth, // 이번 달 마지막 날
//        maxDate: moment(),
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
            '오늘': [moment()], // 오늘
            '이번 달': [firstDayOfMonth, lastDayOfMonth], // 이번 달 전체
//            '이번 달': [moment().startOf('month'), moment().endOf('month')], // 이번 달 전체
            '지난 달': [moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')], // 지난 달 전체
            '지난 7일': [moment().subtract(6, 'days'), moment()], // 최근 7일
            '지난 14일': [moment().subtract(13, 'days'), moment()], // 최근 14일
            '지난 30일': [moment().subtract(29, 'days'), moment()], // 최근 30일
            '지난 3개월': [moment().subtract(3, 'months').startOf('month'), moment().endOf('month')], // 최근 3개월
        },
//    }).on('show.daterangepicker', function (ev, picker) {
//        picker.container.addClass('goodbuyCustomPicker');                            
    });
    
    //------------------------------------------------------------------------------------------------
	// 날짜 검색 초기화
	$("#initDateBtn").on('click', function() {
		$('#schDate').val('');
		periodList.draw();
	});
	
    // 날짜 선택 후에도 placeholder 유지
    $('#schDate').on('apply.daterangepicker', function(ev, picker) {
        $(this).val(`${picker.startDate.format('YYYY-MM-DD')} ~ ${picker.endDate.format('YYYY-MM-DD')}`);
    	periodList.draw(); // 기간 변경 시 테이블 갱신
    });
    
    // 검색 버튼 클릭 시 데이터 필터링
    $("#searchDateBtn").on('click', function() {
		periodList.draw();
	});
	
    
});