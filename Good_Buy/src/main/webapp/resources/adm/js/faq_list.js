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
				const data = res.faqList; // faqList 배열만 가져오기
				console.log("data: " + data);
				console.log("FAQ_ID: " + data.FAQ_ID);
				
				// FAQ_ID(PK)가 아닌 테이블 컬럼 번호 계산
				for (let i = 0; i < data.length; i++) {
					data[i].listIndex = i + 1;
//					console.log(data[i]);
				}
				return data;
			},
		},
		columnDefs: [ { targets: 0, orderable: false }
//		columnDefs: [ 
      	],
		columns: [
			// defaultContent 는 기본값 설정, 데이터 없는 컬럼일 경우 오류나기 때문에 널스트링 처리 해주어야 함
			// 등록 시 유효성 체크를 한다면 defaultContent 값 설정 필요 없음!
            { title: "No.", data: "listIndex" },
            { title: "제목", data : "FAQ_SUBJECT", defaultContent: "",  orderable: false, searchable: true, },
            { title: "내용", data : "FAQ_CONTENT", defaultContent: "", orderable: false, searchable: true, },
            { 
				title: "FAQ카테고리", 
				data : "FAQ_CATE", 
				defaultContent: "운영정책", 
				orderable: false,	// 정렬 비활성화
				searchable: false, // 검색 비활성화
				className : "dt-center", 
				render : function(data, type, row) {
					
					if(!data) {
						return "";
					} 
					switch(data) {
						case 1: return "<span class='faq-cate1'>운영정책</span>";
						case 2: return "<span class='faq-cate2'>회원/계정</span>";
						case 3: return "<span class='faq-cate2'>회원/계정</span>";
						case 4: return "<span class='faq-cate4'>기타</span>";
					}
					
				}
             },
			{ 	
				title : "사용여부",
				data : "LIST_STATUS",
				orderable: false, // 정렬 비활성화
            	searchable: false, // 검색 비활성화
				render: function(data, type, row) {
					let isChecked = data == 1 ? "checked" : "";
					let isUsed = data == 1 ? "사용함" : "사용안함";
	           	return `
	           		<div class="form-check form-switch">
		        		<input type="hidden" value="${data}" name="LIST_STATUS">
						<input class="form-check-input" type="checkbox" role="switch" id="flexSwitchCheckDefault" ${isChecked} onClick="return false;">
						<label class="form-check-label" for="flexSwitchCheckDefault">${isUsed}</label>
					</div>
	           	 `;
            	},
            },
            {
				title : "관리",
				data: null,
				orderable : false,
				searchable: false,
				className : "dt-center",
				render : function(data, type, row) {
					return `
						<button class="btn btn-primary edit-btn" onclick="location.href='AdmFaqModify?faq_id=${data.FAQ_ID}'">수정</button>
						<button class="btn btn-primary delete-btn" data-faq-id="${data.FAQ_ID}">삭제</button>
					`;
				}
			},
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
	
	// FAQ 테이블 컬럼 수정 팝업 셋팅
	faqList.on("click", '.edit-btn', function() {
		const row = $(this).closest('tr');
		const rowData = codeList.row(row).data();
		let listStatus = rowData.LIST_STATUS == 1 ? true : false;
		let listStatusText = rowData.LIST_STATUS == 1 ? "사용함" : "사용안함";
//		console.log(rowData);
		console.log(listStatus);
		
		// 수정 전 기본 데이터 셋팅
		$("#oldFaqId").val(rowData.OLD_FAQ_ID);
		
		$("#updatedFaqSubject").val(rowData.FAQ_SUBJECT);
		$("#updatedFaqContent").val(rowData.FAQ_CONTENT);
		$("#updatedListStatus").val(rowData.LIST_STATUS);
		$("#updateFlexSwitchCheckDefault").prop("checked", listStatus);
		$("#updateFlexSwitchCheckDefaultLab").text(listStatusText);
	});
	
	
	
	// 사용여부 버튼 값 업데이트
	$(document).on("change", ".form-check-input", function() {
	    const switchBtn = this;
	    const hiddenInput = switchBtn.parentElement.querySelector('input[type="hidden"][name="LIST_STATUS"]');
	    const switchLabel = switchBtn.nextElementSibling;
	
	    if (hiddenInput) {
	        hiddenInput.value = switchBtn.checked ? 1 : 2;
		    switchLabel.innerText =  switchBtn.checked ? "사용함" : "사용안함";
	    } else {
	        console.warn("사용여부 버튼이 존재하지 않습니다.");
	    }
	});
	

});

