/* 공통코드 등록 */
document.addEventListener("DOMContentLoaded", function(){
	// 테이블 그리기
	const codeTable = $('#commoncode').DataTable({
		lengthChange : false,
		searching : false,
		info : false,
		ordering : false,
		paging : false,
	});
	
	// 변수 선언
	const btnAddRow = document.querySelector("#btnAddRow");
	const btnDeleteRow = document.querySelector("#btnDeleteRow");
	const btnSubmitForm = document.querySelector("#btnSubmitForm");
	const commoncodeForm = document.querySelector("form[name=commoncodeForm]");

	// 행 추가
	function addNewRow() {
		const rowCount = codeTable.rows().count() + 1;
//		const newRow = `
//			<tr class="tr">
//                <td>
//                	<div class="custom-control custom-checkbox small">
//                    	<input type="checkbox" class="custom-control-input" id="customCheck${rowCount}">
//                    	<label class="custom-control-label" for="customCheck${rowCount}"></label>
//                	</div>
//                </td>
//                <td class="num">${rowCount}</td>
//                <td><input type="text" class="form-control" name="CODE_ID" placeholder="상세코드ID 입력" required></td>
//                <td><input type="text" class="form-control" name="CODE_NAME" placeholder="상세코드명 입력" required></td>
//                <td><input type="text" class="form-control" name="CODE_DESCRIPTION" placeholder="설명 입력" required></td>
//                <td>
//                	<div class="form-check form-switch">
//                		<input type="hidden" value="1" name="CODE_STATUS">
//						<input class="form-check-input" type="checkbox" role="switch" id="flexSwitchCheckDefault${rowCount}" checked required>
//						<label class="form-check-label" for="flexSwitchCheckDefault${rowCount}">사용함</label>
//					</div>
//                </td>
//                <td><input type="number" min="1" class="form-control" name="CODE_SEQ" placeholder="순서 입력" value="1" required></td>
//            </tr>
//		`;
//
//		codeTable.row.add($(newRow)).draw(false);
		codeTable.row.add([
			`<div class="custom-control custom-checkbox small">
               	<input type="checkbox" class="custom-control-input" id="customCheck${rowCount}">
                <label class="custom-control-label" for="customCheck${rowCount}"></label>
			</div>`,
			`<span class="num">${rowCount}</span>`,
			`<input type="text" class="form-control" name="CODE_ID" placeholder="상세코드ID 입력" required>`,
			`<input type="text" class="form-control" name="CODE_NAME" placeholder="상세코드명 입력" required>`,
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
			row.remove(this);
		});
		console.log("삭제할 로우 : "+ deleteRow); // 삭제할 row 확인

		codeTable.draw(true);
		reDrawTable();
	}
	
	// 행 삭제 후 컬럼 번호, 순서 새로 그리기
	function reDrawTable() {
		codeTable.rows().every(function(i) {
			console.log("삭제후 남은 row : " + i); // 삭제 후 남은 row index 출력
			const row = this.node();
			const newNum = $(row).find("span.num");
			const newOrder = $(row).find("input[name=CODE_SEQ]");
			
			updateCheckboxAndSwtich(row, i);
			
			if(newNum.length > 0) {
				newNum.text(i + 1);
				newOrder.val(i + 1);
			}
		});
	}
	
	// 체크박스, 스위치 버튼 업데이트
	function updateCheckboxAndSwtich(row, i) {
		const newCheckbox = $(row).find(".custom-control-input");
		const newCheckboxLabel = $(row).find(".custom-control-label");
		const newSwitch = $(row).find(".form-check-input");
		const newSwitchLabel = $(row).find(".form-check-label");
		
		if(newCheckbox.length > 0) {
			const customCheckId = `customCheck${i + 1}`;
			newCheckbox.attr("id", customCheckId);
			newCheckbox.prop("check", false);
			newCheckboxLabel.attr("for", customCheckId);
		}
		if(newSwitch.length > 0) {
			let switchId = `flexSwitchCheckDefault${i + 1}`;
			newSwitch.attr("id", switchId);
			newSwitchLabel.attr("for", switchId);
		}
		
	}
	
	// 전체 폼 저장
	function submitForm(e) {
		e.preventDefault();
		const formData = $(this).serializeArray();
		console.log("폼데이터111: " + formData); // 넘어오는거 확인
		
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
				if(response.status == 'success') {
					alert(response.message);
					window.location.href = response.redirectURL;
				} else {
					alert(response.message);
				}
			},
			error: function() {
				alert("공통코드 등록이 실패했습니다.");
			}
		});
		
//	    $("form[name='commoncodeForm']").submit();
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

	addNewRow(); // 최초 1행 추가해놓기
});
