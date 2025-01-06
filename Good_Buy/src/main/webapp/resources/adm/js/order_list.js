document.addEventListener("DOMContentLoaded", function(){
//	const modifyForm = document.querySelector("#modifyForm");
	const orderList = $('#orderList').DataTable({
		lengthChange : true, // 건수
		searching : false, // 검색
		info : true, // 정보
		ordering : true, // 정렬
		paging : true,
		responsive: true, // 반응형
		destroy: true,
		scrollX: true, 
		autoWidth: false,
		ajax : {
			url: "AdmOrderList",
			type: "POST",
			dataType : "JSON",
			data: function(d) {
                d.status = $('input[name="status"]:checked').val(); //상태별
                d.searchDate = $("#schDate").val(); //기간별
                d.searchValue = $('input[name="keyword_search"]').val(); //키워드 검색
            },
			dataSrc: function (res) {
				console.log("ajax 응답(res): " + JSON.stringify(res));
				const data = res.OrderList;
				console.log("data : " + JSON.stringify(data));
				const start = $('#orderList').DataTable().page.info().start; 
				
				// PK가 아닌 테이블 컬럼 번호 계산(페이징 포함)
				for (let i = 0; i < data.length; i++) {
					data[i].listIndex = start + i + 1;
				}
				return data;
			},
		},
		order: [[9, 'desc']], // 최초 조회 시 거래일시 최신순으로 기본 설정
		columnDefs: [
			 { targets: [0, 9], orderable: false },
		],
		columns: [
			{	// 체크박스
				data: null, 
				className : "dt-center", 
				width: '60px',
				render : function(data, type, row, meta) {
					const rowCount = meta.row + 1; // 현재 페이지에서의 row 번호를 사용
					const checkboxId = "customCheck" + rowCount;
					const checkboxName = "pay_id_" + data.pay_id; // 고유한 name 값 설정
					return `
						<div class="custom-control custom-checkbox small">
							<input type="hidden" name="pay_id" value="${data.pay_id}">
							<input type="checkbox" class="custom-control-input" id="${checkboxId}" name="${checkboxName}">
							<label class="custom-control-label" for="${checkboxId}"></label>
						</div>
					`;
				}
			},
			// defaultContent 는 기본값 설정, 데이터 없는 컬럼일 경우 오류나기 때문에 널스트링 처리 해주어야 함
			// 회원가입 시 유효성 체크를 한다면 defaultContent 값 설정 필요 없음!
            { title: "No.", data: "listIndex", className : "dt-center", width: '30px', },
            { 
				title: "판매자ID", 
				data: "seller_id",
				defaultContent: "",
	            width: '120px',
	            render: function (data, type, row) {
					if (!data) {
						return "";
					}
                	return data.replace(/(.{16})/g, '$1<br>'); // 16자마다 줄바꿈
           		}
//				className : "dt-center",
			},
            { title: "상품유형", data: "product_category", defaultContent: "", className : "dt-center", },
            { title: "상품명", data: "product_title", defaultContent: "", className : "dt-center",  width: '180px', },
            { title: "상품금액", data: "product_price", defaultContent: "", className : "dt-center",  },
            { 
				title: "구매자ID", 
				data: "buyer_id",
				defaultContent: "",
	            width: '120px',
	            render: function (data, type, row) {
					if (!data) {
						return "";
					}
                	return data.replace(/(.{16})/g, '$1<br>'); // 16자마다 줄바꿈
           		}
//				className : "dt-center",
			},
            { title: "구매금액", data: "pay_price", defaultContent: "", className : "dt-center", },
            { title: "구매일시", data: "pay_date", defaultContent: "", className : "dt-center", },
            { title: "거래장소", data: "pay_address", defaultContent: "", className : "dt-center", },
            { 
				title: "거래상태", data : "pay_status", defaultContent: "", width: '100px', className : "dt-center",
				render : function(data, type, row) {
					if(!data) return "";
					switch (data) {
				        case 0: return "<span class='status status-01'>판매중</span>";
				        case 1: return "<span class='status status-01'>거래중</span>";
				        case 2: return "<span class='status status-02'>예약중</span>";
				        case 3: return "<span class='status status-03'>거래완료</span>";
				        case 4: return "<span class='status status-03'>신고처리</span>";
				        default: return "";
				    }
				}
            },
            {
				title : "관리",
				data: null,
				searchable: false,
				className : "dt-center",
				width: '120px',
				render : function(data, type, row) {
					return `
						<button class="btn btn-primary edit-btn" data-toggle="modal" data-target="#updateOrder"
								data-pay-id="${data.pay_id}"
								aria-label="수정 - pay id: ${data.pay_id}" aria-controls="updateOrder">
								수정</button>
						<button class="btn btn-danger delete-btn"
								data-pay-id="${data.pay_id}"
						 		data-pay-id="${data.pay_id}">삭제</button>
					`;
				}
			}
        ],
		serverSide : true, // 서버사이드 처리
		processing : true,  // 서버와 통신 시 응답을 받기 전이라는 ui를 띄울 것인지 여부
		language : {
			emptyTable: "데이터가 없습니다.",
			lengthMenu: "_MENU_ 건씩 보기",
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
	
	// 답글달기 팝업 셋팅
	orderList.on("click", '.edit-btn', function() {
		const row = $(this).closest('tr');
		const rowData = orderList.row(row).data();

		// 문의내역에 문의내용 보이기
		const supportContent = rowData.SUPPORT_CONTENT
		const enquireContent = document.querySelector("#enquireContent");
        enquireContent.value = rowData.SUPPORT_CONTENT || "";
		
		const status = rowData.STATUS;
		const replyContent = rowData.REPLY_CONTENT != null ? rowData.REPLY_CONTENT : "";
		
		// DB에 저장할 id속성 가져오기
		const supportId = document.querySelector("#supportId"); //게시글id
//		const memId = document.querySelector("#memId"); 		//작성자id
//		const adminId = document.querySelector("#adminId");		//관리자id
		const statusSelect = document.querySelector(`#supportStatus option[value="${status}"]`);
		const reasonTextarea = document.querySelector("#replyContent");
		
		// DB에 저장할 값 저장
		supportId.value = rowData.SUPPORT_ID;
	    if (statusSelect) statusSelect.selected = true;
		reasonTextarea.value = replyContent;
		
		// 글자 수 표시
		const contentLength = rowData.REPLY_CONTENT.length;
   		$("#lengthInfo").text(contentLength); 
		
	});
	
	// 기존 검색 숨기기
	$("#orderList_filter").attr("hidden", "hidden");
	
	 // 필터 변경 시 데이터 테이블 다시 로드
    $('input[name="status"]').on('change', () => orderList.draw());

    // 검색 버튼 클릭 시 테이블 다시 로드
    $('#searchBtn').on('click', () => orderList.draw());
    
    // 엔터키 입력으로 검색
    $('#searchKeyword').on('keypress', (e) => {
        if (e.which == 13)  orderList.draw();
    });
    
	// 기간별 검색 필터링 제이쿼리
    $('#schDate').daterangepicker({
//        startDate: moment().subtract(29, 'days'),
//        startDate: false,
//        endDate: moment(),
        maxDate: moment(),
        locale: {
			start: '시작일시',
			end: '종료일시',
		    separator: " ~ ", // 시작일시와 종료일시 구분자
		    format: 'YYYY-MM-DD', // 일시 노출 포맷
		    applyLabel: "확인", // 확인 버튼 텍스트
		    cancelLabel: "취소", // 취소 버튼 텍스트
		    daysOfWeek: ["일", "월", "화", "수", "목", "금", "토"],
		    monthNames: ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"],
			customRangeLabel: '기간 지정',
		 },
		autoUpdateInput: false,
	    timePicker: false, // 시간 노출 여부
	    showDropdowns: true, // 년월 수동 설정 여부
	    autoApply: false, // 확인/취소 버튼 사용여부
		ranges: {
            '이번 달': [moment().startOf('month'), moment().endOf('month')], // 이번 달 전체
            '지난 달': [moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')], // 지난 달 전체
            '지난 7일': [moment().subtract(6, 'days'), moment()], // 최근 7일
            '지난 14일': [moment().subtract(13, 'days'), moment()], // 최근 14일
            '지난 30일': [moment().subtract(29, 'days'), moment()], // 최근 30일
            '지난 3개월': [moment().subtract(3, 'months').startOf('month'), moment().endOf('month')], // 최근 3개월
        },
    }).on('show.daterangepicker', function (ev, picker) {
        picker.container.addClass('goodbuyCustomPicker');                            
    });
    
    // 날짜 선택 후에도 placeholder 유지
    $('#schDate').on('apply.daterangepicker', function(ev, picker) {
        $(this).val(`${picker.startDate.format('YYYY-MM-DD')} ~ ${picker.endDate.format('YYYY-MM-DD')}`);
    });
    
	// 날짜 검색 초기화
	$("#initDateBtn").on('click', function() {
		$('#schDate').val('');
		orderList.draw();
	});
	
    // 기간별 검색 후 테이블 다시 로드
    $("#searchDateBtn").on('click', function() {
		orderList.draw();
	});
	
	// 답글 작성
	$("#replyContent").on('keyup', () => {
		fnChkByte($("#replyContent"), 500);
	});
	
	// 글자수 제한 함수
	function fnChkByte(item, maxLength){
		const str = item.val();
        const strLength = str.length;
        
         if (strLength > maxLength) {
            alert("글자수는 " + maxLength + "자를 초과할 수 없습니다.");
            $(item).val(str.substr(0, maxLength));      //문자열 자르고 값 넣기
            fnChkByte(item, maxLength);
         }
         $('#lengthInfo').text(strLength);
    }
    
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
	$('#orderList').on('change', 'input[type="checkbox"].custom-control-input', function() {
	    // 전체 체크박스 상태를 체크하려면 모든 체크박스의 상태 확인
	    const allChecked = orderList.rows().nodes().to$().find('input[type="checkbox"].custom-control-input').length;
	    const checkedCount = orderList.rows().nodes().to$().find('input[type="checkbox"].custom-control-input:checked').length;
	
	    // 하나라도 체크박스가 해제되면 전체 선택 체크박스 해제
	    checkAll.prop('checked', allChecked === checkedCount); 
	});
	//-----------------------------------------------------
	// 체크박스 선택 삭제
	$(document).on("click", '#btnDeleteRow', function() {
		if(confirm("선택한 게시글을 삭제하시겠습니까?\n삭제 후 복구가 불가능합니다.")) {
			const deleteItems = [];
			faqList.rows().every(function (index) {
				const row = this.node();
				const checkBox = row.querySelector(".custom-control-input");
				const checkedId = row.querySelector("input[name='pay_id']");
				if(checkBox.checked){
					 deleteItems.push(checkedId.value);
				}
			});	
			console.log(deleteItems);
			
			$.ajax({
				url : "AdmOrderDelete",
				type : "POST",
				contentType : 'application/json',
				data: JSON.stringify(deleteItems),
				
				success: function(response){
					if(response.status == "success") {
						alert(response.message);
//						window.location.href = response.redirectURL;
						orderList.ajax.reload();
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
