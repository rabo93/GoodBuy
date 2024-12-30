// Call the dataTables jQuery plugin
document.addEventListener("DOMContentLoaded", function(){
	const modifyForm = document.querySelector("#modifyForm");
	const faqList = $('#faqList').DataTable({
		lengthChange : true, // 건수
		searching : true, // 검색
		info : true, // 정보
		ordering : true, // 정렬
		paging : true,
		responsive: true, // 반응형
		destroy: true,
		scrollX: true, 
		ajax : {
			url: "FaqListForm",
			type: "POST",
			dataType : "JSON",
			dataSrc: function (res) {
				const data = res;
				// FAQ_ID(PK)가 아닌 테이블 컬럼 번호 계산
				for (let i = 0; i < data.length; i++) {
					data[i].listIndex = i + 1;
//					console.log(data[i]);
				}
				return res;
			},
		},
		columnDefs: [
      	],
		columns: [
			// defaultContent 는 기본값 설정, 데이터 없는 컬럼일 경우 오류나기 때문에 널스트링 처리 해주어야 함
			// 등록 시 유효성 체크를 한다면 defaultContent 값 설정 필요 없음!
            { title: "No.", data: "listIndex" },
            { title: "제목", data : "FAQ_SUBJECT", defaultContent: "",  orderable: false },
            { title: "내용", data : "FAQ_CONTENT", defaultContent: "", orderable: false, },
            { 
				title: "FAQ카테고리", 
				data : "FAQ_CATE", 
				defaultContent: "운영정책", 
				orderable: false,
				className : "dt-center", 
				render : function(data, type, row) {
					if(!data) {
						return "";
					} else if(data == "운영정책"){
						return "<span class='faq-cate1'>운영정책</span>"
					} else if(data == "회원/계정"){
						return "<span class='faq-cate2'>회원/계정</span>"
					} else if(data == "전용페이"){
						return "<span class='faq-cate3'>전용페이</span>"
					} else if(data == "기타"){
						return "<span class='faq-cate4'>기타</span>"
					}
				}
             },
            {
				title : "관리",
				data: null,
				orderable : false,
				searchable: false,
				className : "dt-center",
				render : function(data, type, row) {
//					console.log(data.mem_id);
					return `
						<button class="btn btn-primary edit-btn" onclick="location.href='AdmMemberModify?mem_id=${data.mem_id}'">수정</button>
						<button class="btn btn-primary delete-btn" data-mem-id="${data.mem_id}">삭제</button>
					`;
				}
			}
        ],
		serverSide : true, // 서버사이드 처리
		processing : true,  // 서버와 통신 시 응답을 받기 전이라는 ui를 띄울 것인지 여부
		language : {
			emptyTable: "데이터가 없습니다.",
			lengthMenu: "_MENU_",
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

});

