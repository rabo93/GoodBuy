document.addEventListener("DOMContentLoaded", function () {
	// 이번 달 범위 계산(초기 설정)
	const today = moment(); // 오늘 날짜
	const firstDayOfMonth = today.clone().startOf('month'); // 이번 달 첫날
	const lastDayOfMonth = today.clone().endOf('month'); // 이번 달 마지막 날
	const defaultRange = `${firstDayOfMonth.format('YYYY-MM-DD')} ~ ${lastDayOfMonth.format('YYYY-MM-DD')}`;
	$('#schDate').val(defaultRange);
	
    const periodList = $('#periodList').DataTable({
        lengthChange: false,	//건수(비활성화) 
        searching: false,		//검색(비활성화) 
        info: false,			//정보(비활성화) 
        ordering: true,			//정렬
        paging: false,  		//페이징(비활성화)
        responsive: true,		//반응형
        destroy: true,			
        scrollX: true,
        autoWidth: false,		//컬럼사이즈 조정 자동설정(비활성화)
		ajax : {
			url: "PeriodListForm",
			type: "POST",
			dataType : "JSON",
			data: function(d) {
				d.searchDate = $("#schDate").val();
//				console.log(d.searchDate);
            },
			dataSrc: function (res) {
//				console.log("res:" + JSON.stringify(res));
				const data = res.periodList;
				
				// 날짜 정렬 추가
    			data.sort((a, b) => new Date(a.date) - new Date(b.date));
				
				
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
		            columns: [0, 1, 2, 3, 4, 5]
		        },
		        customize: function (xlsx) {
					// 엑셀에 총합 추가
					const sheet = xlsx.xl.worksheets['sheet1.xml'];
                    const totalMember = $('#periodList').DataTable().column(1).data().reduce((a, b) => parseInt(a) + parseInt(b), 0);
                    const totalJoin = $('#periodList').DataTable().column(2).data().reduce((a, b) => parseInt(a) + parseInt(b), 0);
                    const totalProduct = $('#periodList').DataTable().column(3).data().reduce((a, b) => parseInt(a) + parseInt(b), 0);
                    const totalOrder = $('#periodList').DataTable().column(4).data().reduce((a, b) => parseInt(a) + parseInt(b), 0);
                    const totalPay = $('#periodList').DataTable().column(5).data().reduce((a, b) => parseInt(a) + parseInt(b), 0);

                    const rows = $('sheetData row', sheet);
                    const lastRow = rows.last(); // 마지막 행 찾기
                    const totalRow = `
                        <row r="${rows.length + 1}">
                            <c t="inlineStr"><is><t>총합</t></is></c>
                            <c t="inlineStr"><is><t>${totalMember}</t></is></c>
                            <c t="inlineStr"><is><t>${totalJoin}</t></is></c>
                            <c t="inlineStr"><is><t>${totalProduct}</t></is></c>
                            <c t="inlineStr"><is><t>${totalOrder}</t></is></c>
                            <c t="inlineStr"><is><t>${totalPay}</t></is></c>
                        </row>`;
                    lastRow.after(totalRow); // 마지막 행 다음에 총합 행 추가
				},
            },
		],
		order: [[0, 'asc']], // 최초 조회시 날짜 순으로 기본 설정
        columnDefs: [
			{ targets: [1,2,3,4,5], orderable: false },
		],
        columns: [
			// defaultContent 는 기본값 설정, 데이터 없는 컬럼일 경우 오류나기 때문에 널스트링 처리 해주어야 함
            { title: "날짜", data: "date", className : "dt-center", defaultContent: ""},
            { title: "회원수(명)", data: "memberTotal", className : "dt-center", defaultContent: "0" },
            { title: "신규회원(명)", data: "joinTotal", className : "dt-center", defaultContent: "0" },
            { title: "상품등록(건)", data: "productTotal", className : "dt-center", defaultContent: "0" },
            { title: "거래완료(건)", data: "orderTotal", className : "dt-center", defaultContent: "0" },
            { title: "거래금액(원)", data: "payTotal", className : "dt-center", defaultContent: "0" },
        ],
        createdRow: function (row, data, dataIndex) {
			// 날짜를 Date 객체로 변환하여 데이터 속성에 저장
    		data.date = new Date(data.date);
    		
            // 모든 숫자 데이터 셀에 대해 세자리 콤마 추가
            $('td', row).each(function () {
                const cell = $(this);
                const text = cell.text();
                if ($.isNumeric(text)) {
                    cell.text(Number(text).toLocaleString()); // 세자리 콤마 추가
                }
            });
        },
        initComplete: function () {
			// 데이터 초기화 완료 후 총합 계산
//			updateFooter(this.api());
		},
		serverSide : true, 	// 서버사이드 처리
		processing : true,  // 서버와 통신 시 응답을 받기 전이라는 ui를 띄울 것인지 여부
        language: {
            emptyTable: "데이터가 없습니다.",
            info: "현재 _START_ - _END_ / 총 _TOTAL_건",
            infoEmpty: "데이터 없음",
            loadingRecords: "로딩중...",
			processing: "잠시만 기다려 주세요...",
			zeroRecords: "일치하는 데이터가 없습니다.",
//			infoFiltered: "( _MAX_건의 데이터에서 필터링됨 )",
//			paginate: {
//                first:    '처음',
//                previous: '이전',
//                next:     '다음',
//                last:     '마지막'
//            },
        },
        footerCallback: function (row, data, start, end, display) {
			var api = this.api();
			
	        var totalMember = api
	            .column(1, { page: 'current' })
	            .data()
	            .reduce(function (a, b) {
	                return parseInt(a) + parseInt(b);
	            }, 0);
	            
	            
	        var totalJoin = api
	            .column(2, { page: 'current' })
	            .data()
	            .reduce(function (a, b) {
	                return parseFloat(a) + parseFloat(b);
	            }, 0);

			var totalProduct = api
	            .column(3, { page: 'current' })
	            .data()
	            .reduce(function (a, b) {
	                return parseInt(a) + parseInt(b);
	            }, 0);
	            
			var totalOrder = api
	            .column(4, { page: 'current' })
	            .data()
	            .reduce(function (a, b) {
	                return parseInt(a) + parseInt(b);
	            }, 0);
	            
			var totalPay = api
	            .column(5, { page: 'current' })
	            .data()
	            .reduce(function (a, b) {
	                return parseInt(a) + parseInt(b);
	            }, 0);
	            
	        $(api.column(1).footer()).html(totalMember.toLocaleString(0));
	        $(api.column(2).footer()).html(totalJoin.toLocaleString(0));
	        $(api.column(3).footer()).html(totalProduct.toLocaleString(0));
	        $(api.column(4).footer()).html(totalOrder.toLocaleString(0));
	        $(api.column(5).footer()).html(totalPay.toLocaleString(0));
	        
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
//       picker.container.addClass('goodbuyCustomPicker');                            
    });
    
    //------------------------------------------------------------------------------------------------
	// 날짜 검색 초기화 버튼 클릭시 
	$("#initDateBtn").on('click', function() {
		const datePicker = $('#schDate').data('daterangepicker');
		
		if (datePicker) {
	        // daterangepicker 범위 업데이트
	        datePicker.setStartDate(firstDayOfMonth);
	        datePicker.setEndDate(lastDayOfMonth);
	        $('#schDate').val(defaultRange); // 입력 필드에 반영
	
	        // "이번 달" 버튼 강제로 클릭된 상태로 만들기
	        const ranges = datePicker.ranges; // ranges 확인
//		    console.log(ranges); //{오늘: Array(2), 이번 달: Array(2), 지난 달: Array(2), 지난 7일: Array(2), 지난 14일: Array(2), …}
	        for (let range in ranges) {
	            if (
	                ranges[range][0].isSame(firstDayOfMonth, 'day') &&
	                ranges[range][1].isSame(lastDayOfMonth, 'day')
	            ) {
	                // UI에서 "이번 달" 버튼 활성화
	                datePicker.container.find('.ranges li').removeClass('active'); // 기존 활성화 상태 제거
	                datePicker.container.find('.ranges li').filter(function () {
	                    return $(this).text() == range;
	                }).addClass('active'); // "이번 달"에 활성화 추가
	                break;
	            }
	        }
	    }
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