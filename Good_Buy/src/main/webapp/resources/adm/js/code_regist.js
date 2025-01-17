/* 공통코드 등록 */
document.addEventListener("DOMContentLoaded", function(){
	// 변수 선언
	const btnAddRow = document.querySelector("#btnAddRow");
	const btnDeleteRow = document.querySelector("#btnDeleteRow");
	const commoncodeForm = document.querySelector("form[name=commoncodeForm]");
	const checkAll = document.querySelector("#checkAll");
	let codeIdCheck = false;
	let codeIdDuplicate = false;
	
	// 테이블 그리기
	const codeTable = $('#commoncode').DataTable({
		lengthChange : false,
		searching : false,
		info : false,
		ordering : false,
		paging : false,
		responsive: true,
		fixedHeader: true,
	});

	// 행 추가
	function addNewRow() {
		const rowCount = codeTable.rows().count() + 1;
		codeTable.row.add([
			`<div class="custom-control custom-checkbox small">
               	<input type="checkbox" class="custom-control-input" id="customCheck${rowCount}">
                <label class="custom-control-label" for="customCheck${rowCount}"></label>
			</div>`,
			`<span class="num">${rowCount}</span>`,
			`<input type="text" class="form-control code_id" name="CODE_ID" placeholder="공통코드ID 입력" required>`,
			`<input type="text" class="form-control" name="CODE_NAME" placeholder="공통코드명 입력" required>`,
			`<input type="text" class="form-control" name="CODE_DESCRIPTION" placeholder="설명 입력" required>`,
			`<div class="form-check form-switch">
        		<input type="hidden" value="1" name="CODE_STATUS">
				<input class="form-check-input" type="checkbox" role="switch" id="flexSwitchCheckDefault${rowCount}" checked>
				<label class="form-check-label" for="flexSwitchCheckDefault${rowCount}">사용함</label>
			</div>`,
			`<input type="number" min="1" class="form-control" name="CODE_SEQ" placeholder="순서 입력" value="${rowCount}" required>`
		]).draw(false);
	}
	
	// 행 삭제
	function deleteNewRow() {
		// rows().nodes().to$() 사용하여 jquery object로 변경해주기(안그럼 오류남..)
		const deleteRow = codeTable.rows().nodes().to$().filter(function() {
			const checkbox = $(this).find(".custom-control-input");
			return checkbox.is(":checked");
		});
		
		deleteRow.each(function() {
			const row = codeTable.row($(this));
			row.remove();
		});
		
//		console.log("삭제할 로우 : "+ deleteRow); // 삭제할 row 확인

		// 전부 삭제했을 경우 최소 1행 추가
		if(codeTable.rows().count() == 0) {
			alert("공통코드는 최소 1행 이상 등록하여야 합니다.");
        	addNewRow();
		}
		reDrawTable(codeTable);
		codeTable.draw(false);
	}
	
	// 행 삭제 후 컬럼 번호, 순서 업데이트
	function reDrawTable(table) {
		const rows = table.rows().nodes();
	
	    $(rows).each(function (index) {
	        const row = $(this); // 현재 행
	        const newNum = row.find("span.num");
	        const newOrder = row.find("input[name=CODE_SEQ]");
	
	        // 번호와 순서 업데이트
	        newNum.text(index + 1); // 1부터 시작하도록 설정
	        newOrder.val(index + 1);
	
	        // 체크박스와 스위치 업데이트
	        updateCheckboxAndSwtich(row, index + 1);
	    });
	}
	
	// 체크박스 , 스위치 버튼 인덱스 업데이트
	function updateCheckboxAndSwtich(row, i) {
		const newCheckbox = $(row).find(".custom-control-input");
		const newCheckboxLabel = $(row).find(".custom-control-label");
		const newSwitch = $(row).find(".form-check-input");
		const newSwitchLabel = $(row).find(".form-check-label");
		
		if(newCheckbox.length > 0) {
			const customCheckId = `customCheck${i}`;
			newCheckbox.attr("id", customCheckId);
			newCheckbox.prop("checked", false);
			newCheckboxLabel.attr("for", customCheckId);
		}
		if(newSwitch.length > 0) {
			let switchId = `flexSwitchCheckDefault${i}`;
			newSwitch.attr("id", switchId);
			newSwitchLabel.attr("for", switchId);
		}
		
	}
	
	
	// 코드타입 ID 중복검사
	$("#codetype_id").on("keyup", function(){
		
		// 유효성 체크
		$.ajax({
			url: "CheckCommonCodeID",
			type: "POST",
			data: {
				mainCodeId : $("#codetype_id").val()
			},
			success: function(res) {
				console.log(res);
				if(res == "true") {
					$("#commonCodeResult").show();
					$("#commonCodeResult").css("color", "#e74a3b").text("이미 존재하는 코드타입ID입니다. 다시 입력해주세요.");
					$("#codetype_id").focus();
					codeIdCheck = false;
				} else {
					$("#commonCodeResult").css("color", "#4e73df").text("사용할 수 있는 코드타입ID입니다.");
					codeIdCheck = true;
				}
			},
			error: function() {
				alert("오류가 발생했습니다.\n다시 입력해주세요.");
			}
		
		});
	});
	
	// 공통코드 ID 중복체크 
	$(document).on('input', '.code_id', function(){
		const input = $(this);
		const codeIdValue = input.val().trim();
		const allCodeIds = [];
		
		$(".code_id").each(function(){
			const val = $(this).val().trim();
			if(val) {
				allCodeIds.push(val);
			}
		});
		
		const isDuplicate = allCodeIds.filter(id => id == codeIdValue).length > 1;
		if (isDuplicate) {
	        input.addClass('is-invalid');
	        input.siblings('.invalid-feedback').remove();
	        input.after('<div class="invalid-feedback">중복된 공통코드ID 입니다. 수정해주세요.</div>');
	    	codeIdDuplicate = true;
		} else {
	        input.removeClass('is-invalid');
	        input.siblings('.invalid-feedback').remove();
			codeIdDuplicate = false;
	    }
		
	});
	
	// 전체 폼 저장
	function submitForm(e) {
		e.preventDefault();
		const formData = $(this).serializeArray();
		console.log("폼데이터: " + formData); // 넘어오는거 확인
		
		// 코드타입 중복체크 확인
		if(!codeIdCheck) {
			alert("코드타입 ID를 확인해주세요.");
			$("#codetype_id").focus();
			return;
		};
		
		// 공통코드 중복체크 확
		if(codeIdDuplicate) {
			alert("공통코드 ID를 확인해주세요.");
			$(".is-invalid").focus();
			return;
		}
		
		
		// 일반 필드 input 값 저장
		const mainCode = {};
		formData.forEach((field) => {
			if (['CODETYPE_ID', 'CODETYPE_NAME', 'DESCRIPTION'].includes(field.name)) {
				mainCode[field.name] = field.value;
			}
		});
		
		// datatables input 필드 값 저장
		const subCodes = [];
		$("#commoncode tbody tr").each(function() {
			const rowData = {};
			$(this).find('input').each(function(){
				rowData[$(this).attr('name')] = $(this).val();
				console.log(rowData);
				delete rowData[undefined];
			});
			subCodes.push(rowData);
		});
		
		const commonCodes = {
			mainCode : mainCode,
			subCodes : subCodes
		};
		
		console.log(commonCodes);
		
		$.ajax({
			url: "AdmCommoncodeRegist",
			type: "POST",
			contentType : 'application/json',
			data : JSON.stringify(commonCodes),
			dataType : "JSON",
			success: function(response) {
				alert(response.message);
				if(response.status == 'success') {
					window.location.href = response.redirectURL;
				}
			},
			error: function() {
				alert("공통코드 등록을 실패했습니다.");
			}
		});
		
//	    $("form[name='commoncodeForm']").submit();
	}
	
	// 체크박스 전체 선택
	function allCheck() {
		const isChecked = checkAll.checked;
		
	    codeTable.rows().every(function (index) {
	        const row = this.node(); // 현재 행
	        console.log(row);
	        const checkBox = row.querySelector(".custom-control-input");
			if(checkBox) {
				checkBox.checked = isChecked;	
			}
	    });
	}
	
	// 사용여부 체크(스위치버튼) 처리
	// 행이 추가되며 스위치 버튼이 동적으로 추가되기 때문에 이벤트 위임 방식 사용해야 함)
	$(document).on("change", ".form-check-input", function() {
	    const switchBtn = this;
	    const hiddenInput = switchBtn.parentElement.querySelector('input[type="hidden"][name="CODE_STATUS"]');
	
	    if (hiddenInput) {
	        hiddenInput.value = switchBtn.checked ? 1 : 2;
	    } else {
	        console.warn("사용여부 버튼이 존재하지 않습니다.");
	    }
	});
	
	
	btnAddRow.addEventListener("click", addNewRow);
	btnDeleteRow.addEventListener("click", deleteNewRow);
	commoncodeForm.addEventListener("submit", submitForm);
	checkAll.addEventListener("change", allCheck);

	addNewRow(); // 최초 1행 추가해놓기
});
