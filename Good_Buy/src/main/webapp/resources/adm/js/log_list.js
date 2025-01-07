document.addEventListener("DOMContentLoaded", function(){
	const logList = $('#logList').DataTable({
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
			url: "AdmLogList",
			type: "POST",
			dataType : "JSON",
			data: function(d) {
                d.search_keyword = $('input[name="keyword_search"]').val();
            },
			dataSrc: function (res) {
				const data = res.logList;
				const start = $('#logList').DataTable().page.info().start; 
				
				// 회원번호(PK)가 아닌 테이블 컬럼 번호 계산(페이징 포함)
				for (let i = 0; i < data.length; i++) {
					data[i].listIndex = start + i + 1;
				}
				return data;
			},
		},
		order: [[3, 'desc']], // 최초 조회 시 작업일시 최신순으로 기본 설정
		columnDefs: [
		],
		columns: [
			// defaultContent 는 기본값 설정, 데이터 없는 컬럼일 경우 오류나기 때문에 널스트링 처리 해주어야 함
			// 회원가입 시 유효성 체크를 한다면 defaultContent 값 설정 필요 없음!
            { title: "No.", data: "listIndex", className : "dt-center", width: '50px', },
            { title: "관리자ID", data : "ADMIN_ID",className : 'dt-center', defaultContent: "", width: '200px',},
            { title: "작업사항", data : "PROCESS_DETAIL",className : 'dt-center', defaultContent: "", },
            { title: "작업일시", data : "PROCESS_TIME",className : 'dt-center', defaultContent: "", width: '250px',},
            { 
				title: "작업결과", 
	            data : "PROCESS_RESULT", 
	            defaultContent: "", 
	            width: '250px', 
	            className : 'dt-center',
            	render : function(data, type, row) {
					if(!data) return "";
					
					switch (data) {
			            case "success": return "<span class='status status-01'>Success</span>";
			            case "fail": return "<span class='status status-02'>Fail</span>";
			            default: return "";
			        }
				}
            },
            { title: "IP주소", data : "IP_ADDRESS", className : 'dt-center', defaultContent: "", width: '250px', },
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
	$("#logList_filter").attr("hidden", "hidden");

    // 검색 버튼 클릭 시 테이블 다시 로드
    $('#searchBtn').on('click', function() {
        logList.draw();
    });

    // 엔터키 입력으로 검색
    $('#searchKeyword').on('keypress', function(e) {
        if (e.which == 13) {
            logList.draw();
        }
    });
    
});