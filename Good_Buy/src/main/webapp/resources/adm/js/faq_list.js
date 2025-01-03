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
		autoWidth: false,
		ajax : {
			url: "FaqListForm",
			type: "POST",
			dataType : "JSON",
			data: function(d) {
                d.faq_cate = $('input[name="faq_cate"]:checked').val(); // faq유형별
                console.log("d.faq_cate : " + d.faq_cate);
				d.list_status = $('input[name="list_status"]:checked').val(); // 사용여부별
                console.log("d.list_status : " + d.list_status);
                d.searchValue = $('input[name="keyword_search"]').val(); // 검색
            },
			dataSrc: function (res) {
				const data = res.faqList; // faqList 배열만 가져오기
//				console.log("data: "+ JSON.stringify(data));
				const start = $('#faqList').DataTable().page.info().start; 
				
				// FAQ_ID(PK)가 아닌 테이블 컬럼 번호 계산
				for (let i = 0; i < data.length; i++) {
					data[i].listIndex = i + 1;
					data[i].list_status = data[i].list_status || 1; // 기본값 1로 설정
//					console.log(data[i]);
				}
				return data;
			},
		},
		order: [[4, 'asc']], // 최초 조회시 카테고리(4번째 컬럼)별로 조회
		columnDefs: [ { targets: 0, orderable: false }
//		columnDefs: [ { targets: [0, 1, 6], orderable: false },
//		columnDefs: [ 
      	],
		columns: [
			{
				data: null, 
				className : "dt-center", 
				width: '60px',
				render : function(data, type, row, meta) {
					const rowCount = meta.row + 1; // 현재 페이지에서의 row 번호를 사용
					const checkboxId = "customCheck" + rowCount;
					const checkboxName = "faq_id_" + data.FAQ_ID; // 고유한 name 값 설정
					return `
						<div class="custom-control custom-checkbox small">
							<input type="hidden" name="faq_id" value="${data.FAQ_ID}">
							<input type="checkbox" class="custom-control-input" id="${checkboxId}" name="${checkboxName}">
							<label class="custom-control-label" for="${checkboxId}"></label>
						</div>
					`;
				}
			},
			// defaultContent 는 기본값 설정, 데이터 없는 컬럼일 경우 오류나기 때문에 널스트링 처리 해주어야 함
			// 등록 시 유효성 체크를 한다면 defaultContent 값 설정 필요 없음!
            { title: "No.", data: "listIndex" , className : "dt-center",  width: '60px', orderable: false},
            { title: "제목", data : "FAQ_SUBJECT", className : "dt-center", defaultContent: "", orderable: false, searchable: true, },
            { title: "내용", data : "FAQ_CONTENT", className : "dt-center", defaultContent: "", orderable: false, searchable: true, },
            { 
				title: "FAQ 유형", 
				data : "FAQ_CATE", 
				defaultContent: "운영정책", 
//				orderable: false,	// 정렬 비활성화
				searchable: false, // 검색 비활성화
				className : "dt-center", 
				render : function(data, type, row) {
					const categories = {
						1: "운영정책",
						2: "회원/계정",
						3: "결제/페이",
						4: "광고서비스",
						5: "기타",
					};
					return `<span class='faq-cate' status>${categories[data] || ""}</span>`
				},
             },
			{ 	
				title : "사용여부",
				data : "LIST_STATUS",
				orderable: false, // 정렬 비활성화
            	searchable: false, // 검색 비활성화
            	className : "dt-center", 
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
				width: '160px',
				render : function(data, type, row) {
					return `
						<button class="btn btn-primary edit-btn" data-toggle="modal" data-target="#updateFaq"
								data-faq-id="${data.FAQ_ID}"
								aria-label="수정 - faq id: ${data.FAQ_ID}" aria-controls="updateFaq">
								수정</button>
					`;
					
				}
			}
        ],
		serverSide : true, // 서버사이드 처리
		processing : true,  // 서버와 통신 시 응답을 받기 전이라는 ui를 띄울 것인지 여부
		language : {
			emptyTable: "데이터가 없습니다.",
			lengthMenu: "_MENU_건씩 보기",
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
	
	//-----------------------------------------------------
	// 기존 검색 숨기기
	$("#faqList_filter").attr("hidden", "hidden");
	
	 // 필터 변경 시 데이터 테이블 다시 로드
    $('input[name="faq_cate"], input[name="list_status"]').on('change', function() {
        faqList.draw();
    });
	
	// 검색 버튼 클릭 시 테이블 다시 로드
    $('#searchBtn').on('click', function() {
        faqList.draw();
    });
    
	// 엔터키 입력으로 검색
    $('#searchKeyword').on('keypress', function(e) {
        if (e.which == 13) {
            faqList.draw();
        }
    });
    
	//-----------------------------------------------------
	// 체크박스 전체 선택
	const checkAll = $("#checkAll");
	checkAll.on("change", function() {
		const isChecked = checkAll.is(":checked"); // 전체 체크박스 상태 확인
		faqList.rows().every(function (index) {
	       const row = this.node(); // 현재 행
	       const checkBox = $(row).find(".custom-control-input"); // 체크박스를 jQuery로 선택
	       checkBox.prop("checked", isChecked); // 체크 상태 업데이트
	    });
	});
	// 개별 체크박스를 클릭할 때 전체 선택 체크박스 상태 업데이트
	$('#faqList').on('change', 'input[type="checkbox"].custom-control-input', function() {
	    // 전체 체크박스 상태를 체크하려면 모든 체크박스의 상태 확인
	    const allChecked = faqList.rows().nodes().to$().find('input[type="checkbox"].custom-control-input').length;
	    const checkedCount = faqList.rows().nodes().to$().find('input[type="checkbox"].custom-control-input:checked').length;
	
	    // 하나라도 체크박스가 해제되면 전체 선택 체크박스 해제
	    checkAll.prop('checked', allChecked === checkedCount); 
	});
	
	
	//-----------------------------------------------------
	//Faq 수정 팝업 설정
	$('#updateFaq').on('shown.bs.modal', function () {
		// 모달이 열리면 첫 번째 입력 필드에 포커스
		$(this).find('input, button, textarea').first().focus();
	});
	
	$('#updateFaq').on('hidden.bs.modal', function () {
		// 모달이 닫히면 이전에 포커스가 있었던 요소로 돌아가게 처리
		$('#previousElement').focus();
	});
	
	// FAQ 수정 셋팅
	faqList.on("click", '.edit-btn', function() {
		const row = $(this).closest('tr');
		const rowData = faqList.row(row).data();
//		console.log("rowData: ", JSON.stringify(rowData, null, 2));
//		rowData:  {
//		  "FAQ_SUBJECT": "중고거래 시 안전한 거래 방법은 무엇인가요?",
//		  "FAQ_CONTENT": "안전한 거래를 위해 사이트 내 결제 시스템을 사용하시길 권장합니다. 또한, 만나서 거래 시 공공장소에서 진행하고, 큰 금액은 계좌 이체보다는 안전결제를 이용하세요.",
//		  "FAQ_ID": 1,
//		  "FAQ_CATE": 1,
//		  "LIST_STATUS": "1",
//		  "listIndex": 1,
//		  "list_status": 1
//		}
		
		const faqCate = rowData.FAQ_CATE;
		console.log("faqCate: " + faqCate); //1
		const listStatus = rowData.LIST_STATUS == 1 ? true : false;
		console.log("listStatus: " + listStatus); //true
		const listStatusText = rowData.list_status == 1 ? "사용함" : "사용안함";
		
//		const faqCateSelect = document.querySelector('input[name="faq_cate"]:checked');
////		const faqCateSelect = document.querySelector(`#faqCate option[value="${faqCate}"]`);;
//		console.log("faqCateSelect: " + faqCateSelect); //null
//		
//		const listStatusSelect = document.querySelector('input[name="list_status"]:checked');
////		const listStatusSelect = document.querySelector(`#listStatus option[value="${listStatus}"]`);;
//		console.log("listStatusSelect: " + listStatusSelect); //null
//		
//		// 선택 상태 설정
//	    if (faqCateSelect) faqCateSelect.selected = true;
//	    if (listStatusSelect) listStatusSelect.selected = true;
		
		// 수정 모달 화면에 기존 데이터 보이게 셋팅
		$("#faqId").val(rowData.FAQ_ID); //히든속성값
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
	    const hiddenInput = switchBtn.parentElement.querySelector('input[type="hidden"][name="list_status"]');
	    const switchLabel = switchBtn.nextElementSibling;
	
	    if (hiddenInput) {
	        hiddenInput.value = switchBtn.checked ? 1 : 2;
		    switchLabel.innerText =  switchBtn.checked ? "사용함" : "사용안함";
	    } else {
	        console.warn("사용여부 버튼이 존재하지 않습니다.");
	    }
	});
	
	//-----------------------------------------------------
	// FAQ 선택 삭제
	$(document).on("click", '#btnDeleteRow', function() {
		if(confirm("선택한 게시글을 삭제하시겠습니까?\n삭제 후 복구가 불가능합니다.")) {
			const deleteItems = [];
			faqList.rows().every(function (index) {
				const row = this.node();
				const checkBox = row.querySelector(".custom-control-input");
				const checkedId = row.querySelector("input[name='faq_id']");
				if(checkBox.checked){
					 deleteItems.push(checkedId.value);
				}
			});	
			console.log(deleteItems);
			
			$.ajax({
				url : "AdmFaqDelete",
				type : "POST",
				contentType : 'application/json',
				data: JSON.stringify(deleteItems),
				
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
					alert("삭제할 컬럼을 선택 후 삭제해주세요.");
				}
			});
		}
	});
	
});

