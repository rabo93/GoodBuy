$(document).ready(function() {
	// 중복코드 여부 
	let codeIdCheck = false;
	// 체크박스
	const checkAll = $("#checkAll");
	
	// 수정 모달
	const modifyForm = document.querySelector("#modifyForm");
	
	// 테이블
	const codeList = $('#codeList').DataTable({
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
			url: "AdmCommoncodeListForm",
			type: "POST",
			dataType : "JSON",
			data: function(d) {
                d.searchValue = $('input[name="keyword_search"]').val();
            },
			dataSrc: function (res) {
				const data = res.commonCodes;
				const start = $('#codeList').DataTable().page.info().start; 
				
				// 고유번호(PK)가 아닌 단순 테이블 컬럼 번호 계산(페이징 포함)
				for (let i = 0; i < data.length; i++) {
					data[i].listIndex = start + i + 1;
				}
				return data;
			},
		},
		order: [[2, 'desc']],
		columnDefs: [
			{ targets: [0, 1, 3, 4, 6, 7, 8, 9, 10], orderable: false},
			{ targets: [0, 1, 8, 9, 10], searchable: false},
		],
		columns: [
			{
				data: null,searchable: false, className : "dt-center", width: '60px',
				render : function(data, type, row) {
					const rowCount = codeList.rows().count() + 1;
					return `
						<div class="custom-control custom-checkbox small">
							<input type="hidden" name="codetype_id" value="${data.CODETYPE_ID}">
							<input type="hidden" name="code_id" value="${data.CODE_ID}">
			               	<input type="checkbox" class="custom-control-input" id="customCheck${rowCount}">
			                <label class="custom-control-label" for="customCheck${rowCount}"></label>
						</div>
					`;
				}
			},
			{ data: "listIndex", className : "dt-center", width: '60px', },
            { data : "CODETYPE_ID", },
            { data : "CODETYPE_NAME" },
            { data : "MAIN_DESC", },
            { data : "CODE_ID", },
            { data : "CODE_NAME", },
            { data : "SUB_DESC", },
            { 
				data : "CODE_STATUS",
				width: "160px",
				render: function(data, type, row) {
					let isChecked = data == 1 ? "checked" : "";
					let isUsed = data == 1 ? "사용함" : "사용안함";
               	 return `
               	 	<div class="form-check form-switch">
		        		<input type="hidden" value="${data}" name="CODE_STATUS">
						<input class="form-check-input" type="checkbox" role="switch" id="flexSwitchCheckDefault" data-codetype-id="${row.CODETYPE_ID}" data-code-id="${row.CODE_ID}" ${isChecked}>
						<label class="form-check-label" for="flexSwitchCheckDefault">${isUsed}</label>
					</div>
               	 `;
            	},
            },
            { data : "CODE_SEQ", className: 'dt-center', type: "string", width: '5%', },
            { 
				data : null,
            	className : "dt-center", 
            	width: '13%',
            	render : function(data, type, row) {
					return `
						<button class="btn btn-primary edit-btn" data-toggle="modal" data-target="#updateCommonCodes"
								data-codetype-id="${data.CODETYPE_ID}"
								data-code-id="${data.CODE_ID}">수정</button>
						<button class="btn btn-danger delete-btn"
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

	// 기존 검색 숨기기
	$("#codeList_filter").attr("hidden", "hidden");
	
	// 검색 버튼 클릭 시 테이블 다시 로드
    $('#searchBtn').on('click', function() {
        codeList.draw();
    });

    // 엔터키 입력으로 검색
    $('#searchKeyword').on('keypress', function(e) {
        if (e.which == 13) {
            codeList.draw();
        }
    });
    
    // 등록 버튼 이동
	$("#btnAddRow").on("click", function() {
		
		// 공통 상위코드 불러오기
		$.ajax({
			url : "GetCommonCodes",
			type : "POST",
			success: function(res){
				console.log(res);
				
				const $mainCodeList = $("#mainCodeList");
				$mainCodeList.empty();
				
				if(!res || !res.length || !res[0]) {
					$("#addCommonCodes").modal('hide');
					alert("등록된 공통코드가 없습니다. 공통코드를 먼저 등록해주세요.");
					window.location.href='AdmCommoncodeRegistForm';
					return;
				}
				
				for(let item of res) {
					$mainCodeList.append(`<option value="${item.CODETYPE_ID}">${item.CODETYPE_ID}</option>`);
				}
				
				const firstData = res[0];
		        $mainCodeList.val(firstData.CODETYPE_ID).change();
		        changeCommonCode(firstData);
				
				$mainCodeList.on("change", function() {
					const findData = res.find(elem => elem.CODETYPE_ID == $(this).val());
					changeCommonCode(findData);
				});
				
				// 공통코드 세부정보 업데이트
		        function changeCommonCode(data) {
		            $("#viewCommonCodeName").val(data.CODETYPE_NAME);
		            $("#viewCommonCodeDesc").val(data.DESCRIPTION);
		        }
			},
			error : function(res) {
				alert("불러오기 실패!");
			}
		});
		
	});
	
	// 상세코드ID 중복 확인
	$("#newCodeId").on("keyup", function(){
		$.ajax({
			url : "CheckSubCodeId",
			type : "POST",
			data : {
				mainCodeId: $("#mainCodeList").val(),
				subCodeId: $(this).val()
			},
			success: function(res){
				console.log(res);
				
				if(res == "true") {
					$("#subCodeResult").show();
					$("#subCodeResult").css("color", "#e74a3b").text("이미 존재하는 공통코드ID입니다. 다시 입력해주세요.");
					$("#newCodeId").focus();
					codeIdCheck = false;
				} else {
					$("#subCodeResult").css("color", "#4e73df").text("사용할 수 있는 공통코드ID입니다.");
					codeIdCheck = true;
				}
				
			},
			error : function(res) {
				alert("불러오기 실패!");
			}
		});
	});
	
	// 공통코드 추가 팝업
	$("#addCommoncodeForm").on("submit", function(e){
		e.preventDefault();
		const subCodeVal = $("#newSwitchCheckDefault").prop("checked");
		const subCodeStatus = subCodeVal ? 1 : 2;
		
		if(!codeIdCheck) {
			alert("공통코드ID를 확인해주세요.");
			$("#newCodeId").focus();
			return;
		}
		
		// 공통코드 중복이 되지 않으면 저장
		$.ajax({
			url: "AddCommonCode",
			type: "POST",
			data: {
				mainCodeId: $("#mainCodeList").val(),
				subCodeId: $("#newCodeId").val(),
				subCodeName: $("#newCodeName").val(),
				subCodeDesc: $("#newCodeDesc").val(),
				subCodeStatus: subCodeStatus,
				subCodeSeq: $("#newCodeSeq").val(),
			},
			success: function(res){
				$("#addCommonCodes").modal('hide');
				alert("공통코드가 추가되었습니다.");
				codeList.ajax.reload();
			},
			error: function(){
				alert("등록 실패");
			}
		});
		
	});
	
	
	// 체크박스 전체 선택
	checkAll.on("change", function() {
		codeList.rows().every(function (index) {
	        const row = this.node(); // 현재 행
	        const checkBox = row.querySelector(".custom-control-input");
	        checkBox.checked = checkAll.is(":checked") ? true : false;
	    });
	});
	
	// 수정 - 공통ID 원본 값 / 현재값 저장
	let originalCodeId;
	let currentCodeId;
	
	// 공통코드 테이블 컬럼 수정 팝업 셋팅
	codeList.on("click", '.edit-btn', function() {
		const row = $(this).closest('tr');
		const rowData = codeList.row(row).data();
		const codeStatus = rowData.CODE_STATUS == 1 ? true : false;
		const codeStatusText = rowData.CODE_STATUS == 1 ? "사용함" : "사용안함";
		originalCodeId = rowData.CODE_ID;
//		console.log(rowData.CODE_SEQ);
		
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
	
	// 수정 팝업 중복값 처리
	$("#updatedCodeId").on("keyup", function(){
		// 현재 값
		currentCodeId = $(this).val();
		console.log("수정 값 : " + currentCodeId);
		console.log("원본 값 : " + originalCodeId);

	    // 원본 값으로 돌아왔는지 확인
	    if (currentCodeId == originalCodeId) {
	        // 메시지 숨김 및 초기화
	        $("#updateSubCodeIdResult").hide().text("");
	        codeIdCheck = true;
	        console.log(codeIdCheck);
	        return;
	    }
		
		// 상세코드ID 중복 확인
		$.ajax({
			url : "CheckSubCodeId",
			type : "POST",
			data : {
				mainCodeId: $("#updatedCommonCodeId").val(),
				subCodeId: $(this).val()
			},
			success: function(res){
				console.log(res);
				
				if(res == "true") {
					$("#updateSubCodeIdResult").show();
					$("#updateSubCodeIdResult").css("color", "#e74a3b").text("이미 존재하는 공통코드ID입니다. 다시 입력해주세요.");
					$("#updatedCodeId").focus();
					codeIdCheck = false;
				} else {
					$("#updateSubCodeIdResult").css("color", "#4e73df").text("사용할 수 있는 공통코드ID입니다.");
					codeIdCheck = true;
				}
				
			},
			error : function(res) {
				alert("불러오기 실패!");
			}
		});
	});
	
	// 수정 팝업 - 수정하기 버튼 클릭 시
	$("#modifyForm").on("submit", function(e){
		// 현재 값
		currentCodeId = $("#updatedCodeId").val();

	    // 원본 값으로 돌아왔는지 확인
	    if (currentCodeId == originalCodeId) {
	        // 메시지 숨김 및 초기화
	        $("#updateSubCodeIdResult").hide().text("");
	        codeIdCheck = true;
	    }
	    
	    // 최종 중복 확인
		if(!codeIdCheck) {
			e.preventDefault();
			alert("공통코드ID를 확인해주세요.");
			$("#updatedCodeId").focus();
			return;
		}
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
	
	// 단일 행 삭제
	$(document).on("click", '.delete-btn', function() {
		if(confirm("해당 코드를 삭제하시겠습니까?")) {
			const codetypeId = this.dataset.codetypeId;
			const codeId = this.dataset.codeId;
			
			$.ajax({
				url : "AdmDeleteCommonCode",
				type : "POST",
				data : {
					"CODETYPE_ID" : codetypeId,
					"CODE_ID" : codeId
				},
				success: function(response){
					alert(response.message);
					if(response.status == 'success') {
						codeList.ajax.reload();
					}
				},
				error : function(res) {
					alert(res.message);
				}
			});
		}
	});
	
	// 다중 행 삭제
	$(document).on("click", '#btnDeleteRow', function() {
		let deletedItems = [];
		
		codeList.rows().every(function (index) {
			const row = this.node();
			const checkBox = row.querySelector(".custom-control-input");
			const checkedCodeTypeId = row.querySelector("input[name='codetype_id']");
			const checkedCodeId = row.querySelector("input[name='code_id']");
			const deletedCode = {};
			
			if(checkBox.checked){
				deletedCode.CODETYPE_ID = checkedCodeTypeId.value;
				deletedCode.CODE_ID = checkedCodeId.value;
				deletedItems.push(deletedCode);
			}
		});	
		
		if(deletedItems.length == 0) {
			alert("삭제할 행을 선택하세요.");
			return;
		}
			
		if(confirm("선택한 행을 삭제하시겠습니까?\n삭제 후 복구가 불가능합니다.")) {
			
			console.log(deletedItems);
			$.ajax({
				url : "AdmDeleteCommonCodeList",
				type : "POST",
				contentType : 'application/json',
				data: JSON.stringify(deletedItems),
				success: function(response){
					alert(response.message);
					if(response.status == 'success') {
						codeList.ajax.reload();
					}
				},
				error : function(res) {
					alert(res.message);
				}
			});
		}
	});
	
	// 사용여부 실시간 업데이트
	$(document).on("change", "#flexSwitchCheckDefault", function() {
		const codetypeId = this.dataset.codetypeId;
		const codeId = this.dataset.codeId;
		const isChecked = this.checked ? 1 : 2;
		
		$.ajax({
			url : "AdmCommonCodeChangeStatus",
			type : "POST",
			data : {
				"CODETYPE_ID" : codetypeId,
				"CODE_ID" : codeId,
				"ISCHECKED" : isChecked
			},
			success: function(response){
				if(response.status == 'success') {
					 codeList.ajax.reload();
				}
			},
			error : function(res) {
				alert(res.message);
			}
		});
	});
	
	
	
});
