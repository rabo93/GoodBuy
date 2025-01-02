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
//				console.log("res: "+ JSON.stringify(res));
				const data = res.faqList; // faqList 배열만 가져오기
				console.log("data: "+ JSON.stringify(data));
				//data: [{"FAQ_SUBJECT":"test","FAQ_CONTENT":"test","FAQ_ID":1,"FAQ_CATE":1},{"FAQ_SUBJECT":"test_cate(2)","FAQ_CONTENT":"test_cate(2)","FAQ_ID":2,"FAQ_CATE":2},{"FAQ_SUBJECT":"test_cate(3)","FAQ_CONTENT":"test_cate(3)","FAQ_ID":3,"FAQ_CATE":3},{"FAQ_SUBJECT":"test_cate(4)","FAQ_CONTENT":"test_cate(4)","FAQ_ID":4,"FAQ_CATE":4}]
				
				// FAQ_ID(PK)가 아닌 테이블 컬럼 번호 계산
				for (let i = 0; i < data.length; i++) {
					data[i].listIndex = i + 1;
					data[i].LIST_STATUS = data[i].LIST_STATUS || 1; // 기본값 1로 설정
//					console.log(data[i]);
				}
				return data;
			},
		},
//		columnDefs: [ { targets: 0, orderable: false }
		columnDefs: [ 
      	],
		columns: [
			// defaultContent 는 기본값 설정, 데이터 없는 컬럼일 경우 오류나기 때문에 널스트링 처리 해주어야 함
			// 등록 시 유효성 체크를 한다면 defaultContent 값 설정 필요 없음!
            { title: "No.", data: "listIndex" },
            { title: "제목", data : "FAQ_SUBJECT", defaultContent: "",  orderable: false, searchable: true, },
            { title: "내용", data : "FAQ_CONTENT", defaultContent: "", orderable: false, searchable: true, },
            { 
				title: "FAQ 유형", 
				data : "FAQ_CATE", 
				defaultContent: "운영정책", 
				orderable: false,	// 정렬 비활성화
				searchable: false, // 검색 비활성화
				className : "dt-center", 
				render : function(data, type, row) {
//					if(!data) {
//						return "";
//					} 
//					switch(data) {
//						case 1: return "<span class='faq-cate1'>운영정책</span>";
//						case 2: return "<span class='faq-cate2'>회원/계정</span>";
//						case 3: return "<span class='faq-cate3'>결제/페이</span>";
//						case 4: return "<span class='faq-cate4'>기타</span>";
//					}
					const categories = {
						1: "운영정책",
						2: "회원/계정",
						3: "결제/페이",
						4: "광고서비스",
						5: "기타",
					};
					return `<span class='faq-cate'>${categories[data] || ""}</span>`
				},
             },
			{ 	
				title : "사용여부",
				data : "LIST_STATUS",
				orderable: false, // 정렬 비활성화
            	searchable: false, // 검색 비활성화
				render: function(data) {
//				render: function(data, type, row) {
					let isChecked = data == 1 ? "checked" : "";
					let isUsed = data == 1 ? "사용함" : "사용안함";
               	 return `
               	 	<div class="form-check form-switch">
		        		<input type="hidden" value="${data}" name="LIST_STATUS">
						<input class="form-check-input" type="checkbox" role="switch" ${isChecked} onClick="return false;">
						<label class="form-check-label">${isUsed}</label>
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
				render : function(data) {
					return `
						<button class="btn btn-primary edit-btn" data-toggle="modal" data-target="#updateFaq"
								data-faq-id="${data.FAQ_ID}"
								aria-label="수정 - FAQ ID: ${data.FAQ_ID}" aria-controls="updateFaq"
								>수정</button>
						<button class="btn btn-danger delete-btn"
						 		data-faq-id="${data.FAQ_ID}"
						 		aria-label="삭제 - FAQ ID: ${data.FAQ_ID}"
						 		>삭제</button>
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
	
	//Faq 수정 팝업 설정
	$('#updateFaq').on('shown.bs.modal', function () {
	  // 모달이 열리면 첫 번째 입력 필드에 포커스
	  $(this).find('input, button, textarea').first().focus();
	});
	$('#updateFaq').on('hidden.bs.modal', function () {
	  // 모달이 닫히면 이전에 포커스가 있었던 요소로 돌아가게 처리
	  $('#previousElement').focus();
	});
	
	faqList.on("click", '.edit-btn', function() {
		const row = $(this).closest('tr');
		const rowData = faqList.row(row).data();
//		console.log(rowData);
		let listStatus = rowData.LIST_STATUS == 1 ? true : false;
		let listStatusText = rowData.LIST_STATUS == 1 ? "사용함" : "사용안함";
//		console.log(listStatus);
		
		// 수정 전 기본 데이터 셋팅
		$("#faqId").val(rowData.FAQ_ID);
		
		$("#updatedFaqSubject").val(rowData.FAQ_SUBJECT);
		$("#updatedFaqContent").val(rowData.FAQ_CONTENT);
		$("#updatedFaqCate").val(rowData.FAQ_CATE);
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
	
	//-----------------------------------------------------
	// FAQ 삭제
	$(document).on("click", '.delete-btn', function() {
		if(confirm("해당 상세코드를 삭제하시겠습니까?")) {
			const faqId = this.dataset.faqId;
			console.log("삭제할 faqId: " + faqId);
			
			$.ajax({
				url : "AdmFaqDelete",
				type : "POST",
				data : { FAQ_ID : faqId },
				success: function(response){
					if(response.status == "success") {
						alert(response.message);
//						window.location.href = response.redirectURL;
						faqList.ajax.reload();
					} else {
						alert(response.message);
					}
				},
				error : function(res) {
					alert(res.message);
				}
			});
		}
	});
	
	
	
});

