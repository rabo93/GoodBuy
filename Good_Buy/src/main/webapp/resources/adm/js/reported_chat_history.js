document.addEventListener("DOMContentLoaded", function(){
//	const reportedChatHistory = $('#reportedChatHistory').DataTable({
//		lengthChange : false, // 건수
//		searching : false, // 검색
//		info : true, // 정보
//		ordering : false, // 정렬
//		paging : true,
//		responsive: true, // 반응형
//		destroy: true,
//		scrollX: true, 
//		autoWidth: false,
//		ajax : {
//			url: "AdmReportedChatHistory",
//			type: "POST",
//			dataType : "JSON",
//			data: function(d) {
//                d.status = $('input[name="status"]:checked').val();
//                d.searchValue = $('input[name="keyword_search"]').val();
//                d.searchDate = $("#schDate").val();
//            },
//			dataSrc: function (res) {
//				const data = res.userReportList;
//				const start = $('#memberReport').DataTable().page.info().start; 
//				
//				for (let i = 0; i < data.length; i++) {
//					data[i].listIndex = start + i + 1;
//				}
//				return data;
//			},
//		},
//		columnDefs: [
//		],
//		columns: [
//            { 
//				title: "신고자ID", 
//	            data : "REPORTER_ID", 
//	            defaultContent: "",
//	            width: '130px',
//	            render: function (data, type, row) {
//					if (!data) {
//						return "";
//					}
//                	return data.replace(/(.{16})/g, '$1<br>'); // 16자마다 줄바꿈
//           		}
//            },
//        ],
//		serverSide : true, // 서버사이드 처리
//		processing : true,  // 서버와 통신 시 응답을 받기 전이라는 ui를 띄울 것인지 여부
//		language : {
//			emptyTable: "데이터가 없습니다.",
//			lengthMenu: "_MENU_ 건씩 보기",
//			info: "현재 _START_ - _END_ / 총 _TOTAL_건",
//			infoEmpty: "데이터 없음",
//			search: "검색",
//			infoFiltered: "( _MAX_건의 데이터에서 필터링됨 )",
//			loadingRecords: "로딩중...",
//			processing: "잠시만 기다려 주세요...",
//			zeroRecords: "일치하는 데이터가 없습니다.",
//            paginate: {
//                first:    '처음',
//                previous: '이전',
//                next:     '다음',
//                last:     '마지막'
//            },
//        },
//	});

});
