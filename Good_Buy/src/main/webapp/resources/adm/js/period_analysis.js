document.addEventListener("DOMContentLoaded", function(){
	const periodList = $('#periodList').DataTable({
		lengthChange : false, // 건수
		searching : false, // 검색
		info : true, // 정보
		ordering : true, // 정렬
		paging : true,
		responsive: true, // 반응형
		destroy: true,
		scrollX: true, 
		autoWidth: false,
		data: generateCurrentMonthDates(), // 데이터 생성
		ajax : {
			url: "PeriodAnalysis",
			type: "POST",
			dataType : "JSON",
			data: function(d) {
                d.searchDate = $("#schDate").val(); //기간별
            },
			dataSrc: function (res) {
//				const data = res.periodList;
//				const start = $('#periodList').DataTable().page.info().start; 
//				// PK가 아닌 테이블 컬럼 번호 계산(페이징 포함) => 이건 필요 없을꺼 같은데..
//				for (let i = 0; i < data.length; i++) {
//					data[i].listIndex = start + i + 1;
//				}
//				return data;

				if (res.periodList) {
                    return res.periodList; // 데이터가 있으면 반환
                }
                return []; // 데이터가 없으면 빈 배열 반환

			},
		},
		order: [[0, 'asc']], // 최초 조회 시 날짜순으로 기본 설정
		columnDefs: [
			 { targets: [2, 3], orderable: false },
			 { targets: "_all", className: "dt-center" }, // 모든 컬럼 가운데 정렬
		],
		columns: [
			// defaultContent 는 기본값 설정, 데이터 없는 컬럼일 경우 오류나기 때문에 널스트링 처리 해주어야 함
			// 회원가입 시 유효성 체크를 한다면 defaultContent 값 설정 필요 없음!
            { title: "날짜", data: "date"},
            { title: "가입수", data : "join", defaultContent: "0"},
            { title: "방문자수", data : "visit", defaultContent: "0"},
            { title: "거래수", data : "order", defaultContent: "0"},
        ],
		serverSide : true, // 서버사이드 처리
		processing : true,  // 서버와 통신 시 응답을 받기 전이라는 ui를 띄울 것인지 여부
		language : {
			emptyTable: "데이터가 없습니다.",
//			lengthMenu: "_MENU_ 건씩 보기",
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
	
	// 현재 월의 일자별 데이터를 생성하는 함수
    function generateCurrentMonthDates() {
        const today = new Date();
        const year = today.getFullYear();
        const month = today.getMonth(); // 0: January
        const daysInMonth = new Date(year, month + 1, 0).getDate();
        const data = [];

        for (let day = 1; day <= daysInMonth; day++) {
            const date = new Date(year, month, day);
            const formattedDate = date.toISOString().split('T')[0]; // YYYY-MM-DD 포맷
            data.push({
                date: formattedDate,
                join: "", // 가입 수는 기본값
                visit: "", // 방문자 수 기본값
                order: "", // 거래 수 기본값
            });
        }

        return data;
    }
	
	
	// 기존 검색 숨기기
//	$("#periodList_filter").attr("hidden", "hidden");
	
	 // 필터 변경 시 데이터 테이블 다시 로드
    $('input[name="status"]').on('change', () => periodList.draw());

    // 검색 버튼 클릭 시 테이블 다시 로드
    $('#searchBtn').on('click', () => periodList.draw());
    
    // 엔터키 입력으로 검색
    $('#searchKeyword').on('keypress', (e) => {
        if (e.which == 13)  periodList.draw();
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
		periodList.draw();
	});
	
    // 기간별 검색 후 테이블 다시 로드
    $("#searchDateBtn").on('click', function() {
//		periodList.draw(); // 화면만 갱신
		periodList.ajax.reload(); // 서버에서 데이터 다시 갱신
	});
	

});
