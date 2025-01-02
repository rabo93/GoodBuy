// Call the dataTables jQuery plugin
document.addEventListener("DOMContentLoaded", function(){
//	const modifyForm = document.querySelector("#modifyForm");
	const productReport = $('#productReport').DataTable({
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
			url: "AdmProductReportList",
			type: "POST",
			dataType : "JSON",
			data: function(d) {
                d.status = $('input[name="status"]:checked').val();
                d.searchValue = $('input[name="keyword_search"]').val();
            },
			dataSrc: function (res) {
				const data = res.productReportList;
				const start = $('#productReport').DataTable().page.info().start; 
				
				// 회원번호(PK)가 아닌 테이블 컬럼 번호 계산(페이징 포함)
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
				title: "신고자ID", 
	            data : "REPORTER_ID", 
	            defaultContent: "",
	            width: '120px',
	            render: function (data, type, row) {
					if (!data) {
						return "";
					}
                	return data.replace(/(.{16})/g, '$1<br>'); // 16자마다 줄바꿈
           		}
            },
            { title: "상품ID", data : "PRODUCT_ID", defaultContent: "", width: '100px',},
            { title: "상품명", data : "PRODUCT_TITLE", defaultContent: "", },
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
            { title: "조치사유", data : "ACTION_REASON", defaultContent: "", },
            { title: "조치자", data : "ADMIN_ID", defaultContent: "", width: '100px', },
            { title: "조치일시", data : "ACTION_DATE", defaultContent: "", width: '180px', },
            {
				title : "관리",
				data: null,
				searchable: false,
				className : "dt-center",
				width: '160px',
				render : function(data, type, row) {
					return `
						<button class="btn btn-primary edit-btn" data-toggle="modal" data-target="#updateMemberInfo" data-mem-id=${data.mem_id}'">조치</button>
						<button class="btn btn-success edit-btn" onclick="location.href='AdmMemberDetailForm?mem_id=${data.mem_id}'">상세</button>
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
	
	// 기존 검색 숨기기
	$("#productReportList_filter").attr("hidden", "hidden");
	
	 // 필터 변경 시 데이터 테이블 다시 로드
    $('input[name="status"]').on('change', function() {
        productReport.draw();
    });

    // 검색 버튼 클릭 시 테이블 다시 로드
    $('#searchBtn').on('click', function() {
        productReport.draw();
    });

    // 엔터키 입력으로 검색
    $('#searchKeyword').on('keypress', function(e) {
        if (e.which == 13) {
            productReport.draw();
        }
    });
    
	// 선택한 컬럼 삭제
//	$(document).on("click", '.delete-btn', function() {
//		if(confirm("해당 회원을 삭제하시겠습니까?\n삭제 후 복구가 불가능합니다.")) {
//			const memId = this.dataset.memId;
//			console.log("삭제할 회원 아이디 : " + memId);
//			
//			$.ajax({
//				url : "AdmMemberDelete",
//				type : "POST",
//				data : {
//					"mem_id" : memId,
//				},
//				success: function(response){
//					alert(response.message);
//					if(response.status == 'success') {
//						window.location.href = response.redirectURL;
//					}
//				},
//				error : function(res) {
//					alert(res.message);
//				}
//			});
//		}
//	});
	
});

// 휴대폰 형식 가공 => DB에서 처리함..
//function formatPhone(phone) {
//    return phone.replace(/(\d{3})(\d{4})(\d{4})/, '$1-$2-$3');
//}
