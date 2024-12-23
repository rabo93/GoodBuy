/* 공통코드 등록 */
document.addEventListener("DOMContentLoaded", function(){
	const codeTable = $('#commoncode').DataTable({
		lengthChange : false,
		searching : false,
		info : false,
		ordering : false,
		paging : false,
		fields: [
            {
                label: 'First name:',
                name: 'users.first_name'
            },
            {
                label: 'Last name:',
                name: '상세코드 ID'
            },
            {
                label: 'Phone #:',
                name: 'users.phone'
            },
            {
                label: 'Site:',
                name: 'users.site',
                type: 'select'
            }
        ]
	});
	
	const btnAddRow = document.querySelector("#btnAddRow");
	const btnDeleteRow = document.querySelector("#btnDeleteRow");
	const btnSave = document.querySelector("#btnSave");
	
	function addNewRow() {
		const rowCount = codeTable.rows().count() + 1;
		const newRow = `
			<tr class="tr">
                <td>
                	<div class="custom-control custom-checkbox small">
                    	<input type="checkbox" class="custom-control-input" id="customCheck${rowCount}">
                    	<label class="custom-control-label" for="customCheck${rowCount}"></label>
                	</div>
                </td>
                <td class="num">${rowCount}</td>
                <td><input type="text" class="form-control" name="CODE_ID" placeholder="상세코드ID 입력"></td>
                <td><input type="text" class="form-control" name="CODE_NAME" placeholder="상세코드명 입력"></td>
                <td><input type="text" class="form-control" name="CODE_DESCRIPTION" placeholder="설명 입력"></td>
                <td>
                	<div class="form-check form-switch">
                		<input type="hidden" value="1" name="CODE_STATUS">
						<input class="form-check-input" type="checkbox" role="switch" id="flexSwitchCheckDefault${rowCount}" checked>
						<label class="form-check-label" for="flexSwitchCheckDefault${rowCount}">사용함</label>
					</div>
                </td>
                <td><input type="number" min="1" class="form-control" name="CODE_SEQ" placeholder="순서 입력"></td>
            </tr>
		`;

		codeTable.row.add($(newRow)).draw(false);
	}
	
	function deleteNewRow() {
//		console.log("행 삭제하기");
		
		// .nodes().to$() 사용하여 jquery object로 변경해주기.. 안그럼 오류 남
		const deleteRow = codeTable.rows().nodes().to$().filter(function() {
			const checkbox = $(this).find(".custom-control-input");
			return checkbox.is(":checked");
		});
		
		deleteRow.each(function() {
			const row = codeTable.row($(this));
			row.remove(this);
		});
//		console.log(deleteRow);
		codeTable.draw(true);
		reDrawTable();
	}
	
	function reDrawTable() {
		codeTable.rows().every(function(i) {
			console.log(i);
			const row = this.node();
			const newNum = $(row).find("td.num");
			
			updateCheckboxAndSwtich(row, i);
			
			if(newNum.length > 0) {
				newNum.text(i + 1);
			}
		});
	}
	
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
	
	function saveTable() {
	    let data = codeTable.$('input').serialize();
	    console.log(data);
	    $("form[name='commoncodeForm']").submit();
	}
	
	
	btnAddRow.addEventListener("click", addNewRow);
	btnDeleteRow.addEventListener("click", deleteNewRow);
	btnSave.addEventListener("click", saveTable);
	
	// DOM 요소가 동적추가 되기때문에 이벤트 위임 방식으로 해야함..
	$(document).on("change", ".form-check-input", function () {
	    const checkbox = $(this);
	    const hiddenInput = checkbox.siblings('input[type="hidden"][name="CODE_STATUS"]');
	
	    if (checkbox.is(":checked")) {
	        hiddenInput.val(1); // 체크 시 값 1
	    } else {
	        hiddenInput.val(2); // 체크 해제 시 값 2
	    }
	});

	addNewRow(); // 최초 1행 추가해놓기
});
