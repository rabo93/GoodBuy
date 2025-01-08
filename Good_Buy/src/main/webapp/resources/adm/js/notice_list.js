document.addEventListener("DOMContentLoaded", function(){
	const modifyForm = document.querySelector("#modifyForm");
	
	const noticeList = $('#noticeList').DataTable({
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
			url: "AdmNoticeList",
			type: "POST",
			dataType : "JSON",
			data: function(d) {
                d.searchValue = $('input[name="keyword_search"]').val();
            },
			dataSrc: function (res) {
				const data = res.noticeList;
				const start = $('#noticeList').DataTable().page.info().start; 
				
				// 공지사항 고유번호(PK)가 아닌 단순 테이블 컬럼 번호 계산(페이징 포함)
				for (let i = 0; i < data.length; i++) {
					data[i].listIndex = start + i + 1;
				}
				return data;
			},
		},
		order: [[4, 'desc']], // 최초 조회 시 작성일자 최신순으로 조회
		columnDefs: [
			 { targets: [0, 1, 6], orderable: false },
		],
		columns: [
			{
				data: null, className : "dt-center", width: '60px',
				render : function(data, type, row) {
					const rowCount = noticeList.rows().count() + 1;
					return `
						<div class="custom-control custom-checkbox small">
							<input type="hidden" name="notice_id" value="${data.notice_id}">
			               	<input type="checkbox" class="custom-control-input" id="customCheck${rowCount}">
			                <label class="custom-control-label" for="customCheck${rowCount}"></label>
						</div>
					`;
				}
			},
            { title: "No.", data: "listIndex", className : "dt-center", width: '60px', },
            { title: "작성자", data : "mem_id", defaultContent: "", width: '160px', },
            { title: "제목", data : "notice_subject", defaultContent: "",},
            { title: "작성일자", data : "notice_date", className: "dt-center", defaultContent: "", width: '160px',},
            { title: "조회수", data : "notice_read_count", className: "dt-center", defaultContent: "", width: '100px', },
            {
				title : "관리",
				data: null,
				searchable: false,
				className : "dt-center",
				width: '120px',
				render : function(data, type, row) {
					return `
						<button type="button" class="btn btn-primary edit-btn" onclick="location.href='AdmNoticeModify?notice_id=${row.notice_id}'">수정</button>
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
	
	// 기존 검색 숨기기
	$("#noticeList_filter").attr("hidden", "hidden");
	
    // 검색 버튼 클릭 시 테이블 다시 로드
    $('#searchBtn').on('click', function() {
        noticeList.draw();
    });

    // 엔터키 입력으로 검색
    $('#searchKeyword').on('keypress', function(e) {
        if (e.which == 13) {
            noticeList.draw();
        }
    });
    	
	// 체크박스 전체 선택
	const checkAll = $("#checkAll");
	checkAll.on("change", function() {
		noticeList.rows().every(function (index) {
	        const row = this.node(); // 현재 행
	        const checkBox = row.querySelector(".custom-control-input");
	        checkBox.checked = checkAll.is(":checked") ? true : false;
	    });
	});
	
	// 버튼 이동
	$("#btnAddRow").on("click", function() {
		window.location.href='AdmNoticeRegist';
	});
	
	// 선택한 컬럼 삭제
	$(document).on("click", '#btnDeleteRow', function() {
		const deleteItems = [];
		noticeList.rows().every(function (index) {
			const row = this.node();
			const checkBox = row.querySelector(".custom-control-input");
			const checkedId = row.querySelector("input[name='notice_id']");
			if(checkBox.checked){
				 deleteItems.push(checkedId.value);
			}
		});	
		
		if(deleteItems.length == 0) {
			alert("삭제할 게시글을 선택하세요.");
			return;
		}
			
		if(confirm("선택한 게시글을 삭제하시겠습니까?\n삭제 후 복구가 불가능합니다.")) {
			
			console.log(deleteItems);
			$.ajax({
				url : "AdmNoticeDelete",
				type : "POST",
				contentType : 'application/json',
				data: JSON.stringify(deleteItems),
				success: function(response){
					alert(response.message);
					if(response.status == 'success') {
						window.location.href = response.redirectURL;
					}
				},
				error : function(res) {
					alert(res.message);
				}
			});
		}
	});
	
	
	
});

