document.addEventListener("DOMContentLoaded", function(){
	const memberReport = $('#memberReport').DataTable({
		lengthChange : true, // 건수
		searching : true, // 검색
		info : true, // 정보
		ordering : true, // 정렬
		paging : true,
		responsive: true, // 반응형
		destroy: true,
		scrollX: true, 
		autoWidth: false,
		ajax : {
			url: "AdmMemberReportList",
			type: "POST",
			dataType : "JSON",
			data: function(d) {
                d.status = $('input[name="status"]:checked').val();
                d.searchValue = $('input[name="keyword_search"]').val();
                d.searchDate = $("#schDate").val();
            },
			dataSrc: function (res) {
				const data = res.userReportList;
				const start = $('#memberReport').DataTable().page.info().start; 
				
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
		order: [[4, 'desc']], // 최초 조회 시 신고일시 최신순으로 기본 설정
		columnDefs: [
			 { targets: [0, 10], orderable: false },
		],
		columns: [
            { title: "No.", data: "listIndex", className : "dt-center", width: '30px', },
            { 
				title: "신고자ID", 
	            data : "REPORTER_ID", 
	            defaultContent: "",
	            width: '130px',
	            render: function (data, type, row) {
					if (!data) {
						return "";
					}
                	return data.replace(/(.{16})/g, '$1<br>'); // 16자마다 줄바꿈
           		}
            },
            { 
				title: "신고대상자ID", 
	            data : "REPORTED_ID", 
	            defaultContent: "",
	            width: '130px',
	            render: function (data, type, row) {
					if (!data) {
						return "";
					}
                	return data.replace(/(.{16})/g, '$1<br>'); // 16자마다 줄바꿈
           		}
            },
            { 
				title: "신고된채팅", 
	            data : "ROOM_ID", 
	            defaultContent: "",
	            orderable : false,
	            width: '150px',
	            className: 'dt-center',
	            render: function (data, type, row) {
					return `<button type="button" class="btn btn-primary" onclick="location.href='AdmReportedChatHistory?room_id=${data}'">내역보기</button>`;
           		}
            },
            { title: "신고일시", data : "REPORT_DATE", defaultContent: "", width: '180px',},
            { title: "신고사유", data : "REASON", defaultContent: "", },
            { 
				title: "처리상태", data : "STATUS", defaultContent: "", width: '100px', className : "dt-center",
				render : function(data, type, row) {
					if(!data) return "";
					switch (data) {
				        case "접수": return "<span class='status status-01'>접수</span>";
				        case "처리완료": return "<span class='status status-02'>처리완료</span>";
				        case "기각": return "<span class='status status-03'>기각</span>";
				        default: return "";
				    }
				}
            },
            { 
				title: "조치사유", data : "ACTION_REASON", defaultContent: "", 
            },
            { title: "조치자", data : "ADMIN_ID", defaultContent: "", width: '100px', },
            { title: "조치일시", data : "ACTION_DATE", defaultContent: "", width: '180px', },
            {
				title : "관리",
				data: null,
				searchable: false,
				className : "dt-center",
				width: '120px',
				render : function(data, type, row) {
					const text = row.STATUS !== "접수" ? "결과보기" : "조치하기";
					const className = row.STATUS !== "접수" ? "primary" : "warning";
					return `
						<button class="btn btn-${className} edit-btn" data-toggle="modal" data-target="#updateReportInfo"
						 data-report-id="${row.REPORT_ID}">${text}</button>
					`;
				}
			}
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
	
	// 신고 조치 팝업 셋팅
	memberReport.on("click", '.edit-btn', function() {
		const row = $(this).closest('tr');
		const rowData = memberReport.row(row).data();
		
		console.log(rowData);

		const status = rowData.STATUS;
		const actionReason = rowData.ACTION_REASON != null ? rowData.ACTION_REASON : "";
		const roomId = document.querySelector("#roomId");
		const reportId = document.querySelector("#reportId");
		const reporterId = document.querySelector("#reporterId");
		const reportedId = document.querySelector("#reportedId");
		const statusSelect = document.querySelector(`#reportStatus option[value="${status}"]`);
		const reasonTextarea = document.querySelector("#actionReason");
		const lengthInfo = document.querySelector("#lengthInfo");
		
		reportId.value = rowData.REPORT_ID;
		reporterId.value = rowData.REPORTER_ID;
		reportedId.value = rowData.REPORTED_ID;
		roomId.value = rowData.ROOM_ID;
		reasonTextarea.value = actionReason;
		lengthInfo.innerText = reasonTextarea.value.length;
	    if (statusSelect) statusSelect.selected = true;
	});
	
	// 기존 검색 숨기기
	$("#memberReport_filter").attr("hidden", "hidden");
	
	 // 필터 변경 시 데이터 테이블 다시 로드
    $('input[name="status"]').on('change', () => memberReport.draw());

    // 검색 버튼 클릭 시 테이블 다시 로드
    $('#searchBtn').on('click', () => memberReport.draw());
    
    // 엔터키 입력으로 검색
    $('#searchKeyword').on('keypress', (e) => {
        if (e.which == 13)  memberReport.draw();
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
			'오늘': [moment()], // 오늘
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
		memberReport.draw();
	});
	
    // 기간별 검색 후 테이블 다시 로드
    $("#searchDateBtn").on('click', function() {
		memberReport.draw();
	});
	
	// 조치 사유 작성
	$("#actionReason").on('keydown', () => {
		fnChkByte($("#actionReason"), 500);
	});
	

	// 글자수 제한 함수
	function fnChkByte(item, maxLength){
		const str = item.val();
        const strLength = str.length;
        
         if (strLength > maxLength) {
            alert("글자수는 " + maxLength + "자를 초과할 수 없습니다.");
            $(item).val(str.substr(0, maxLength));      //문자열 자르고 값 넣기
            fnChkByte(item, maxLength);
         }
         $('#lengthInfo').text(strLength);
    }
	
});
