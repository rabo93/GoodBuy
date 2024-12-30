// Call the dataTables jQuery plugin
$(document).ready(function() {
	const modifyForm = document.querySelector("#modifyForm");
	const codeList = $('#codeList').DataTable({
		lengthChange : true, // 건수
		searching : true, // 검색
		info : true, // 정보
		ordering : true, // 정렬
		paging : true,
		responsive: true, // 반응형
		destroy: true,
		ajax : {
			url: "AdmCommoncodeListForm",
			type: "POST",
			dataType : "JSON",
			dataSrc: function (res) {
				return res.commonCodes;
			},
		},
		columnDefs: [
		],
		columns: [
            { data : "CODETYPE_ID", orderable: false, },
            { data : "CODETYPE_NAME", orderable: false, },
            { data : "MAIN_DESC", orderable: false, },
            { data : "CODE_ID", orderable: false, },
            { data : "CODE_NAME", orderable: false, },
            { data : "SUB_DESC", orderable: false, },
            { 
				data : "CODE_STATUS",
				orderable: false, // 정렬 비활성화
            	searchable: false, // 검색 비활성화
				render: function(data, type, row) {
					let isChecked = data == 1 ? "checked" : "";
					let isUsed = data == 1 ? "사용함" : "사용안함";
               	 return `
               	 	<div class="form-check form-switch">
		        		<input type="hidden" value="${data}" name="CODE_STATUS">
						<input class="form-check-input" type="checkbox" role="switch" id="flexSwitchCheckDefault" ${isChecked} onClick="return false;">
						<label class="form-check-label" for="flexSwitchCheckDefault">${isUsed}</label>
					</div>
               	 `;
            	},
            },
            { data : "CODE_SEQ", orderable: false, className: 'dt-center', type: "string", width: '5%', },
            { 
				data : null,
				orderable: false, // 정렬 비활성화
            	searchable: false, // 검색 비활성화
            	className : "dt-center", 
            	width: '13%',
            	render : function(data, type, row) {
					return `
						<button class="btn btn-primary edit-btn"
						 		data-toggle="modal" data-target="#updateCommonCodes"
						 		data-codetype-id="${data.CODETYPE_ID}"
						 		data-code-id="${data.CODE_ID}">수정</button>
						<button class="btn btn-primary delete-btn"
								data-codetype-id="${data.CODETYPE_ID}"
						 		data-code-id="${data.CODE_ID}">삭제</button>
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

	// 공통코드 테이블 컬럼 수정 팝업 셋팅
	codeList.on("click", '.edit-btn', function() {
		const row = $(this).closest('tr');
		const rowData = codeList.row(row).data();
		let codeStatus = rowData.CODE_STATUS == 1 ? true : false;
		let codeStatusText = rowData.CODE_STATUS == 1 ? "사용함" : "사용안함";
//		console.log(rowData);
		console.log(codeStatus);
		
		// 수정 전 기본 데이터 셋팅
		$("#oldCodetypeId").val(rowData.CODETYPE_ID);
		$("#oldCodeId").val(rowData.CODE_ID);
		
		$("#updatedCommonCodeId").val(rowData.CODETYPE_ID);
		$("#updatedCommonCodeName").val(rowData.CODETYPE_NAME);
		$("#updatedCommonCodeDesc").val(rowData.MAIN_DESC);
		$("#updatedCodeId").val(rowData.CODE_ID);
		$("#updatedCodeName").val(rowData.CODE_NAME);
		$("#updatedCodeDesc").val(rowData.SUB_DESC);
		$("#updatedCodeStatus").val(rowData.CODE_STATUS);
		$("#updateFlexSwitchCheckDefault").prop("checked", codeStatus);
		$("#updateFlexSwitchCheckDefaultLab").text(codeStatusText);
		$("#updatedCodeSeq").val(rowData.CODE_SEQ);
	});
	
	// 사용여부 버튼 값 업데이트
	$(document).on("change", ".form-check-input", function() {
	    const switchBtn = this;
	    const hiddenInput = switchBtn.parentElement.querySelector('input[type="hidden"][name="CODE_STATUS"]');
	    const switchLabel = switchBtn.nextElementSibling;
	
	    if (hiddenInput) {
	        hiddenInput.value = switchBtn.checked ? 1 : 2;
		    switchLabel.innerText =  switchBtn.checked ? "사용함" : "사용안함";
	    } else {
	        console.warn("사용여부 버튼이 존재하지 않습니다.");
	    }
	});
	
	// 선택한 컬럼 삭제
	$(document).on("click", '.delete-btn', function() {
		if(confirm("해당 상세코드를 삭제하시겠습니까?")) {
			const codetypeId = this.dataset.codetypeId;
			const codeId = this.dataset.codeId;
			
			console.log(codetypeId);
			console.log(codeId);
			
			$.ajax({
				url : "AdmDeleteCommonCode",
				type : "POST",
				data : {
					"CODETYPE_ID" : codetypeId,
					"CODE_ID" : codeId
				},
				success: function(res){
					console.log(res);
					alert(res);
				},
				error : function(res) {
					alert(res);
				}
			});
		}
	});
	
});
