document.addEventListener("DOMContentLoaded", function(){
	const supportList = $('#supportList').DataTable({
		lengthChange : true, // 건수
		searching : false, // 검색
		info : true, // 정보
		ordering : true, // 정렬
		paging : true,
		responsive: true, // 반응형
		destroy: true,
		scrollX: true, 
		autoWidth: false,
		ajax : {
			url: "AdmSupportList",
			type: "POST",
			dataType : "JSON",
			data: function(d) {
                d.status = $('input[name="status"]:checked').val(); //상태별
                d.searchDate = $("#schDate").val(); //기간별
                d.searchValue = $('input[name="keyword_search"]').val(); //키워드 검색
            },
			dataSrc: function (res) {
//				console.log("res: " + JSON.stringify(res));
				const data = res.EnquireList;
				const start = $('#supportList').DataTable().page.info().start; 
				
				console.log("data:" + JSON.stringify(data));
				console.log("data.SUPPORT_FILE:" + data.SUPPORT_FILE);
				// PK가 아닌 테이블 컬럼 번호 계산(페이징 포함)
				for (let i = 0; i < data.length; i++) {
					data[i].listIndex = start + i + 1;
				}
				return data;
			},
		},
		order: [[4, 'desc']], // 최초 조회 시 신고일시 최신순으로 기본 설정
		columnDefs: [
			 { targets: [0, 9], orderable: false },
		],
		columns: [
			// defaultContent 는 기본값 설정, 데이터 없는 컬럼일 경우 오류나기 때문에 널스트링 처리 해주어야 함
			// 회원가입 시 유효성 체크를 한다면 defaultContent 값 설정 필요 없음!
            { title: "No.", data: "listIndex", className : "dt-center", width: '30px', },
            { 
				title: "문의 유형", 
				data : "SUPPORT_CATEGORY", 
				defaultContent: "이용문의", 
				className : "dt-center", 
				render : function(data, type, row) {
					const categories = {
						1: "이용문의",
						2: "결제문의",
						3: "기타",
					};
					return `<span class='support-cate' status>${categories[data] || ""}</span>`
				},
             },
            { 
				title: "작성자ID", 
	            data : "MEM_ID",
	            defaultContent: "",
	            width: '120px',
	            render: function (data, type, row) {
					if (!data) {
						return "";
					}
                	return data.replace(/(.{16})/g, '$1<br>'); // 16자마다 줄바꿈
           		}
            },
            { title: "문의 제목", data : "SUPPORT_SUBJECT", defaultContent: "", orderable: false},
            { title: "문의 내용", data : "SUPPORT_CONTENT", defaultContent: "", orderable: false},
            { title: "작성일시", data : "SUPPORT_DATE", defaultContent: "", width: '180px',},
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
//            { title: "답변자", data : "ADMIN_ID", defaultContent: "", width: '100px', },
            { title: "답변내용", data : "REPLY_CONTENT", defaultContent: "", orderable: false},
            { title: "답변일시", data : "REPLY_DATE", defaultContent: "", width: '180px', },
            {
				title : "관리",
				data: null,
				searchable: false,
				className : "dt-center",
				width: '120px',
				render : function(data, type, row) {
					const text = row.STATUS !== "접수" ? "수정" : "답변달기";
					const className = row.STATUS !== "접수" ? "primary" : "warning";
					return `
						<button class="btn btn-${className} edit-btn" data-toggle="modal" data-target="#updateSupportInfo"
						 data-support-id="${row.SUPPORT_ID}">${text}</button>
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
	
	// 답글달기 팝업 셋팅
	supportList.on("click", '.edit-btn', function() {
		const row = $(this).closest('tr');
		const rowData = supportList.row(row).data();
	
		// 문의내역에 문의내용 보이기
		const supportContent = rowData.SUPPORT_CONTENT
		const enquireContent = document.querySelector("#enquireContent");
        enquireContent.value = supportContent || "";
		
		const status = rowData.STATUS;
		const replyContent = rowData.REPLY_CONTENT != null ? rowData.REPLY_CONTENT : "";
		
		// 첨부파일 보이기
		const supportFileName = rowData.SUPPORT_FILE;
		const supportFileDiv = document.querySelector("#supportFile");
		
		if (supportFileName) {
	        // 파일이 있는 경우 다운로드 링크 생성
		    const originalFileName = supportFileName.split('/').pop(); // 파일명 추출
		    const filePath = `${contextPath}/resources/upload/${supportFileName}`; // 전체 경로
		    supportFileDiv.innerHTML = `
		    	<a href="${filePath}" target="_blank" download="${originalFileName}">
		    		${originalFileName}
		    	</a>
		    `;
		} else {
	        // 첨부파일이 없을 경우 메시지 표시
	        supportFileDiv.innerHTML = "첨부된 파일 없음";
	    }
		
		
		// DB에 저장할 id속성 가져오기
		const supportId = document.querySelector("#supportId"); //게시글id
//		const memId = document.querySelector("#memId"); 		//작성자id
//		const adminId = document.querySelector("#adminId");		//관리자id
		const statusSelect = document.querySelector(`#supportStatus option[value="${status}"]`);
		const reasonTextarea = document.querySelector("#replyContent");
		
		// DB에 저장할 값 저장
		supportId.value = rowData.SUPPORT_ID;
	    if (statusSelect) statusSelect.selected = true;
		reasonTextarea.value = replyContent;
		
		// 글자 수 표시
		const contentLength = replyContent.length;
   		$("#lengthInfo").text(contentLength); 
		
	});
	
	// 기존 검색 숨기기
	$("#supportList_filter").attr("hidden", "hidden");
	
	 // 필터 변경 시 데이터 테이블 다시 로드
    $('input[name="status"]').on('change', () => supportList.draw());

    // 검색 버튼 클릭 시 테이블 다시 로드
    $('#searchBtn').on('click', () => supportList.draw());
    
    // 엔터키 입력으로 검색
    $('#searchKeyword').on('keypress', (e) => {
        if (e.which == 13)  supportList.draw();
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
		supportList.draw();
	});
	
    // 기간별 검색 후 테이블 다시 로드
    $("#searchDateBtn").on('click', function() {
		supportList.draw();
	});
	
	// 답글 작성
	$("#replyContent").on('keyup', () => {
		fnChkByte($("#replyContent"), 500);
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
